#!/bin/bash
# Script pour détruire Terraform via Docker (WSL) - Exercices
# Usage: ./scripts/wsl/terraform-destroy.sh [exercice_dir] [options]

CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXERCICES_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

if [ -n "$1" ] && [ -d "$EXERCICES_DIR/$1" ]; then
    WORK_DIR="$EXERCICES_DIR/$1"
    shift
    ARGS="$@"
else
    WORK_DIR="$EXERCICES_DIR"
    ARGS="$@"
fi

cd "$WORK_DIR"

if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Erreur: Docker n'est pas installé${NC}"
    exit 1
fi

if ! docker images terraform-exercices:latest --format "{{.Repository}}:{{.Tag}}" | grep -q "terraform-exercices:latest"; then
    echo -e "${YELLOW}⚠️  Image terraform-exercices:latest non trouvée${NC}"
    echo -e "${CYAN}💡 Construction de l'image...${NC}"
    "$EXERCICES_DIR/scripts/docker/docker-build.sh" || exit 1
fi

if [[ "$ARGS" != *"-auto-approve"* ]]; then
    echo -e "${YELLOW}⚠️  Attention: Cette commande va détruire les ressources !${NC}"
    read -p "Êtes-vous sûr? (yes/no): " confirm
    if [ "$confirm" != "yes" ]; then
        echo -e "${RED}❌ Opération annulée${NC}"
        exit 0
    fi
fi

echo -e "${CYAN}🗑️  Destruction des ressources...${NC}"

# Charger les helpers
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/_helpers.sh" 2>/dev/null || true

# Détecter le dossier .azure pour les credentials Azure CLI
AZURE_VOLUME=$(get_azure_volume_mount)

# Construire la commande Docker
DOCKER_CMD="docker run --rm -it \
    -v \"$WORK_DIR:/workspace\" \
    -v terraform-plugins-exercices:/root/.terraform.d/plugins \
    -v terraform-cache-exercices:/root/.terraform.d"

# Ajouter le montage Azure si disponible
if [ -n "$AZURE_VOLUME" ]; then
    DOCKER_CMD="$DOCKER_CMD $AZURE_VOLUME"
fi

DOCKER_CMD="$DOCKER_CMD -w /workspace \
    terraform-exercices:latest destroy $ARGS"

eval $DOCKER_CMD

exit_code=$?
if [ $exit_code -eq 0 ]; then
    echo -e "${GREEN}✅ Ressources détruites avec succès${NC}"
else
    echo -e "${RED}❌ Erreur lors de la destruction${NC}"
fi

exit $exit_code

#!/bin/bash
# Script pour afficher la version de Terraform via Docker (WSL)
# Usage: ./scripts/wsl/terraform-version.sh

CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BRIEF_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$BRIEF_DIR"

if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Erreur: Docker n'est pas installé${NC}"
    exit 1
fi

# Vérifier que l'image existe
if ! docker images terraform-brief:latest --format "{{.Repository}}:{{.Tag}}" | grep -q "terraform-brief:latest"; then
    echo -e "${YELLOW}⚠️  Image terraform-brief:latest non trouvée${NC}"
    echo -e "${CYAN}💡 Construction de l'image...${NC}"
    "$BRIEF_DIR/scripts/docker/docker-build.sh" || exit 1
fi

echo -e "${CYAN}📦 Version de Terraform:${NC}"

# Charger les helpers
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/_helpers.sh" 2>/dev/null || true

# Détecter le dossier .azure pour les credentials Azure CLI
AZURE_VOLUME=$(get_azure_volume_mount)

# Construire la commande Docker
DOCKER_CMD="docker run --rm -it \
    -v \"$BRIEF_DIR:/workspace\" \
    -v terraform-plugins:/root/.terraform.d/plugins \
    -v terraform-cache:/root/.terraform.d"

# Ajouter le montage Azure si disponible
if [ -n "$AZURE_VOLUME" ]; then
    DOCKER_CMD="$DOCKER_CMD $AZURE_VOLUME"
fi

DOCKER_CMD="$DOCKER_CMD -w /workspace \
    terraform-brief:latest version"

eval $DOCKER_CMD

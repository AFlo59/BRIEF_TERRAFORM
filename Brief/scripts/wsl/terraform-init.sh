#!/bin/bash
# Script pour initialiser Terraform via Docker (WSL)
# Usage: ./scripts/terraform-init.sh

CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Obtenir le répertoire du script et remonter au dossier Brief
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BRIEF_DIR="$SCRIPT_DIR"
cd "$BRIEF_DIR"

# Vérifier Docker
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Erreur: Docker n'est pas installé${NC}"
    exit 1
fi

echo -e "${CYAN}🚀 Initialisation de Terraform...${NC}"

# Vérifier que l'image existe
if ! docker images terraform-brief:latest --format "{{.Repository}}:{{.Tag}}" | grep -q "terraform-brief:latest"; then
    echo -e "${YELLOW}⚠️  Image terraform-brief:latest non trouvée${NC}"
    echo -e "${CYAN}💡 Construction de l'image...${NC}"
    "$BRIEF_DIR/scripts/docker/docker-build.sh" || exit 1
fi

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
    terraform-brief:latest init"

eval $DOCKER_CMD

exit_code=$?
if [ $exit_code -eq 0 ]; then
    echo -e "${GREEN}✅ Terraform initialisé avec succès${NC}"
else
    echo -e "${RED}❌ Erreur lors de l'initialisation${NC}"
fi

exit $exit_code

#!/bin/bash
# Script pour exécuter une commande dans le conteneur Terraform
# Usage: ./scripts/docker/docker-run.sh <command> [args...]
# Exemple: ./scripts/docker/docker-run.sh terraform version

CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BRIEF_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Erreur: Docker n'est pas installé${NC}"
    exit 1
fi

# Vérifier que l'image existe
if ! docker images terraform-brief:latest --format "{{.Repository}}:{{.Tag}}" | grep -q "terraform-brief:latest"; then
    echo -e "${RED}❌ Image terraform-brief:latest non trouvée${NC}"
    echo -e "${CYAN}💡 Construisez l'image d'abord: ./scripts/docker/docker-build.sh${NC}"
    exit 1
fi

# Exécuter la commande
if [ -t 0 ]; then
    docker run --rm -it \
        -v "$BRIEF_DIR:/workspace" \
        -v terraform-plugins:/root/.terraform.d/plugins \
        -v terraform-cache:/root/.terraform.d \
        -w /workspace \
        terraform-brief:latest \
        "$@"
else
    docker run --rm -i \
        -v "$BRIEF_DIR:/workspace" \
        -v terraform-plugins:/root/.terraform.d/plugins \
        -v terraform-cache:/root/.terraform.d \
        -w /workspace \
        terraform-brief:latest \
        "$@"
fi

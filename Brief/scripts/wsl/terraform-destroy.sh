#!/bin/bash
# Script pour détruire l'infrastructure Terraform via Docker (WSL)
# Usage: ./scripts/terraform-destroy.sh [OPTIONS]
# Exemple: ./scripts/terraform-destroy.sh -auto-approve

CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$SCRIPT_DIR"

if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Erreur: Docker n'est pas installé${NC}"
    exit 1
fi

# Vérifier si -auto-approve est dans les arguments
if [[ "$*" != *"-auto-approve"* ]]; then
    echo -e "${YELLOW}⚠️  Attention: Cette commande va détruire toutes les ressources Azure !${NC}"
    read -p "Êtes-vous sûr de vouloir continuer? (yes/no): " confirm
    if [ "$confirm" != "yes" ]; then
        echo -e "${RED}❌ Opération annulée${NC}"
        exit 0
    fi
fi

echo -e "${CYAN}🗑️  Destruction de l'infrastructure...${NC}"

docker run --rm -it \
    -v "$SCRIPT_DIR:/workspace" \
    -v terraform-plugins:/root/.terraform.d/plugins \
    -v terraform-cache:/root/.terraform.d \
    -w /workspace \
    hashicorp/terraform:latest destroy "$@"

exit_code=$?
if [ $exit_code -eq 0 ]; then
    echo -e "${GREEN}✅ Infrastructure détruite avec succès${NC}"
else
    echo -e "${RED}❌ Erreur lors de la destruction${NC}"
fi

exit $exit_code

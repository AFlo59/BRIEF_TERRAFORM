#!/bin/bash
# Script pour appliquer la configuration Terraform via Docker (WSL)
# Usage: ./scripts/terraform-apply.sh [OPTIONS]
# Exemple: ./scripts/terraform-apply.sh -auto-approve

CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$SCRIPT_DIR"

if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Erreur: Docker n'est pas installé${NC}"
    exit 1
fi

echo -e "${CYAN}⚙️  Application de la configuration Terraform...${NC}"

# Passer tous les arguments supplémentaires à terraform apply
docker run --rm -it \
    -v "$SCRIPT_DIR:/workspace" \
    -v terraform-plugins:/root/.terraform.d/plugins \
    -v terraform-cache:/root/.terraform.d \
    -w /workspace \
    hashicorp/terraform:latest apply "$@"

exit_code=$?
if [ $exit_code -eq 0 ]; then
    echo -e "${GREEN}✅ Configuration appliquée avec succès${NC}"
else
    echo -e "${RED}❌ Erreur lors de l'application${NC}"
fi

exit $exit_code

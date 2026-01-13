#!/bin/bash
# Script pour valider la configuration Terraform via Docker (WSL)
# Usage: ./scripts/terraform-validate.sh

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

echo -e "${CYAN}✅ Validation de la configuration Terraform...${NC}"

docker run --rm -it \
    -v "$SCRIPT_DIR:/workspace" \
    -v terraform-plugins:/root/.terraform.d/plugins \
    -v terraform-cache:/root/.terraform.d \
    -w /workspace \
    hashicorp/terraform:latest validate

exit_code=$?
if [ $exit_code -eq 0 ]; then
    echo -e "${GREEN}✅ Configuration valide${NC}"
else
    echo -e "${RED}❌ Erreurs de validation détectées${NC}"
fi

exit $exit_code

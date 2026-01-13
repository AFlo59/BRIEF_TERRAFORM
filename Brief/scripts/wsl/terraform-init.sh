#!/bin/bash
# Script pour initialiser Terraform via Docker (WSL)
# Usage: ./scripts/terraform-init.sh

CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Obtenir le répertoire du script et remonter au dossier Brief
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$SCRIPT_DIR"

# Vérifier Docker
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Erreur: Docker n'est pas installé${NC}"
    exit 1
fi

echo -e "${CYAN}🚀 Initialisation de Terraform...${NC}"

docker run --rm -it \
    -v "$SCRIPT_DIR:/workspace" \
    -v terraform-plugins:/root/.terraform.d/plugins \
    -v terraform-cache:/root/.terraform.d \
    -w /workspace \
    hashicorp/terraform:latest init

exit_code=$?
if [ $exit_code -eq 0 ]; then
    echo -e "${GREEN}✅ Terraform initialisé avec succès${NC}"
else
    echo -e "${RED}❌ Erreur lors de l'initialisation${NC}"
fi

exit $exit_code

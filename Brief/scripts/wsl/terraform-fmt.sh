#!/bin/bash
# Script pour formater les fichiers Terraform via Docker (WSL)
# Usage: ./scripts/terraform-fmt.sh

CYAN='\033[0;36m'
GREEN='\033[0;32m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$SCRIPT_DIR"

if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Erreur: Docker n'est pas installé${NC}"
    exit 1
fi

echo -e "${CYAN}📝 Formatage des fichiers Terraform...${NC}"

docker run --rm -it \
    -v "$SCRIPT_DIR:/workspace" \
    -v terraform-plugins:/root/.terraform.d/plugins \
    -v terraform-cache:/root/.terraform.d \
    -w /workspace \
    hashicorp/terraform:latest fmt

echo -e "${GREEN}✅ Formatage terminé${NC}"

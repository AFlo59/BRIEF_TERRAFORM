#!/bin/bash
# Script pour nettoyer les fichiers Terraform (état, cache, etc.)
# Usage: ./scripts/wsl/terraform-clean.sh

CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BRIEF_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$BRIEF_DIR"

echo -e "${CYAN}🧹 Nettoyage des fichiers Terraform...${NC}"

# Supprimer .terraform et .terraform.lock.hcl
if [ -d ".terraform" ]; then
    echo -e "${YELLOW}🗑️  Suppression de .terraform/...${NC}"
    rm -rf .terraform
fi

if [ -f ".terraform.lock.hcl" ]; then
    echo -e "${YELLOW}🗑️  Suppression de .terraform.lock.hcl...${NC}"
    rm -f .terraform.lock.hcl
fi

# Supprimer les fichiers de plan
if [ -f "terraform.tfplan" ]; then
    echo -e "${YELLOW}🗑️  Suppression de terraform.tfplan...${NC}"
    rm -f terraform.tfplan
fi

if [ -f "terraform.tfplan.json" ]; then
    echo -e "${YELLOW}🗑️  Suppression de terraform.tfplan.json...${NC}"
    rm -f terraform.tfplan.json
fi

echo -e "${GREEN}✅ Nettoyage terminé${NC}"
echo -e "${CYAN}💡 Vous pouvez maintenant réinitialiser avec: ./scripts/wsl/terraform-init.sh${NC}"

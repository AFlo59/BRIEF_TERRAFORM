#!/bin/bash
# Script pour formater les fichiers Terraform via Docker (WSL)
# Usage: ./scripts/wsl/terraform-fmt.sh

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

echo -e "${CYAN}📝 Formatage des fichiers Terraform...${NC}"

docker run --rm -it \
    -v "$BRIEF_DIR:/workspace" \
    -v terraform-plugins:/root/.terraform.d/plugins \
    -v terraform-cache:/root/.terraform.d \
    -w /workspace \
    terraform-brief:latest fmt

echo -e "${GREEN}✅ Formatage terminé${NC}"

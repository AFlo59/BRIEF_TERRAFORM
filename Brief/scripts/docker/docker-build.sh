#!/bin/bash
# Script pour construire l'image Docker Terraform
# Usage: ./scripts/docker/docker-build.sh

CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Obtenir le répertoire du script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BRIEF_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
DOCKER_DIR="$BRIEF_DIR/docker"

# Vérifier Docker
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Erreur: Docker n'est pas installé${NC}"
    exit 1
fi

echo -e "${CYAN}🔨 Construction de l'image Docker Terraform...${NC}"
echo -e "${YELLOW}📁 Dossier Docker: $DOCKER_DIR${NC}"

cd "$DOCKER_DIR"

# Build l'image
docker build -t terraform-brief:latest .

exit_code=$?
if [ $exit_code -eq 0 ]; then
    echo -e "${GREEN}✅ Image Docker construite avec succès${NC}"
    echo -e "${CYAN}📦 Image: terraform-brief:latest${NC}"
    docker images terraform-brief:latest
else
    echo -e "${RED}❌ Erreur lors de la construction${NC}"
    exit $exit_code
fi

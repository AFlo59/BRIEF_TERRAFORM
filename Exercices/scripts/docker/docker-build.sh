#!/bin/bash
# Script pour construire l'image Docker Terraform pour les exercices
# Usage: ./scripts/docker/docker-build.sh

CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXERCICES_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
DOCKER_DIR="$EXERCICES_DIR/docker"

if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Erreur: Docker n'est pas installé${NC}"
    exit 1
fi

echo -e "${CYAN}🔨 Construction de l'image Docker Terraform pour les exercices...${NC}"
echo -e "${YELLOW}📁 Dossier Docker: $DOCKER_DIR${NC}"

cd "$DOCKER_DIR"

docker build -t terraform-exercices:latest .

exit_code=$?
if [ $exit_code -eq 0 ]; then
    echo -e "${GREEN}✅ Image Docker construite avec succès${NC}"
    echo -e "${CYAN}📦 Image: terraform-exercices:latest${NC}"
    docker images terraform-exercices:latest
else
    echo -e "${RED}❌ Erreur lors de la construction${NC}"
    exit $exit_code
fi

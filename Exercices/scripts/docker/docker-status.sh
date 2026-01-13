#!/bin/bash
# Script pour vérifier le statut de l'image Docker - Exercices
# Usage: ./scripts/docker/docker-status.sh

CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Erreur: Docker n'est pas installé${NC}"
    exit 1
fi

echo -e "${CYAN}📊 Statut de l'image Docker Terraform${NC}"
echo ""

# Vérifier si l'image existe
if docker images terraform-exercices:latest --format "{{.Repository}}:{{.Tag}}" | grep -q "terraform-exercices:latest"; then
    echo -e "${GREEN}✅ Image terraform-exercices:latest trouvée${NC}"
    echo ""
    docker images terraform-exercices:latest
    echo ""
    echo -e "${CYAN}📦 Informations détaillées:${NC}"
    docker inspect terraform-exercices:latest --format '{{.Created}}' | xargs -I {} echo "Créée le: {}"
else
    echo -e "${YELLOW}⚠️  Image terraform-exercices:latest non trouvée${NC}"
    echo -e "${CYAN}💡 Construisez l'image: ./scripts/docker/docker-build.sh${NC}"
fi

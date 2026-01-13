#!/bin/bash
# Script pour supprimer l'image Docker
# Usage: ./scripts/docker/docker-remove.sh

CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Erreur: Docker n'est pas installé${NC}"
    exit 1
fi

# Vérifier que l'image existe
if ! docker images terraform-brief:latest --format "{{.Repository}}:{{.Tag}}" | grep -q "terraform-brief:latest"; then
    echo -e "${YELLOW}⚠️  Image terraform-brief:latest non trouvée${NC}"
    exit 0
fi

echo -e "${YELLOW}⚠️  Attention: Cette commande va supprimer l'image terraform-brief:latest${NC}"
read -p "Êtes-vous sûr? (yes/no): " confirm

if [ "$confirm" = "yes" ]; then
    echo -e "${CYAN}🗑️  Suppression de l'image...${NC}"
    docker rmi terraform-brief:latest

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Image supprimée avec succès${NC}"
    else
        echo -e "${RED}❌ Erreur lors de la suppression${NC}"
        exit 1
    fi
else
    echo -e "${CYAN}❌ Opération annulée${NC}"
fi

#!/bin/bash
# Script pour reconstruire l'image Docker (update)
# Usage: ./scripts/docker/docker-update.sh

CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BRIEF_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
DOCKER_DIR="$BRIEF_DIR/docker"

if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Erreur: Docker n'est pas installé${NC}"
    exit 1
fi

echo -e "${CYAN}🔄 Mise à jour de l'image Docker Terraform...${NC}"

cd "$DOCKER_DIR"

# Supprimer l'ancienne image (optionnel)
if docker images terraform-brief:latest --format "{{.Repository}}:{{.Tag}}" | grep -q "terraform-brief:latest"; then
    echo -e "${YELLOW}🗑️  Suppression de l'ancienne image...${NC}"
    docker rmi terraform-brief:latest 2>/dev/null || true
fi

# Rebuild sans cache pour forcer la mise à jour
echo -e "${CYAN}🔨 Reconstruction de l'image (sans cache)...${NC}"
docker build --no-cache -t terraform-brief:latest .

exit_code=$?
if [ $exit_code -eq 0 ]; then
    echo -e "${GREEN}✅ Image Docker mise à jour avec succès${NC}"
    docker images terraform-brief:latest
else
    echo -e "${RED}❌ Erreur lors de la mise à jour${NC}"
    exit $exit_code
fi

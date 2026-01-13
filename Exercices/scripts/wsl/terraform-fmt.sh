#!/bin/bash
# Script pour formater les fichiers Terraform via Docker (WSL) - Exercices
# Usage: ./scripts/wsl/terraform-fmt.sh [exercice_dir]

CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXERCICES_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Si un exercice est spécifié, utiliser ce dossier
if [ -n "$1" ]; then
    WORK_DIR="$EXERCICES_DIR/$1"
else
    WORK_DIR="$EXERCICES_DIR"
fi

cd "$WORK_DIR"

if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Erreur: Docker n'est pas installé${NC}"
    exit 1
fi

# Vérifier que l'image existe
if ! docker images terraform-exercices:latest --format "{{.Repository}}:{{.Tag}}" | grep -q "terraform-exercices:latest"; then
    echo -e "${YELLOW}⚠️  Image terraform-exercices:latest non trouvée${NC}"
    echo -e "${CYAN}💡 Construction de l'image...${NC}"
    "$EXERCICES_DIR/scripts/docker/docker-build.sh" || exit 1
fi

echo -e "${CYAN}📝 Formatage des fichiers Terraform...${NC}"

docker run --rm -it \
    -v "$WORK_DIR:/workspace" \
    -v terraform-plugins-exercices:/root/.terraform.d/plugins \
    -v terraform-cache-exercices:/root/.terraform.d \
    -w /workspace \
    terraform-exercices:latest fmt

echo -e "${GREEN}✅ Formatage terminé${NC}"

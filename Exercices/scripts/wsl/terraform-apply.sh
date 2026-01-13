#!/bin/bash
# Script pour appliquer Terraform via Docker (WSL) - Exercices
# Usage: ./scripts/wsl/terraform-apply.sh [exercice_dir] [options]

CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXERCICES_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

# Si le premier argument est un dossier d'exercice, l'utiliser
if [ -n "$1" ] && [ -d "$EXERCICES_DIR/$1" ]; then
    WORK_DIR="$EXERCICES_DIR/$1"
    shift
    ARGS="$@"
else
    WORK_DIR="$EXERCICES_DIR"
    ARGS="$@"
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

echo -e "${CYAN}⚙️  Application de la configuration Terraform...${NC}"

docker run --rm -it \
    -v "$WORK_DIR:/workspace" \
    -v terraform-plugins-exercices:/root/.terraform.d/plugins \
    -v terraform-cache-exercices:/root/.terraform.d \
    -w /workspace \
    terraform-exercices:latest apply $ARGS

exit_code=$?
if [ $exit_code -eq 0 ]; then
    echo -e "${GREEN}✅ Configuration appliquée avec succès${NC}"
else
    echo -e "${RED}❌ Erreur lors de l'application${NC}"
fi

exit $exit_code

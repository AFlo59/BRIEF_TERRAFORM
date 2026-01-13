#!/bin/bash
# Script pour lancer le conteneur Docker Terraform en mode interactif
# Usage: ./scripts/docker/docker-run.sh [command]
#
# Sans argument: Lance un shell bash interactif dans le conteneur
# Avec argument: Exécute la commande spécifiée dans le conteneur

CYAN='\033[0;36m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BRIEF_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Erreur: Docker n'est pas installé${NC}"
    exit 1
fi

# Vérifier que l'image existe
if ! docker images terraform-brief:latest --format "{{.Repository}}:{{.Tag}}" | grep -q "terraform-brief:latest"; then
    echo -e "${RED}❌ Image terraform-brief:latest non trouvée${NC}"
    echo -e "${CYAN}💡 Construisez l'image d'abord: ./scripts/docker/docker-build.sh${NC}"
    exit 1
fi

# Détecter le dossier .azure pour les credentials Azure CLI
AZURE_DIR=""
if [ -L ~/.azure ]; then
    AZURE_DIR=$(readlink -f ~/.azure)
elif [ -d ~/.azure ]; then
    AZURE_DIR=~/.azure
elif [ -d /mnt/c/Users/*/.azure ]; then
    AZURE_DIR=$(ls -d /mnt/c/Users/*/.azure 2>/dev/null | head -1)
fi

# Si aucune commande n'est fournie, lancer un shell interactif
if [ $# -eq 0 ]; then
    echo -e "${CYAN}🐳 Lancement du conteneur Docker en mode interactif...${NC}"
    echo -e "${YELLOW}💡 Vous êtes maintenant dans le conteneur. Tapez 'exit' pour quitter.${NC}"
    echo ""

    DOCKER_CMD="docker run --rm -it \
        --entrypoint /bin/bash \
        -v \"$BRIEF_DIR:/workspace\" \
        -v terraform-plugins:/root/.terraform.d/plugins \
        -v terraform-cache:/root/.terraform.d"

    if [ -n "$AZURE_DIR" ] && ([ -d "$AZURE_DIR" ] || [ -L "$AZURE_DIR" ]); then
        DOCKER_CMD="$DOCKER_CMD -v \"$AZURE_DIR:/root/.azure\""
    fi

    DOCKER_CMD="$DOCKER_CMD -w /workspace \
        terraform-brief:latest"

    eval $DOCKER_CMD
else
    # Exécuter la commande fournie (avec terraform en préfixe si nécessaire)
    DOCKER_CMD="docker run --rm -it \
        -v \"$BRIEF_DIR:/workspace\" \
        -v terraform-plugins:/root/.terraform.d/plugins \
        -v terraform-cache:/root/.terraform.d"

    if [ -n "$AZURE_DIR" ] && ([ -d "$AZURE_DIR" ] || [ -L "$AZURE_DIR" ]); then
        DOCKER_CMD="$DOCKER_CMD -v \"$AZURE_DIR:/root/.azure\""
    fi

    DOCKER_CMD="$DOCKER_CMD -w /workspace \
        terraform-brief:latest \
        \"$@\""

    eval $DOCKER_CMD
fi

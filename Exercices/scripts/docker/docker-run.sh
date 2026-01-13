#!/bin/bash
# Script pour lancer le conteneur Docker Terraform en mode interactif - Exercices
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
EXERCICES_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Erreur: Docker n'est pas installé${NC}"
    exit 1
fi

# Vérifier que l'image existe
if ! docker images terraform-exercices:latest --format "{{.Repository}}:{{.Tag}}" | grep -q "terraform-exercices:latest"; then
    echo -e "${RED}❌ Image terraform-exercices:latest non trouvée${NC}"
    echo -e "${CYAN}💡 Construisez l'image d'abord: ./scripts/docker/docker-build.sh${NC}"
    exit 1
fi

# Si aucune commande n'est fournie, lancer un shell interactif
if [ $# -eq 0 ]; then
    echo -e "${CYAN}🐳 Lancement du conteneur Docker en mode interactif...${NC}"
    echo -e "${YELLOW}💡 Vous êtes maintenant dans le conteneur. Tapez 'exit' pour quitter.${NC}"
    echo ""
    docker run --rm -it \
        -v "$EXERCICES_DIR:/workspace" \
        -v terraform-plugins-exercices:/root/.terraform.d/plugins \
        -v terraform-cache-exercices:/root/.terraform.d \
        -w /workspace \
        terraform-exercices:latest \
        bash
else
    # Exécuter la commande fournie
    docker run --rm -it \
        -v "$EXERCICES_DIR:/workspace" \
        -v terraform-plugins-exercices:/root/.terraform.d/plugins \
        -v terraform-cache-exercices:/root/.terraform.d \
        -w /workspace \
        terraform-exercices:latest \
        "$@"
fi

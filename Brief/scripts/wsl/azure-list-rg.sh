#!/bin/bash
# Script pour lister les Resource Groups Azure disponibles
# Usage: ./scripts/wsl/azure-list-rg.sh

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

# Charger les helpers
source "$SCRIPT_DIR/_helpers.sh" 2>/dev/null || true

# Détecter le dossier .azure
AZURE_VOLUME=$(get_azure_volume_mount)

echo -e "${CYAN}📋 Liste des Resource Groups Azure disponibles${NC}"
echo ""

docker run --rm -it \
    -v "$BRIEF_DIR:/workspace" \
    $(echo $AZURE_VOLUME) \
    -w /workspace \
    terraform-brief:latest \
    az group list --output table

echo ""
echo -e "${YELLOW}💡 Pour voir les détails d'un Resource Group spécifique :${NC}"
echo "   docker run --rm -it -v \"\$PWD:/workspace\" -v \"\$HOME/.azure:/root/.azure\" -w /workspace terraform-brief:latest az group show --name NOM_DU_RG"

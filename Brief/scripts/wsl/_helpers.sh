#!/bin/bash
# Fonctions helper pour les scripts Terraform WSL

# Vérifier et construire l'image Docker si nécessaire
check_docker_image() {
    local BRIEF_DIR="$1"

    if ! docker images terraform-brief:latest --format "{{.Repository}}:{{.Tag}}" | grep -q "terraform-brief:latest"; then
        echo -e "${YELLOW}⚠️  Image terraform-brief:latest non trouvée${NC}"
        echo -e "${CYAN}💡 Construction de l'image...${NC}"
        "$BRIEF_DIR/scripts/docker/docker-build.sh" || exit 1
    fi
}

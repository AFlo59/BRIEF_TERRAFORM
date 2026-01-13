#!/bin/bash
# Script wrapper pour utiliser Terraform via Docker dans WSL
# Usage: ./scripts/terraform-wsl.sh <command> [options]

# Couleurs pour les messages
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Chemin vers le dossier Terraform
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TERRAFORM_DIR="$SCRIPT_DIR/../infrastructure/terraform"

# Vérifier que le dossier existe
if [ ! -d "$TERRAFORM_DIR" ]; then
    echo -e "${RED}❌ Erreur: Le dossier $TERRAFORM_DIR n'existe pas${NC}"
    exit 1
fi

# Vérifier que Docker est disponible
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Erreur: Docker n'est pas installé ou n'est pas dans le PATH${NC}"
    exit 1
fi

# Fonction pour exécuter Terraform dans Docker
run_terraform() {
    local command=$1
    shift
    local args=("$@")
    
    # Détecter si -chdir est utilisé
    local work_dir="$TERRAFORM_DIR"
    local terraform_args=("$command")
    
    # Chercher -chdir dans les arguments
    for i in "${!args[@]}"; do
        if [[ "${args[$i]}" == "-chdir" ]] && [[ -n "${args[$i+1]}" ]]; then
            # -chdir trouvé, utiliser ce répertoire
            work_dir="$TERRAFORM_DIR/${args[$i+1]}"
            # Retirer -chdir et sa valeur des args
            terraform_args+=("${args[@]:0:$i}")
            terraform_args+=("${args[@]:$((i+2))}")
            break
        fi
    done
    
    # Si -chdir n'a pas été trouvé, ajouter tous les args
    if [[ "${#terraform_args[@]}" -eq 1 ]]; then
        terraform_args+=("${args[@]}")
    fi
    
    # Vérifier que le répertoire de travail existe
    if [ ! -d "$work_dir" ]; then
        echo -e "${RED}❌ Erreur: Le dossier $work_dir n'existe pas${NC}"
        exit 1
    fi
    
    # Détecter si on est dans un environnement interactif
    if [ -t 0 ]; then
        # Terminal interactif disponible
        docker run --rm -it \
            -v "$work_dir:/workspace" \
            -v terraform-plugins:/root/.terraform.d/plugins \
            -v terraform-cache:/root/.terraform.d \
            -w /workspace \
            hashicorp/terraform:latest \
            "${terraform_args[@]}"
    else
        # Pas de terminal interactif (ex: script non-interactif)
        docker run --rm -i \
            -v "$work_dir:/workspace" \
            -v terraform-plugins:/root/.terraform.d/plugins \
            -v terraform-cache:/root/.terraform.d \
            -w /workspace \
            hashicorp/terraform:latest \
            "${terraform_args[@]}"
    fi
}

# Gestion des commandes
case "${1,,}" in
    init)
        echo -e "${CYAN}🚀 Initialisation de Terraform...${NC}"
        run_terraform "init" "${@:2}"
        ;;
    plan)
        echo -e "${CYAN}📋 Génération du plan Terraform...${NC}"
        run_terraform "plan" "${@:2}"
        ;;
    apply)
        echo -e "${CYAN}⚙️  Application de la configuration Terraform...${NC}"
        run_terraform "apply" "${@:2}"
        ;;
    destroy)
        echo -e "${YELLOW}🗑️  Destruction de l'infrastructure...${NC}"
        read -p "Êtes-vous sûr de vouloir détruire l'infrastructure? (yes/no): " confirm
        if [ "$confirm" = "yes" ]; then
            run_terraform "destroy" "${@:2}"
        else
            echo -e "${RED}❌ Opération annulée${NC}"
        fi
        ;;
    validate)
        echo -e "${CYAN}✅ Validation de la configuration Terraform...${NC}"
        run_terraform "validate" "${@:2}"
        ;;
    fmt)
        echo -e "${CYAN}📝 Formatage des fichiers Terraform...${NC}"
        run_terraform "fmt" "${@:2}"
        ;;
    version)
        run_terraform "version" "${@:2}"
        ;;
    help|"")
        echo ""
        echo -e "${CYAN}========================================${NC}"
        echo -e "${CYAN}  Terraform via Docker - Aide${NC}"
        echo -e "${CYAN}========================================${NC}"
        echo ""
        echo "Usage: ./scripts/terraform-wsl.sh <command> [options]"
        echo ""
        echo -e "${YELLOW}Commandes disponibles:${NC}"
        echo "  init      - Initialise Terraform dans le répertoire"
        echo "  plan      - Génère un plan d'exécution"
        echo "  apply     - Applique les changements"
        echo "  destroy   - Détruit l'infrastructure"
        echo "  validate  - Valide la configuration"
        echo "  fmt       - Formate les fichiers .tf"
        echo "  version   - Affiche la version de Terraform"
        echo ""
        echo -e "${YELLOW}Exemples:${NC}"
        echo "  ./scripts/terraform-wsl.sh init"
        echo "  ./scripts/terraform-wsl.sh plan"
        echo "  ./scripts/terraform-wsl.sh apply -auto-approve"
        echo "  ./scripts/terraform-wsl.sh validate"
        echo ""
        ;;
    *)
        echo -e "${YELLOW}⚠️  Commande non reconnue, exécution directe: $1${NC}"
        run_terraform "$1" "${@:2}"
        ;;
esac

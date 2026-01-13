#!/bin/bash
# Script wrapper pour l'exercice 4
# Usage: ./run.sh <command> [options]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$SCRIPT_DIR/../../.."
TERRAFORM_SCRIPT="$PROJECT_ROOT/scripts/terraform-wsl.sh"

cd "$SCRIPT_DIR"

if [ ! -f "$TERRAFORM_SCRIPT" ]; then
    echo "❌ Erreur: Script terraform-wsl.sh non trouvé à $TERRAFORM_SCRIPT"
    exit 1
fi

"$TERRAFORM_SCRIPT" "$@"

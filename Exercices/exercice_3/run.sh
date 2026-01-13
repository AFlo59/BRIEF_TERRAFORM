#!/bin/bash
# Script wrapper pour l'exercice 3
# Usage: ./run.sh <command> [options]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXERCICES_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

cd "$SCRIPT_DIR"

case "$1" in
    init)
        "$EXERCICES_DIR/scripts/wsl/terraform-init.sh" exercice_3
        ;;
    plan)
        "$EXERCICES_DIR/scripts/wsl/terraform-plan.sh" exercice_3
        ;;
    apply)
        "$EXERCICES_DIR/scripts/wsl/terraform-apply.sh" exercice_3 "${@:2}"
        ;;
    destroy)
        "$EXERCICES_DIR/scripts/wsl/terraform-destroy.sh" exercice_3 "${@:2}"
        ;;
    *)
        echo "Usage: ./run.sh {init|plan|apply|destroy} [options]"
        exit 1
        ;;
esac

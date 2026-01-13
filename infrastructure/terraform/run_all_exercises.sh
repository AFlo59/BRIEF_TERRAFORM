#!/bin/bash
# Script pour exécuter tous les exercices Terraform
# Usage: ./run_all_exercises.sh [init|plan|apply|destroy]

EXERCISE_COMMAND="${1:-apply}"

echo "=========================================="
echo "  Exécution de tous les exercices Terraform"
echo "  Commande: $EXERCISE_COMMAND"
echo "=========================================="
echo ""

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for i in {1..4}; do
    EXERCISE_DIR="$BASE_DIR/exercice_$i"

    if [ ! -d "$EXERCISE_DIR" ]; then
        echo "⚠️  Dossier exercice_$i non trouvé, ignoré"
        continue
    fi

    echo "=========================================="
    echo "  Exercice $i"
    echo "=========================================="
    echo ""

    cd "$EXERCISE_DIR"

    if [ ! -f "run.sh" ]; then
        echo "⚠️  Script run.sh non trouvé dans exercice_$i"
        continue
    fi

    chmod +x run.sh

    case "$EXERCISE_COMMAND" in
        init)
            echo "🚀 Initialisation..."
            ./run.sh init
            ;;
        plan)
            echo "📋 Plan..."
            ./run.sh plan
            ;;
        apply)
            echo "⚙️  Application..."
            ./run.sh apply -auto-approve
            ;;
        destroy)
            echo "🗑️  Destruction..."
            ./run.sh destroy -auto-approve
            ;;
        *)
            echo "❌ Commande non reconnue: $EXERCISE_COMMAND"
            echo "Usage: $0 [init|plan|apply|destroy]"
            exit 1
            ;;
    esac

    echo ""
    echo "✅ Exercice $i terminé"
    echo ""

    cd "$BASE_DIR"
done

echo "=========================================="
echo "  Tous les exercices terminés !"
echo "=========================================="

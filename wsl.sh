#!/bin/bash
# Script pour ouvrir WSL dans le répertoire actuel (à utiliser depuis WSL)
# Usage: source wsl.sh ou . wsl.sh

# Le script est déjà dans WSL, donc on reste dans le répertoire actuel
echo "🐧 WSL dans: $(pwd)"
echo ""

# Si vous voulez exécuter quelque chose de spécifique, vous pouvez le faire ici
# Par exemple, vérifier Docker:
# docker --version

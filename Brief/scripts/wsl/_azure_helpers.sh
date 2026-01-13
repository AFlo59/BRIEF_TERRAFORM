#!/bin/bash
# Helper functions pour gérer les credentials Azure CLI dans Docker

# Fonction pour obtenir le chemin du dossier .azure
get_azure_dir() {
    # Essayer plusieurs emplacements possibles
    if [ -L ~/.azure ]; then
        # Si c'est un lien symbolique (WSL vers Windows)
        readlink -f ~/.azure
    elif [ -d ~/.azure ]; then
        # Si le dossier existe directement
        echo ~/.azure
    elif [ -d /mnt/c/Users/*/.azure ]; then
        # Chercher dans Windows via WSL
        ls -d /mnt/c/Users/*/.azure 2>/dev/null | head -1
    else
        # Par défaut, essayer le chemin Windows standard
        echo "/mnt/c/Users/$USER/.azure"
    fi
}

# Fonction pour obtenir les arguments Docker pour monter .azure
get_azure_volume_args() {
    local azure_dir=$(get_azure_dir)

    if [ -d "$azure_dir" ] || [ -L "$azure_dir" ]; then
        # Monter en lecture seule pour la sécurité
        echo "-v \"$azure_dir:/root/.azure:ro\""
    else
        # Si le dossier n'existe pas, retourner vide (pas d'erreur)
        echo ""
    fi
}

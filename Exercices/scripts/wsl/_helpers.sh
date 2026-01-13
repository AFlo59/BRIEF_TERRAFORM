#!/bin/bash
# Helper functions pour les scripts Terraform WSL - Exercices

# Fonction pour obtenir le chemin du dossier .azure (credentials Azure CLI)
get_azure_dir() {
    # Essayer plusieurs emplacements possibles
    if [ -L ~/.azure ]; then
        # Si c'est un lien symbolique (WSL vers Windows)
        readlink -f ~/.azure
    elif [ -d ~/.azure ]; then
        # Si le dossier existe directement dans WSL
        echo ~/.azure
    elif [ -d /mnt/c/Users/*/.azure ]; then
        # Chercher dans Windows via WSL
        ls -d /mnt/c/Users/*/.azure 2>/dev/null | head -1
    else
        # Par défaut, essayer le chemin Windows standard
        echo ""
    fi
}

# Fonction pour obtenir les arguments Docker pour monter .azure
# Retourne une chaîne vide si le dossier n'existe pas
get_azure_volume_mount() {
    local azure_dir=$(get_azure_dir)

    if [ -n "$azure_dir" ] && ([ -d "$azure_dir" ] || [ -L "$azure_dir" ]); then
        # Monter en lecture seule pour la sécurité
        echo "-v \"$azure_dir:/root/.azure:ro\""
    else
        # Si le dossier n'existe pas, retourner vide
        echo ""
    fi
}

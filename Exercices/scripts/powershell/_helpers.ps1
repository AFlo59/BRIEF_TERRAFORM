# Helper functions pour les scripts Terraform PowerShell - Exercices

# Fonction pour obtenir le chemin du dossier .azure (credentials Azure CLI)
function Get-AzureDir {
    # Essayer plusieurs emplacements possibles
    $azurePath = "$env:USERPROFILE\.azure"

    if (Test-Path $azurePath) {
        return (Resolve-Path $azurePath).Path
    }

    # Essayer aussi dans le home directory
    $homeAzure = "$HOME\.azure"
    if (Test-Path $homeAzure) {
        return (Resolve-Path $homeAzure).Path
    }

    return ""
}

# Fonction pour obtenir les arguments Docker pour monter .azure
function Get-AzureVolumeMount {
    $azureDir = Get-AzureDir

    if ($azureDir -and (Test-Path $azureDir)) {
        # Monter en lecture-écriture (Azure CLI a besoin d'écrire des logs)
        # Le conteneur est isolé et supprimé après utilisation (--rm), donc c'est sécurisé
        return "-v `"${azureDir}:/root/.azure`""
    }

    return ""
}

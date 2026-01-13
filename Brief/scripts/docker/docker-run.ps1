# Script pour lancer le conteneur Docker Terraform en mode interactif
# Usage: .\scripts\docker\docker-run.ps1 [command]
#
# Sans argument: Lance un shell bash interactif dans le conteneur
# Avec argument: Exécute la commande spécifiée dans le conteneur

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$BriefDir = Split-Path -Parent (Split-Path -Parent $ScriptDir)

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Erreur: Docker n'est pas installé" -ForegroundColor Red
    exit 1
}

# Vérifier que l'image existe
$imageExists = docker images terraform-brief:latest --format "{{.Repository}}:{{.Tag}}" | Select-String "terraform-brief:latest"
if (-not $imageExists) {
    Write-Host "❌ Image terraform-brief:latest non trouvée" -ForegroundColor Red
    Write-Host "💡 Construisez l'image d'abord: .\scripts\docker\docker-build.ps1" -ForegroundColor Cyan
    exit 1
}

# Charger les helpers PowerShell
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$HelpersPath = Join-Path (Split-Path -Parent $ScriptDir) "powershell\_helpers.ps1"
if (Test-Path $HelpersPath) {
    . $HelpersPath
}

# Détecter le dossier .azure pour les credentials Azure CLI
$azureVolume = Get-AzureVolumeMount

# Retirer :ro si présent (Azure CLI a besoin d'écrire des logs)
if ($azureVolume) {
    $azureVolume = $azureVolume -replace ':ro', ''
}

$workspacePath = (Resolve-Path $BriefDir).Path

# Si aucune commande n'est fournie, lancer un shell interactif
if ($args.Count -eq 0) {
    Write-Host "🐳 Lancement du conteneur Docker en mode interactif..." -ForegroundColor Cyan
    Write-Host "💡 Vous êtes maintenant dans le conteneur. Tapez 'exit' pour quitter." -ForegroundColor Yellow
    Write-Host ""

    $dockerCmd = "docker run --rm -it `"
        --entrypoint /bin/bash `"
        -v `"${workspacePath}:/workspace`" `"
        -v terraform-plugins:/root/.terraform.d/plugins `"
        -v terraform-cache:/root/.terraform.d"

    if ($azureVolume) {
        $dockerCmd += " $azureVolume"
    }

    $dockerCmd += " `"
        -w /workspace `"
        terraform-brief:latest"

    Invoke-Expression $dockerCmd
} else {
    # Exécuter la commande fournie (avec terraform en préfixe si nécessaire)
    $dockerCmd = "docker run --rm -it `"
        -v `"${workspacePath}:/workspace`" `"
        -v terraform-plugins:/root/.terraform.d/plugins `"
        -v terraform-cache:/root/.terraform.d"

    if ($azureVolume) {
        $dockerCmd += " $azureVolume"
    }

    $dockerCmd += " `"
        -w /workspace `"
        terraform-brief:latest `"
        $($args -join ' ')"

    Invoke-Expression $dockerCmd
}

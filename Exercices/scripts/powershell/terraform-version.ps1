# Script pour afficher la version de Terraform via Docker (PowerShell) - Exercices
# Usage: .\scripts\powershell\terraform-version.ps1

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ExercicesDir = Split-Path -Parent $ScriptDir
Set-Location $ExercicesDir

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Erreur: Docker n'est pas installé" -ForegroundColor Red
    exit 1
}

# Vérifier que l'image existe
$imageExists = docker images terraform-exercices:latest --format "{{.Repository}}:{{.Tag}}" | Select-String "terraform-exercices:latest"
if (-not $imageExists) {
    Write-Host "⚠️  Image terraform-exercices:latest non trouvée" -ForegroundColor Yellow
    Write-Host "💡 Construction de l'image..." -ForegroundColor Cyan
    & "$ExercicesDir\scripts\docker\docker-build.ps1"
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
}

Write-Host "📦 Version de Terraform:" -ForegroundColor Cyan

# Charger les helpers
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$ScriptDir\_helpers.ps1"

# Détecter le dossier .azure pour les credentials Azure CLI
$azureVolume = Get-AzureVolumeMount

$workspacePath = (Resolve-Path $ExercicesDir).Path

# Construire la commande Docker
$dockerCmd = "docker run --rm -it `"
    -v `"${workspacePath}:/workspace`" `"
    -v terraform-plugins-exercices:/root/.terraform.d/plugins `"
    -v terraform-cache-exercices:/root/.terraform.d"

# Ajouter le montage Azure si disponible
if ($azureVolume) {
    $dockerCmd += " $azureVolume"
}

$dockerCmd += " `"
    -w /workspace `"
    terraform-exercices:latest version"

Invoke-Expression $dockerCmd

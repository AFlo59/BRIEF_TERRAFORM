# Script pour formater les fichiers Terraform via Docker (PowerShell)
# Usage: .\scripts\powershell\terraform-fmt.ps1

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$BriefDir = Split-Path -Parent $ScriptDir
Set-Location $BriefDir

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Erreur: Docker n'est pas installé" -ForegroundColor Red
    exit 1
}

# Vérifier que l'image existe
$imageExists = docker images terraform-brief:latest --format "{{.Repository}}:{{.Tag}}" | Select-String "terraform-brief:latest"
if (-not $imageExists) {
    Write-Host "⚠️  Image terraform-brief:latest non trouvée" -ForegroundColor Yellow
    Write-Host "💡 Construction de l'image..." -ForegroundColor Cyan
    & "$BriefDir\scripts\docker\docker-build.ps1"
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
}

Write-Host "📝 Formatage des fichiers Terraform..." -ForegroundColor Cyan

# Charger les helpers
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$ScriptDir\_helpers.ps1"

# Détecter le dossier .azure pour les credentials Azure CLI
$azureVolume = Get-AzureVolumeMount

$workspacePath = (Resolve-Path $BriefDir).Path

# Construire la commande Docker
$dockerCmd = "docker run --rm -it `"
    -v `"${workspacePath}:/workspace`" `"
    -v terraform-plugins:/root/.terraform.d/plugins `"
    -v terraform-cache:/root/.terraform.d"

# Ajouter le montage Azure si disponible
if ($azureVolume) {
    $dockerCmd += " $azureVolume"
}

$dockerCmd += " `"
    -w /workspace `"
    terraform-brief:latest fmt"

Invoke-Expression $dockerCmd

Write-Host "✅ Formatage terminé" -ForegroundColor Green

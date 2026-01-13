# Script pour appliquer Terraform via Docker (PowerShell) - Exercices
# Usage: .\scripts\powershell\terraform-apply.ps1 [exercice_dir] [options]

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ExercicesDir = Split-Path -Parent (Split-Path -Parent $ScriptDir)

if ($args.Count -gt 0 -and (Test-Path "$ExercicesDir\$($args[0])")) {
    $WorkDir = "$ExercicesDir\$($args[0])"
    $terraformArgs = $args[1..($args.Count-1)]
} else {
    $WorkDir = $ExercicesDir
    $terraformArgs = $args
}

Set-Location $WorkDir

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Erreur: Docker n'est pas installé" -ForegroundColor Red
    exit 1
}

$imageExists = docker images terraform-exercices:latest --format "{{.Repository}}:{{.Tag}}" | Select-String "terraform-exercices:latest"
if (-not $imageExists) {
    Write-Host "⚠️  Image terraform-exercices:latest non trouvée" -ForegroundColor Yellow
    Write-Host "💡 Construction de l'image..." -ForegroundColor Cyan
    & "$ExercicesDir\scripts\docker\docker-build.ps1"
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
}

Write-Host "⚙️  Application de la configuration Terraform..." -ForegroundColor Cyan

# Charger les helpers
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$ScriptDir\_helpers.ps1"

# Détecter le dossier .azure pour les credentials Azure CLI
$azureVolume = Get-AzureVolumeMount

$workspacePath = (Resolve-Path $WorkDir).Path

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
    terraform-exercices:latest apply"

if ($terraformArgs.Count -gt 0) {
    $dockerCmd += " $($terraformArgs -join ' ')"
}

Invoke-Expression $dockerCmd

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Configuration appliquée avec succès" -ForegroundColor Green
} else {
    Write-Host "❌ Erreur lors de l'application" -ForegroundColor Red
    exit $LASTEXITCODE
}

# Script pour détruire l'infrastructure Terraform via Docker (PowerShell)
# Usage: .\scripts\powershell\terraform-destroy.ps1 [OPTIONS]
# Exemple: .\scripts\powershell\terraform-destroy.ps1 -auto-approve

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

# Vérifier si -auto-approve est dans les arguments
$terraformArgs = $args
$autoApprove = $terraformArgs -contains "-auto-approve"

if (-not $autoApprove) {
    Write-Host "⚠️  Attention: Cette commande va détruire toutes les ressources Azure !" -ForegroundColor Yellow
    $confirm = Read-Host "Êtes-vous sûr de vouloir continuer? (yes/no)"
    if ($confirm -ne "yes") {
        Write-Host "❌ Opération annulée" -ForegroundColor Red
        exit 0
    }
}

Write-Host "🗑️  Destruction de l'infrastructure..." -ForegroundColor Cyan

$workspacePath = (Resolve-Path $BriefDir).Path

docker run --rm -it `
    -v "${workspacePath}:/workspace" `
    -v terraform-plugins:/root/.terraform.d/plugins `
    -v terraform-cache:/root/.terraform.d `
    -w /workspace `
    terraform-brief:latest destroy $terraformArgs

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Infrastructure détruite avec succès" -ForegroundColor Green
} else {
    Write-Host "❌ Erreur lors de la destruction" -ForegroundColor Red
    exit $LASTEXITCODE
}

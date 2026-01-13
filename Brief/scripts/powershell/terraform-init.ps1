# Script pour initialiser Terraform via Docker (PowerShell)
# Usage: .\scripts\terraform-init.ps1

$ErrorActionPreference = "Stop"

# Obtenir le répertoire du script et remonter au dossier Brief
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$BriefDir = Split-Path -Parent $ScriptDir
Set-Location $BriefDir

# Vérifier Docker
if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Erreur: Docker n'est pas installé" -ForegroundColor Red
    exit 1
}

Write-Host "🚀 Initialisation de Terraform..." -ForegroundColor Cyan

$workspacePath = (Resolve-Path $BriefDir).Path

docker run --rm -it `
    -v "${workspacePath}:/workspace" `
    -v terraform-plugins:/root/.terraform.d/plugins `
    -v terraform-cache:/root/.terraform.d `
    -w /workspace `
    hashicorp/terraform:latest init

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Terraform initialisé avec succès" -ForegroundColor Green
} else {
    Write-Host "❌ Erreur lors de l'initialisation" -ForegroundColor Red
    exit $LASTEXITCODE
}

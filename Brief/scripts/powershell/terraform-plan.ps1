# Script pour générer le plan Terraform via Docker (PowerShell)
# Usage: .\scripts\terraform-plan.ps1

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$BriefDir = Split-Path -Parent $ScriptDir
Set-Location $BriefDir

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Erreur: Docker n'est pas installé" -ForegroundColor Red
    exit 1
}

Write-Host "📋 Génération du plan Terraform..." -ForegroundColor Cyan

$workspacePath = (Resolve-Path $BriefDir).Path

docker run --rm -it `
    -v "${workspacePath}:/workspace" `
    -v terraform-plugins:/root/.terraform.d/plugins `
    -v terraform-cache:/root/.terraform.d `
    -w /workspace `
    hashicorp/terraform:latest plan

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Plan généré avec succès" -ForegroundColor Green
} else {
    Write-Host "❌ Erreur lors de la génération du plan" -ForegroundColor Red
    exit $LASTEXITCODE
}

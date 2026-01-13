# Script pour valider la configuration Terraform via Docker (PowerShell)
# Usage: .\scripts\terraform-validate.ps1

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$BriefDir = Split-Path -Parent $ScriptDir
Set-Location $BriefDir

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Erreur: Docker n'est pas installé" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Validation de la configuration Terraform..." -ForegroundColor Cyan

$workspacePath = (Resolve-Path $BriefDir).Path

docker run --rm -it `
    -v "${workspacePath}:/workspace" `
    -v terraform-plugins:/root/.terraform.d/plugins `
    -v terraform-cache:/root/.terraform.d `
    -w /workspace `
    hashicorp/terraform:latest validate

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Configuration valide" -ForegroundColor Green
} else {
    Write-Host "❌ Erreurs de validation détectées" -ForegroundColor Red
    exit $LASTEXITCODE
}

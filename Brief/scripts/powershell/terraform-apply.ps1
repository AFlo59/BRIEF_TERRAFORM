# Script pour appliquer la configuration Terraform via Docker (PowerShell)
# Usage: .\scripts\terraform-apply.ps1 [OPTIONS]
# Exemple: .\scripts\terraform-apply.ps1 -auto-approve

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$BriefDir = Split-Path -Parent $ScriptDir
Set-Location $BriefDir

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Erreur: Docker n'est pas installé" -ForegroundColor Red
    exit 1
}

Write-Host "⚙️  Application de la configuration Terraform..." -ForegroundColor Cyan

$workspacePath = (Resolve-Path $BriefDir).Path

# Passer tous les arguments supplémentaires à terraform apply
$terraformArgs = $args
if ($terraformArgs.Count -eq 0) {
    $terraformArgs = @()
}

docker run --rm -it `
    -v "${workspacePath}:/workspace" `
    -v terraform-plugins:/root/.terraform.d/plugins `
    -v terraform-cache:/root/.terraform.d `
    -w /workspace `
    hashicorp/terraform:latest apply $terraformArgs

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Configuration appliquée avec succès" -ForegroundColor Green
} else {
    Write-Host "❌ Erreur lors de l'application" -ForegroundColor Red
    exit $LASTEXITCODE
}

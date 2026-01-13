# Script pour construire l'image Docker Terraform
# Usage: .\scripts\docker\docker-build.ps1

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$BriefDir = Split-Path -Parent (Split-Path -Parent $ScriptDir)
$DockerDir = Join-Path $BriefDir "docker"

# Vérifier Docker
if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Erreur: Docker n'est pas installé" -ForegroundColor Red
    exit 1
}

Write-Host "🔨 Construction de l'image Docker Terraform..." -ForegroundColor Cyan
Write-Host "📁 Dossier Docker: $DockerDir" -ForegroundColor Yellow

Set-Location $DockerDir

# Build l'image
docker build -t terraform-brief:latest .

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Image Docker construite avec succès" -ForegroundColor Green
    Write-Host "📦 Image: terraform-brief:latest" -ForegroundColor Cyan
    docker images terraform-brief:latest
} else {
    Write-Host "❌ Erreur lors de la construction" -ForegroundColor Red
    exit $LASTEXITCODE
}

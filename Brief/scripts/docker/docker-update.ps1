# Script pour reconstruire l'image Docker (update)
# Usage: .\scripts\docker\docker-update.ps1

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$BriefDir = Split-Path -Parent (Split-Path -Parent $ScriptDir)
$DockerDir = Join-Path $BriefDir "docker"

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Erreur: Docker n'est pas installé" -ForegroundColor Red
    exit 1
}

Write-Host "🔄 Mise à jour de l'image Docker Terraform..." -ForegroundColor Cyan

Set-Location $DockerDir

# Supprimer l'ancienne image (optionnel)
$imageExists = docker images terraform-brief:latest --format "{{.Repository}}:{{.Tag}}" | Select-String "terraform-brief:latest"
if ($imageExists) {
    Write-Host "🗑️  Suppression de l'ancienne image..." -ForegroundColor Yellow
    docker rmi terraform-brief:latest 2>$null
}

# Rebuild sans cache
Write-Host "🔨 Reconstruction de l'image (sans cache)..." -ForegroundColor Cyan
docker build --no-cache -t terraform-brief:latest .

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Image Docker mise à jour avec succès" -ForegroundColor Green
    docker images terraform-brief:latest
} else {
    Write-Host "❌ Erreur lors de la mise à jour" -ForegroundColor Red
    exit $LASTEXITCODE
}

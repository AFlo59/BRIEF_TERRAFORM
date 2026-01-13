# Script pour construire l'image Docker Terraform pour les exercices
# Usage: .\scripts\docker\docker-build.ps1

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ExercicesDir = Split-Path -Parent (Split-Path -Parent $ScriptDir)
$DockerDir = Join-Path $ExercicesDir "docker"

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Erreur: Docker n'est pas installé" -ForegroundColor Red
    exit 1
}

Write-Host "🔨 Construction de l'image Docker Terraform pour les exercices..." -ForegroundColor Cyan
Write-Host "📁 Dossier Docker: $DockerDir" -ForegroundColor Yellow

Set-Location $DockerDir

docker build -t terraform-exercices:latest .

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Image Docker construite avec succès" -ForegroundColor Green
    Write-Host "📦 Image: terraform-exercices:latest" -ForegroundColor Cyan
    docker images terraform-exercices:latest
} else {
    Write-Host "❌ Erreur lors de la construction" -ForegroundColor Red
    exit $LASTEXITCODE
}

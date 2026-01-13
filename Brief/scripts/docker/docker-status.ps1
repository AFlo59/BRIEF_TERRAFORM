# Script pour vérifier le statut de l'image Docker
# Usage: .\scripts\docker\docker-status.ps1

$ErrorActionPreference = "Stop"

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Erreur: Docker n'est pas installé" -ForegroundColor Red
    exit 1
}

Write-Host "📊 Statut de l'image Docker Terraform" -ForegroundColor Cyan
Write-Host ""

# Vérifier si l'image existe
$imageExists = docker images terraform-brief:latest --format "{{.Repository}}:{{.Tag}}" | Select-String "terraform-brief:latest"
if ($imageExists) {
    Write-Host "✅ Image terraform-brief:latest trouvée" -ForegroundColor Green
    Write-Host ""
    docker images terraform-brief:latest
    Write-Host ""
    Write-Host "📦 Informations détaillées:" -ForegroundColor Cyan
    $created = docker inspect terraform-brief:latest --format '{{.Created}}'
    Write-Host "Créée le: $created"
} else {
    Write-Host "⚠️  Image terraform-brief:latest non trouvée" -ForegroundColor Yellow
    Write-Host "💡 Construisez l'image: .\scripts\docker\docker-build.ps1" -ForegroundColor Cyan
}

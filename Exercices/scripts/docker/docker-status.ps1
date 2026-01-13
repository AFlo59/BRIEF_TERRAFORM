# Script pour vérifier le statut de l'image Docker - Exercices
# Usage: .\scripts\docker\docker-status.ps1

$ErrorActionPreference = "Stop"

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Erreur: Docker n'est pas installé" -ForegroundColor Red
    exit 1
}

Write-Host "📊 Statut de l'image Docker Terraform" -ForegroundColor Cyan
Write-Host ""

# Vérifier si l'image existe
$imageExists = docker images terraform-exercices:latest --format "{{.Repository}}:{{.Tag}}" | Select-String "terraform-exercices:latest"
if ($imageExists) {
    Write-Host "✅ Image terraform-exercices:latest trouvée" -ForegroundColor Green
    Write-Host ""
    docker images terraform-exercices:latest
    Write-Host ""
    Write-Host "📦 Informations détaillées:" -ForegroundColor Cyan
    $created = docker inspect terraform-exercices:latest --format '{{.Created}}'
    Write-Host "Créée le: $created"
} else {
    Write-Host "⚠️  Image terraform-exercices:latest non trouvée" -ForegroundColor Yellow
    Write-Host "💡 Construisez l'image: .\scripts\docker\docker-build.ps1" -ForegroundColor Cyan
}

# Script pour supprimer l'image Docker
# Usage: .\scripts\docker\docker-remove.ps1

$ErrorActionPreference = "Stop"

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Erreur: Docker n'est pas installé" -ForegroundColor Red
    exit 1
}

# Vérifier que l'image existe
$imageExists = docker images terraform-brief:latest --format "{{.Repository}}:{{.Tag}}" | Select-String "terraform-brief:latest"
if (-not $imageExists) {
    Write-Host "⚠️  Image terraform-brief:latest non trouvée" -ForegroundColor Yellow
    exit 0
}

Write-Host "⚠️  Attention: Cette commande va supprimer l'image terraform-brief:latest" -ForegroundColor Yellow
$confirm = Read-Host "Êtes-vous sûr? (yes/no)"

if ($confirm -eq "yes") {
    Write-Host "🗑️  Suppression de l'image..." -ForegroundColor Cyan
    docker rmi terraform-brief:latest

    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Image supprimée avec succès" -ForegroundColor Green
    } else {
        Write-Host "❌ Erreur lors de la suppression" -ForegroundColor Red
        exit $LASTEXITCODE
    }
} else {
    Write-Host "❌ Opération annulée" -ForegroundColor Cyan
}

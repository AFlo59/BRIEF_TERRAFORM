# Script pour exécuter une commande dans le conteneur Terraform
# Usage: .\scripts\docker\docker-run.ps1 <command> [args...]
# Exemple: .\scripts\docker\docker-run.ps1 terraform version

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$BriefDir = Split-Path -Parent (Split-Path -Parent $ScriptDir)

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Erreur: Docker n'est pas installé" -ForegroundColor Red
    exit 1
}

# Vérifier que l'image existe
$imageExists = docker images terraform-brief:latest --format "{{.Repository}}:{{.Tag}}" | Select-String "terraform-brief:latest"
if (-not $imageExists) {
    Write-Host "❌ Image terraform-brief:latest non trouvée" -ForegroundColor Red
    Write-Host "💡 Construisez l'image d'abord: .\scripts\docker\docker-build.ps1" -ForegroundColor Cyan
    exit 1
}

$workspacePath = (Resolve-Path $BriefDir).Path
$terraformArgs = $args

docker run --rm -it `
    -v "${workspacePath}:/workspace" `
    -v terraform-plugins:/root/.terraform.d/plugins `
    -v terraform-cache:/root/.terraform.d `
    -w /workspace `
    terraform-brief:latest `
    $terraformArgs

# Script pour détruire Terraform via Docker (PowerShell) - Exercices
# Usage: .\scripts\powershell\terraform-destroy.ps1 [exercice_dir] [options]

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ExercicesDir = Split-Path -Parent (Split-Path -Parent $ScriptDir)

if ($args.Count -gt 0 -and (Test-Path "$ExercicesDir\$($args[0])")) {
    $WorkDir = "$ExercicesDir\$($args[0])"
    $terraformArgs = $args[1..($args.Count-1)]
} else {
    $WorkDir = $ExercicesDir
    $terraformArgs = $args
}

Set-Location $WorkDir

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Erreur: Docker n'est pas installé" -ForegroundColor Red
    exit 1
}

$imageExists = docker images terraform-exercices:latest --format "{{.Repository}}:{{.Tag}}" | Select-String "terraform-exercices:latest"
if (-not $imageExists) {
    Write-Host "⚠️  Image terraform-exercices:latest non trouvée" -ForegroundColor Yellow
    Write-Host "💡 Construction de l'image..." -ForegroundColor Cyan
    & "$ExercicesDir\scripts\docker\docker-build.ps1"
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
}

$autoApprove = $terraformArgs -contains "-auto-approve"
if (-not $autoApprove) {
    Write-Host "⚠️  Attention: Cette commande va détruire les ressources !" -ForegroundColor Yellow
    $confirm = Read-Host "Êtes-vous sûr? (yes/no)"
    if ($confirm -ne "yes") {
        Write-Host "❌ Opération annulée" -ForegroundColor Red
        exit 0
    }
}

Write-Host "🗑️  Destruction des ressources..." -ForegroundColor Cyan

$workspacePath = (Resolve-Path $WorkDir).Path

docker run --rm -it `
    -v "${workspacePath}:/workspace" `
    -v terraform-plugins-exercices:/root/.terraform.d/plugins `
    -v terraform-cache-exercices:/root/.terraform.d `
    -w /workspace `
    terraform-exercices:latest destroy $terraformArgs

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Ressources détruites avec succès" -ForegroundColor Green
} else {
    Write-Host "❌ Erreur lors de la destruction" -ForegroundColor Red
    exit $LASTEXITCODE
}

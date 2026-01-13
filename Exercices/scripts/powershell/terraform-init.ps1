# Script pour initialiser Terraform via Docker (PowerShell) - Exercices
# Usage: .\scripts\powershell\terraform-init.ps1 [exercice_dir]

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ExercicesDir = Split-Path -Parent (Split-Path -Parent $ScriptDir)

if ($args.Count -gt 0 -and (Test-Path "$ExercicesDir\$($args[0])")) {
    $WorkDir = "$ExercicesDir\$($args[0])"
} else {
    $WorkDir = $ExercicesDir
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

Write-Host "🚀 Initialisation de Terraform..." -ForegroundColor Cyan

$workspacePath = (Resolve-Path $WorkDir).Path

docker run --rm -it `
    -v "${workspacePath}:/workspace" `
    -v terraform-plugins-exercices:/root/.terraform.d/plugins `
    -v terraform-cache-exercices:/root/.terraform.d `
    -w /workspace `
    terraform-exercices:latest init

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Terraform initialisé avec succès" -ForegroundColor Green
} else {
    Write-Host "❌ Erreur lors de l'initialisation" -ForegroundColor Red
    exit $LASTEXITCODE
}

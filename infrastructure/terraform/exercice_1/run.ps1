# Script wrapper pour l'exercice 1
# Usage: .\run.ps1 <command> [options]

param(
    [Parameter(Position=0)]
    [string]$Command = "help",
    
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$Arguments
)

$scriptPath = Join-Path $PSScriptRoot "..\..\..\scripts\terraform.ps1"

if (-not (Test-Path $scriptPath)) {
    Write-Host "❌ Erreur: Script terraform.ps1 non trouvé à $scriptPath" -ForegroundColor Red
    exit 1
}

# Se placer dans le dossier de l'exercice
Push-Location $PSScriptRoot

try {
    # Exécuter le script principal
    & $scriptPath $Command @Arguments
} finally {
    # Revenir au dossier précédent
    Pop-Location
}

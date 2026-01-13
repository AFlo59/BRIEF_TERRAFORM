# Script pour ouvrir WSL dans le répertoire actuel du projet
# Usage: .\wsl.ps1 [command]

param(
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$Command
)

# Obtenir le répertoire actuel
$currentDir = Get-Location

# Convertir le chemin Windows en chemin WSL
# Format: D:\PROJETS\BRIEF_TERRAFORM -> /mnt/d/PROJETS/BRIEF_TERRAFORM
# WSL est sensible à la casse pour la lettre du lecteur (doit être en minuscule)
$driveLetter = $currentDir.Path.Substring(0,1).ToLower()
$pathWithoutDrive = $currentDir.Path.Substring(2) -replace '\\', '/'
$wslPath = "/mnt/$driveLetter$pathWithoutDrive"

Write-Host "🐧 Ouverture de WSL dans: $wslPath" -ForegroundColor Cyan
Write-Host ""

# Détecter la distribution WSL par défaut
$wslDistro = "Ubuntu"
if ($Env:WSL_DISTRO_NAME) {
    $wslDistro = $Env:WSL_DISTRO_NAME
} else {
    # Essayer de détecter Ubuntu
    $wslList = wsl --list --quiet 2>$null
    if ($wslList -match "Ubuntu") {
        $wslDistro = "Ubuntu"
    }
}

Write-Host "   Distribution: $wslDistro" -ForegroundColor Gray
Write-Host ""

# Si une commande est fournie, l'exécuter dans WSL
if ($Command.Count -gt 0) {
    $commandString = $Command -join ' '
    wsl -d $wslDistro --cd "$wslPath" bash -c "$commandString"
} else {
    # Sinon, ouvrir un shell interactif
    wsl -d $wslDistro --cd "$wslPath"
}

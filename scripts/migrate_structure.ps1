# Script de Migration - Restructuration du Projet SmartTech Streaming
# Ce script automatise la migration vers la structure optimisée

param(
    [switch]$DryRun = $false,
    [switch]$SkipBackup = $false
)

$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Migration de la Structure du Projet  " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

if ($DryRun) {
    Write-Host "⚠️  MODE DRY-RUN: Aucune modification ne sera effectuée" -ForegroundColor Yellow
    Write-Host ""
}

# Fonction pour créer un dossier (avec dry-run)
function New-DirectorySafe {
    param([string]$Path)
    if (-not $DryRun) {
        New-Item -ItemType Directory -Force -Path $Path | Out-Null
        Write-Host "✓ Créé: $Path" -ForegroundColor Green
    } else {
        Write-Host "[DRY-RUN] Créerait: $Path" -ForegroundColor Gray
    }
}

# Fonction pour déplacer un fichier (avec dry-run)
function Move-ItemSafe {
    param([string]$Source, [string]$Destination)
    if (Test-Path $Source) {
        if (-not $DryRun) {
            Move-Item -Path $Source -Destination $Destination -Force
            Write-Host "✓ Déplacé: $Source -> $Destination" -ForegroundColor Green
        } else {
            Write-Host "[DRY-RUN] Déplacerait: $Source -> $Destination" -ForegroundColor Gray
        }
    } else {
        Write-Host "⚠️  Non trouvé: $Source" -ForegroundColor Yellow
    }
}

# Fonction pour supprimer un dossier (avec dry-run)
function Remove-DirectorySafe {
    param([string]$Path)
    if (Test-Path $Path) {
        if (-not $DryRun) {
            Remove-Item -Recurse -Force -Path $Path -ErrorAction SilentlyContinue
            Write-Host "✓ Supprimé: $Path" -ForegroundColor Green
        } else {
            Write-Host "[DRY-RUN] Supprimerait: $Path" -ForegroundColor Gray
        }
    }
}

Write-Host "Phase 1: Nettoyage Immédiat" -ForegroundColor Cyan
Write-Host "---------------------------" -ForegroundColor Cyan

# 1.1 Supprimer __MACOSX
Write-Host "`n1.1 Suppression des fichiers système macOS..." -ForegroundColor Yellow
Remove-DirectorySafe "__MACOSX"
Remove-DirectorySafe "smarttech-streaming\__MACOSX"

# 1.2 Créer la structure de base
Write-Host "`n1.2 Création de la structure de base..." -ForegroundColor Yellow
New-DirectorySafe "docs\terraform"
New-DirectorySafe "docs\streaming"
New-DirectorySafe "infrastructure\terraform"
New-DirectorySafe "scripts"

# 1.3 Déplacer la documentation Terraform
Write-Host "`n1.3 Déplacement de la documentation Terraform..." -ForegroundColor Yellow
if (Test-Path "IaC-Provisionning(Terraform)") {
    Get-ChildItem "IaC-Provisionning(Terraform)\*.pdf" -ErrorAction SilentlyContinue | ForEach-Object {
        Move-ItemSafe $_.FullName "docs\terraform\$($_.Name)"
    }
    Remove-DirectorySafe "IaC-Provisionning(Terraform)"
}

Write-Host "`nPhase 2: Réorganisation du Projet Streaming" -ForegroundColor Cyan
Write-Host "-------------------------------------------" -ForegroundColor Cyan

# Se placer dans smarttech-streaming
$originalLocation = Get-Location
if (Test-Path "smarttech-streaming") {
    Set-Location "smarttech-streaming"
    
    # 2.1 Aplatir la structure imbriquée
    Write-Host "`n2.1 Aplatissement de la structure imbriquée..." -ForegroundColor Yellow
    if (Test-Path "smarttech-streaming") {
        Get-ChildItem "smarttech-streaming" -Force | ForEach-Object {
            Move-ItemSafe $_.FullName ".\$($_.Name)"
        }
        Remove-DirectorySafe "smarttech-streaming"
    }
    
    # 2.2 Créer la nouvelle structure Python
    Write-Host "`n2.2 Création de la nouvelle structure Python..." -ForegroundColor Yellow
    New-DirectorySafe "src\producers"
    New-DirectorySafe "src\streams"
    New-DirectorySafe "src\utils"
    New-DirectorySafe "notebooks"
    New-DirectorySafe "data\raw\sensor_data"
    New-DirectorySafe "data\raw\activity-data"
    New-DirectorySafe "data\raw\stream_events"
    New-DirectorySafe "data\input"
    New-DirectorySafe "data\delta"
    New-DirectorySafe "data\checkpoints"
    New-DirectorySafe "tests"
    New-DirectorySafe "config"
    
    # 2.3 Déplacer les scripts
    Write-Host "`n2.3 Déplacement des scripts..." -ForegroundColor Yellow
    if (Test-Path "scripts\producer_kafka.py") {
        Move-ItemSafe "scripts\producer_kafka.py" "src\producers\kafka_producer.py"
    }
    if (Test-Path "scripts\stream_files_to_delta_bronze.py") {
        Move-ItemSafe "scripts\stream_files_to_delta_bronze.py" "src\streams\bronze_stream.py"
    }
    if (Test-Path "scripts\stream_kafka_to_delta_silver.py") {
        Move-ItemSafe "scripts\stream_kafka_to_delta_silver.py" "src\streams\silver_stream.py"
    }
    
    # 2.4 Déplacer les notebooks
    Write-Host "`n2.4 Déplacement des notebooks..." -ForegroundColor Yellow
    if (Test-Path "veille") {
        Get-ChildItem "veille\*.ipynb" -ErrorAction SilentlyContinue | ForEach-Object {
            Move-ItemSafe $_.FullName "notebooks\$($_.Name)"
        }
    }
    
    # 2.5 Déplacer les données
    Write-Host "`n2.5 Déplacement des données..." -ForegroundColor Yellow
    
    # Données depuis la racine du projet
    if (Test-Path "..\sensor_data") {
        Get-ChildItem "..\sensor_data\*.json" -ErrorAction SilentlyContinue | ForEach-Object {
            Move-ItemSafe $_.FullName "data\raw\sensor_data\$($_.Name)"
        }
    }
    
    # Données depuis veille
    if (Test-Path "veille\activity-data") {
        Get-ChildItem "veille\activity-data\*.json" -ErrorAction SilentlyContinue | ForEach-Object {
            Move-ItemSafe $_.FullName "data\raw\activity-data\$($_.Name)"
        }
    }
    
    if (Test-Path "veille\stream_events") {
        Get-ChildItem "veille\stream_events\*.json" -ErrorAction SilentlyContinue | ForEach-Object {
            Move-ItemSafe $_.FullName "data\raw\stream_events\$($_.Name)"
        }
    }
    
    # Déplacer input
    if (Test-Path "input") {
        Get-ChildItem "input\*" -ErrorAction SilentlyContinue | ForEach-Object {
            Move-ItemSafe $_.FullName "data\input\$($_.Name)"
        }
    }
    
    # Déplacer checkpoints et delta
    if (Test-Path "checkpoints") {
        Get-ChildItem "checkpoints\*" -ErrorAction SilentlyContinue | ForEach-Object {
            $destPath = "data\checkpoints\$($_.Name)"
            if (-not $DryRun) {
                if (-not (Test-Path $destPath)) {
                    New-Item -ItemType Directory -Force -Path $destPath | Out-Null
                }
                Copy-Item -Path $_.FullName -Destination $destPath -Recurse -Force
                Write-Host "✓ Copié: $($_.FullName) -> $destPath" -ForegroundColor Green
            } else {
                Write-Host "[DRY-RUN] Copierait: $($_.FullName) -> $destPath" -ForegroundColor Gray
            }
        }
    }
    
    if (Test-Path "delta") {
        Get-ChildItem "delta\*" -ErrorAction SilentlyContinue | ForEach-Object {
            $destPath = "data\delta\$($_.Name)"
            if (-not $DryRun) {
                if (-not (Test-Path $destPath)) {
                    New-Item -ItemType Directory -Force -Path $destPath | Out-Null
                }
                Copy-Item -Path $_.FullName -Destination $destPath -Recurse -Force
                Write-Host "✓ Copié: $($_.FullName) -> $destPath" -ForegroundColor Green
            } else {
                Write-Host "[DRY-RUN] Copierait: $($_.FullName) -> $destPath" -ForegroundColor Gray
            }
        }
    }
    
    # 2.6 Créer les fichiers __init__.py
    Write-Host "`n2.6 Création des fichiers __init__.py..." -ForegroundColor Yellow
    if (-not $DryRun) {
        @("src", "src\producers", "src\streams", "src\utils", "tests") | ForEach-Object {
            $initFile = Join-Path $_ "__init__.py"
            if (-not (Test-Path $initFile)) {
                New-Item -ItemType File -Force -Path $initFile | Out-Null
                Write-Host "✓ Créé: $initFile" -ForegroundColor Green
            }
        }
    } else {
        Write-Host "[DRY-RUN] Créerait les fichiers __init__.py" -ForegroundColor Gray
    }
    
    # 2.7 Nettoyer les dossiers vides
    Write-Host "`n2.7 Nettoyage des dossiers vides..." -ForegroundColor Yellow
    Remove-DirectorySafe "veille"
    Remove-DirectorySafe "scripts"
    Remove-DirectorySafe "input"
    
    Set-Location $originalLocation
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  Migration terminée!                   " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

if ($DryRun) {
    Write-Host "`n⚠️  C'était un DRY-RUN. Aucune modification n'a été effectuée." -ForegroundColor Yellow
    Write-Host "Pour exécuter la migration, relancez sans le paramètre -DryRun" -ForegroundColor Yellow
} else {
    Write-Host "`n✓ Migration terminée avec succès!" -ForegroundColor Green
    Write-Host "`nProchaines étapes:" -ForegroundColor Cyan
    Write-Host "1. Vérifier la nouvelle structure" -ForegroundColor White
    Write-Host "2. Mettre à jour les chemins dans les scripts (Phase 3)" -ForegroundColor White
    Write-Host "3. Créer les modules utils (spark_config.py, schemas.py)" -ForegroundColor White
    Write-Host "4. Tester les imports et l'exécution" -ForegroundColor White
}


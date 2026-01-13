# Script wrapper pour utiliser Terraform via Docker
# Usage: .\scripts\terraform.ps1 <command> [options]

param(
    [Parameter(Position=0)]
    [string]$Command = "help",
    
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$Arguments
)

# Chemin vers le dossier Terraform de base
$terraformBaseDir = Join-Path $PSScriptRoot "..\infrastructure\terraform"

# Vérifier que le dossier de base existe
if (-not (Test-Path $terraformBaseDir)) {
    Write-Host "❌ Erreur: Le dossier $terraformBaseDir n'existe pas" -ForegroundColor Red
    exit 1
}

# Détecter si on est dans un sous-dossier d'exercice
$currentDir = Get-Location
$terraformDir = $terraformBaseDir

# Vérifier si on est dans un sous-dossier d'exercice (exercice_1, exercice_2, etc.)
if ($currentDir.Path -like "*\exercice_*") {
    # On est dans un sous-dossier d'exercice, utiliser le dossier actuel
    $terraformDir = $currentDir.Path
    Write-Host "📁 Détection: Sous-dossier d'exercice détecté" -ForegroundColor Green
    Write-Host "   Utilisation du dossier: $terraformDir" -ForegroundColor Gray
} else {
    # Sinon, utiliser le dossier de base
    $terraformDir = $terraformBaseDir
}

# Vérifier que Docker est disponible
try {
    docker --version | Out-Null
} catch {
    Write-Host "❌ Erreur: Docker n'est pas installé ou n'est pas dans le PATH" -ForegroundColor Red
    exit 1
}

# Fonction pour exécuter Terraform dans Docker
function Invoke-TerraformDocker {
    param(
        [string]$TerraformCommand,
        [string[]]$CmdArgs
    )
    
    $dockerArgs = @(
        "run",
        "--rm",
        "-it",
        "-v", "${terraformDir}:/workspace",
        "-v", "terraform-plugins:/root/.terraform.d/plugins",
        "-v", "terraform-cache:/root/.terraform.d",
        "-w", "/workspace",
        "hashicorp/terraform:latest",
        $TerraformCommand
    )
    
    # Ajouter les arguments supplémentaires
    if ($CmdArgs) {
        $dockerArgs += $CmdArgs
    }
    
    # Exécuter Docker
    docker $dockerArgs
}

# Gestion des commandes spéciales
switch ($Command.ToLower()) {
    "init" {
        Write-Host "🚀 Initialisation de Terraform..." -ForegroundColor Cyan
        Invoke-TerraformDocker "init" $Arguments
    }
    "plan" {
        Write-Host "📋 Génération du plan Terraform..." -ForegroundColor Cyan
        Invoke-TerraformDocker "plan" $Arguments
    }
    "apply" {
        Write-Host "⚙️  Application de la configuration Terraform..." -ForegroundColor Cyan
        Invoke-TerraformDocker "apply" $Arguments
    }
    "destroy" {
        Write-Host "🗑️  Destruction de l'infrastructure..." -ForegroundColor Yellow
        $confirm = Read-Host "Êtes-vous sûr de vouloir détruire l'infrastructure? (yes/no)"
        if ($confirm -eq "yes") {
            Invoke-TerraformDocker "destroy" $Arguments
        } else {
            Write-Host "❌ Opération annulée" -ForegroundColor Red
        }
    }
    "validate" {
        Write-Host "✅ Validation de la configuration Terraform..." -ForegroundColor Cyan
        Invoke-TerraformDocker "validate" $Arguments
    }
    "fmt" {
        Write-Host "📝 Formatage des fichiers Terraform..." -ForegroundColor Cyan
        Invoke-TerraformDocker "fmt" $Arguments
    }
    "version" {
        Invoke-TerraformDocker "version" $Arguments
    }
    "help" {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Cyan
        Write-Host "  Terraform via Docker - Aide" -ForegroundColor Cyan
        Write-Host "========================================" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Usage: .\scripts\terraform.ps1 <command> [options]" -ForegroundColor White
        Write-Host ""
        Write-Host "Commandes disponibles:" -ForegroundColor Yellow
        Write-Host "  init      - Initialise Terraform dans le répertoire" -ForegroundColor White
        Write-Host "  plan      - Génère un plan d'exécution" -ForegroundColor White
        Write-Host "  apply     - Applique les changements" -ForegroundColor White
        Write-Host "  destroy   - Détruit l'infrastructure" -ForegroundColor White
        Write-Host "  validate  - Valide la configuration" -ForegroundColor White
        Write-Host "  fmt       - Formate les fichiers .tf" -ForegroundColor White
        Write-Host "  version   - Affiche la version de Terraform" -ForegroundColor White
        Write-Host ""
        Write-Host "Exemples:" -ForegroundColor Yellow
        Write-Host "  .\scripts\terraform.ps1 init" -ForegroundColor Gray
        Write-Host "  .\scripts\terraform.ps1 plan" -ForegroundColor Gray
        Write-Host "  .\scripts\terraform.ps1 apply -auto-approve" -ForegroundColor Gray
        Write-Host "  .\scripts\terraform.ps1 validate" -ForegroundColor Gray
        Write-Host ""
    }
    default {
        # Commande non reconnue, passer directement à Terraform
        Write-Host "⚠️  Commande non reconnue, exécution directe: $Command" -ForegroundColor Yellow
        Invoke-TerraformDocker $Command $Arguments
    }
}

# Script wrapper pour l'exercice 2 (PowerShell)
# Usage: .\run.ps1 <command> [options]

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ExercicesDir = Split-Path -Parent $ScriptDir

Set-Location $ScriptDir

$command = $args[0]
$commandArgs = $args[1..($args.Count-1)]

switch ($command) {
    "init" {
        & "$ExercicesDir\scripts\powershell\terraform-init.ps1" "exercice_2"
    }
    "plan" {
        & "$ExercicesDir\scripts\powershell\terraform-plan.ps1" "exercice_2"
    }
    "apply" {
        & "$ExercicesDir\scripts\powershell\terraform-apply.ps1" "exercice_2" $commandArgs
    }
    "destroy" {
        & "$ExercicesDir\scripts\powershell\terraform-destroy.ps1" "exercice_2" $commandArgs
    }
    default {
        Write-Host "Usage: .\run.ps1 {init|plan|apply|destroy} [options]"
        exit 1
    }
}

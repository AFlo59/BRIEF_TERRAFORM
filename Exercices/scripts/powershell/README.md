# 💻 Scripts Terraform pour PowerShell - Exercices

Scripts PowerShell pour exécuter Terraform via Docker depuis Windows pour les exercices.

---

## 📁 Scripts Disponibles

- `terraform-init.ps1` - Initialiser Terraform
- `terraform-plan.ps1` - Générer le plan
- `terraform-apply.ps1` - Appliquer la configuration
- `terraform-destroy.ps1` - Détruire l'infrastructure
- `terraform-validate.ps1` - Valider la configuration
- `terraform-fmt.ps1` - Formater les fichiers
- `terraform-version.ps1` - Afficher la version

---

## 🚀 Utilisation

### Depuis le dossier Exercices

```powershell
# Depuis le dossier Exercices
cd D:\PROJETS\BRIEF_TERRAFORM\Exercices

# Initialiser
.\scripts\powershell\terraform-init.ps1

# Valider
.\scripts\powershell\terraform-validate.ps1

# Plan
.\scripts\powershell\terraform-plan.ps1

# Appliquer
.\scripts\powershell\terraform-apply.ps1
# OU avec auto-approve
.\scripts\powershell\terraform-apply.ps1 -auto-approve

# Détruire
.\scripts\powershell\terraform-destroy.ps1

# Formater
.\scripts\powershell\terraform-fmt.ps1

# Version
.\scripts\powershell\terraform-version.ps1
```

### Depuis un exercice spécifique

```powershell
# Depuis un exercice (ex: exercice_1)
cd D:\PROJETS\BRIEF_TERRAFORM\Exercices\exercice_1

# Utiliser les scripts avec le nom de l'exercice
..\scripts\powershell\terraform-init.ps1 exercice_1
..\scripts\powershell\terraform-plan.ps1 exercice_1
..\scripts\powershell\terraform-apply.ps1 exercice_1
```

### Utiliser les scripts run.ps1 dans chaque exercice

```powershell
# Depuis un exercice
cd D:\PROJETS\BRIEF_TERRAFORM\Exercices\exercice_1

# Les scripts run.ps1 appellent automatiquement les bons scripts
.\run.ps1
```

---

## ⚙️ Prérequis

- Docker Desktop installé et démarré
- PowerShell 5.1 ou supérieur
- Execution Policy configurée (si nécessaire)

### Configurer Execution Policy

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

## 📋 Image Docker

**Nom** : `terraform-exercices:latest`

**Volumes Docker** :
- `terraform-plugins-exercices` - Plugins Terraform
- `terraform-cache-exercices` - Cache Terraform

---

*Scripts pour PowerShell/Windows - Exercices Terraform*

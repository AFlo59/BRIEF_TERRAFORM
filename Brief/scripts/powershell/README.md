# 💻 Scripts Terraform pour PowerShell

Scripts PowerShell pour exécuter Terraform via Docker depuis Windows.

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

```powershell
# Depuis le dossier Brief
cd D:\PROJETS\BRIEF_TERRAFORM\Brief

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

*Scripts pour PowerShell/Windows*

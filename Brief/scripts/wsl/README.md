# 🐧 Scripts Terraform pour WSL

Scripts bash pour exécuter Terraform via Docker depuis WSL.

---

## 📁 Scripts Disponibles

- `terraform-init.sh` - Initialiser Terraform
- `terraform-plan.sh` - Générer le plan
- `terraform-apply.sh` - Appliquer la configuration
- `terraform-destroy.sh` - Détruire l'infrastructure
- `terraform-validate.sh` - Valider la configuration
- `terraform-fmt.sh` - Formater les fichiers
- `terraform-version.sh` - Afficher la version

---

## 🚀 Utilisation

```bash
# Depuis le dossier Brief
cd /mnt/d/PROJETS/BRIEF_TERRAFORM/Brief

# Initialiser
./scripts/wsl/terraform-init.sh

# Valider
./scripts/wsl/terraform-validate.sh

# Plan
./scripts/wsl/terraform-plan.sh

# Appliquer
./scripts/wsl/terraform-apply.sh
# OU avec auto-approve
./scripts/wsl/terraform-apply.sh -auto-approve

# Détruire
./scripts/wsl/terraform-destroy.sh

# Formater
./scripts/wsl/terraform-fmt.sh

# Version
./scripts/wsl/terraform-version.sh
```

---

## ⚙️ Prérequis

- Docker installé et fonctionnel
- WSL configuré
- Accès au dossier Brief

---

*Scripts pour WSL/Linux*

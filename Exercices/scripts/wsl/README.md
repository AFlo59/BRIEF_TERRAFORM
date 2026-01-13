# 🐧 Scripts Terraform pour WSL - Exercices

Scripts bash pour exécuter Terraform via Docker depuis WSL pour les exercices.

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

### Depuis le dossier Exercices

```bash
# Depuis le dossier Exercices
cd /mnt/d/PROJETS/BRIEF_TERRAFORM/Exercices

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

### Depuis un exercice spécifique

```bash
# Depuis un exercice (ex: exercice_1)
cd /mnt/d/PROJETS/BRIEF_TERRAFORM/Exercices/exercice_1

# Utiliser les scripts avec le nom de l'exercice
../scripts/wsl/terraform-init.sh exercice_1
../scripts/wsl/terraform-plan.sh exercice_1
../scripts/wsl/terraform-apply.sh exercice_1
```

### Utiliser les scripts run.sh dans chaque exercice

```bash
# Depuis un exercice
cd /mnt/d/PROJETS/BRIEF_TERRAFORM/Exercices/exercice_1

# Les scripts run.sh appellent automatiquement les bons scripts
./run.sh
```

---

## ⚙️ Prérequis

- Docker installé et fonctionnel
- WSL configuré
- Accès au dossier Exercices

---

## 📋 Image Docker

**Nom** : `terraform-exercices:latest`

**Volumes Docker** :
- `terraform-plugins-exercices` - Plugins Terraform
- `terraform-cache-exercices` - Cache Terraform

---

*Scripts pour WSL/Linux - Exercices Terraform*

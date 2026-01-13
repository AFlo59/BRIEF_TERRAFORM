# 🚀 Scripts Terraform pour les Exercices

Scripts pour exécuter Terraform via Docker depuis WSL ou PowerShell pour les exercices Terraform.

---

## 📁 Structure

```
scripts/
├── docker/              # Scripts de gestion Docker
│   ├── docker-build.sh/.ps1    # Construire l'image
│   ├── docker-run.sh/.ps1      # Lancer le conteneur interactif
│   ├── docker-update.sh/.ps1   # Mettre à jour l'image
│   ├── docker-remove.sh/.ps1   # Supprimer l'image
│   ├── docker-status.sh/.ps1   # Vérifier le statut
│   └── README.md
│
├── wsl/                 # Scripts Bash pour WSL
│   ├── terraform-init.sh
│   ├── terraform-plan.sh
│   ├── terraform-apply.sh
│   ├── terraform-destroy.sh
│   ├── terraform-validate.sh
│   ├── terraform-fmt.sh
│   ├── terraform-version.sh
│   └── README.md
│
└── powershell/          # Scripts PowerShell pour Windows
    ├── terraform-init.ps1
    ├── terraform-plan.ps1
    ├── terraform-apply.ps1
    ├── terraform-destroy.ps1
    ├── terraform-validate.ps1
    ├── terraform-fmt.ps1
    ├── terraform-version.ps1
    └── README.md
```

---

## 🎯 Rôles des Scripts

### Scripts Docker (`docker/`)
**Rôle** : Gérer le conteneur Docker lui-même
- `docker-build.sh` - Construire l'image Docker
- `docker-run.sh` - **Lancer le conteneur en mode interactif** (shell bash)
- `docker-update.sh` - Reconstruire l'image
- `docker-remove.sh` - Supprimer l'image
- `docker-status.sh` - Vérifier le statut

### Scripts Terraform (`wsl/` et `powershell/`)
**Rôle** : Exécuter des commandes Terraform via Docker
- `terraform-init.sh` - Exécute `terraform init` dans Docker
- `terraform-plan.sh` - Exécute `terraform plan` dans Docker
- `terraform-apply.sh` - Exécute `terraform apply` dans Docker
- `terraform-destroy.sh` - Exécute `terraform destroy` dans Docker
- `terraform-validate.sh` - Exécute `terraform validate` dans Docker
- `terraform-fmt.sh` - Exécute `terraform fmt` dans Docker
- `terraform-version.sh` - Exécute `terraform version` dans Docker

---

## 🚀 Utilisation

### Pour les Commandes Terraform (Recommandé)

```bash
# WSL - Depuis le dossier Exercices
cd /mnt/d/PROJETS/BRIEF_TERRAFORM/Exercices
./scripts/wsl/terraform-init.sh
./scripts/wsl/terraform-plan.sh
./scripts/wsl/terraform-apply.sh

# WSL - Depuis un exercice spécifique
cd /mnt/d/PROJETS/BRIEF_TERRAFORM/Exercices/exercice_1
../scripts/wsl/terraform-init.sh exercice_1
```

```powershell
# PowerShell - Depuis le dossier Exercices
cd D:\PROJETS\BRIEF_TERRAFORM\Exercices
.\scripts\powershell\terraform-init.ps1
.\scripts\powershell\terraform-plan.ps1
.\scripts\powershell\terraform-apply.ps1
```

### Utiliser les Scripts run.sh/run.ps1 dans Chaque Exercice

```bash
# WSL - Depuis un exercice
cd /mnt/d/PROJETS/BRIEF_TERRAFORM/Exercices/exercice_1
./run.sh
```

```powershell
# PowerShell - Depuis un exercice
cd D:\PROJETS\BRIEF_TERRAFORM\Exercices\exercice_1
.\run.ps1
```

### Pour Lancer le Conteneur Interactif

```bash
# WSL - Ouvre un shell bash dans le conteneur
./scripts/docker/docker-run.sh

# Dans le conteneur, vous pouvez exécuter :
terraform version
terraform init
terraform plan
# etc.
```

```powershell
# PowerShell - Ouvre un shell bash dans le conteneur
.\scripts\docker\docker-run.ps1
```

---

## 📋 Workflow Recommandé

### 1. Construire l'image (une seule fois)
```bash
./scripts/docker/docker-build.sh
```

### 2. Utiliser les scripts Terraform
```bash
# Depuis un exercice
cd exercice_1
./run.sh
```

### 3. (Optionnel) Lancer le conteneur interactif
```bash
./scripts/docker/docker-run.sh
# Puis dans le conteneur :
terraform version
terraform --help
```

---

## ⚙️ Comment Ça Marche

1. **Scripts Terraform** (`terraform-*.sh`) :
   - Vérifient que l'image Docker existe
   - Construisent l'image si nécessaire
   - Exécutent `docker run` avec la commande Terraform spécifique
   - Exemple : `docker run ... terraform-exercices:latest init`

2. **Script Docker Run** (`docker-run.sh`) :
   - Lance le conteneur en mode interactif
   - Ouvre un shell bash dans le conteneur
   - Permet d'exécuter n'importe quelle commande manuellement

---

## 📋 Image Docker

**Nom** : `terraform-exercices:latest`

**Volumes Docker** :
- `terraform-plugins-exercices` - Plugins Terraform
- `terraform-cache-exercices` - Cache Terraform

---

## 🎯 Résumé

| Script | Rôle | Usage |
|--------|------|-------|
| `docker-run.sh` | Lancer conteneur interactif | `./scripts/docker/docker-run.sh` |
| `terraform-init.sh` | Exécuter `terraform init` | `./scripts/wsl/terraform-init.sh` |
| `terraform-plan.sh` | Exécuter `terraform plan` | `./scripts/wsl/terraform-plan.sh` |
| `terraform-apply.sh` | Exécuter `terraform apply` | `./scripts/wsl/terraform-apply.sh` |

---

*Scripts organisés pour faciliter l'utilisation de Terraform avec Docker pour les exercices*

# 🚀 Scripts Terraform pour le Projet Brief

Scripts pour exécuter Terraform via Docker depuis WSL ou PowerShell.

---

## 📁 Structure des Scripts

```
scripts/
├── wsl/                    # Scripts Bash pour WSL/Linux
│   ├── terraform-init.sh
│   ├── terraform-plan.sh
│   ├── terraform-apply.sh
│   ├── terraform-destroy.sh
│   ├── terraform-validate.sh
│   ├── terraform-fmt.sh
│   ├── terraform-version.sh
│   └── README.md
│
└── powershell/             # Scripts PowerShell pour Windows
    ├── terraform-init.ps1
    ├── terraform-plan.ps1
    ├── terraform-apply.ps1
    ├── terraform-destroy.ps1
    ├── terraform-validate.ps1
    ├── terraform-fmt.ps1
    ├── terraform-version.ps1
    └── README.md
```

### Scripts Bash (WSL/Linux) - `wsl/`
- `terraform-init.sh` - Initialiser Terraform
- `terraform-plan.sh` - Générer le plan
- `terraform-apply.sh` - Appliquer la configuration
- `terraform-destroy.sh` - Détruire l'infrastructure
- `terraform-validate.sh` - Valider la configuration
- `terraform-fmt.sh` - Formater les fichiers
- `terraform-version.sh` - Afficher la version

### Scripts PowerShell (Windows) - `powershell/`
- `terraform-init.ps1` - Initialiser Terraform
- `terraform-plan.ps1` - Générer le plan
- `terraform-apply.ps1` - Appliquer la configuration
- `terraform-destroy.ps1` - Détruire l'infrastructure
- `terraform-validate.ps1` - Valider la configuration
- `terraform-fmt.ps1` - Formater les fichiers
- `terraform-version.ps1` - Afficher la version

---

## 🐧 Utilisation depuis WSL

### Prérequis
```bash
# Vérifier que Docker fonctionne
docker --version
```

### Commandes

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
# OU avec auto-approve
./scripts/wsl/terraform-destroy.sh -auto-approve

# Formater
./scripts/wsl/terraform-fmt.sh

# Version
./scripts/wsl/terraform-version.sh
```

---

## 💻 Utilisation depuis PowerShell

### Prérequis
```powershell
# Vérifier que Docker fonctionne
docker --version
```

### Commandes

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
# OU avec auto-approve
.\scripts\powershell\terraform-destroy.ps1 -auto-approve

# Formater
.\scripts\powershell\terraform-fmt.ps1

# Version
.\scripts\powershell\terraform-version.ps1
```

---

## 📋 Workflow Recommandé

### 1. Initialiser (une seule fois)
```bash
# WSL
./scripts/wsl/terraform-init.sh

# PowerShell
.\scripts\powershell\terraform-init.ps1
```

### 2. Valider la Configuration
```bash
# WSL
./scripts/wsl/terraform-validate.sh

# PowerShell
.\scripts\powershell\terraform-validate.ps1
```

### 3. Voir le Plan
```bash
# WSL
./scripts/wsl/terraform-plan.sh

# PowerShell
.\scripts\powershell\terraform-plan.ps1
```

### 4. Appliquer
```bash
# WSL
./scripts/wsl/terraform-apply.sh

# PowerShell
.\scripts\powershell\terraform-apply.ps1
```

### 5. Détruire (quand terminé)
```bash
# WSL
./scripts/wsl/terraform-destroy.sh

# PowerShell
.\scripts\powershell\terraform-destroy.ps1
```

---

## 🔧 Options Disponibles

### terraform-apply.sh / terraform-apply.ps1
- `-auto-approve` - Appliquer sans confirmation
- Tous les autres arguments sont passés à Terraform

### terraform-destroy.sh / terraform-destroy.ps1
- `-auto-approve` - Détruire sans confirmation
- Tous les autres arguments sont passés à Terraform

---

## 📚 Documentation par Environnement

- **WSL** : Voir [wsl/README.md](./wsl/README.md)
- **PowerShell** : Voir [powershell/README.md](./powershell/README.md)

---

## ⚠️ Notes Importantes

1. **Docker requis** : Tous les scripts nécessitent Docker
2. **Dossier Brief** : Les scripts doivent être exécutés depuis le dossier `Brief/`
3. **Volumes Docker** : Les scripts utilisent des volumes nommés pour le cache Terraform
4. **Permissions** : Les scripts `.sh` sont rendus exécutables automatiquement

---

## 🐛 Dépannage

### Erreur "Docker n'est pas installé"
```bash
# Vérifier Docker
docker --version

# Si Docker Desktop n'est pas démarré, le démarrer depuis Windows
```

### Erreur "Permission denied" (WSL)
```bash
# Rendre les scripts exécutables
chmod +x scripts/*.sh
```

### Erreur "Execution Policy" (PowerShell)
```powershell
# Autoriser l'exécution des scripts
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

## 📚 Documentation

- **Guide complet** : [../COMMANDES_TERRAFORM.md](../COMMANDES_TERRAFORM.md)
- **État du projet** : [../ETAT_PROJET.md](../ETAT_PROJET.md)

---

*Scripts créés pour faciliter l'utilisation de Terraform avec Docker*

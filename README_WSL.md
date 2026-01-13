# 🐧 Utilisation avec WSL (Windows Subsystem for Linux)

Ce guide explique comment utiliser le projet avec WSL pour une meilleure compatibilité avec les outils Linux.

---

## 🚀 Démarrage Rapide

### Ouvrir WSL dans le répertoire actuel

**Depuis PowerShell/CMD:**
```powershell
.\wsl.ps1
```

**Depuis WSL directement:**
```bash
cd /mnt/d/PROJETS/BRIEF_TERRAFORM
# ou utilisez le chemin converti automatiquement
```

---

## 📋 Prérequis WSL

1. **WSL installé** sur Windows
   ```powershell
   # Vérifier l'installation
   wsl --list --verbose
   
   # Installer WSL si nécessaire
   wsl --install
   ```

2. **Docker dans WSL** (Docker Desktop avec intégration WSL activée)
   ```bash
   # Dans WSL, vérifier Docker
   docker --version
   ```

---

## 🔧 Utilisation de Terraform avec WSL

### Méthode 1: Script PowerShell (depuis Windows)

Le script `wsl.ps1` ouvre WSL dans le répertoire actuel:

```powershell
# Ouvrir WSL dans le projet
.\wsl.ps1

# Exécuter une commande dans WSL
.\wsl.ps1 "docker --version"
.\wsl.ps1 "cd infrastructure/terraform && ls"
```

### Méthode 2: Script Bash (depuis WSL)

Utilisez le script `scripts/terraform-wsl.sh`:

```bash
# Rendre le script exécutable
chmod +x scripts/terraform-wsl.sh

# Utiliser Terraform
./scripts/terraform-wsl.sh init
./scripts/terraform-wsl.sh plan
./scripts/terraform-wsl.sh apply
```

### Méthode 3: Docker directement dans WSL

```bash
# Se placer dans le dossier Terraform
cd infrastructure/terraform

# Utiliser Docker directement
docker run --rm -it \
  -v $(pwd):/workspace \
  -w /workspace \
  hashicorp/terraform:latest init
```

---

## 📁 Conversion des Chemins

### Windows → WSL

| Windows | WSL |
|---------|-----|
| `D:\PROJETS\BRIEF_TERRAFORM` | `/mnt/d/PROJETS/BRIEF_TERRAFORM` |
| `C:\Users\...` | `/mnt/c/Users/...` |

### Commandes utiles

```bash
# Convertir chemin Windows → WSL
wslpath "D:\PROJETS\BRIEF_TERRAFORM"
# Résultat: /mnt/d/PROJETS/BRIEF_TERRAFORM

# Convertir chemin WSL → Windows
wslpath -w "/mnt/d/PROJETS/BRIEF_TERRAFORM"
# Résultat: D:\PROJETS\BRIEF_TERRAFORM
```

---

## 🎯 Exécution des Exercices avec WSL

### Exercice 1: Fichier Local

```bash
# Dans WSL
cd /mnt/d/PROJETS/BRIEF_TERRAFORM/infrastructure/terraform/exercice_1

# Utiliser le script WSL
../../../../scripts/terraform-wsl.sh init
../../../../scripts/terraform-wsl.sh plan
../../../../scripts/terraform-wsl.sh apply
```

### Ou utiliser Docker directement

```bash
cd /mnt/d/PROJETS/BRIEF_TERRAFORM/infrastructure/terraform/exercice_1

docker run --rm -it \
  -v $(pwd):/workspace \
  -v terraform-plugins:/root/.terraform.d/plugins \
  -w /workspace \
  hashicorp/terraform:latest init

docker run --rm -it \
  -v $(pwd):/workspace \
  -v terraform-plugins:/root/.terraform.d/plugins \
  -w /workspace \
  hashicorp/terraform:latest apply
```

---

## 🔄 Scripts Wrapper pour les Exercices

Créez des scripts dans chaque dossier d'exercice:

**`infrastructure/terraform/exercice_1/run.sh`:**

```bash
#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"
../../../../scripts/terraform-wsl.sh "$@"
```

**Utilisation:**

```bash
cd infrastructure/terraform/exercice_1
chmod +x run.sh
./run.sh init
./run.sh apply
```

---

## ⚙️ Configuration Docker dans WSL

### Docker Desktop avec WSL

1. **Activer l'intégration WSL** dans Docker Desktop:
   - Settings → Resources → WSL Integration
   - Activer votre distribution WSL

2. **Vérifier la connexion:**
   ```bash
   docker ps
   ```

### Docker dans WSL (sans Docker Desktop)

Si vous utilisez Docker directement dans WSL:

```bash
# Installer Docker dans WSL
sudo apt update
sudo apt install docker.io
sudo service docker start

# Ajouter votre utilisateur au groupe docker
sudo usermod -aG docker $USER
```

---

## 🐛 Dépannage

### Problème: "Docker daemon not running"

**Solution:**
```bash
# Démarrer Docker dans WSL
sudo service docker start

# Ou si Docker Desktop est utilisé
# Vérifier que Docker Desktop est démarré sur Windows
```

### Problème: "Permission denied"

**Solution:**
```bash
# Ajouter les permissions d'exécution
chmod +x scripts/terraform-wsl.sh
chmod +x wsl.sh
```

### Problème: Chemins Windows non reconnus

**Solution:**
```bash
# Utiliser les chemins WSL (/mnt/d/...)
# Ou convertir avec wslpath
wslpath "D:\PROJETS\BRIEF_TERRAFORM"
```

---

## 💡 Avantages de WSL

✅ **Meilleure compatibilité** avec les outils Linux  
✅ **Scripts bash** natifs  
✅ **Performance** améliorée pour certains outils  
✅ **Environnement** plus proche de la production Linux  

---

## 📚 Ressources

- [Documentation WSL](https://docs.microsoft.com/en-us/windows/wsl/)
- [Docker avec WSL](https://docs.docker.com/desktop/windows/wsl/)
- [Terraform dans WSL](https://learn.hashicorp.com/tutorials/terraform/install-cli)

---

*Guide créé pour faciliter l'utilisation avec WSL*

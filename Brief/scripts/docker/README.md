# 🐳 Scripts Docker - Gestion du Conteneur Terraform

Scripts pour gérer le conteneur Docker Terraform du Brief.

---

## 📁 Scripts Disponibles

### Scripts Bash (WSL)
- `docker-build.sh` - Construire l'image Docker
- `docker-run.sh` - Exécuter une commande dans le conteneur
- `docker-update.sh` - Reconstruire l'image (mise à jour)
- `docker-remove.sh` - Supprimer l'image
- `docker-status.sh` - Vérifier le statut de l'image

### Scripts PowerShell (Windows)
- `docker-build.ps1` - Construire l'image Docker
- `docker-run.ps1` - Exécuter une commande dans le conteneur
- `docker-update.ps1` - Reconstruire l'image (mise à jour)
- `docker-remove.ps1` - Supprimer l'image
- `docker-status.ps1` - Vérifier le statut de l'image

---

## 🚀 Utilisation

### Construire l'image (première fois)

```bash
# WSL
./scripts/docker/docker-build.sh

# PowerShell
.\scripts\docker\docker-build.ps1
```

### Vérifier le statut

```bash
# WSL
./scripts/docker/docker-status.sh

# PowerShell
.\scripts\docker\docker-status.ps1
```

### Mettre à jour l'image

```bash
# WSL
./scripts/docker/docker-update.sh

# PowerShell
.\scripts\docker\docker-update.ps1
```

### Exécuter une commande personnalisée

```bash
# WSL
./scripts/docker/docker-run.sh terraform version
./scripts/docker/docker-run.sh bash

# PowerShell
.\scripts\docker\docker-run.ps1 terraform version
.\scripts\docker\docker-run.ps1 bash
```

### Supprimer l'image

```bash
# WSL
./scripts/docker/docker-remove.sh

# PowerShell
.\scripts\docker\docker-remove.ps1
```

---

## 📋 Image Docker

**Nom** : `terraform-brief:latest`

**Contenu** :
- Terraform (dernière version)
- Azure CLI (via pip)
- Outils utiles (git, jq, ssh, bash)

**Dockerfile** : `Brief/docker/Dockerfile`

---

## ⚙️ Notes

- Les scripts Terraform (`wsl/` et `powershell/`) construisent automatiquement l'image si elle n'existe pas
- L'image est partagée entre tous les scripts Terraform
- Les volumes Docker sont persistants (`terraform-plugins`, `terraform-cache`)

---

*Scripts de gestion Docker pour le projet Brief*

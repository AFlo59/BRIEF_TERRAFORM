# 🐳 Scripts Docker - Gestion du Conteneur Terraform - Exercices

Scripts pour gérer le conteneur Docker Terraform pour les exercices.

---

## 📁 Scripts Disponibles

### Scripts Bash (WSL)
- `docker-build.sh` - Construire l'image Docker
- `docker-run.sh` - Lancer le conteneur en mode interactif
- `docker-update.sh` - Reconstruire l'image (mise à jour)
- `docker-remove.sh` - Supprimer l'image
- `docker-status.sh` - Vérifier le statut de l'image

### Scripts PowerShell (Windows)
- `docker-build.ps1` - Construire l'image Docker
- `docker-run.ps1` - Lancer le conteneur en mode interactif
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

### Lancer le conteneur en mode interactif

```bash
# WSL - Lance un shell bash dans le conteneur
./scripts/docker/docker-run.sh

# WSL - Exécuter une commande spécifique
./scripts/docker/docker-run.sh terraform version
./scripts/docker/docker-run.sh terraform --help

# PowerShell - Lance un shell bash dans le conteneur
.\scripts\docker\docker-run.ps1

# PowerShell - Exécuter une commande spécifique
.\scripts\docker\docker-run.ps1 terraform version
```

**Note** : Pour les commandes Terraform, utilisez plutôt les scripts dédiés :
- `./scripts/wsl/terraform-init.sh`
- `./scripts/wsl/terraform-plan.sh`
- `./scripts/wsl/terraform-apply.sh`

### Supprimer l'image

```bash
# WSL
./scripts/docker/docker-remove.sh

# PowerShell
.\scripts\docker\docker-remove.ps1
```

---

## 📋 Image Docker

**Nom** : `terraform-exercices:latest`

**Contenu** :
- Terraform (dernière version)
- Outils utiles (git, jq, ssh, bash)

**Dockerfile** : `Exercices/docker/Dockerfile`

**Volumes Docker** :
- `terraform-plugins-exercices` - Plugins Terraform
- `terraform-cache-exercices` - Cache Terraform

---

## ⚙️ Notes

- **docker-run.sh** lance le conteneur en mode interactif (shell bash)
- **Pour les commandes Terraform**, utilisez les scripts dédiés dans `wsl/` ou `powershell/`
- Les scripts Terraform construisent automatiquement l'image si elle n'existe pas
- L'image est partagée entre tous les scripts Terraform
- Les volumes Docker sont persistants et séparés de ceux du projet Brief

---

## 🎯 Différence avec les Scripts Terraform

| Script | Rôle |
|-------|------|
| `docker-run.sh` | Lance le conteneur interactif (shell bash) |
| `terraform-init.sh` | Exécute `terraform init` via Docker |
| `terraform-plan.sh` | Exécute `terraform plan` via Docker |

**Recommandation** : Utilisez les scripts `terraform-*.sh` pour les commandes Terraform standard.

---

*Scripts de gestion Docker pour les exercices Terraform*

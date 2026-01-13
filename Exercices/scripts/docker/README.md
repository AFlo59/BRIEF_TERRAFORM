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
# Vous êtes maintenant dans le conteneur, vous pouvez exécuter :
#   terraform version
#   terraform init
#   terraform plan
#   exit  (pour quitter)

# WSL - Exécuter une commande Terraform spécifique
./scripts/docker/docker-run.sh version
./scripts/docker/docker-run.sh init
```

**⚠️ Important** :
- `docker-run.sh` lance un **shell interactif** dans le conteneur (comme `docker run -it --entrypoint /bin/bash`)
- Ce n'est **PAS** `docker-compose up` (on utilise `docker run` directement)
- Pour les commandes Terraform standard, utilisez plutôt les scripts dédiés :
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

- **docker-build.sh** : Construit l'image Docker (une seule fois au début)
- **docker-run.sh** : Lance le conteneur en mode interactif (shell bash) - utile pour explorer ou tester manuellement
- **Pour les commandes Terraform** : Utilisez les scripts dédiés dans `wsl/` ou `powershell/`
- Les scripts Terraform construisent automatiquement l'image si elle n'existe pas
- L'image est partagée entre tous les scripts Terraform
- Les volumes Docker sont persistants et séparés de ceux du projet Brief

---

## 🎯 Différence entre les Scripts

| Script | Rôle | Quand l'utiliser |
|-------|------|-----------------|
| `docker-build.sh` | Construit l'image Docker | Une seule fois au début |
| `docker-run.sh` | Lance un shell interactif dans le conteneur | Pour explorer/test manuel |
| `terraform-init.sh` | Exécute `terraform init` via Docker | Pour initialiser Terraform |
| `terraform-plan.sh` | Exécute `terraform plan` via Docker | Pour voir les changements |
| `terraform-apply.sh` | Exécute `terraform apply` via Docker | Pour appliquer les changements |

**Recommandation** :
- Utilisez les scripts `terraform-*.sh` pour les commandes Terraform standard (99% du temps)
- Utilisez `docker-run.sh` seulement si vous voulez un shell interactif pour explorer/test manuel

---

## ❓ Pourquoi pas docker-compose ?

On utilise `docker run` directement au lieu de `docker-compose` car :
- Plus simple pour des commandes ponctuelles
- Pas besoin de maintenir un fichier `docker-compose.yml` complexe
- Chaque script Terraform peut être exécuté indépendamment
- Les volumes sont gérés automatiquement par Docker

---

*Scripts de gestion Docker pour les exercices Terraform*

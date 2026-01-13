# Guide: Utiliser Terraform avec Docker

Ce guide explique comment utiliser Terraform via Docker sans avoir à l'installer directement sur votre machine.

## 🎯 Pourquoi utiliser Terraform avec Docker ?

### Avantages

✅ **Pas d'installation locale** - Pas besoin d'installer Terraform sur votre machine  
✅ **Version isolée** - Chaque projet peut utiliser une version spécifique de Terraform  
✅ **Environnement propre** - Pas de conflits avec d'autres outils  
✅ **Reproductibilité** - Même environnement pour toute l'équipe  
✅ **Facilité de mise à jour** - Mise à jour via une simple image Docker  

### Inconvénients

⚠️ **Dépendance Docker** - Nécessite Docker installé et en cours d'exécution  
⚠️ **Légèrement plus lent** - Légère surcharge due à Docker  

## 📋 Prérequis

1. **Docker Desktop** installé et en cours d'exécution
   - Windows: [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop)
   - Mac: [Docker Desktop for Mac](https://www.docker.com/products/docker-desktop)
   - Linux: [Docker Engine](https://docs.docker.com/engine/install/)

2. Vérifier l'installation :
   ```powershell
   docker --version
   docker-compose --version
   ```

## 🚀 Méthodes d'Utilisation

### Méthode 1: Script PowerShell (Recommandée)

Le script `scripts/terraform.ps1` simplifie l'utilisation :

```powershell
# Depuis la racine du projet
.\scripts\terraform.ps1 init
.\scripts\terraform.ps1 plan
.\scripts\terraform.ps1 apply
```

**Avantages:**
- Commande simple et intuitive
- Gestion automatique des volumes Docker
- Messages d'aide intégrés
- Validation des prérequis

### Méthode 2: Docker Compose

Utilisez docker-compose pour une configuration plus structurée :

```powershell
cd infrastructure/terraform

# Initialiser
docker-compose run --rm terraform init

# Plan
docker-compose run --rm terraform plan

# Apply
docker-compose run --rm terraform apply
```

**Avantages:**
- Configuration centralisée dans docker-compose.yml
- Volumes persistants configurés
- Réseau isolé si nécessaire

### Méthode 3: Docker Direct

Utilisez Docker directement pour un contrôle total :

```powershell
cd infrastructure/terraform

docker run --rm -it `
  -v ${PWD}:/workspace `
  -w /workspace `
  hashicorp/terraform:latest init
```

**Avantages:**
- Contrôle total sur les options Docker
- Pas de dépendance à docker-compose

## 📝 Exemples d'Utilisation

### Initialisation

```powershell
# Avec le script
.\scripts\terraform.ps1 init

# Avec docker-compose
cd infrastructure/terraform
docker-compose run --rm terraform init
```

### Plan avec Variables

```powershell
# Avec le script
.\scripts\terraform.ps1 plan -var="region=us-east-1"

# Avec docker-compose
cd infrastructure/terraform
docker-compose run --rm terraform plan -var="region=us-east-1"
```

### Apply avec Auto-Approve

```powershell
# Avec le script
.\scripts\terraform.ps1 apply -auto-approve

# Avec docker-compose
cd infrastructure/terraform
docker-compose run --rm terraform apply -auto-approve
```

### Validation et Formatage

```powershell
# Valider la configuration
.\scripts\terraform.ps1 validate

# Formater les fichiers
.\scripts\terraform.ps1 fmt -recursive
```

### Utiliser un fichier de variables

```powershell
# Créer terraform.tfvars
# region = "us-east-1"
# instance_type = "t2.micro"

# Utiliser avec plan
.\scripts\terraform.ps1 plan -var-file="terraform.tfvars"
```

## 🔧 Configuration Avancée

### Variables d'Environnement

Vous pouvez passer des variables d'environnement à Terraform :

```powershell
# Avec le script (modifier scripts/terraform.ps1)
$env:TF_VAR_region = "us-east-1"
.\scripts\terraform.ps1 plan

# Avec docker-compose (modifier docker-compose.yml)
environment:
  - TF_VAR_region=us-east-1
```

### Backend Remote

Pour utiliser un backend distant (S3, Azure Storage, etc.) :

1. Configurez le backend dans `main.tf`
2. Initialisez avec le backend :
   ```powershell
   .\scripts\terraform.ps1 init -backend-config="backend.hcl"
   ```

### Workspaces

Utiliser des workspaces pour gérer plusieurs environnements :

```powershell
# Créer un workspace
.\scripts\terraform.ps1 workspace new production

# Sélectionner un workspace
.\scripts\terraform.ps1 workspace select production

# Lister les workspaces
.\scripts\terraform.ps1 workspace list
```

## 🗂️ Gestion des Volumes Docker

Les volumes Docker sont utilisés pour :
- **terraform-plugins**: Cache des providers Terraform
- **terraform-cache**: Cache général de Terraform

### Voir les volumes

```powershell
docker volume ls | Select-String terraform
```

### Nettoyer les volumes

```powershell
# Supprimer les volumes (libère de l'espace)
docker volume rm terraform-plugins terraform-cache
```

⚠️ **Attention**: Cela supprimera le cache et nécessitera de re-télécharger les providers.

## 🐛 Dépannage

### Problème: "docker: command not found"

**Solution**: Vérifiez que Docker est installé et dans votre PATH.

```powershell
# Vérifier l'installation
docker --version

# Si non trouvé, redémarrer PowerShell après installation
```

### Problème: "Cannot connect to the Docker daemon"

**Solution**: Assurez-vous que Docker Desktop est en cours d'exécution.

```powershell
# Vérifier le statut Docker
docker ps
```

### Problème: "Permission denied" sur Linux/Mac

**Solution**: Utilisez `sudo` ou ajoutez votre utilisateur au groupe docker.

```bash
# Ajouter l'utilisateur au groupe docker
sudo usermod -aG docker $USER
# Déconnexion/reconnexion nécessaire
```

### Problème: Les fichiers ne sont pas synchronisés

**Solution**: Vérifiez que le volume est correctement monté.

```powershell
# Vérifier le montage du volume
docker run --rm -v ${PWD}:/workspace -w /workspace hashicorp/terraform:latest ls -la
```

### Problème: Les providers ne se téléchargent pas

**Solution**: Vérifiez votre connexion Internet et les volumes Docker.

```powershell
# Vérifier les volumes
docker volume inspect terraform-plugins

# Réinitialiser si nécessaire
docker volume rm terraform-plugins
.\scripts\terraform.ps1 init
```

## 💡 Bonnes Pratiques

1. **Utilisez le script wrapper** pour la cohérence
2. **Versionnez votre configuration** Terraform
3. **Ne commitez jamais** les fichiers sensibles (.tfvars avec secrets)
4. **Utilisez un backend distant** pour le state en production
5. **Validez et formatez** avant de commiter
6. **Documentez** vos variables et outputs

## 📚 Ressources Complémentaires

- [Documentation Terraform](https://www.terraform.io/docs)
- [Terraform Docker Hub](https://hub.docker.com/r/hashicorp/terraform)
- [Terraform Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/index.html)
- [Docker Documentation](https://docs.docker.com/)

---

*Guide créé pour faciliter l'utilisation de Terraform via Docker*

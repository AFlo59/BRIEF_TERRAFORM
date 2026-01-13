# 🔧 Guide de Configuration Azure - Étapes Manuelles

Ce guide explique **ce que vous devez faire manuellement** avant de pouvoir utiliser Terraform avec Azure.

> ⚠️ **Important** : Ces étapes ne peuvent pas être automatisées et doivent être faites via le portail Azure ou Azure CLI.

---

## 📋 Prérequis à Configurer Manuellement

### 1. Créer un Compte Azure (Si vous n'en avez pas)

#### Via le Portail Azure

1. **Aller sur** [portal.azure.com](https://portal.azure.com)
2. **Cliquer sur** "Créer une ressource" ou "S'inscrire"
3. **Suivre le processus d'inscription** :
   - Email
   - Mot de passe
   - Informations de paiement (nécessaire même pour le free tier)
   - Vérification par téléphone

#### Via Azure CLI (Alternative)

```bash
# S'inscrire (ouvre le navigateur)
az login
```

**Temps estimé** : 10-15 minutes

---

### 2. Créer une Subscription Azure

#### Via le Portail Azure

1. **Se connecter** à [portal.azure.com](https://portal.azure.com)
2. **Aller dans** "Subscriptions" (rechercher dans la barre de recherche)
3. **Cliquer sur** "+ Ajouter"
4. **Choisir** :
   - **Free Trial** (si disponible) - $200 de crédit gratuit
   - **Pay-As-You-Go** - Paiement à l'usage
5. **Remplir les informations** et créer la subscription

#### Vérifier la Subscription

```bash
# Lister les subscriptions
az account list --output table

# Définir la subscription active
az account set --subscription "Votre-Subscription-Name"
```

**Temps estimé** : 5 minutes

---

### 3. Installer Azure CLI (Si pas déjà fait)

#### Windows

**Option 1: Via le site officiel**
1. Aller sur [aka.ms/installazurecliwindows](https://aka.ms/installazurecliwindows)
2. Télécharger le MSI
3. Installer

**Option 2: Via PowerShell**
```powershell
# Télécharger et installer
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi
Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'
```

#### Vérifier l'Installation

```bash
az --version
```

**Temps estimé** : 5-10 minutes

---

### 4. Se Connecter à Azure via CLI

#### Connexion Interactive

```bash
# Se connecter (ouvre le navigateur)
az login

# Vérifier la connexion
az account show
```

#### Connexion avec Compte Spécifique

```bash
# Se connecter avec un compte spécifique
az login --username votre-email@example.com

# Lister les subscriptions disponibles
az account list --output table

# Définir la subscription active
az account set --subscription "Nom-de-votre-subscription"
```

**Temps estimé** : 2 minutes

---

### 5. Générer une Clé SSH (Pour la VM)

#### Windows (WSL ou Git Bash)

```bash
# Générer une nouvelle clé SSH
ssh-keygen -t rsa -b 4096 -C "votre-email@example.com"

# Appuyer sur Entrée pour accepter l'emplacement par défaut
# Entrer un mot de passe (optionnel mais recommandé)

# Afficher la clé publique
cat ~/.ssh/id_rsa.pub
```

#### Windows (PowerShell)

```powershell
# Si vous avez OpenSSH installé
ssh-keygen -t rsa -b 4096

# Sinon, utiliser WSL
wsl ssh-keygen -t rsa -b 4096
```

#### Copier la Clé Publique

```bash
# Dans WSL
cat ~/.ssh/id_rsa.pub

# Copier tout le contenu (commence par ssh-rsa)
# Vous en aurez besoin pour terraform.tfvars
```

**Temps estimé** : 5 minutes

---

## 🎯 Configuration Terraform

### Étape 1: Créer terraform.tfvars

```bash
cd Brief
cp terraform.tfvars.example terraform.tfvars
```

### Étape 2: Éditer terraform.tfvars

Ouvrir `terraform.tfvars` et remplir :

```hcl
# Configuration Azure
location             = "West Europe"
resource_group_name  = "rg-terraform-brief"

# Tags
tags = {
  Environment = "dev"
  Project     = "terraform-brief"
  ManagedBy   = "terraform"
}

# Configuration VM
vm_name         = "vm-terraform-brief"
vm_size         = "Standard_B1s"
vm_admin_username = "azureuser"

# ⚠️ COLLER VOTRE CLÉ SSH PUBLIQUE ICI
vm_ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQD... votre-clé-complète"

# Configuration Storage
# ⚠️ IMPORTANT: Ajoutez des chiffres pour rendre le nom unique
storage_account_name = "stterraformbrief123"  # Doit être unique globalement
container_name       = "data-container"

# Configuration Web App
# ⚠️ IMPORTANT: Ajoutez des chiffres pour rendre le nom unique
webapp_name = "webapp-terraform-brief-123"  # Doit être unique globalement
webapp_sku  = "F1"  # Free tier
```

**Points importants** :
- Les noms `storage_account_name` et `webapp_name` doivent être **uniques globalement**
- Ajoutez des chiffres ou votre nom pour les rendre uniques
- La clé SSH doit être la **clé publique complète** (commence par `ssh-rsa`)

---

## ✅ Vérification Avant de Commencer

### Checklist Pré-Déploiement

- [ ] Compte Azure créé
- [ ] Subscription Azure active
- [ ] Azure CLI installé
- [ ] Connecté via `az login`
- [ ] Subscription sélectionnée
- [ ] Clé SSH générée
- [ ] `terraform.tfvars` créé et rempli
- [ ] Noms uniques pour Storage Account et Web App

### Commandes de Vérification

```bash
# Vérifier la connexion Azure
az account show

# Vérifier la subscription active
az account list --output table

# Vérifier que Terraform est installé (ou via Docker)
terraform version

# Vérifier la clé SSH
cat ~/.ssh/id_rsa.pub
```

---

## 🚀 Une Fois Configuré

Une fois toutes ces étapes faites, vous pouvez :

1. **Initialiser Terraform** :
   ```bash
   cd Brief
   terraform init
   ```

2. **Voir le plan** :
   ```bash
   terraform plan
   ```

3. **Déployer** :
   ```bash
   terraform apply
   ```

---

## 🆘 Dépannage

### Problème: "az: command not found"
**Solution** : Azure CLI n'est pas installé ou pas dans le PATH

### Problème: "Please run 'az login'"
**Solution** : Exécuter `az login`

### Problème: "Storage account name already taken"
**Solution** : Le nom doit être unique. Ajoutez des chiffres ou votre nom.

### Problème: "Web app name already taken"
**Solution** : Le nom doit être unique. Ajoutez des chiffres ou votre nom.

---

*Guide créé pour les étapes manuelles de configuration Azure*

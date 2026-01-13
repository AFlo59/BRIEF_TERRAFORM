# 🚀 Brief - Provisioning Azure avec Terraform

Projet de déploiement d'infrastructure Azure automatisée avec Terraform pour Data Engineering.

---

## 📋 Vue d'ensemble

Ce projet déploie **3 ressources Azure** via Terraform dans le **Resource Group existant `RG_FABADI`** :
1. **Machine Virtuelle Linux** - Pour jobs de traitement de données
2. **Azure Storage Account + Blob Container** - Pour stocker des fichiers de données
3. **Web App Azure** - Pour exposer des résultats/services web

> **Note** : Le projet utilise le Resource Group existant `RG_FABADI` au lieu d'en créer un nouveau.

---

## 🎯 Objectifs

- Automatiser le déploiement d'infrastructure cloud avec Terraform
- Créer des ressources Azure basiques et peu coûteuses
- Organiser le code en modules réutilisables
- Documenter le processus de déploiement

---

## 📁 Structure du Projet

```
Brief/
├── main.tf                    # Configuration principale
├── variables.tf                # Variables globales
├── outputs.tf                 # Outputs globaux
├── terraform.tfvars.example   # Exemple de variables
├── .gitignore                 # Exclure .terraform/, etc.
│
├── modules/                    # Modules Terraform
│   ├── vm/                    # Module Machine Virtuelle
│   ├── storage/               # Module Storage Account + Container
│   └── webapp/                # Module Web App
│
└── docs/                      # Documentation
    ├── DEPLOYMENT.md          # Procédure de déploiement
    ├── VERIFICATION.md        # Procédure de vérification
    └── ARCHITECTURE.md        # Explication de l'architecture
```

---

## 📚 Documentation

### ⚡ Configuration Rapide

**Vous avez déjà un Resource Group `RG_FABADI` ?**

👉 Consultez **[QUICK_CONFIG.md](./QUICK_CONFIG.md)** pour une configuration rapide en 3 étapes.

### Guides Essentiels

1. **[START_HERE.md](./START_HERE.md)** ⭐
   - Guide de démarrage rapide
   - Ce qu'il faut faire en premier

2. **[docs/GUIDE_AZURE_SETUP.md](./docs/GUIDE_AZURE_SETUP.md)** 🔧
   - **Configuration Azure manuelle** (ce que vous devez faire)
   - Création de compte Azure
   - Configuration Azure CLI
   - Génération de clé SSH
   - Configuration terraform.tfvars

3. **[docs/GUIDE_PORTAL_AZURE.md](./docs/GUIDE_PORTAL_AZURE.md)** 🌐
   - **Guide étape par étape du portail Azure**
   - Comment vérifier chaque ressource
   - Captures d'écran recommandées
   - Tests fonctionnels

4. **[docs/DEPLOYMENT.md](./docs/DEPLOYMENT.md)** 🚀
   - Procédure complète de déploiement
   - Commandes étape par étape
   - Tests et vérifications

5. **[docs/VERIFICATION.md](./docs/VERIFICATION.md)** ✅
   - Procédures de vérification complètes
   - Via portail Azure
   - Via Azure CLI
   - Via Terraform outputs

### Documents de Planification

1. **[ANALYSE_BRIEF.md](./ANALYSE_BRIEF.md)**
   - Analyse détaillée des exigences
   - Ressources à créer
   - Contraintes techniques

2. **[PLAN_PROJET.md](./PLAN_PROJET.md)**
   - Plan d'exécution étape par étape
   - Phases de développement
   - Estimation du temps

3. **[STRUCTURE_PROJET.md](./STRUCTURE_PROJET.md)**
   - Structure détaillée des fichiers
   - Description de chaque module
   - Relations entre modules

4. **[CHECKLIST_DETAILLEE.md](./CHECKLIST_DETAILLEE.md)**
   - Checklist complète
   - Validation de tous les critères
   - Préparation du livrable

---

## 🚀 Démarrage Rapide

### Prérequis

- **Terraform** installé (ou via Docker)
- **Azure CLI** installé et configuré
- **Compte Azure** avec crédits disponibles
- **Azure Subscription** active

### Configuration Azure

1. **Se connecter à Azure** :
   ```bash
   az login
   ```

2. **Vérifier la connexion** :
   ```bash
   az account show
   ```

3. **Configurer les variables** :
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   # Éditer terraform.tfvars avec vos valeurs Azure
   ```

### Déploiement

```bash
# Initialiser Terraform
terraform init

# Voir le plan
terraform plan

# Déployer
terraform apply

# Détruire
terraform destroy
```

---

## 📦 Modules

### Module VM (`modules/vm/`)
- Crée une VM Linux (1 vCPU, 1 Go RAM)
- Configure le réseau (VNet, Subnet, NSG)
- Assigne une IP publique

### Module Storage (`modules/storage/`)
- Crée un Storage Account
- Crée un Blob Container
- Configuration basique et peu coûteuse

### Module Web App (`modules/webapp/`)
- Crée un App Service Plan
- Déploie une Web App
- Configuration basique

---

## 🔍 Vérification

### Via Portail Azure
1. Se connecter à [portal.azure.com](https://portal.azure.com)
2. Vérifier chaque ressource dans les Resource Groups

### Via Azure CLI
```bash
# Lister les ressources
az resource list --output table

# Vérifier la VM
az vm list --output table

# Vérifier le Storage
az storage account list --output table

# Vérifier la Web App
az webapp list --output table
```

Voir [docs/VERIFICATION.md](./docs/VERIFICATION.md) pour plus de détails.

---

## 💰 Coûts Estimés

- **VM** : ~$10/mois (Standard_B1s)
- **Storage** : ~$1-2/mois (Standard LRS, selon usage)
- **Web App** : ~$13/mois (Basic B1) ou Gratuit (F1)

**Total estimé** : ~$25/mois (ou ~$12/mois avec Web App Free)

---

## 📝 Livrables

- ✅ Code Terraform organisé en modules
- ✅ Documentation complète
- ✅ Procédures de vérification
- ✅ Variables bien définies

**⚠️ Important** : Exclure le dossier `.terraform/` du livrable ZIP

---

## 🔗 Ressources

- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure CLI Documentation](https://learn.microsoft.com/en-us/cli/azure/)
- [Azure Pricing Calculator](https://azure.microsoft.com/en-us/pricing/calculator/)

---

*Projet créé pour le brief "Provisioning d'infrastructure cloud avec Terraform"*

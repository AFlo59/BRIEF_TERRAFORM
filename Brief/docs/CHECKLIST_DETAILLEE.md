# ✅ Checklist Détaillée du Projet Azure

Checklist complète pour s'assurer que tous les éléments du brief sont couverts.

---

## 📋 Exigences du Brief

### ✅ Ressources à Créer

#### 1. Machine Virtuelle Linux
- [ ] VM Linux créée
- [ ] Spécifications basiques (1 vCPU, 1 Go RAM)
- [ ] Image Linux (Ubuntu Server)
- [ ] Réseau configuré (VNet, Subnet, NSG)
- [ ] IP publique assignée
- [ ] SSH configuré
- [ ] Module Terraform créé

#### 2. Azure Storage Account + Blob Container
- [ ] Storage Account créé
- [ ] Blob Container créé dans le Storage Account
- [ ] Configuration basique et peu coûteuse (LRS)
- [ ] Module Terraform créé

#### 3. Web App Azure
- [ ] App Service Plan créé
- [ ] Web App (App Service) déployée
- [ ] Configuration basique
- [ ] Module Terraform créé

---

## 🔧 Contraintes Techniques

### Organisation du Code
- [ ] **Modules** : Chaque ressource dans un module séparé
  - [ ] Module `vm/` créé
  - [ ] Module `storage/` créé
  - [ ] Module `webapp/` créé
- [ ] **Variables** : Fichier `variables.tf` avec tous les paramètres
- [ ] **Coûts** : Ressources basiques et peu coûteuses
- [ ] **Modularité** : Code organisé en fichiers séparés
  - [ ] `main.tf` - Configuration principale
  - [ ] `variables.tf` - Variables
  - [ ] `outputs.tf` - Outputs
  - [ ] Modules dans `modules/`

---

## 📦 Livrables

### 1. Code Terraform
- [ ] Fichiers `.tf` pour VM
- [ ] Fichiers `.tf` pour Storage Account
- [ ] Fichiers `.tf` pour Blob Container
- [ ] Fichiers `.tf` pour Web App
- [ ] **Dossier `.terraform/` exclu** du livrable

### 2. Documentation
- [ ] **Explication des étapes** de création des ressources
- [ ] **Procédure de vérification** :
  - [ ] Via portail Azure
  - [ ] Via Azure CLI

### 3. Variables
- [ ] Fichier(s) `variables.tf` avec paramètres :
  - [ ] Nom de la VM
  - [ ] Taille de la VM
  - [ ] Nom du container
  - [ ] Autres paramètres nécessaires

---

## 🎯 Critères de Performance

### 1. Code Organisé et Modularisé
- [ ] Code réparti dans différents fichiers :
  - [ ] `main.tf` - Configuration principale
  - [ ] `modules/` - Modules pour chaque ressource
  - [ ] `variables.tf` - Variables
  - [ ] `data sources` - Si nécessaire
  - [ ] `outputs.tf` - Outputs

### 2. Fonctionnement Correct
- [ ] **`terraform plan`** fonctionne
- [ ] **`terraform apply`** fonctionne
- [ ] **`terraform destroy`** fonctionne

### 3. Déploiement Correct
- [ ] Infrastructure déployée sur Azure
- [ ] Toutes les ressources créées selon spécifications
- [ ] VM accessible
- [ ] Storage Account accessible
- [ ] Web App accessible

### 4. Destruction Complète
- [ ] `terraform destroy` supprime toutes les ressources
- [ ] Aucune trace laissée sur Azure
- [ ] Vérification dans le portail Azure

---

## 📝 Checklist Technique Détaillée

### Configuration Azure Provider
- [ ] Provider `azurerm` configuré
- [ ] Version du provider spécifiée
- [ ] Variables pour subscription_id, tenant_id (si nécessaire)
- [ ] Location définie (ex: "West Europe")

### Module VM
- [ ] Resource Group (ou partagé)
- [ ] Virtual Network
- [ ] Subnet
- [ ] Network Security Group
- [ ] Network Security Rule (SSH - port 22)
- [ ] Public IP
- [ ] Network Interface
- [ ] Linux Virtual Machine
  - [ ] Taille : Standard_B1s (1 vCPU, 1 Go RAM)
  - [ ] Image : Ubuntu Server
  - [ ] SSH key configuré
  - [ ] OS Disk configuré

### Module Storage
- [ ] Storage Account
  - [ ] Nom unique
  - [ ] Account tier : Standard
  - [ ] Replication : LRS
- [ ] Storage Container
  - [ ] Nom défini
  - [ ] Access type configuré

### Module Web App
- [ ] App Service Plan
  - [ ] SKU basique (Basic ou Free)
  - [ ] Location
- [ ] App Service (Web App)
  - [ ] Nom unique
  - [ ] Plan associé
  - [ ] Configuration de base

### Variables
- [ ] Variables globales définies
- [ ] Variables pour chaque module
- [ ] Descriptions ajoutées
- [ ] Types spécifiés
- [ ] Valeurs par défaut (si approprié)
- [ ] `terraform.tfvars.example` créé

### Outputs
- [ ] Output VM (IP publique, nom)
- [ ] Output Storage (nom, URL)
- [ ] Output Web App (URL)
- [ ] Descriptions ajoutées

---

## 📚 Documentation

### README.md
- [ ] Vue d'ensemble du projet
- [ ] Prérequis (Azure CLI, Terraform, etc.)
- [ ] Instructions d'installation
- [ ] Instructions de déploiement
- [ ] Instructions de vérification
- [ ] Instructions de destruction

### Documentation des Étapes
- [ ] Explication de la création de la VM
- [ ] Explication de la création du Storage
- [ ] Explication de la création de la Web App
- [ ] Schémas ou diagrammes (optionnel)

### Procédure de Vérification
- [ ] **Via Portail Azure** :
  - [ ] Comment accéder au portail
  - [ ] Où trouver chaque ressource
  - [ ] Comment vérifier chaque ressource
- [ ] **Via Azure CLI** :
  - [ ] Commandes pour lister les ressources
  - [ ] Commandes pour vérifier chaque ressource
  - [ ] Commandes pour tester la connectivité

---

## 🧪 Tests

### Tests Locaux
- [ ] `terraform init` - Succès
- [ ] `terraform validate` - Aucune erreur
- [ ] `terraform fmt` - Code formaté
- [ ] `terraform plan` - Plan généré sans erreur

### Tests Azure
- [ ] `terraform apply` - Déploiement réussi
- [ ] VM accessible via SSH
- [ ] Storage Account accessible
- [ ] Container créé dans Storage
- [ ] Web App accessible (URL fonctionne)
- [ ] `terraform destroy` - Destruction complète

---

## 💰 Optimisation des Coûts

- [ ] VM : Standard_B1s (le moins cher)
- [ ] Storage : Standard LRS (le moins cher)
- [ ] Web App : Basic B1 ou Free (le moins cher)
- [ ] Pas de ressources inutiles
- [ ] Tags pour faciliter la gestion

---

## 🔐 Sécurité

- [ ] Pas de secrets hardcodés
- [ ] Variables pour les secrets
- [ ] SSH keys au lieu de mots de passe
- [ ] Network Security Groups configurés
- [ ] `.gitignore` exclut les fichiers sensibles

---

## 📦 Préparation du Livrable

- [ ] Tous les fichiers `.tf` présents
- [ ] Documentation complète
- [ ] Dossier `.terraform/` **exclu**
- [ ] Fichiers `*.tfstate` **exclus**
- [ ] `terraform.tfvars` **exclu** (si contient secrets)
- [ ] Archive ZIP créée
- [ ] Archive testée (extraction + vérification)

---

## ✅ Validation Finale

Avant de soumettre, vérifier :

1. [ ] Toutes les ressources sont créées
2. [ ] Le code est organisé en modules
3. [ ] Les variables sont bien définies
4. [ ] La documentation est complète
5. [ ] Les procédures de vérification sont claires
6. [ ] `terraform destroy` fonctionne
7. [ ] Le dossier `.terraform/` est exclu du livrable
8. [ ] Le projet est prêt à être soumis

---

*Checklist créée pour s'assurer de couvrir tous les aspects du brief*

# 🚀 Projet BRIEF_TERRAFORM

Projet d'apprentissage et de déploiement d'infrastructure avec Terraform.

---

## 📋 Vue d'ensemble

Ce projet contient :
- **Brief Azure** - Déploiement d'infrastructure Azure avec Terraform
- **Exercices Terraform** - Exercices locaux pour apprendre Terraform
- **Application de streaming** SmartTech pour le traitement de données de capteurs
- **Documentation** et ressources d'apprentissage

---

## 🗂️ Structure du Projet

```
BRIEF_TERRAFORM/
├── Brief/                    # Projet Brief Azure (infrastructure complète)
│   ├── docker/               # Configuration Docker pour Brief
│   ├── scripts/              # Scripts Terraform (wsl/powershell)
│   ├── modules/              # Modules Terraform (vm, storage, webapp)
│   └── docs/                 # Documentation du Brief
│
├── Exercices/                 # Exercices Terraform locaux
│   ├── docker/               # Configuration Docker pour exercices
│   ├── scripts/              # Scripts Terraform (wsl/powershell)
│   ├── docs/                 # Documentation des exercices
│   └── exercice_*/           # Exercices individuels (1-4)
│
├── docs/                     # Documentation générale
│   └── terraform/            # Guides Terraform généraux
│
├── IaC-Provisionning(Terraform)/  # PDFs d'apprentissage
├── sensor_data/              # Données de capteurs
└── smarttech-streaming/      # Application de streaming
```

---

## 🎯 Projets Disponibles

### 1. Brief Azure (`Brief/`)

Déploiement d'infrastructure Azure complète :
- Machine Virtuelle Linux
- Azure Storage Account + Blob Container
- Web App Azure

**Documentation** : [Brief/README.md](./Brief/README.md)

**Démarrage rapide** :
```bash
cd Brief
./scripts/wsl/terraform-init.sh
./scripts/wsl/terraform-plan.sh
```

---

### 2. Exercices Terraform (`Exercices/`)

4 exercices locaux pour apprendre Terraform :
1. Créer un fichier local
2. Utiliser des variables
3. Télécharger un fichier via HTTP
4. Générer des mots de passe aléatoires

**Documentation** : [Exercices/README.md](./Exercices/README.md)

**Démarrage rapide** :
```bash
cd Exercices/exercice_1
./run.sh init
./run.sh apply
```

---

## 🐳 Docker

Les deux projets utilisent Docker pour exécuter Terraform sans installation locale.

### Brief Azure
- **Image** : `terraform-brief:latest`
- **Build** : `Brief/scripts/docker/docker-build.sh`

### Exercices
- **Image** : `terraform-exercices:latest`
- **Build** : `Exercices/scripts/docker/docker-build.sh`

---

## 🛠️ Prérequis

- **Docker** installé et en cours d'exécution
- **WSL** (pour les scripts bash) ou **PowerShell** (pour les scripts .ps1)
- **Azure CLI** (pour le Brief Azure uniquement)

---

## 📚 Documentation

### Brief Azure
- [Guide de configuration Azure](./Brief/docs/GUIDE_AZURE_SETUP.md)
- [Guide portail Azure](./Brief/docs/GUIDE_PORTAL_AZURE.md)
- [Procédure de déploiement](./Brief/docs/DEPLOYMENT.md)

### Exercices
- [Documentation des exercices](./Exercices/docs/)
- [Guide Docker](./docs/terraform/GUIDE_DOCKER.md)

### Général
- [Extensions IDE Terraform](./docs/terraform/IDE_EXTENSIONS.md)

---

## 🚀 Démarrage Rapide

### Pour le Brief Azure

```bash
# WSL
cd Brief
./scripts/wsl/terraform-init.sh
./scripts/wsl/terraform-plan.sh
```

```powershell
# PowerShell
cd Brief
.\scripts\powershell\terraform-init.ps1
.\scripts\powershell\terraform-plan.ps1
```

### Pour les Exercices

```bash
# WSL
cd Exercices/exercice_1
./run.sh init
./run.sh apply
```

---

## 🔧 Technologies Utilisées

- **Terraform** - Infrastructure as Code
- **Docker** - Conteneurisation
- **Azure** - Cloud provider (Brief)
- **Apache Spark** - Streaming (SmartTech)
- **Delta Lake** - Stockage de données
- **Kafka** - Messagerie en streaming

---

## 📝 Notes

- Les projets **Brief** et **Exercices** sont indépendants
- Chaque projet a son propre conteneur Docker
- Les scripts sont disponibles en versions WSL (bash) et PowerShell

---

*Projet organisé pour l'apprentissage et le déploiement avec Terraform*

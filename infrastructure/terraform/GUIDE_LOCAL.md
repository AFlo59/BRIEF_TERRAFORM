# 🏠 Guide: Exécuter les Exercices Terraform en Local

Ce guide explique comment faire les exercices Terraform **sans avoir besoin d'un compte cloud** ou de credentials.

---

## 🎯 Options Disponibles

### Option 1: Providers Locaux (Recommandé pour Apprendre) ⭐

Terraform propose des **providers locaux** qui permettent de créer des ressources "virtuelles" sans connexion à un cloud.

**Avantages:**
- ✅ Gratuit
- ✅ Pas besoin de credentials cloud
- ✅ Pas de coûts
- ✅ Parfait pour apprendre la syntaxe Terraform
- ✅ Rapide et sans latence réseau

**Inconvénients:**
- ⚠️ Ressources virtuelles uniquement (pas de vraies instances)
- ⚠️ Limité aux fonctionnalités de base

### Option 2: LocalStack (Simulation AWS)

LocalStack simule les services AWS localement dans Docker.

**Avantages:**
- ✅ Gratuit
- ✅ API AWS complète simulée
- ✅ Parfait pour tester avant de déployer en vrai

**Inconvénients:**
- ⚠️ Nécessite Docker
- ⚠️ Configuration plus complexe

### Option 3: Cloud Provider (Production)

Utiliser un vrai cloud provider (AWS, Azure, GCP).

**Avantages:**
- ✅ Environnement réel
- ✅ Expérience complète

**Inconvénients:**
- ❌ Nécessite un compte cloud
- ❌ Peut générer des coûts
- ❌ Nécessite des credentials

---

## 🚀 Option 1: Providers Locaux (Recommandé)

### Configuration pour les Exercices

#### Exercice 1: Provider Local

**Fichier: `main.tf`**

```hcl
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    # Provider local - crée des fichiers/répertoires localement
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
    
    # Provider random - génère des valeurs aléatoires
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
    
    # Provider null - pour les ressources de test
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
}

# Pas besoin de configurer le provider local
# Il fonctionne automatiquement
```

#### Exercice 2: Variables Locales

**Fichier: `variables.tf`**

```hcl
variable "project_name" {
  description = "Nom du projet"
  type        = string
  default     = "brief-terraform"
}

variable "environment" {
  description = "Environnement (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "file_content" {
  description = "Contenu du fichier à créer"
  type        = string
  default     = "Hello from Terraform!"
}
```

#### Exercice 3: Ressources Locales

**Fichier: `main.tf`** (ajouter après le bloc terraform)

```hcl
# Créer un répertoire
resource "local_file" "project_dir" {
  content  = ""
  filename = "${path.module}/output/${var.project_name}"
}

# Créer un fichier avec du contenu
resource "local_file" "readme" {
  content = <<-EOT
    # Projet ${var.project_name}
    
    Environnement: ${var.environment}
    Créé avec Terraform le ${timestamp()}
  EOT
  
  filename        = "${path.module}/output/README.md"
  file_permission = "0644"
  
  depends_on = [local_file.project_dir]
}

# Générer un ID aléatoire
resource "random_id" "project_id" {
  byte_length = 4
}

# Créer un fichier avec l'ID généré
resource "local_file" "config" {
  content = <<-EOT
    project_name = "${var.project_name}"
    project_id   = "${random_id.project_id.hex}"
    environment  = "${var.environment}"
    created_at   = "${timestamp()}"
  EOT
  
  filename = "${path.module}/output/config.txt"
}
```

#### Exercice 4: Outputs Locaux

**Fichier: `outputs.tf`**

```hcl
output "project_name" {
  description = "Nom du projet"
  value       = var.project_name
}

output "project_id" {
  description = "ID aléatoire généré pour le projet"
  value       = random_id.project_id.hex
}

output "readme_file_path" {
  description = "Chemin du fichier README créé"
  value       = local_file.readme.filename
}

output "config_file_path" {
  description = "Chemin du fichier de configuration"
  value       = local_file.config.filename
}

output "all_files" {
  description = "Liste de tous les fichiers créés"
  value = [
    local_file.readme.filename,
    local_file.config.filename
  ]
}
```

### Exécution

```powershell
# 1. Initialiser
.\scripts\terraform.ps1 init

# 2. Valider
.\scripts\terraform.ps1 validate

# 3. Plan
.\scripts\terraform.ps1 plan

# 4. Appliquer
.\scripts\terraform.ps1 apply

# 5. Voir les outputs
.\scripts\terraform.ps1 output

# 6. Vérifier les fichiers créés
ls infrastructure/terraform/output/
```

---

## 🐳 Option 2: LocalStack (Simulation AWS)

### Installation de LocalStack

```powershell
# Installer LocalStack via Docker
docker pull localstack/localstack:latest

# Ou utiliser docker-compose
```

**Fichier: `docker-compose.localstack.yml`**

```yaml
version: '3.8'

services:
  localstack:
    image: localstack/localstack:latest
    ports:
      - "4566:4566"  # Edge port
      - "4510-4559:4510-4559"  # External services port range
    environment:
      - SERVICES=s3,ec2,lambda,iam,sts
      - DEBUG=1
      - DATA_DIR=/tmp/localstack/data
    volumes:
      - "./localstack-data:/tmp/localstack"
      - "/var/run/docker.sock:/var/run/docker.sock"
```

### Configuration Terraform pour LocalStack

**Fichier: `main.tf`**

```hcl
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  access_key                  = "test"
  secret_key                  = "test"
  region                      = "us-east-1"
  
  # Configuration pour LocalStack
  endpoints {
    s3  = "http://localhost:4566"
    ec2 = "http://localhost:4566"
    iam = "http://localhost:4566"
  }
  
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
}

# Exemple: Créer un bucket S3
resource "aws_s3_bucket" "test" {
  bucket = "my-test-bucket-${random_id.bucket_suffix.hex}"
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}
```

### Utilisation

```powershell
# 1. Démarrer LocalStack
docker-compose -f docker-compose.localstack.yml up -d

# 2. Initialiser Terraform
.\scripts\terraform.ps1 init

# 3. Appliquer
.\scripts\terraform.ps1 apply
```

---

## ☁️ Option 3: Cloud Provider (Si vous avez un compte)

### AWS (Free Tier disponible)

**Configuration minimale:**

1. Créer un compte AWS (free tier disponible)
2. Créer un utilisateur IAM avec permissions
3. Configurer les credentials

**Fichier: `main.tf`**

```hcl
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
  # Credentials via variables d'environnement:
  # AWS_ACCESS_KEY_ID
  # AWS_SECRET_ACCESS_KEY
}
```

**Variables d'environnement:**

```powershell
$env:AWS_ACCESS_KEY_ID = "your-access-key"
$env:AWS_SECRET_ACCESS_KEY = "your-secret-key"
$env:AWS_DEFAULT_REGION = "us-east-1"
```

---

## 📊 Comparaison des Options

| Critère | Provider Local | LocalStack | Cloud Provider |
|---------|----------------|------------|----------------|
| **Coût** | ✅ Gratuit | ✅ Gratuit | ⚠️ Peut coûter |
| **Setup** | ✅ Très simple | ⚠️ Moyen | ⚠️ Complexe |
| **Credentials** | ✅ Non requis | ✅ Non requis | ❌ Requis |
| **Ressources réelles** | ❌ Non | ❌ Simulées | ✅ Oui |
| **Apprentissage** | ✅ Parfait | ✅ Bon | ✅ Excellent |
| **Production** | ❌ Non | ❌ Non | ✅ Oui |

---

## 🎓 Recommandation pour les Exercices

### Pour Apprendre (Recommandé) ⭐

**Utilisez l'Option 1 (Providers Locaux)**

- Parfait pour comprendre la syntaxe Terraform
- Pas de configuration complexe
- Résultats visibles immédiatement (fichiers créés)
- Gratuit et sans risque

### Pour Tester avant Production

**Utilisez l'Option 2 (LocalStack)**

- Simule l'API AWS complète
- Permet de tester des configurations complexes
- Bon compromis entre local et cloud

### Pour Production

**Utilisez l'Option 3 (Cloud Provider)**

- Environnement réel
- Nécessite un compte et des credentials
- Peut générer des coûts

---

## 🚀 Quick Start: Option 1 (Local)

1. **Modifier `main.tf`** avec la configuration locale (voir ci-dessus)
2. **Modifier `variables.tf`** avec les variables locales
3. **Ajouter les ressources** dans `main.tf`
4. **Ajouter les outputs** dans `outputs.tf`
5. **Exécuter**:
   ```powershell
   .\scripts\terraform.ps1 init
   .\scripts\terraform.ps1 plan
   .\scripts\terraform.ps1 apply
   ```

---

## 📝 Exemple Complet Local

Un exemple complet est disponible dans `EXERCICES_LOCAL.md` (à créer si nécessaire) avec:
- Configuration complète des providers locaux
- Exemples de ressources
- Variables et outputs
- Commandes d'exécution

---

*Guide créé pour permettre l'apprentissage de Terraform sans setup cloud*

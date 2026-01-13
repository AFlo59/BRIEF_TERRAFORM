# Infrastructure Terraform

Configuration Infrastructure as Code (IaC) pour le projet BRIEF_TERRAFORM.

## 🐳 Utilisation avec Docker

Ce projet utilise Terraform via Docker pour éviter l'installation locale. Aucune installation de Terraform n'est nécessaire sur votre machine !

### Prérequis

- **Docker** installé et en cours d'exécution
- **Docker Compose** (optionnel, pour utiliser docker-compose.yml)

### 🚀 Commandes Rapides

Utilisez le script PowerShell wrapper pour exécuter Terraform :

```powershell
# Depuis la racine du projet
.\scripts\terraform.ps1 <command> [options]
```

#### Commandes Disponibles

| Commande | Description |
|----------|-------------|
| `init` | Initialise Terraform et télécharge les providers |
| `plan` | Génère un plan d'exécution |
| `apply` | Applique les changements |
| `destroy` | Détruit l'infrastructure |
| `validate` | Valide la syntaxe des fichiers |
| `fmt` | Formate les fichiers .tf |
| `version` | Affiche la version de Terraform |

#### Exemples

```powershell
# Initialiser Terraform
.\scripts\terraform.ps1 init

# Générer un plan
.\scripts\terraform.ps1 plan

# Appliquer les changements (avec auto-approve)
.\scripts\terraform.ps1 apply -auto-approve

# Valider la configuration
.\scripts\terraform.ps1 validate

# Formater les fichiers
.\scripts\terraform.ps1 fmt

# Voir l'aide
.\scripts\terraform.ps1 help
```

### 📝 Utilisation Directe avec Docker

Si vous préférez utiliser Docker directement :

```powershell
# Se placer dans le dossier terraform
cd infrastructure/terraform

# Initialiser
docker run --rm -it -v ${PWD}:/workspace -w /workspace hashicorp/terraform:latest init

# Plan
docker run --rm -it -v ${PWD}:/workspace -w /workspace hashicorp/terraform:latest plan

# Apply
docker run --rm -it -v ${PWD}:/workspace -w /workspace hashicorp/terraform:latest apply
```

### 🐳 Utilisation avec Docker Compose

Vous pouvez également utiliser docker-compose :

```powershell
cd infrastructure/terraform

# Initialiser
docker-compose run --rm terraform init

# Plan
docker-compose run --rm terraform plan

# Apply
docker-compose run --rm terraform apply
```

## 📁 Structure des Fichiers

```
infrastructure/terraform/
├── docker-compose.yml         # Configuration Docker Compose
├── main.tf                     # Configuration principale
├── variables.tf                # Définition des variables
├── outputs.tf                  # Définition des outputs
├── .gitignore                  # Fichiers à ignorer
├── README.md                   # Ce fichier
├── EXERCICES_OFFICIELS.md      # 📋 Les 4 exercices du PDF
├── GUIDE_LOCAL.md              # Guide pour exécuter en local
└── exercice_1/                 # Dossiers pour chaque exercice
    exercice_2/
    exercice_3/
    exercice_4/
```

## 📚 Exercices Officiels

Les **4 exercices** du document "Intro Terraform.pdf" sont documentés dans **[EXERCICES_OFFICIELS.md](./EXERCICES_OFFICIELS.md)**.

### Résumé des Exercices

1. **Exercice 1**: Créer un fichier local avec `local_file`
2. **Exercice 2**: Utiliser des variables pour créer un fichier dynamique
3. **Exercice 3**: Télécharger un fichier via HTTP et le sauvegarder localement
4. **Exercice 4**: Générer 10 mots de passe aléatoires et les sauvegarder

> ✅ **Tous les exercices peuvent être faits en local** - Aucun compte cloud nécessaire !

## ⚙️ Configuration

### Variables

Définissez vos variables dans `variables.tf` ou créez un fichier `terraform.tfvars` :

```hcl
# terraform.tfvars
region        = "us-east-1"
instance_type = "t2.micro"
```

Utilisez-les ensuite :

```powershell
.\scripts\terraform.ps1 plan -var-file="terraform.tfvars"
```

### Providers

Ajoutez vos providers dans `main.tf` :

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}
```

## 🔐 Gestion des Secrets

⚠️ **Important**: Ne commitez jamais de fichiers contenant des secrets !

- Utilisez des variables d'environnement
- Utilisez un fichier `terraform.tfvars` (déjà dans .gitignore)
- Utilisez un backend sécurisé pour le state (S3, Azure Storage, etc.)

## 📊 État Terraform (State)

Par défaut, Terraform stocke l'état localement dans `terraform.tfstate`.

Pour un environnement de production, configurez un backend distant :

```hcl
terraform {
  backend "s3" {
    bucket = "your-terraform-state-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
```

## 🧹 Nettoyage

Pour nettoyer les volumes Docker créés :

```powershell
docker volume rm terraform-plugins terraform-cache
```

## 📚 Ressources

- [Documentation Terraform](https://www.terraform.io/docs)
- [Terraform Docker Image](https://hub.docker.com/r/hashicorp/terraform)
- [Best Practices Terraform](https://www.terraform.io/docs/cloud/guides/recommended-practices/index.html)

## 🆘 Dépannage

### Problème: Docker n'est pas trouvé
- Vérifiez que Docker est installé et en cours d'exécution
- Vérifiez que Docker est dans votre PATH

### Problème: Permissions refusées
- Sur Linux/Mac, vous pourriez avoir besoin de `sudo`
- Sur Windows, assurez-vous d'exécuter PowerShell en tant qu'administrateur si nécessaire

### Problème: Les plugins ne se téléchargent pas
- Vérifiez votre connexion Internet
- Les plugins sont mis en cache dans le volume Docker `terraform-plugins`

---

*Dernière mise à jour: Configuration initiale*

# 📋 Exercices Terraform Officiels

Basé sur le document **Intro Terraform.pdf**, voici les **4 exercices officiels** à compléter.

> ✅ **Tous ces exercices peuvent être faits en local** - Aucun compte cloud nécessaire !

---

## 🎯 Exercice 1 : Fichier Local

### Objectif
Prendre en main Terraform en créant un fichier local sur votre machine avec du contenu spécifique et en définissant les droits sur ce fichier.

### Consignes

1. **Créer un sous-dossier** `exercice_1` dans votre dossier de projet Terraform
2. **Créer un fichier `main.tf`** pour définir votre première ressource
3. **Créer une ressource `local_file`** qui génère un fichier texte appelé `hello_world.txt` avec le contenu : `"Bienvenue dans Terraform !"`
4. **Ajouter des arguments** pour définir les permissions de lecture et écriture sur le fichier (ex: `0755`)
5. **Exécuter les commandes** nécessaires pour obtenir la création du fichier local

### Solution

**Fichier: `exercice_1/main.tf`**

```hcl
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

resource "local_file" "hello_world" {
  content  = "Bienvenue dans Terraform !"
  filename = "${path.module}/hello_world.txt"
  file_permission = "0755"
}
```

### Commandes d'exécution

```powershell
# Se placer dans le dossier exercice_1
cd infrastructure/terraform/exercice_1

# Initialiser Terraform
..\..\..\scripts\terraform.ps1 init

# Valider
..\..\..\scripts\terraform.ps1 validate

# Plan
..\..\..\scripts\terraform.ps1 plan

# Appliquer
..\..\..\scripts\terraform.ps1 apply

# Vérifier le fichier créé
ls hello_world.txt
cat hello_world.txt
```

### Ressources
- [Provider Local - Resource File](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file)

---

## 🎯 Exercice 2 : Variables

### Objectif
Découvrir l'utilisation des variables dans Terraform pour rendre la configuration flexible. Vous allez créer un fichier dont le nom et le contenu seront définis par des variables.

### Consignes

1. **Créer un sous-dossier** `exercice_2` dans votre dossier de projet Terraform
2. **Créer deux fichiers** : `main.tf` et `variables.tf`
3. **Dans `variables.tf`**, définir deux variables :
   - `file_name` : une chaîne de caractères qui représente le nom du fichier à créer
   - `file_content` : une chaîne de caractères qui sera utilisée pour remplir le fichier
4. **Dans `main.tf`**, utiliser ces variables pour créer un fichier avec Terraform
5. **Exécuter les commandes** nécessaires pour obtenir la création du fichier local

### Solution

**Fichier: `exercice_2/variables.tf`**

```hcl
variable "file_name" {
  description = "Nom du fichier à créer"
  type        = string
  default     = "mon_fichier.txt"
}

variable "file_content" {
  description = "Contenu du fichier"
  type        = string
  default     = "Contenu par défaut"
}
```

**Fichier: `exercice_2/main.tf`**

```hcl
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

resource "local_file" "dynamic_file" {
  content  = var.file_content
  filename = "${path.module}/${var.file_name}"
  file_permission = "0644"
}
```

### Utilisation avec variables personnalisées

**Option 1: Via fichier `terraform.tfvars`**

Créer `exercice_2/terraform.tfvars`:
```hcl
file_name    = "mon_document.txt"
file_content = "Ceci est le contenu de mon fichier créé avec Terraform !"
```

Puis exécuter:
```powershell
..\..\..\scripts\terraform.ps1 apply -var-file="terraform.tfvars"
```

**Option 2: Via ligne de commande**

```powershell
..\..\..\scripts\terraform.ps1 apply -var="file_name=test.txt" -var="file_content=Hello Terraform!"
```

### Commandes d'exécution

```powershell
cd infrastructure/terraform/exercice_2

# Initialiser
..\..\..\scripts\terraform.ps1 init

# Appliquer avec les valeurs par défaut
..\..\..\scripts\terraform.ps1 apply

# Ou avec des variables personnalisées
..\..\..\scripts\terraform.ps1 apply -var="file_name=mon_fichier.txt" -var="file_content=Contenu personnalisé"
```

### Ressources
- [Provider Local - Resource File](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file)
- [Terraform Variables](https://developer.hashicorp.com/terraform/language/values/variables)

---

## 🎯 Exercice 3 : Data Source + HTTP

### Objectif
Utiliser le provider HTTP de Terraform pour télécharger un fichier à partir d'une URL et le stocker localement.

Le fichier se situe à l'adresse suivante : `https://cdn.wsform.com/wp-content/uploads/2018/09/country_full.csv`

### Consignes

1. **Créer un sous-dossier** `exercice_3` dans votre dossier de projet Terraform
2. **Créer un fichier `main.tf`** pour définir le téléchargement et la sauvegarde du fichier
3. **Créer une source de données `data`** basée sur le fichier à télécharger
4. **Créer une ressource `local_file`** pour sauvegarder ce fichier localement sous le nom `downloaded_file.txt`
5. **Exécuter les commandes** nécessaires pour procéder au téléchargement du fichier

### Solution

**Fichier: `exercice_3/main.tf`**

```hcl
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    http = {
      source  = "hashicorp/http"
      version = "~> 3.4"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

# Data source pour télécharger le fichier depuis l'URL
data "http" "country_data" {
  url = "https://cdn.wsform.com/wp-content/uploads/2018/09/country_full.csv"
  
  # Optionnel: méthode de requête
  request_headers = {
    Accept = "text/csv"
  }
}

# Ressource pour sauvegarder le fichier téléchargé localement
resource "local_file" "downloaded_file" {
  content  = data.http.country_data.response_body
  filename = "${path.module}/downloaded_file.txt"
  file_permission = "0644"
}
```

### Commandes d'exécution

```powershell
cd infrastructure/terraform/exercice_3

# Initialiser
..\..\..\scripts\terraform.ps1 init

# Plan (va télécharger le fichier pour vérifier)
..\..\..\scripts\terraform.ps1 plan

# Appliquer
..\..\..\scripts\terraform.ps1 apply

# Vérifier le fichier téléchargé
ls downloaded_file.txt
cat downloaded_file.txt
```

### Ressources
- [Provider HTTP](https://registry.terraform.io/providers/hashicorp/http/latest/docs)

---

## 🎯 Exercice 4 : Multi Providers

### Objectif
Utiliser Terraform pour générer un ensemble de 10 mots de passe aléatoires et les stocker dans un fichier local. Cet exercice vous permet de travailler avec deux ressources Terraform où l'une dépend de l'autre : une ressource random pour générer des mots de passe et une ressource local_file pour les sauvegarder.

### Consignes

1. **Créer un sous-dossier** `exercice_4` dans votre dossier de projet Terraform
2. **Créer un fichier `main.tf`** pour définir les ressources
3. **Utiliser la ressource adéquate du provider random** pour générer 10 mots de passe aléatoires
4. **Votre code doit contenir 2 ressources**
5. **Exécuter les commandes** nécessaires pour procéder à la génération et sauvegarde des mots de passe

### Solution

**Fichier: `exercice_4/main.tf`**

```hcl
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

# Générer 10 mots de passe aléatoires
resource "random_password" "passwords" {
  count   = 10
  length  = 16
  special = true
  upper   = true
  lower   = true
  numeric = true
}

# Sauvegarder les mots de passe dans un fichier
resource "local_file" "passwords_file" {
  content = <<-EOT
    # Mots de passe générés avec Terraform
    # Générés le: ${timestamp()}
    
    ${join("\n", [
      for i, password in random_password.passwords : "Password ${i + 1}: ${password.result}"
    ])}
  EOT
  
  filename        = "${path.module}/passwords.txt"
  file_permission = "0600"  # Permissions restrictives pour un fichier de mots de passe
}
```

### Alternative avec for_each

**Version alternative utilisant `for_each`:**

```hcl
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

# Générer 10 mots de passe avec for_each
resource "random_password" "passwords" {
  for_each = toset([for i in range(1, 11) : "password_${i}"])
  
  length  = 16
  special = true
  upper   = true
  lower   = true
  numeric = true
}

# Sauvegarder les mots de passe
resource "local_file" "passwords_file" {
  content = <<-EOT
    # Mots de passe générés avec Terraform
    # Générés le: ${timestamp()}
    
    ${join("\n", [
      for key, password in random_password.passwords : "${key}: ${password.result}"
    ])}
  EOT
  
  filename        = "${path.module}/passwords.txt"
  file_permission = "0600"
}
```

### Commandes d'exécution

```powershell
cd infrastructure/terraform/exercice_4

# Initialiser
..\..\..\scripts\terraform.ps1 init

# Plan
..\..\..\scripts\terraform.ps1 plan

# Appliquer
..\..\..\scripts\terraform.ps1 apply

# Vérifier le fichier créé
ls passwords.txt
cat passwords.txt
```

### Ressources
- [Provider Random](https://registry.terraform.io/providers/hashicorp/random/latest/docs)
- [Terraform for_each](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each)

---

## 📋 Checklist Complète des 4 Exercices

### ✅ Exercice 1: Fichier Local
- [ ] Dossier `exercice_1` créé
- [ ] Fichier `main.tf` créé avec ressource `local_file`
- [ ] Contenu "Bienvenue dans Terraform !"
- [ ] Permissions définies (0755)
- [ ] `terraform init` exécuté
- [ ] `terraform apply` exécuté
- [ ] Fichier `hello_world.txt` créé et vérifié

### ✅ Exercice 2: Variables
- [ ] Dossier `exercice_2` créé
- [ ] Fichier `variables.tf` créé avec 2 variables
- [ ] Fichier `main.tf` utilisant les variables
- [ ] `terraform init` exécuté
- [ ] `terraform apply` exécuté avec variables
- [ ] Fichier créé avec le nom et contenu des variables

### ✅ Exercice 3: Data Source + HTTP
- [ ] Dossier `exercice_3` créé
- [ ] Fichier `main.tf` avec provider `http`
- [ ] Data source `http` configurée avec l'URL
- [ ] Ressource `local_file` utilisant la data source
- [ ] `terraform init` exécuté
- [ ] `terraform apply` exécuté
- [ ] Fichier `downloaded_file.txt` créé avec le contenu téléchargé

### ✅ Exercice 4: Multi Providers
- [ ] Dossier `exercice_4` créé
- [ ] Fichier `main.tf` avec providers `random` et `local`
- [ ] 10 mots de passe générés avec `random_password`
- [ ] Ressource `local_file` pour sauvegarder les mots de passe
- [ ] 2 ressources au total (random + local)
- [ ] `terraform init` exécuté
- [ ] `terraform apply` exécuté
- [ ] Fichier `passwords.txt` créé avec 10 mots de passe

---

## 🚀 Workflow Complet

### Structure des dossiers

```
infrastructure/terraform/
├── exercice_1/
│   └── main.tf
├── exercice_2/
│   ├── main.tf
│   └── variables.tf
├── exercice_3/
│   └── main.tf
└── exercice_4/
    └── main.tf
```

### Commandes pour chaque exercice

```powershell
# Pour chaque exercice, depuis la racine du projet:
cd infrastructure/terraform/exercice_X

# 1. Initialiser
..\..\..\scripts\terraform.ps1 init

# 2. Valider
..\..\..\scripts\terraform.ps1 validate

# 3. Plan
..\..\..\scripts\terraform.ps1 plan

# 4. Appliquer
..\..\..\scripts\terraform.ps1 apply

# 5. Vérifier les résultats
ls
```

---

## 💡 Points d'Apprentissage

### Exercice 1
- ✅ Utilisation du provider `local`
- ✅ Création d'une ressource `local_file`
- ✅ Définition des permissions de fichier

### Exercice 2
- ✅ Définition de variables
- ✅ Utilisation de variables dans les ressources
- ✅ Passage de variables via CLI ou fichiers

### Exercice 3
- ✅ Utilisation du provider `http`
- ✅ Data sources pour lire des données externes
- ✅ Référencement d'une data source dans une ressource

### Exercice 4
- ✅ Utilisation du provider `random`
- ✅ Génération de multiples ressources avec `count` ou `for_each`
- ✅ Dépendances entre ressources
- ✅ Fonctions Terraform (`join`, `for`, `timestamp`)

---

## 📚 Ressources Complémentaires

- [Documentation Terraform](https://www.terraform.io/docs)
- [Terraform Language Documentation](https://developer.hashicorp.com/terraform/language)
- [Terraform Providers Registry](https://registry.terraform.io/)

---

*Exercices basés sur le document "Intro Terraform.pdf"*

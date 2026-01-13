# 🏠 Exercices Terraform - Version Locale (Sans Cloud)

Ce document contient les **4 exercices Terraform** adaptés pour être exécutés **entièrement en local**, sans besoin de compte cloud ou de credentials.

---

## ✅ Prérequis

- Docker installé (pour exécuter Terraform)
- Aucun compte cloud nécessaire
- Aucun credential nécessaire

---

## 🎯 Exercice 1: Configuration du Provider Local

### Objectif
Configurer les providers Terraform locaux pour créer des ressources sur votre machine.

### Fichier: `main.tf`

```hcl
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    # Provider local - crée des fichiers/répertoires
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

# Les providers locaux n'ont pas besoin de configuration
# Ils fonctionnent automatiquement
```

### Validation

```powershell
.\scripts\terraform.ps1 init
.\scripts\terraform.ps1 validate
```

**Résultat attendu**: ✅ Initialisation réussie, providers téléchargés

---

## 🎯 Exercice 2: Définition des Variables

### Objectif
Définir les variables nécessaires pour créer des ressources locales.

### Fichier: `variables.tf`

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
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "L'environnement doit être dev, staging ou prod."
  }
}

variable "file_content" {
  description = "Contenu du fichier principal à créer"
  type        = string
  default     = "Hello from Terraform!"
}

variable "create_backup" {
  description = "Créer une sauvegarde du fichier"
  type        = bool
  default     = true
}
```

### Validation

```powershell
.\scripts\terraform.ps1 validate
```

**Résultat attendu**: ✅ Validation réussie

---

## 🎯 Exercice 3: Création de Ressources Locales

### Objectif
Créer des ressources locales (fichiers, répertoires) avec Terraform.

### Fichier: `main.tf` (ajouter après le bloc terraform)

```hcl
# Générer un ID unique pour le projet
resource "random_id" "project_id" {
  byte_length = 8
}

# Créer le répertoire de sortie
resource "local_file" "output_dir" {
  content  = ""
  filename = "${path.module}/output/.gitkeep"
}

# Créer un fichier README avec des informations dynamiques
resource "local_file" "readme" {
  content = <<-EOT
    # Projet ${var.project_name}
    
    ## Informations du Projet
    
    - **ID du Projet**: ${random_id.project_id.hex}
    - **Environnement**: ${var.environment}
    - **Créé le**: ${timestamp()}
    - **Géré par**: Terraform
    
    ## Description
    
    Ce projet a été créé automatiquement avec Terraform.
    Il démontre l'utilisation des providers locaux.
    
    ## Structure
    
    - `config.txt`: Configuration du projet
    - `data.json`: Données du projet
    ${var.create_backup ? "- `backup/`: Sauvegarde des fichiers" : ""}
  EOT
  
  filename        = "${path.module}/output/README.md"
  file_permission = "0644"
  
  depends_on = [local_file.output_dir]
}

# Créer un fichier de configuration
resource "local_file" "config" {
  content = <<-EOT
    project_name = "${var.project_name}"
    project_id   = "${random_id.project_id.hex}"
    environment  = "${var.environment}"
    created_at   = "${timestamp()}"
    terraform_version = ">= 1.0"
  EOT
  
  filename        = "${path.module}/output/config.txt"
  file_permission = "0644"
}

# Créer un fichier JSON avec les données
resource "local_file" "data_json" {
  content = jsonencode({
    project_name = var.project_name
    project_id   = random_id.project_id.hex
    environment  = var.environment
    created_at   = timestamp()
    files = [
      "README.md",
      "config.txt",
      "data.json"
    ]
  })
  
  filename        = "${path.module}/output/data.json"
  file_permission = "0644"
}

# Créer un fichier de sauvegarde (conditionnel)
resource "local_file" "backup" {
  count = var.create_backup ? 1 : 0
  
  content = <<-EOT
    Backup créé le: ${timestamp()}
    Projet: ${var.project_name}
    ID: ${random_id.project_id.hex}
  EOT
  
  filename        = "${path.module}/output/backup/backup.txt"
  file_permission = "0644"
}

# Utiliser une ressource null pour exécuter une action
resource "null_resource" "setup_complete" {
  triggers = {
    project_id = random_id.project_id.hex
    timestamp  = timestamp()
  }
  
  provisioner "local-exec" {
    command = "echo 'Setup completed for project ${var.project_name}'"
  }
}
```

### Validation

```powershell
.\scripts\terraform.ps1 plan
```

**Résultat attendu**: Plan montrant 6-7 ressources à créer

### Application

```powershell
.\scripts\terraform.ps1 apply
```

**Résultat attendu**: 
- ✅ Fichiers créés dans `infrastructure/terraform/output/`
- ✅ README.md, config.txt, data.json créés
- ✅ Backup créé si `create_backup = true`

---

## 🎯 Exercice 4: Configuration des Outputs

### Objectif
Définir les outputs pour afficher les informations importantes.

### Fichier: `outputs.tf`

```hcl
output "project_name" {
  description = "Nom du projet"
  value       = var.project_name
}

output "project_id" {
  description = "ID unique généré pour le projet"
  value       = random_id.project_id.hex
}

output "environment" {
  description = "Environnement du projet"
  value       = var.environment
}

output "readme_file_path" {
  description = "Chemin complet du fichier README"
  value       = local_file.readme.filename
}

output "config_file_path" {
  description = "Chemin complet du fichier de configuration"
  value       = local_file.config.filename
}

output "data_file_path" {
  description = "Chemin complet du fichier de données JSON"
  value       = local_file.data_json.filename
}

output "all_files" {
  description = "Liste de tous les fichiers créés"
  value = [
    local_file.readme.filename,
    local_file.config.filename,
    local_file.data_json.filename
  ]
}

output "backup_created" {
  description = "Indique si la sauvegarde a été créée"
  value       = var.create_backup
}

output "backup_file_path" {
  description = "Chemin du fichier de sauvegarde (si créé)"
  value       = var.create_backup ? local_file.backup[0].filename : "Non créé"
}

output "setup_complete" {
  description = "Message de confirmation"
  value       = "✅ Setup terminé pour le projet ${var.project_name} (ID: ${random_id.project_id.hex})"
}
```

### Validation

```powershell
.\scripts\terraform.ps1 apply
.\scripts\terraform.ps1 output
```

**Résultat attendu**: Tous les outputs affichés avec leurs valeurs

---

## 📋 Checklist Complète

### ✅ Exercice 1: Provider
- [ ] Providers locaux ajoutés dans `required_providers`
- [ ] `terraform init` exécuté avec succès
- [ ] Providers téléchargés (local, random, null)
- [ ] `terraform validate` passe

### ✅ Exercice 2: Variables
- [ ] Variables définies dans `variables.tf`
- [ ] Descriptions ajoutées
- [ ] Types spécifiés
- [ ] Valeurs par défaut définies
- [ ] Validation ajoutée (pour environment)
- [ ] `terraform validate` passe

### ✅ Exercice 3: Ressources
- [ ] Ressource `random_id` créée
- [ ] Ressource `local_file` pour README créée
- [ ] Ressource `local_file` pour config créée
- [ ] Ressource `local_file` pour data.json créée
- [ ] Ressource conditionnelle pour backup créée
- [ ] Ressource `null_resource` créée
- [ ] `terraform plan` montre toutes les ressources
- [ ] `terraform apply` crée tous les fichiers

### ✅ Exercice 4: Outputs
- [ ] Outputs définis dans `outputs.tf`
- [ ] Descriptions ajoutées
- [ ] Outputs référencent les ressources
- [ ] Output conditionnel pour backup
- [ ] `terraform apply` exécuté
- [ ] `terraform output` affiche toutes les valeurs

---

## 🚀 Workflow Complet

```powershell
# 1. Se placer dans le dossier terraform
cd infrastructure/terraform

# 2. Initialiser Terraform
..\..\scripts\terraform.ps1 init

# 3. Valider la configuration
..\..\scripts\terraform.ps1 validate

# 4. Voir le plan
..\..\scripts\terraform.ps1 plan

# 5. Appliquer les changements
..\..\scripts\terraform.ps1 apply

# 6. Voir les outputs
..\..\scripts\terraform.ps1 output

# 7. Vérifier les fichiers créés
ls output/

# 8. Modifier une variable et réappliquer
# Éditer variables.tf, puis:
..\..\scripts\terraform.ps1 apply

# 9. Détruire les ressources (optionnel)
..\..\scripts\terraform.ps1 destroy
```

---

## 📁 Structure des Fichiers Créés

Après l'exécution, vous devriez avoir:

```
infrastructure/terraform/
├── output/
│   ├── README.md          # Fichier README généré
│   ├── config.txt         # Configuration du projet
│   ├── data.json          # Données en JSON
│   └── backup/
│       └── backup.txt     # Sauvegarde (si activée)
├── main.tf
├── variables.tf
├── outputs.tf
└── .terraform/            # Cache Terraform
```

---

## 💡 Améliorations Possibles

### Ajouter plus de ressources:

```hcl
# Créer plusieurs fichiers avec une boucle
resource "local_file" "multiple_files" {
  for_each = toset(["file1.txt", "file2.txt", "file3.txt"])
  
  content  = "Contenu du fichier ${each.key}"
  filename = "${path.module}/output/${each.key}"
}
```

### Utiliser des data sources:

```hcl
# Lire un fichier existant
data "local_file" "existing" {
  filename = "${path.module}/input.txt"
}

# Utiliser le contenu
resource "local_file" "processed" {
  content  = upper(data.local_file.existing.content)
  filename = "${path.module}/output/processed.txt"
}
```

---

## 🎓 Points d'Apprentissage

1. **Providers**: Comprendre comment configurer les providers
2. **Variables**: Définir et utiliser des variables
3. **Ressources**: Créer et gérer des ressources
4. **Outputs**: Exposer des informations importantes
5. **Dependencies**: Utiliser `depends_on` pour l'ordre d'exécution
6. **Conditionals**: Créer des ressources conditionnelles avec `count`
7. **Functions**: Utiliser `timestamp()`, `jsonencode()`, etc.
8. **State**: Comprendre comment Terraform track les ressources

---

## ⚠️ Notes Importantes

1. Les fichiers créés sont **réels** sur votre machine
2. Utilisez `terraform destroy` pour supprimer les ressources
3. Le dossier `output/` peut être ajouté au `.gitignore` si nécessaire
4. Les providers locaux sont parfaits pour apprendre, mais limités pour la production

---

*Exercices adaptés pour l'apprentissage local de Terraform*

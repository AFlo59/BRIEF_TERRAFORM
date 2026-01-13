# 📋 Analyse des Exercices Terraform

Basé sur l'analyse des fichiers disponibles dans `infrastructure/terraform/`, voici les **4 exercices** identifiés à compléter :

> 🏠 **Bonne nouvelle !** Les exercices peuvent être faits **entièrement en local** sans besoin de compte cloud.
> 
> 📖 **Voir**: [GUIDE_LOCAL.md](./GUIDE_LOCAL.md) pour les options disponibles  
> 📖 **Voir**: [EXERCICES_LOCAL.md](./EXERCICES_LOCAL.md) pour la version complète des exercices en local

---

## 🎯 Exercice 1: Configuration du Provider

### 📍 Fichier: `main.tf`

**Objectif**: Configurer le provider Terraform pour votre cloud provider (AWS, Azure, GCP, etc.)

**État actuel**: 
- Le bloc `required_providers` est commenté
- Aucun provider n'est configuré

**À faire**:
1. Décommenter et configurer le provider dans `required_providers`
2. Ajouter le bloc `provider` avec la configuration appropriée
3. Choisir un cloud provider (AWS recommandé pour débuter)

**Exemple pour AWS**:
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

**Validation**:
```powershell
.\scripts\terraform.ps1 init
.\scripts\terraform.ps1 validate
```

---

## 🎯 Exercice 2: Définition des Variables

### 📍 Fichier: `variables.tf`

**Objectif**: Définir les variables nécessaires pour votre infrastructure

**État actuel**: 
- Toutes les variables sont commentées
- Aucune variable n'est définie

**À faire**:
1. Décommenter et adapter les variables selon vos besoins
2. Ajouter des variables pour :
   - La région du cloud provider
   - Le type d'instance (si création de VM)
   - L'AMI/Image à utiliser
   - Les tags pour les ressources
   - Tout autre paramètre nécessaire

**Exemple**:
```hcl
variable "region" {
  description = "Région du cloud provider"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Type d'instance"
  type        = string
  default     = "t2.micro"
}

variable "project_name" {
  description = "Nom du projet"
  type        = string
  default     = "brief-terraform"
}
```

**Validation**:
```powershell
.\scripts\terraform.ps1 validate
```

---

## 🎯 Exercice 3: Création de Ressources

### 📍 Fichier: `main.tf`

**Objectif**: Créer les ressources d'infrastructure (instances, réseaux, stockage, etc.)

**État actuel**: 
- L'exemple de ressource est commenté
- Aucune ressource n'est définie

**À faire**:
1. Décommenter et adapter l'exemple de ressource
2. Créer au moins une ressource (ex: instance EC2, bucket S3, etc.)
3. Utiliser les variables définies dans `variables.tf`
4. Ajouter des tags appropriés

**Exemple pour AWS EC2**:
```hcl
resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type
  
  tags = {
    Name        = "${var.project_name}-instance"
    Environment = "dev"
    ManagedBy   = "terraform"
  }
}
```

**Exemple pour AWS S3**:
```hcl
resource "aws_s3_bucket" "example" {
  bucket = "${var.project_name}-bucket-${random_id.bucket_suffix.hex}"
  
  tags = {
    Name        = "${var.project_name}-bucket"
    Environment = "dev"
  }
}
```

**Validation**:
```powershell
.\scripts\terraform.ps1 plan
```

---

## 🎯 Exercice 4: Configuration des Outputs

### 📍 Fichier: `outputs.tf`

**Objectif**: Définir les outputs pour afficher les informations importantes après le déploiement

**État actuel**: 
- Tous les outputs sont commentés
- Aucun output n'est défini

**À faire**:
1. Décommenter et adapter les outputs selon vos ressources
2. Créer des outputs pour :
   - L'ID de l'instance créée
   - L'IP publique/privée
   - Les URLs des ressources
   - Tout autre information utile

**Exemple**:
```hcl
output "instance_id" {
  description = "ID de l'instance créée"
  value       = aws_instance.example.id
}

output "instance_public_ip" {
  description = "IP publique de l'instance"
  value       = aws_instance.example.public_ip
}

output "instance_public_dns" {
  description = "DNS public de l'instance"
  value       = aws_instance.example.public_dns
}
```

**Validation**:
```powershell
.\scripts\terraform.ps1 apply
.\scripts\terraform.ps1 output
```

---

## 📝 Checklist Complète

### Exercice 1: Provider
- [ ] Provider ajouté dans `required_providers`
- [ ] Bloc `provider` configuré
- [ ] `terraform init` exécuté avec succès
- [ ] `terraform validate` passe

### Exercice 2: Variables
- [ ] Variables définies dans `variables.tf`
- [ ] Descriptions ajoutées pour chaque variable
- [ ] Types spécifiés
- [ ] Valeurs par défaut définies (si approprié)
- [ ] `terraform validate` passe

### Exercice 3: Ressources
- [ ] Au moins une ressource créée
- [ ] Variables utilisées dans les ressources
- [ ] Tags ajoutés aux ressources
- [ ] `terraform plan` génère un plan valide
- [ ] Plan montre les ressources à créer

### Exercice 4: Outputs
- [ ] Outputs définis dans `outputs.tf`
- [ ] Descriptions ajoutées
- [ ] Outputs référencent les ressources créées
- [ ] `terraform apply` exécuté avec succès
- [ ] `terraform output` affiche les valeurs

---

## 🚀 Workflow Recommandé

1. **Commencer par le Provider** (Exercice 1)
   ```powershell
   # Éditer main.tf pour ajouter le provider
   .\scripts\terraform.ps1 init
   .\scripts\terraform.ps1 validate
   ```

2. **Définir les Variables** (Exercice 2)
   ```powershell
   # Éditer variables.tf
   .\scripts\terraform.ps1 validate
   ```

3. **Créer les Ressources** (Exercice 3)
   ```powershell
   # Éditer main.tf pour ajouter les ressources
   .\scripts\terraform.ps1 plan
   ```

4. **Configurer les Outputs** (Exercice 4)
   ```powershell
   # Éditer outputs.tf
   .\scripts\terraform.ps1 apply
   .\scripts\terraform.ps1 output
   ```

---

## 💡 Ressources Utiles

- [Documentation Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Documentation Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Documentation Terraform GCP Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- [Terraform Language Documentation](https://www.terraform.io/docs/language)

---

## ⚠️ Notes Importantes

1. **Ne commitez jamais** de fichiers contenant des secrets (`terraform.tfvars` avec credentials)
2. **Utilisez des variables** plutôt que des valeurs codées en dur
3. **Ajoutez des tags** à toutes vos ressources pour faciliter la gestion
4. **Validez toujours** avant d'appliquer (`terraform validate` et `terraform plan`)
5. **Testez en mode dry-run** avec `terraform plan` avant `terraform apply`

---

*Document créé pour identifier les exercices à compléter*

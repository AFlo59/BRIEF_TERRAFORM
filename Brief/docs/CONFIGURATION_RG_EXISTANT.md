# 🔧 Configuration avec Resource Group Existant

Guide pour utiliser un Resource Group Azure existant avec Terraform.

---

## ✅ Votre Situation

Vous avez un **Resource Group existant** : `RG_FABADI`

La configuration Terraform a été mise à jour pour utiliser ce Resource Group existant au lieu d'en créer un nouveau.

---

## 🔄 Changements Effectués

### Dans `main.tf`

**Avant** (création d'un nouveau RG) :
```hcl
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}
```

**Maintenant** (utilisation du RG existant) :
```hcl
data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}
```

### Dans `variables.tf`

La valeur par défaut a été mise à jour :
```hcl
variable "resource_group_name" {
  default = "RG_FABADI"  # Votre Resource Group existant
}
```

---

## ⚙️ Configuration

### Étape 1: Vérifier le Resource Group

```bash
# Vérifier que le Resource Group existe
az group show --name RG_FABADI

# Voir la location du Resource Group
az group show --name RG_FABADI --query location -o tsv
```

### Étape 2: Configurer terraform.tfvars

```bash
cd Brief
cp terraform.tfvars.example terraform.tfvars
```

Éditer `terraform.tfvars` :

```hcl
# Configuration Azure
location             = "West Europe"  # ⚠️ Doit correspondre à la location de RG_FABADI
resource_group_name  = "RG_FABADI"    # Votre Resource Group existant

# Tags (seront appliqués aux nouvelles ressources)
tags = {
  Environment = "dev"
  Project     = "terraform-brief"
  ManagedBy   = "terraform"
}

# ... reste de la configuration
```

**⚠️ Important** : La `location` doit correspondre à la location de votre Resource Group `RG_FABADI`.

---

## 🔍 Vérification

### Vérifier la Location du Resource Group

```bash
# Voir la location actuelle de RG_FABADI
az group show --name RG_FABADI --query location -o tsv
```

**Exemples de locations** :
- `westeurope` → Utiliser `"West Europe"` dans terraform.tfvars
- `francecentral` → Utiliser `"France Central"` dans terraform.tfvars
- `eastus` → Utiliser `"East US"` dans terraform.tfvars

### Vérifier dans le Portail Azure

1. Aller sur [portal.azure.com](https://portal.azure.com)
2. Rechercher "Resource groups"
3. Ouvrir `RG_FABADI`
4. Voir la **Location** dans les détails

---

## 🚀 Utilisation

Une fois configuré, utilisez normalement :

```bash
# Initialiser
terraform init

# Plan (vérifier que le RG est trouvé)
terraform plan

# Appliquer
terraform apply
```

Terraform utilisera automatiquement le Resource Group `RG_FABADI` existant.

---

## 🔄 Si Vous Voulez Créer un Nouveau Resource Group

Si vous préférez créer un nouveau Resource Group au lieu d'utiliser `RG_FABADI` :

### Option 1: Modifier main.tf

1. **Commenter** la data source :
```hcl
# data "azurerm_resource_group" "main" {
#   name = var.resource_group_name
# }
```

2. **Décommenter** le resource :
```hcl
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location

  tags = var.tags
}
```

3. **Mettre à jour** les références dans les modules :
   - Remplacer `data.azurerm_resource_group.main` par `azurerm_resource_group.main`

### Option 2: Utiliser un Nom Différent

Dans `terraform.tfvars` :
```hcl
resource_group_name = "rg-terraform-brief"  # Nouveau nom
```

---

## ⚠️ Points d'Attention

1. **Location** : Les nouvelles ressources seront créées dans la même location que le Resource Group
2. **Permissions** : Vous devez avoir les permissions pour créer des ressources dans `RG_FABADI`
3. **Tags** : Les tags définis dans `terraform.tfvars` seront appliqués aux nouvelles ressources
4. **Destruction** : `terraform destroy` supprimera les ressources mais **PAS** le Resource Group existant

---

## ✅ Avantages d'Utiliser un RG Existant

- ✅ Pas besoin de créer un nouveau Resource Group
- ✅ Toutes vos ressources Azure dans le même endroit
- ✅ Gestion simplifiée
- ✅ Pas de risque de créer un RG en double

---

## 🧪 Test

```bash
# Vérifier que Terraform trouve le Resource Group
terraform plan

# Vous devriez voir dans le plan :
# data.azurerm_resource_group.main: Refreshing state...
# (pas de création de Resource Group)
```

---

*Guide créé pour utiliser le Resource Group existant RG_FABADI*

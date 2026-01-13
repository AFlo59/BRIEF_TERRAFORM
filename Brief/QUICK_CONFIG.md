# ⚡ Configuration Rapide avec RG_FABADI

Configuration rapide pour utiliser votre Resource Group existant `RG_FABADI`.

---

## ✅ Ce qui a été fait

- ✅ Configuration mise à jour pour utiliser `RG_FABADI`
- ✅ Variables par défaut mises à jour
- ✅ `main.tf` configuré pour utiliser le RG existant

---

## 🚀 Configuration en 3 Étapes

### Étape 1: Vérifier la Location de RG_FABADI

```bash
# Voir la location actuelle
az group show --name RG_FABADI --query location -o tsv
```

**Notez cette location** (ex: `westeurope`, `francecentral`, etc.)

### Étape 2: Créer terraform.tfvars

```bash
cd Brief
cp terraform.tfvars.example terraform.tfvars
```

### Étape 3: Éditer terraform.tfvars

Ouvrir `terraform.tfvars` et configurer :

```hcl
# Configuration Azure
location             = "West Europe"  # ⚠️ Utilisez la location de RG_FABADI
resource_group_name  = "RG_FABADI"    # Votre Resource Group existant

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
vm_ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2E..."

# Configuration Storage
# ⚠️ Ajoutez des chiffres pour rendre unique
storage_account_name = "stterraformbrief123"
container_name       = "data-container"

# Configuration Web App
# ⚠️ Ajoutez des chiffres pour rendre unique
webapp_name = "webapp-terraform-brief-123"
webapp_sku  = "F1"
```

---

## 🔍 Vérification Rapide

```bash
# Vérifier que le RG existe
az group show --name RG_FABADI

# Vérifier la location
az group show --name RG_FABADI --query location

# Vérifier votre connexion
az account show
```

---

## ✅ Prêt à Déployer

Une fois `terraform.tfvars` configuré :

```bash
terraform init
terraform plan
terraform apply
```

Les ressources seront créées dans `RG_FABADI` existant.

---

## 📚 Documentation Complète

- **Configuration détaillée** : [docs/CONFIGURATION_RG_EXISTANT.md](./docs/CONFIGURATION_RG_EXISTANT.md)
- **Guide portail Azure** : [docs/GUIDE_PORTAL_AZURE.md](./docs/GUIDE_PORTAL_AZURE.md)
- **Vérification** : [docs/VERIFICATION.md](./docs/VERIFICATION.md)

---

*Configuration rapide pour RG_FABADI*

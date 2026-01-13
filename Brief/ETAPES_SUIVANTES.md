# 🎯 Étapes Suivantes - Configuration terraform.tfvars

Vous avez généré votre clé SSH ! Voici ce qu'il faut faire maintenant.

---

## ✅ Ce Que Vous Avez Fait

- ✅ Clé SSH générée : `~/.ssh/id_ed25519_azure.pub`
- ✅ Clé publique disponible

---

## 📝 Étape 1: Créer terraform.tfvars

```bash
cd /mnt/d/PROJETS/BRIEF_TERRAFORM/Brief
cp terraform.tfvars.example terraform.tfvars
```

---

## 🔧 Étape 2: Configurer terraform.tfvars

Ouvrez `terraform.tfvars` et remplacez les valeurs suivantes :

### 1. Votre Clé SSH Publique

**Remplacez cette ligne** :
```hcl
vm_ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQD... votre-clé-publique-ssh"
```

**Par votre clé** :
```hcl
vm_ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOuvHBihgrhMHWezPAxBg7mc4I4JYrRnTKMOYxi2BN/v azure-vm-key"
```

**⚠️ Important** : Copiez **toute la ligne** de la clé, de `ssh-ed25519` jusqu'à la fin.

### 2. Location de RG_FABADI

Vérifiez d'abord la location de votre Resource Group :

```bash
az group show --name RG_FABADI --query location -o tsv
```

Puis dans `terraform.tfvars`, utilisez la même location (format Azure) :

```hcl
location = "West Europe"  # Si la location est "westeurope"
# OU
location = "France Central"  # Si la location est "francecentral"
```

**Mapping des locations** :
- `westeurope` → `"West Europe"`
- `francecentral` → `"France Central"`
- `eastus` → `"East US"`
- `westus` → `"West US"`

### 3. Rendre les Noms Uniques

Azure exige des noms uniques globalement pour :
- **Storage Account** : 3-24 caractères, alphanumériques uniquement
- **Web App** : 2-60 caractères, alphanumériques et tirets

**Dans terraform.tfvars** :

```hcl
# Ajoutez des chiffres pour rendre unique
storage_account_name = "stterraformbrief123"  # Changez les chiffres
container_name       = "data-container"

# Ajoutez des chiffres pour rendre unique
webapp_name = "webapp-terraform-brief-123"  # Changez les chiffres
webapp_sku  = "F1"
```

---

## 📋 Exemple Complet de terraform.tfvars

```hcl
# Configuration Azure
location             = "West Europe"  # ⚠️ Utilisez la location de RG_FABADI
resource_group_name  = "RG_FABADI"

# Tags
tags = {
  Environment = "dev"
  Project     = "terraform-brief"
  ManagedBy   = "terraform"
  Student     = "VotreNom"
}

# Configuration VM
vm_name         = "vm-terraform-brief"
vm_size         = "Standard_B1s"
vm_admin_username = "azureuser"

# ⚠️ VOTRE CLÉ SSH PUBLIQUE (toute la ligne)
vm_ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOuvHBihgrhMHWezPAxBg7mc4I4JYrRnTKMOYxi2BN/v azure-vm-key"

# Configuration Storage
storage_account_name = "stterraformbrief123"  # ⚠️ Changez les chiffres
container_name       = "data-container"

# Configuration Web App
webapp_name = "webapp-terraform-brief-123"  # ⚠️ Changez les chiffres
webapp_sku  = "F1"
```

---

## ✅ Étape 3: Vérifier la Configuration

```bash
# Vérifier que terraform.tfvars existe
ls -la terraform.tfvars

# Vérifier votre connexion Azure
az account show

# Vérifier le Resource Group
az group show --name RG_FABADI
```

---

## 🚀 Étape 4: Initialiser Terraform

```bash
# Depuis le dossier Brief
cd /mnt/d/PROJETS/BRIEF_TERRAFORM/Brief

# Initialiser Terraform
terraform init
```

---

## 🔍 Étape 5: Vérifier le Plan

```bash
# Voir ce que Terraform va créer
terraform plan
```

Vous devriez voir :
- ✅ Data source pour RG_FABADI (pas de création)
- ✅ Création de la VM
- ✅ Création du Storage Account
- ✅ Création de la Web App

---

## 📦 Étape 6: Déployer

```bash
# Déployer l'infrastructure
terraform apply

# Tapez "yes" pour confirmer
```

---

## ⚠️ Points Importants

1. **Clé SSH** : Utilisez la clé **publique** (`*.pub`), jamais la privée
2. **Location** : Doit correspondre à celle de RG_FABADI
3. **Noms uniques** : Storage Account et Web App doivent être uniques globalement
4. **terraform.tfvars** : Ce fichier contient vos secrets, ne le commitez JAMAIS dans Git

---

## 🆘 Si Vous Avez des Erreurs

### Erreur "Storage Account name already exists"
→ Changez les chiffres dans `storage_account_name`

### Erreur "Web App name already exists"
→ Changez les chiffres dans `webapp_name`

### Erreur "Location mismatch"
→ Vérifiez la location de RG_FABADI et utilisez le même format

### Erreur "SSH key invalid"
→ Vérifiez que vous avez copié toute la ligne de la clé publique

---

## 📚 Documentation

- **Guide complet Azure** : [docs/GUIDE_AZURE_SETUP.md](./docs/GUIDE_AZURE_SETUP.md)
- **Configuration RG existant** : [docs/CONFIGURATION_RG_EXISTANT.md](./docs/CONFIGURATION_RG_EXISTANT.md)
- **Déploiement** : [docs/DEPLOYMENT.md](./docs/DEPLOYMENT.md)

---

*Guide créé après génération de la clé SSH*

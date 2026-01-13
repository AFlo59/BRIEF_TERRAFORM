# 📍 Où En Êtes-Vous ?

Guide rapide pour savoir où vous en êtes et ce qu'il reste à faire.

---

## ✅ Ce Que Vous Avez Déjà Fait

1. ✅ **Azure CLI installé** (PowerShell et WSL)
2. ✅ **Connexion Azure configurée** (`az login`)

---

## 🔄 Étape Actuelle : Générer une Clé SSH

**OUI, vous devez générer une clé SSH** car la VM Linux nécessite une clé SSH publique pour l'authentification.

### Pourquoi une Clé SSH ?

- La VM Linux utilise l'authentification par clé SSH (plus sécurisé que les mots de passe)
- Terraform a besoin de votre clé SSH **publique** pour configurer la VM
- Vous utiliserez la clé SSH **privée** pour vous connecter à la VM

---

## 🚀 Génération de la Clé SSH (2 minutes)

### Option 1: Dans WSL (Recommandé)

```bash
# Générer une clé SSH (si vous n'en avez pas déjà)
ssh-keygen -t ed25519 -C "azure-vm-key" -f ~/.ssh/id_ed25519_azure

# Ou utiliser RSA (si ed25519 n'est pas supporté)
ssh-keygen -t rsa -b 4096 -C "azure-vm-key" -f ~/.ssh/id_rsa_azure

# Afficher la clé publique (à copier dans terraform.tfvars)
cat ~/.ssh/id_ed25519_azure.pub
# OU
cat ~/.ssh/id_rsa_azure.pub
```

### Option 2: Dans PowerShell

```powershell
# Générer une clé SSH
ssh-keygen -t ed25519 -C "azure-vm-key" -f $env:USERPROFILE\.ssh\id_ed25519_azure

# Afficher la clé publique
Get-Content $env:USERPROFILE\.ssh\id_ed25519_azure.pub
```

### Option 3: Si Vous Avez Déjà une Clé SSH

Si vous avez déjà une clé SSH (`~/.ssh/id_rsa.pub` ou `~/.ssh/id_ed25519.pub`), vous pouvez l'utiliser :

```bash
# Afficher votre clé publique existante
cat ~/.ssh/id_rsa.pub
# OU
cat ~/.ssh/id_ed25519.pub
```

---

## 📋 Prochaines Étapes (Après la Clé SSH)

### 1. Vérifier la Location de RG_FABADI

```bash
# Voir la location du Resource Group
az group show --name RG_FABADI --query location -o tsv
```

**Notez cette location** (ex: `westeurope`, `francecentral`)

### 2. Créer terraform.tfvars

```bash
cd Brief
cp terraform.tfvars.example terraform.tfvars
```

### 3. Configurer terraform.tfvars

Éditer `terraform.tfvars` et remplir :

```hcl
# Configuration Azure
location             = "West Europe"  # ⚠️ Utilisez la location de RG_FABADI
resource_group_name  = "RG_FABADI"

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

# ⚠️ COLLER VOTRE CLÉ SSH PUBLIQUE ICI (toute la ligne)
vm_ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2E... votre-clé-complète"

# Configuration Storage
# ⚠️ Ajoutez des chiffres pour rendre unique (3-24 caractères, alphanumériques)
storage_account_name = "stterraformbrief123"
container_name       = "data-container"

# Configuration Web App
# ⚠️ Ajoutez des chiffres pour rendre unique (2-60 caractères, alphanumériques)
webapp_name = "webapp-terraform-brief-123"
webapp_sku  = "F1"
```

### 4. Vérifier la Connexion Azure

```bash
# Vérifier que vous êtes connecté
az account show

# Vérifier le Resource Group
az group show --name RG_FABADI
```

### 5. Initialiser Terraform

```bash
# Dans WSL, depuis le dossier Brief
cd Brief
terraform init
```

### 6. Vérifier le Plan

```bash
terraform plan
```

### 7. Déployer

```bash
terraform apply
```

---

## ✅ Checklist Rapide

- [ ] Azure CLI installé
- [ ] `az login` effectué
- [ ] Clé SSH générée
- [ ] Clé SSH publique copiée
- [ ] Location de RG_FABADI vérifiée
- [ ] `terraform.tfvars` créé et configuré
- [ ] `terraform init` exécuté
- [ ] `terraform plan` vérifié
- [ ] Prêt pour `terraform apply`

---

## 🆘 Aide Rapide

### Vérifier si vous avez déjà une clé SSH

```bash
# Dans WSL
ls -la ~/.ssh/*.pub

# Dans PowerShell
Get-ChildItem $env:USERPROFILE\.ssh\*.pub
```

### Si vous avez une clé, l'afficher

```bash
# Dans WSL
cat ~/.ssh/id_rsa.pub
cat ~/.ssh/id_ed25519.pub

# Dans PowerShell
Get-Content $env:USERPROFILE\.ssh\id_rsa.pub
```

### Format de la Clé SSH

La clé SSH publique doit ressembler à :

```
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC... votre-email@example.com
```

ou

```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI... azure-vm-key
```

**⚠️ Important** : Copiez **toute la ligne** dans `terraform.tfvars`, pas seulement une partie.

---

## 📚 Guides Complets

- **Génération SSH détaillée** : [docs/GUIDE_AZURE_SETUP.md](./docs/GUIDE_AZURE_SETUP.md#5-générer-une-clé-ssh)
- **Configuration rapide** : [QUICK_CONFIG.md](./QUICK_CONFIG.md)
- **Guide complet Azure** : [docs/GUIDE_AZURE_SETUP.md](./docs/GUIDE_AZURE_SETUP.md)

---

*Guide mis à jour pour suivre votre progression*

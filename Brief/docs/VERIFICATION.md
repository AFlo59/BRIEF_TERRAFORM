# ✅ Guide de Vérification - Ressources Azure

Procédure complète pour vérifier que toutes les ressources ont été correctement déployées.

---

## 🎯 Objectif

Vérifier que les 3 ressources Azure sont correctement déployées :
1. ✅ Machine Virtuelle Linux
2. ✅ Storage Account + Blob Container
3. ✅ Web App

---

## 📋 Méthodes de Vérification

### Méthode 1: Portail Azure (Recommandée) 🌐

**Voir** : [GUIDE_PORTAL_AZURE.md](./GUIDE_PORTAL_AZURE.md) pour le guide détaillé étape par étape.

**Résumé rapide** :
1. Aller sur [portal.azure.com](https://portal.azure.com)
2. Rechercher "Resource groups"
3. Ouvrir votre Resource Group
4. Vérifier les 3 ressources

---

### Méthode 2: Azure CLI 💻

#### Vérification Rapide

```bash
# 1. Vérifier le Resource Group
az group show --name rg-terraform-brief --output table

# 2. Lister toutes les ressources du Resource Group
az resource list --resource-group rg-terraform-brief --output table

# 3. Vérifier la VM
az vm show --resource-group rg-terraform-brief --name vm-terraform-brief --output table

# 4. Vérifier le Storage Account
az storage account show --name stterraformbrief123 --resource-group rg-terraform-brief --output table

# 5. Vérifier la Web App
az webapp show --resource-group rg-terraform-brief --name webapp-terraform-brief-123 --output table
```

#### Vérification Détaillée

```bash
# VM - Obtenir l'IP publique
az vm show -d \
  --resource-group rg-terraform-brief \
  --name vm-terraform-brief \
  --query publicIps -o tsv

# Storage - Lister les containers
az storage container list \
  --account-name stterraformbrief123 \
  --auth-mode login \
  --output table

# Web App - Obtenir l'URL
az webapp show \
  --resource-group rg-terraform-brief \
  --name webapp-terraform-brief-123 \
  --query defaultHostName -o tsv
```

---

### Méthode 3: Terraform Outputs 📤

Après `terraform apply`, utiliser les outputs :

```bash
# Voir tous les outputs
terraform output

# Voir un output spécifique
terraform output vm_public_ip
terraform output storage_account_name
terraform output webapp_url
```

---

## ✅ Checklist de Vérification

### Resource Group

- [ ] Le Resource Group existe
- [ ] Location correcte
- [ ] Tags appliqués
- [ ] Contient 3 ressources principales

**Commande** :
```bash
az group show --name rg-terraform-brief
```

---

### Machine Virtuelle

- [ ] VM créée avec le bon nom
- [ ] Status : "Running"
- [ ] Taille : Standard_B1s (1 vCPU, 1 Go RAM)
- [ ] IP publique assignée
- [ ] OS : Linux (Ubuntu)
- [ ] Réseau configuré (VNet, Subnet, NSG)

**Commandes** :
```bash
# Vérifier la VM
az vm show --resource-group rg-terraform-brief --name vm-terraform-brief

# Obtenir l'IP publique
az vm show -d --resource-group rg-terraform-brief --name vm-terraform-brief --query publicIps -o tsv

# Tester la connectivité SSH (optionnel)
ssh azureuser@<PUBLIC_IP>
```

**Dans le Portail** :
- Aller dans "Virtual machines"
- Ouvrir votre VM
- Vérifier l'onglet "Overview"

---

### Storage Account

- [ ] Storage Account créé avec le bon nom
- [ ] Status : "Available"
- [ ] Performance : Standard
- [ ] Replication : LRS
- [ ] Blob Container créé

**Commandes** :
```bash
# Vérifier le Storage Account
az storage account show --name stterraformbrief123 --resource-group rg-terraform-brief

# Lister les containers
az storage container list --account-name stterraformbrief123 --auth-mode login
```

**Dans le Portail** :
- Aller dans "Storage accounts"
- Ouvrir votre Storage Account
- Aller dans "Containers"
- Vérifier que le container existe

---

### Web App

- [ ] Web App créée avec le bon nom
- [ ] Status : "Running"
- [ ] App Service Plan associé
- [ ] URL accessible
- [ ] SKU correct (F1 ou B1)

**Commandes** :
```bash
# Vérifier la Web App
az webapp show --resource-group rg-terraform-brief --name webapp-terraform-brief-123

# Obtenir l'URL
az webapp show --resource-group rg-terraform-brief --name webapp-terraform-brief-123 --query defaultHostName -o tsv

# Tester l'URL (dans un navigateur)
# https://webapp-terraform-brief-123.azurewebsites.net
```

**Dans le Portail** :
- Aller dans "App Services"
- Ouvrir votre Web App
- Vérifier l'URL dans "Overview"
- Cliquer sur l'URL pour tester

---

## 🧪 Tests Fonctionnels

### Test 1: VM Accessible

```bash
# Obtenir l'IP publique
VM_IP=$(terraform output -raw vm_public_ip)

# Tester la connectivité
ping -c 4 $VM_IP

# Se connecter via SSH
ssh azureuser@$VM_IP
```

### Test 2: Storage Fonctionnel

```bash
# Créer un fichier de test
echo "Test Terraform Storage" > test-storage.txt

# Uploader vers le container
az storage blob upload \
  --account-name $(terraform output -raw storage_account_name) \
  --container-name $(terraform output -raw container_name) \
  --name test-storage.txt \
  --file test-storage.txt \
  --auth-mode login

# Vérifier l'upload
az storage blob list \
  --account-name $(terraform output -raw storage_account_name) \
  --container-name $(terraform output -raw container_name) \
  --auth-mode login \
  --output table
```

### Test 3: Web App Accessible

```bash
# Obtenir l'URL
WEBAPP_URL=$(terraform output -raw webapp_url)

# Tester avec curl
curl -I $WEBAPP_URL

# Ou ouvrir dans un navigateur
# Devrait afficher la page par défaut Azure
```

---

## 📊 Résumé de Vérification

### Après `terraform apply`

| Ressource | Vérification Portail | Vérification CLI | Test Fonctionnel |
|-----------|---------------------|-----------------|------------------|
| **Resource Group** | ✅ Existe | `az group show` | - |
| **VM** | ✅ Running | `az vm show` | SSH accessible |
| **Storage** | ✅ Available | `az storage account show` | Upload blob |
| **Container** | ✅ Existe | `az storage container list` | Liste blobs |
| **Web App** | ✅ Running | `az webapp show` | URL accessible |

---

## 🗑️ Vérification de la Destruction

Après `terraform destroy`, vérifier :

### Via Portail Azure

1. Aller dans "Resource groups"
2. Chercher votre Resource Group
3. **Vérifier** qu'il n'existe plus (ou qu'il est vide)

### Via Azure CLI

```bash
# Devrait retourner une erreur "not found"
az group show --name rg-terraform-brief

# Vérifier qu'aucune ressource n'existe
az resource list --resource-group rg-terraform-brief
# Devrait être vide
```

### Vérification des Coûts

1. Aller dans "Cost Management + Billing"
2. Vérifier qu'aucun coût n'est généré
3. Les ressources supprimées ne doivent plus apparaître

---

## 📝 Documentation à Inclure

Pour votre livrable, documentez :

1. **Captures d'écran** :
   - Resource Group avec toutes les ressources
   - VM Overview
   - Storage Account avec container
   - Web App avec URL

2. **Résultats des commandes** :
   - `terraform output`
   - `az vm show`
   - `az storage account show`
   - `az webapp show`

3. **Tests fonctionnels** :
   - Résultat du test SSH (si fait)
   - Résultat du test Storage (si fait)
   - Résultat du test Web App (si fait)

---

## 🆘 Dépannage

### Problème: Ressource non trouvée

**Vérifier** :
- Le nom de la ressource est correct
- Le Resource Group est correct
- La subscription est la bonne

### Problème: VM non accessible

**Vérifier** :
- Le Network Security Group autorise SSH (port 22)
- L'IP publique est assignée
- La VM est en état "Running"

### Problème: Web App non accessible

**Vérifier** :
- La Web App est en état "Running"
- L'URL est correcte
- Pas d'erreur dans les logs

---

*Guide créé pour faciliter la vérification des ressources déployées*

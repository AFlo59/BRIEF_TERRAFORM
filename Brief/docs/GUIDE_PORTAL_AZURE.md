# 🌐 Guide Portail Azure - Vérification des Ressources

Guide étape par étape pour vérifier vos ressources déployées via Terraform dans le portail Azure.

---

## 🔍 Accès au Portail Azure

1. **Aller sur** [portal.azure.com](https://portal.azure.com)
2. **Se connecter** avec vos identifiants Azure
3. **Vérifier** que vous êtes sur la bonne subscription (en haut à droite)

---

## 📋 Vérification des Ressources

### 1. Vérifier le Resource Group

#### Étape par Étape

1. **Dans la barre de recherche** en haut, taper : `Resource groups`
2. **Cliquer sur** "Resource groups"
3. **Chercher** votre Resource Group (ex: `rg-terraform-brief`)
4. **Cliquer dessus** pour voir le contenu

#### Ce que vous devriez voir

- ✅ Le Resource Group existe
- ✅ Location : "West Europe" (ou celle que vous avez choisie)
- ✅ Tags : Environment, Project, ManagedBy
- ✅ 3 ressources principales :
  - Virtual Machine
  - Storage Account
  - App Service

---

### 2. Vérifier la Machine Virtuelle (VM)

#### Via le Resource Group

1. **Dans le Resource Group**, chercher la ressource de type "Virtual machine"
2. **Cliquer dessus** pour ouvrir les détails

#### Via la Recherche Directe

1. **Taper** "Virtual machines" dans la barre de recherche
2. **Cliquer sur** "Virtual machines"
3. **Chercher** votre VM (ex: `vm-terraform-brief`)

#### Informations à Vérifier

- ✅ **Nom** : Correspond à votre variable `vm_name`
- ✅ **Status** : "Running" (en cours d'exécution)
- ✅ **Size** : Standard_B1s (1 vCPU, 1 Go RAM)
- ✅ **Public IP address** : Une adresse IP publique est assignée
- ✅ **OS** : Linux (Ubuntu Server)
- ✅ **Resource Group** : Le bon Resource Group

#### Détails à Vérifier

1. **Onglet "Overview"** :
   - Public IP address
   - Private IP address
   - Status
   - Location

2. **Onglet "Networking"** :
   - Network Interface
   - Public IP
   - Network Security Group

3. **Onglet "Properties"** :
   - VM ID
   - Computer name
   - OS type

#### Test de Connectivité (Optionnel)

```bash
# Depuis votre machine locale
ssh azureuser@<PUBLIC_IP>
# Remplacez <PUBLIC_IP> par l'IP publique de la VM
```

---

### 3. Vérifier le Storage Account

#### Via le Resource Group

1. **Dans le Resource Group**, chercher la ressource de type "Storage account"
2. **Cliquer dessus**

#### Via la Recherche Directe

1. **Taper** "Storage accounts" dans la barre de recherche
2. **Cliquer sur** "Storage accounts"
3. **Chercher** votre Storage Account (ex: `stterraformbrief123`)

#### Informations à Vérifier

- ✅ **Nom** : Correspond à votre variable `storage_account_name`
- ✅ **Status** : "Available"
- ✅ **Performance** : Standard
- ✅ **Replication** : LRS (Locally Redundant Storage)
- ✅ **Location** : Correcte

#### Vérifier le Blob Container

1. **Dans le Storage Account**, aller dans le menu de gauche
2. **Cliquer sur** "Containers" (sous "Data storage")
3. **Vérifier** que votre container existe (ex: `data-container`)
4. **Cliquer sur** le container pour voir les détails

#### Informations du Container

- ✅ **Nom** : Correspond à votre variable `container_name`
- ✅ **Public access level** : Private (ou celui que vous avez configuré)
- ✅ **Last modified** : Date de création

#### Tester le Storage (Optionnel)

```bash
# Via Azure CLI
az storage blob list \
  --account-name <STORAGE_ACCOUNT_NAME> \
  --container-name <CONTAINER_NAME> \
  --output table
```

---

### 4. Vérifier la Web App

#### Via le Resource Group

1. **Dans le Resource Group**, chercher la ressource de type "App Service"
2. **Cliquer dessus**

#### Via la Recherche Directe

1. **Taper** "App Services" dans la barre de recherche
2. **Cliquer sur** "App Services"
3. **Chercher** votre Web App (ex: `webapp-terraform-brief-123`)

#### Informations à Vérifier

- ✅ **Nom** : Correspond à votre variable `webapp_name`
- ✅ **Status** : "Running"
- ✅ **App Service Plan** : Le plan associé
- ✅ **URL** : URL de la Web App (ex: `https://webapp-terraform-brief-123.azurewebsites.net`)
- ✅ **Location** : Correcte

#### Détails à Vérifier

1. **Onglet "Overview"** :
   - URL de l'application
   - Status
   - App Service Plan
   - Location

2. **Onglet "Configuration"** :
   - Application settings
   - Connection strings

3. **Tester l'URL** :
   - Cliquer sur l'URL ou l'ouvrir dans un navigateur
   - Vous devriez voir une page par défaut Azure (car aucune app n'est déployée)

---

## 📊 Vue d'Ensemble dans le Portail

### Dashboard Personnalisé

1. **Dans le Resource Group**, vous verrez toutes les ressources
2. **Utiliser les filtres** pour organiser la vue
3. **Ajouter au dashboard** pour un suivi rapide

### Métriques et Monitoring

Chaque ressource a des onglets pour :
- **Metrics** : Graphiques de performance
- **Logs** : Journaux d'activité
- **Alerts** : Alertes configurées

---

## 🔍 Vérification via Azure CLI

### Commandes Utiles

```bash
# Lister tous les Resource Groups
az group list --output table

# Voir les détails d'un Resource Group
az group show --name rg-terraform-brief

# Lister les VMs
az vm list --output table

# Voir les détails d'une VM
az vm show --resource-group rg-terraform-brief --name vm-terraform-brief

# Voir l'IP publique de la VM
az vm show -d --resource-group rg-terraform-brief --name vm-terraform-brief --query publicIps -o tsv

# Lister les Storage Accounts
az storage account list --output table

# Lister les Web Apps
az webapp list --output table

# Voir l'URL d'une Web App
az webapp show --resource-group rg-terraform-brief --name webapp-terraform-brief-123 --query defaultHostName -o tsv
```

---

## ✅ Checklist de Vérification Complète

### Après `terraform apply`

- [ ] **Resource Group** créé et visible
- [ ] **VM** créée et en état "Running"
- [ ] **IP publique** assignée à la VM
- [ ] **Storage Account** créé et disponible
- [ ] **Blob Container** créé dans le Storage Account
- [ ] **Web App** créée et en état "Running"
- [ ] **URL de la Web App** accessible (page par défaut Azure)

### Vérifications Supplémentaires

- [ ] **Tags** appliqués à toutes les ressources
- [ ] **Location** cohérente sur toutes les ressources
- [ ] **Coûts** vérifiés dans "Cost Management"

---

## 🧪 Tests de Fonctionnement

### Test VM

```bash
# Obtenir l'IP publique
VM_IP=$(az vm show -d --resource-group rg-terraform-brief --name vm-terraform-brief --query publicIps -o tsv)

# Se connecter via SSH
ssh azureuser@$VM_IP

# Une fois connecté, tester
uname -a
df -h
```

### Test Storage

```bash
# Créer un fichier de test
echo "Test Terraform" > test.txt

# Uploader vers le container
az storage blob upload \
  --account-name stterraformbrief123 \
  --container-name data-container \
  --name test.txt \
  --file test.txt

# Lister les blobs
az storage blob list \
  --account-name stterraformbrief123 \
  --container-name data-container \
  --output table
```

### Test Web App

1. **Ouvrir l'URL** dans un navigateur
2. **Vérifier** que la page Azure par défaut s'affiche
3. **Vérifier** qu'il n'y a pas d'erreur 404 ou 500

---

## 📸 Captures d'Écran Recommandées

Pour votre documentation, prenez des captures d'écran de :

1. **Resource Group** avec toutes les ressources
2. **VM Overview** montrant l'IP publique
3. **Storage Account** avec le container
4. **Web App** avec l'URL
5. **Résultat de `terraform output`**

---

## 🗑️ Vérification de la Destruction

Après `terraform destroy`, vérifier :

1. **Dans le Resource Group** :
   - Toutes les ressources doivent être supprimées
   - Le Resource Group peut être vide ou supprimé

2. **Via Azure CLI** :
   ```bash
   # Vérifier que le Resource Group n'existe plus
   az group show --name rg-terraform-brief
   # Devrait retourner une erreur "not found"
   ```

3. **Vérifier les coûts** :
   - Aller dans "Cost Management"
   - Vérifier qu'aucun coût n'est généré

---

## 💡 Astuces

- **Utilisez les favoris** dans le portail pour accéder rapidement aux ressources
- **Configurez des alertes** pour être notifié des coûts
- **Utilisez les filtres** pour trouver rapidement vos ressources
- **Exportez les métriques** si nécessaire pour votre documentation

---

*Guide créé pour faciliter la vérification des ressources dans le portail Azure*

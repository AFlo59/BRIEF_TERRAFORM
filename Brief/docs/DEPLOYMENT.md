# 🚀 Guide de Déploiement - Étapes Complètes

Guide étape par étape pour déployer l'infrastructure Azure avec Terraform.

---

## 📋 Prérequis

Avant de commencer, assurez-vous d'avoir :

- [ ] Compte Azure créé
- [ ] Subscription Azure active
- [ ] Azure CLI installé et configuré (`az login`)
- [ ] Terraform installé (ou Docker)
- [ ] Clé SSH générée

**Voir** : [GUIDE_AZURE_SETUP.md](./GUIDE_AZURE_SETUP.md) pour les étapes de configuration.

---

## 🔧 Configuration Initiale

### Étape 1: Préparer les Variables

```bash
# Se placer dans le dossier Brief
cd Brief

# Copier l'exemple de variables
cp terraform.tfvars.example terraform.tfvars

# Éditer terraform.tfvars avec vos valeurs
# Utiliser votre éditeur préféré (nano, vim, code, etc.)
nano terraform.tfvars
```

### Étape 2: Configurer terraform.tfvars

**Points importants** :
- ⚠️ **Storage Account Name** : Doit être unique globalement (ajoutez des chiffres)
- ⚠️ **Web App Name** : Doit être unique globalement (ajoutez des chiffres)
- ⚠️ **SSH Public Key** : Collez votre clé publique complète

**Exemple** :
```hcl
storage_account_name = "stterraformbrief123"  # Ajoutez des chiffres
webapp_name = "webapp-terraform-brief-123"    # Ajoutez des chiffres
vm_ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2E..."  # Votre clé complète
```

---

## 🚀 Déploiement

### Étape 1: Initialiser Terraform

```bash
# Initialiser Terraform (télécharge les providers)
terraform init
```

**Résultat attendu** :
```
Terraform has been successfully initialized!
```

**Si erreur** :
- Vérifier que vous êtes dans le bon dossier
- Vérifier que les fichiers `.tf` sont présents
- Vérifier votre connexion Internet

---

### Étape 2: Valider la Configuration

```bash
# Valider la syntaxe
terraform validate
```

**Résultat attendu** :
```
Success! The configuration is valid.
```

**Si erreur** :
- Vérifier la syntaxe des fichiers `.tf`
- Vérifier que les modules existent
- Vérifier que les variables sont définies

---

### Étape 3: Formater le Code

```bash
# Formater le code Terraform
terraform fmt -recursive
```

**Résultat** : Les fichiers sont formatés automatiquement

---

### Étape 4: Générer le Plan

```bash
# Générer le plan d'exécution
terraform plan
```

**Résultat attendu** :
```
Plan: X to add, 0 to change, 0 to destroy.
```

**Vérifier** :
- Le nombre de ressources à créer (devrait être ~10-15 ressources)
- Les noms des ressources
- Les tailles et configurations

**Si erreur** :
- Vérifier les variables dans `terraform.tfvars`
- Vérifier la connexion Azure (`az account show`)
- Vérifier que les noms sont uniques

---

### Étape 5: Appliquer la Configuration

```bash
# Appliquer le plan (créer les ressources)
terraform apply
```

**Ou avec auto-approve** :
```bash
terraform apply -auto-approve
```

**Résultat attendu** :
```
Apply complete! Resources: X added, 0 changed, 0 destroyed.
```

**Temps estimé** : 5-10 minutes

**Pendant l'exécution** :
- Terraform affiche la progression
- Vous pouvez suivre dans le portail Azure
- Les ressources sont créées dans l'ordre

---

### Étape 6: Vérifier les Outputs

```bash
# Voir tous les outputs
terraform output

# Voir un output spécifique
terraform output vm_public_ip
terraform output webapp_url
terraform output storage_account_name
```

**Outputs attendus** :
- `vm_public_ip` : Adresse IP publique de la VM
- `vm_name` : Nom de la VM
- `storage_account_name` : Nom du Storage Account
- `webapp_url` : URL de la Web App

---

## ✅ Vérification Post-Déploiement

### Via Terraform Outputs

```bash
terraform output
```

### Via Portail Azure

**Voir** : [GUIDE_PORTAL_AZURE.md](./GUIDE_PORTAL_AZURE.md) pour le guide détaillé.

**Résumé** :
1. Aller sur [portal.azure.com](https://portal.azure.com)
2. Rechercher "Resource groups"
3. Ouvrir votre Resource Group
4. Vérifier les 3 ressources

### Via Azure CLI

```bash
# Lister toutes les ressources
az resource list --resource-group rg-terraform-brief --output table

# Vérifier la VM
az vm show --resource-group rg-terraform-brief --name vm-terraform-brief

# Vérifier le Storage
az storage account show --name stterraformbrief123 --resource-group rg-terraform-brief

# Vérifier la Web App
az webapp show --resource-group rg-terraform-brief --name webapp-terraform-brief-123
```

**Voir** : [VERIFICATION.md](./VERIFICATION.md) pour plus de détails.

---

## 🧪 Tests Fonctionnels

### Test VM

```bash
# Obtenir l'IP publique
VM_IP=$(terraform output -raw vm_public_ip)

# Tester la connectivité
ping -c 4 $VM_IP

# Se connecter via SSH (optionnel)
ssh azureuser@$VM_IP
```

### Test Storage

```bash
# Créer un fichier de test
echo "Test Terraform" > test.txt

# Uploader vers le container
az storage blob upload \
  --account-name $(terraform output -raw storage_account_name) \
  --container-name $(terraform output -raw container_name) \
  --name test.txt \
  --file test.txt \
  --auth-mode login
```

### Test Web App

```bash
# Obtenir l'URL
WEBAPP_URL=$(terraform output -raw webapp_url)

# Tester avec curl
curl -I $WEBAPP_URL

# Ou ouvrir dans un navigateur
echo $WEBAPP_URL
```

---

## 🗑️ Destruction de l'Infrastructure

### Étape 1: Vérifier ce qui sera détruit

```bash
# Voir le plan de destruction
terraform plan -destroy
```

### Étape 2: Détruire les ressources

```bash
# Détruire toutes les ressources
terraform destroy
```

**Ou avec auto-approve** :
```bash
terraform destroy -auto-approve
```

**Résultat attendu** :
```
Destroy complete! Resources: X destroyed.
```

**Temps estimé** : 5-10 minutes

### Étape 3: Vérifier la Destruction

```bash
# Vérifier que le Resource Group n'existe plus
az group show --name rg-terraform-brief
# Devrait retourner une erreur "not found"
```

**Dans le Portail** :
- Aller dans "Resource groups"
- Vérifier que le Resource Group n'existe plus

---

## 📊 Timeline du Déploiement

```
0 min  : terraform init
2 min  : terraform plan
5 min  : terraform apply (démarre)
10 min : Resource Group créé
12 min : VM en cours de création
15 min : Storage Account créé
18 min : Web App créée
20 min : Apply complete!
```

---

## 🆘 Dépannage

### Erreur: "Storage account name already taken"

**Solution** :
- Modifier `storage_account_name` dans `terraform.tfvars`
- Ajouter des chiffres ou votre nom
- Le nom doit être unique globalement

### Erreur: "Web app name already taken"

**Solution** :
- Modifier `webapp_name` dans `terraform.tfvars`
- Ajouter des chiffres ou votre nom
- Le nom doit être unique globalement

### Erreur: "Please run 'az login'"

**Solution** :
```bash
az login
az account set --subscription "Votre-Subscription"
```

### Erreur: "Invalid SSH key"

**Solution** :
- Vérifier que la clé SSH est complète
- Commence par `ssh-rsa` ou `ssh-ed25519`
- Pas de retours à la ligne dans la clé

### Erreur: "Insufficient permissions"

**Solution** :
- Vérifier que votre compte a les permissions nécessaires
- Vérifier la subscription active
- Contacter l'administrateur Azure si nécessaire

---

## 📝 Documentation à Créer

Après le déploiement, documentez :

1. **Résultats de terraform apply** :
   - Capture d'écran du résultat
   - Liste des ressources créées

2. **Outputs Terraform** :
   - Capture de `terraform output`
   - Valeurs importantes (IPs, URLs)

3. **Vérifications** :
   - Captures d'écran du portail Azure
   - Résultats des tests fonctionnels

---

## ✅ Checklist de Déploiement

- [ ] Prérequis vérifiés
- [ ] `terraform.tfvars` configuré
- [ ] `terraform init` réussi
- [ ] `terraform validate` réussi
- [ ] `terraform plan` généré sans erreur
- [ ] `terraform apply` réussi
- [ ] Ressources vérifiées dans le portail
- [ ] Outputs vérifiés
- [ ] Tests fonctionnels effectués (optionnel)
- [ ] Documentation créée

---

*Guide créé pour faciliter le déploiement étape par étape*

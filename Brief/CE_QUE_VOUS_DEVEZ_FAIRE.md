# ⚠️ Ce Que Vous Devez Faire Manuellement

Ce document liste **tout ce que vous devez faire vous-même** avant de pouvoir utiliser Terraform.

> 💡 **Ces étapes ne peuvent pas être automatisées** et nécessitent une action manuelle de votre part.

---

## 🔴 Actions Manuelles Requises

### 1. Créer un Compte Azure ✅

**Où** : [portal.azure.com](https://portal.azure.com)

**Comment** :
- Cliquer sur "Créer une ressource" ou "S'inscrire"
- Suivre le processus d'inscription
- Vérifier votre email
- Ajouter une méthode de paiement (nécessaire même pour le free tier)

**Temps** : 10-15 minutes

**Guide détaillé** : [docs/GUIDE_AZURE_SETUP.md](./docs/GUIDE_AZURE_SETUP.md#1-créer-un-compte-azure-si-vous-nen-avez-pas)

---

### 2. Créer une Subscription Azure ✅

**Où** : Portail Azure → Subscriptions

**Comment** :
1. Aller sur [portal.azure.com](https://portal.azure.com)
2. Rechercher "Subscriptions"
3. Cliquer sur "+ Ajouter"
4. Choisir "Free Trial" (si disponible) ou "Pay-As-You-Go"
5. Remplir les informations

**Temps** : 5 minutes

**Guide détaillé** : [docs/GUIDE_AZURE_SETUP.md](./docs/GUIDE_AZURE_SETUP.md#2-créer-une-subscription-azure)

---

### 3. Installer Azure CLI ✅

**Où** : [aka.ms/installazurecliwindows](https://aka.ms/installazurecliwindows)

**Comment** :
- Télécharger le MSI
- Installer
- Vérifier avec `az --version`

**Temps** : 5-10 minutes

**Guide détaillé** : [docs/GUIDE_AZURE_SETUP.md](./docs/GUIDE_AZURE_SETUP.md#3-installer-azure-cli-si-pas-déjà-fait)

---

### 4. Se Connecter à Azure via CLI ✅

**Commande** :
```bash
az login
```

**Comment** :
- Exécuter la commande
- Un navigateur s'ouvre
- Se connecter avec vos identifiants Azure
- Vérifier avec `az account show`

**Temps** : 2 minutes

**Guide détaillé** : [docs/GUIDE_AZURE_SETUP.md](./docs/GUIDE_AZURE_SETUP.md#4-se-connecter-à-azure-via-cli)

---

### 5. Générer une Clé SSH ✅

**Commande** :
```bash
ssh-keygen -t rsa -b 4096
```

**Comment** :
- Exécuter la commande dans WSL ou Git Bash
- Appuyer sur Entrée pour l'emplacement par défaut
- Entrer un mot de passe (optionnel)
- Copier la clé publique : `cat ~/.ssh/id_rsa.pub`

**Temps** : 5 minutes

**Guide détaillé** : [docs/GUIDE_AZURE_SETUP.md](./docs/GUIDE_AZURE_SETUP.md#5-générer-une-clé-ssh-pour-la-vm)

---

### 6. Configurer terraform.tfvars ✅

**Fichier** : `Brief/terraform.tfvars`

**Comment** :
1. Copier `terraform.tfvars.example` vers `terraform.tfvars`
2. Éditer le fichier
3. Remplir les valeurs :
   - Coller votre clé SSH publique
   - Ajouter des chiffres aux noms pour les rendre uniques
   - Vérifier tous les paramètres

**Points importants** :
- ⚠️ `storage_account_name` doit être unique globalement
- ⚠️ `webapp_name` doit être unique globalement
- ⚠️ `vm_ssh_public_key` doit être votre clé publique complète

**Temps** : 10 minutes

**Guide détaillé** : [docs/GUIDE_AZURE_SETUP.md](./docs/GUIDE_AZURE_SETUP.md#configuration-terraform)

---

## ✅ Vérification Avant de Commencer

Avant d'exécuter `terraform init`, vérifier :

- [ ] Compte Azure créé
- [ ] Subscription Azure active
- [ ] Azure CLI installé (`az --version`)
- [ ] Connecté via `az login`
- [ ] Subscription sélectionnée (`az account show`)
- [ ] Clé SSH générée (`cat ~/.ssh/id_rsa.pub`)
- [ ] `terraform.tfvars` créé et rempli
- [ ] Noms uniques pour Storage Account et Web App

**Commandes de vérification** :
```bash
# Vérifier Azure
az account show

# Vérifier la clé SSH
cat ~/.ssh/id_rsa.pub

# Vérifier Terraform
terraform version
```

---

## 🚀 Une Fois Tout Configuré

Après avoir complété toutes ces étapes, vous pouvez :

```bash
cd Brief
terraform init
terraform plan
terraform apply
```

---

## 📚 Guides Détaillés

Pour chaque étape, consultez :

- **[docs/GUIDE_AZURE_SETUP.md](./docs/GUIDE_AZURE_SETUP.md)** - Configuration Azure complète
- **[docs/GUIDE_PORTAL_AZURE.md](./docs/GUIDE_PORTAL_AZURE.md)** - Guide du portail Azure
- **[docs/DEPLOYMENT.md](./docs/DEPLOYMENT.md)** - Procédure de déploiement
- **[docs/VERIFICATION.md](./docs/VERIFICATION.md)** - Procédures de vérification

---

## 🆘 Besoin d'Aide ?

Si vous rencontrez des problèmes :

1. Consultez [docs/GUIDE_AZURE_SETUP.md](./docs/GUIDE_AZURE_SETUP.md) pour le dépannage
2. Vérifiez que tous les prérequis sont remplis
3. Vérifiez les messages d'erreur dans Terraform

---

*Document créé pour clarifier les actions manuelles nécessaires*

# 🔐 Cache MSAL et Tokens Azure CLI dans Docker

Guide pour résoudre les problèmes de cache MSAL (tokens d'authentification) dans Docker.

---

## ❌ Problème : "User does not exist in MSAL token cache"

### Symptômes

```bash
# Dans le conteneur Docker
az account show  # ✅ Fonctionne
terraform plan  # ❌ Échoue

# Erreur Terraform :
Error: building account: could not acquire access token to parse claims:
running Azure CLI: exit status 1:
ERROR: User 'votre-email@example.com' does not exist in MSAL token cache.
Run `az login`.
```

### Cause

Le cache MSAL (`msal_token_cache.bin` et `msal_http_cache.bin`) est monté depuis l'hôte, mais :
- Les tokens peuvent avoir expiré
- Le format du cache peut être incompatible entre l'hôte et le conteneur
- Les permissions peuvent empêcher la lecture du cache

---

## ✅ Solutions

### Solution 1 : Se reconnecter dans le conteneur (Recommandé)

```bash
# 1. Lancer le conteneur interactif
./scripts/docker/docker-run.sh

# 2. Dans le conteneur, se reconnecter à Azure
az login

# 3. Vérifier la connexion
az account show

# 4. Tester Terraform
terraform plan
```

**Note** : Les tokens seront sauvegardés dans le dossier `.azure` monté, donc ils seront disponibles pour les prochaines exécutions.

---

### Solution 2 : Vérifier et renouveler les tokens sur l'hôte

```bash
# Sur l'hôte (WSL ou PowerShell)
# 1. Vérifier que vous êtes connecté
az account show

# 2. Si nécessaire, se reconnecter
az login

# 3. Vérifier que les tokens sont à jour
ls -la ~/.azure/msal_token_cache.bin
ls -la ~/.azure/msal_http_cache.bin

# 4. Relancer Terraform dans le conteneur
./scripts/docker/docker-run.sh
terraform plan
```

---

### Solution 3 : Utiliser un Service Principal (Avancé)

Si vous avez des problèmes récurrents avec le cache MSAL, vous pouvez utiliser un Service Principal :

1. **Créer un Service Principal** :
```bash
az ad sp create-for-rbac --name terraform-brief --role contributor \
  --scopes /subscriptions/VOTRE_SUBSCRIPTION_ID
```

2. **Configurer Terraform** :
```hcl
# Dans main.tf ou via variables d'environnement
provider "azurerm" {
  features {}

  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
}
```

3. **Définir les variables** :
```bash
export ARM_SUBSCRIPTION_ID="..."
export ARM_CLIENT_ID="..."
export ARM_CLIENT_SECRET="..."
export ARM_TENANT_ID="..."
```

---

## 🔍 Diagnostic

### Vérifier le cache MSAL dans le conteneur

```bash
# Lancer le conteneur
./scripts/docker/docker-run.sh

# Dans le conteneur
ls -la /root/.azure/
cat /root/.azure/azureProfile.json
```

### Vérifier les permissions

```bash
# Dans le conteneur
ls -la /root/.azure/msal_token_cache.bin
ls -la /root/.azure/msal_http_cache.bin

# Si les fichiers sont en lecture seule, les tokens ne peuvent pas être mis à jour
```

---

## 📋 Notes Techniques

### Structure du cache MSAL

Le dossier `.azure` contient :
- `azureProfile.json` : Informations sur les comptes et subscriptions
- `msal_token_cache.bin` : Cache des tokens d'authentification
- `msal_http_cache.bin` : Cache HTTP pour les requêtes MSAL
- `commands/` : Logs des commandes Azure CLI

### Pourquoi le cache peut échouer

1. **Expiration** : Les tokens expirent après un certain temps (généralement 1 heure)
2. **Format** : Le format du cache peut changer entre versions d'Azure CLI
3. **Permissions** : Les fichiers peuvent être en lecture seule
4. **Isolation Docker** : Le conteneur peut avoir des problèmes d'accès au cache

---

## 🎯 Solution Recommandée

**Pour un usage normal** : Utilisez la **Solution 1** (se reconnecter dans le conteneur). C'est la plus simple et la plus fiable.

Les tokens seront sauvegardés dans le dossier `.azure` monté, donc vous n'aurez besoin de vous reconnecter que lorsque les tokens expirent.

---

## 🔄 Automatisation (Optionnel)

Vous pouvez créer un script qui vérifie automatiquement si les tokens sont valides :

```bash
#!/bin/bash
# scripts/docker/docker-check-azure.sh

docker run --rm \
  -v "$(pwd):/workspace" \
  -v "$HOME/.azure:/root/.azure" \
  terraform-brief:latest \
  sh -c "az account show >/dev/null 2>&1 || az login"
```

Puis l'exécuter avant `terraform plan` :

```bash
./scripts/docker/docker-check-azure.sh
./scripts/wsl/terraform-plan.sh
```

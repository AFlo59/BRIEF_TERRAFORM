# 🔧 Guide de Dépannage - Brief Terraform

Guide pour résoudre les problèmes courants lors de l'utilisation de Terraform avec Docker.

---

## ❌ Problème : "No configuration files"

### Symptômes
```
Error: No configuration files
Plan requires configuration to be present.
```

### Causes possibles
1. Les fichiers `.tf` ne sont pas dans le bon répertoire
2. Le volume Docker n'est pas monté correctement
3. Terraform a été initialisé dans un répertoire vide

### Solution

```bash
# 1. Vérifier que les fichiers .tf existent
cd /mnt/d/PROJETS/BRIEF_TERRAFORM/Brief
ls -la *.tf

# 2. Nettoyer l'état Terraform
./scripts/wsl/terraform-clean.sh

# 3. Réinitialiser Terraform
./scripts/wsl/terraform-init.sh

# 4. Valider la configuration
./scripts/wsl/terraform-validate.sh

# 5. Générer le plan
./scripts/wsl/terraform-plan.sh
```

---

## ❌ Problème : "the input device is not a TTY"

### Symptômes
```
the input device is not a TTY
```

### Cause
Les scripts utilisent `-it` mais sont exécutés dans un contexte non-interactif.

### Solution
Exécutez les scripts directement dans votre terminal WSL (pas via un script wrapper).

---

## ❌ Problème : Erreurs d'authentification Azure

### Symptômes
```
Error: building client: obtaining Azure client: "DefaultAzureCredential: failed to acquire a token"
```

### Solution

```bash
# 1. Se connecter à Azure CLI
az login

# 2. Vérifier la connexion
az account show

# 3. Vérifier que vous êtes dans le bon abonnement
az account list --output table
az account set --subscription "VOTRE_SUBSCRIPTION_ID"
```

---

## ❌ Problème : Resource Group introuvable

### Symptômes
```
Error: reading Resource Group "RG_FABADI": resources.GroupsClient#Get:
Resource group 'RG_FABADI' could not be found
```

### Solution

1. Vérifier que le Resource Group existe :
```bash
az group show --name RG_FABADI
```

2. Si le Resource Group n'existe pas, créez-le :
```bash
az group create --name RG_FABADI --location "West Europe"
```

3. Ou modifiez `variables.tf` pour utiliser un autre Resource Group.

---

## ❌ Problème : Image Docker non trouvée

### Symptômes
```
❌ Image terraform-brief:latest non trouvée
```

### Solution

```bash
# Construire l'image
./scripts/docker/docker-build.sh
```

---

## ❌ Problème : docker-run.sh ne lance pas bash

### Symptômes
```
Terraform has no command named "bash"
```

### Solution
Le script a été corrigé. Assurez-vous d'avoir la dernière version :

```bash
# Vérifier que le script utilise --entrypoint
grep "entrypoint" ./scripts/docker/docker-run.sh

# Si ce n'est pas le cas, reconstruire l'image
./scripts/docker/docker-build.sh
```

---

## ✅ Vérification Rapide

Pour vérifier que tout fonctionne :

```bash
# 1. Vérifier Docker
docker --version

# 2. Vérifier l'image
./scripts/docker/docker-status.sh

# 3. Vérifier les fichiers Terraform
ls -la *.tf

# 4. Nettoyer et réinitialiser
./scripts/wsl/terraform-clean.sh
./scripts/wsl/terraform-init.sh

# 5. Valider
./scripts/wsl/terraform-validate.sh
```

---

## 📞 Besoin d'aide ?

Si le problème persiste :
1. Vérifiez les logs Docker : `docker logs <container_id>`
2. Vérifiez la connexion Azure : `az account show`
3. Consultez la documentation : `Brief/docs/`

---

*Guide de dépannage pour le projet Brief*

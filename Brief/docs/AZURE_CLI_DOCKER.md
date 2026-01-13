# 🔧 Azure CLI dans Docker - Guide de Dépannage

Guide pour résoudre les problèmes d'Azure CLI dans le conteneur Docker.

---

## ❌ Problème : "az: executable file not found in $PATH"

### Symptômes
```
Error: unable to build authorizer for Resource Manager API:
could not configure AzureCli Authorizer:
could not parse Azure CLI version: launching Azure CLI:
exec: "az": executable file not found in $PATH
```

### Cause
Azure CLI installé via `pip3` dans Alpine Linux ne crée pas toujours un binaire `az` directement accessible dans le PATH.

### Solution

Le Dockerfile crée maintenant un wrapper pour `az`. Si le problème persiste :

1. **Reconstruire l'image** :
   ```bash
   ./scripts/docker/docker-update.sh
   ```

2. **Vérifier dans le conteneur** :
   ```bash
   ./scripts/docker/docker-run.sh

   # Dans le conteneur
   az --version
   ```

3. **Si az ne fonctionne toujours pas**, tester manuellement :
   ```bash
   python3 -m azure.cli.__main__ --version
   ```

---

## 🔍 Vérification

### Tester Azure CLI dans le conteneur

```bash
# Lancer le conteneur
./scripts/docker/docker-run.sh

# Dans le conteneur
az --version
az account show
```

### Si Azure CLI n'est pas trouvé

```bash
# Dans le conteneur, tester le module Python
python3 -m azure.cli.__main__ --version

# Si cela fonctionne, le wrapper doit être créé
ls -la /usr/local/bin/az
ls -la /usr/bin/az
```

---

## 🛠️ Solution Alternative

Si le problème persiste après reconstruction, vous pouvez utiliser les credentials montés depuis l'hôte :

1. Les scripts montent automatiquement `~/.azure` dans le conteneur
2. Terraform peut utiliser les credentials même si `az` n'est pas dans le PATH
3. Le provider Azure peut utiliser les credentials montés directement

---

## 📋 Notes Techniques

- **Image de base** : `hashicorp/terraform:latest` (Alpine Linux)
- **Installation** : `pip3 install azure-cli`
- **Wrapper** : `/usr/local/bin/az` → `python3 -m azure.cli.__main__`
- **Lien symbolique** : `/usr/bin/az` → `/usr/local/bin/az`

---

*Guide de dépannage pour Azure CLI dans Docker*

# 🔐 Credentials Azure CLI dans Docker

Guide pour comprendre comment les credentials Azure CLI sont transmis au conteneur Docker.

---

## ❓ Le Problème

Par défaut, les conteneurs Docker sont **isolés** et n'ont **pas accès** aux credentials Azure CLI configurés sur votre machine hôte.

Si vous faites `az login` dans WSL ou PowerShell, le conteneur Docker ne peut pas utiliser ces credentials.

---

## ✅ La Solution

Les scripts Terraform montent automatiquement le dossier `.azure` (qui contient les credentials Azure CLI) dans le conteneur Docker.

### Comment ça fonctionne

1. **Détection automatique** : Les scripts détectent automatiquement où se trouve votre dossier `.azure`
   - WSL : `~/.azure` (lien symbolique vers Windows) ou `/mnt/c/Users/*/.azure`
   - PowerShell : `$env:USERPROFILE\.azure`

2. **Montage en lecture-écriture** : Le dossier est monté en **lecture-écriture** pour permettre à Azure CLI d'écrire des logs et de mettre à jour le cache MSAL
   ```bash
   -v "/mnt/c/Users/red59/.azure:/root/.azure"
   ```

   **Note** : Le conteneur est isolé et supprimé après chaque exécution (`--rm`), donc c'est sécurisé.

3. **Transparent** : Vous n'avez rien à faire, c'est automatique !

---

## 🔍 Vérification

### Vérifier que les credentials sont montés

```bash
# Lancer le conteneur interactif
./scripts/docker/docker-run.sh

# Dans le conteneur, vérifier que .azure existe
ls -la /root/.azure

# Tester Azure CLI dans le conteneur
az account show
```

### Si les credentials ne sont pas montés

1. Vérifier que vous êtes connecté à Azure :
   ```bash
   az account show
   ```

2. Vérifier où se trouve votre dossier `.azure` :
   ```bash
   # WSL
   ls -la ~/.azure

   # PowerShell
   Test-Path $env:USERPROFILE\.azure
   ```

3. Si le dossier n'existe pas, reconnectez-vous :
   ```bash
   az login
   ```

---

## 📋 Scripts Concernés

Tous les scripts Terraform montent automatiquement le dossier `.azure` :

**WSL (Bash)** :
- ✅ `terraform-init.sh`
- ✅ `terraform-plan.sh`
- ✅ `terraform-apply.sh`
- ✅ `terraform-destroy.sh`
- ✅ `terraform-validate.sh`
- ✅ `terraform-fmt.sh`
- ✅ `terraform-version.sh`
- ✅ `docker-run.sh`

**PowerShell** :
- ✅ `terraform-init.ps1`
- ✅ `terraform-plan.ps1`
- ✅ `terraform-apply.ps1`
- ✅ `terraform-destroy.ps1`
- ✅ `terraform-validate.ps1`
- ✅ `terraform-fmt.ps1`
- ✅ `terraform-version.ps1`
- ✅ `docker-run.ps1`

---

## 🔒 Sécurité

- Les credentials ne sont jamais copiés, seulement montés
- Le conteneur est isolé et supprimé après chaque exécution (`--rm`)
- Les modifications dans le conteneur ne persistent pas sur l'hôte

## ⚠️ Problème : Cache MSAL

Si vous rencontrez l'erreur :
```
ERROR: User '...' does not exist in MSAL token cache. Run `az login`.
```

**Solution** : Faites `az login` dans le conteneur Docker pour régénérer les tokens :

```bash
./scripts/docker/docker-run.sh
# Dans le conteneur
az login
terraform plan
```

Voir le guide complet : [AZURE_TOKEN_CACHE.md](./AZURE_TOKEN_CACHE.md)

---

## 🎯 Résumé

| Action | Résultat |
|--------|----------|
| `az login` dans WSL/PowerShell | ✅ Credentials sauvegardés dans `.azure` |
| Exécution de `terraform-plan.sh` | ✅ Script monte automatiquement `.azure` dans Docker |
| Terraform dans Docker | ✅ Peut utiliser les credentials Azure CLI |

**Vous n'avez rien à faire** : les scripts gèrent tout automatiquement ! 🎉

---

## 📝 Note Technique

Les scripts utilisent des fonctions helper (`_helpers.sh` pour WSL, `_helpers.ps1` pour PowerShell) qui :
1. Détectent automatiquement le chemin du dossier `.azure`
2. Ajoutent le montage Docker si le dossier existe
3. Montent en lecture seule pour la sécurité

---

*Guide pour les credentials Azure CLI dans Docker*

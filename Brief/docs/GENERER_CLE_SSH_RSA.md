# 🔑 Générer une Clé SSH RSA pour Azure

Azure ne supporte **que les clés SSH RSA** (pas ed25519). Ce guide vous montre comment générer une clé RSA.

---

## ❌ Problème

```
Error: the provided ssh-ed25519 SSH key is not supported.
Only RSA SSH keys are supported by Azure
```

Azure ne supporte pas les clés `ed25519`, seulement les clés `RSA`.

---

## ✅ Solution : Générer une Clé RSA

### Dans WSL ou Linux

```bash
# Générer une nouvelle clé RSA (4096 bits recommandé)
ssh-keygen -t rsa -b 4096 -C "azure-vm-key" -f ~/.ssh/id_rsa_azure

# Afficher la clé publique
cat ~/.ssh/id_rsa_azure.pub
```

### Dans PowerShell (si OpenSSH est installé)

```powershell
# Générer une clé RSA
ssh-keygen -t rsa -b 4096 -C "azure-vm-key" -f $env:USERPROFILE\.ssh\id_rsa_azure

# Afficher la clé publique
Get-Content $env:USERPROFILE\.ssh\id_rsa_azure.pub
```

---

## 📋 Mettre à Jour terraform.tfvars

1. **Copier la clé publique** (commence par `ssh-rsa`)

2. **Mettre à jour `Brief/terraform.tfvars`** :

```hcl
vm_ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQD... votre-clé-rsa-complète"
```

**Important** :
- La clé doit commencer par `ssh-rsa` (pas `ssh-ed25519`)
- Copiez la clé **complète** sur une seule ligne
- Ne mettez pas de sauts de ligne dans la clé

---

## 🔍 Vérifier le Format de la Clé

Une clé RSA valide ressemble à :

```
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQD... (très longue ligne) ... azure-vm-key
```

**Format** : `ssh-rsa` + espace + clé (base64) + espace + commentaire

---

## 🎯 Exemple Complet

```bash
# 1. Générer la clé
ssh-keygen -t rsa -b 4096 -C "azure-vm-key" -f ~/.ssh/id_rsa_azure

# 2. Afficher la clé publique
cat ~/.ssh/id_rsa_azure.pub

# 3. Copier la sortie complète dans terraform.tfvars
# Exemple :
# vm_ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQD..."
```

---

## ⚠️ Note sur les Clés Existantes

Si vous avez déjà une clé ed25519 :
- Vous pouvez garder les deux clés
- La clé RSA sera utilisée uniquement pour Azure
- Votre clé ed25519 peut continuer à être utilisée pour d'autres services

---

## 🔒 Sécurité

- **Clé privée** (`id_rsa_azure`) : Ne jamais partager, garder secrète
- **Clé publique** (`id_rsa_azure.pub`) : C'est celle que vous mettez dans `terraform.tfvars`

---

*Guide pour générer une clé SSH RSA compatible avec Azure*

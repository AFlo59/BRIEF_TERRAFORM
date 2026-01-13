# 🔐 Guide : Passphrase SSH - Qu'est-ce que c'est ?

Guide pour comprendre le passphrase SSH et ce qu'il faut en faire.

---

## ❓ Qu'est-ce que le Passphrase ?

Le **passphrase** est le **mot de passe** que vous avez entré lors de la génération de votre clé SSH. C'est une **sécurité supplémentaire** pour protéger votre clé SSH **privée**.

---

## 🔑 Clé Privée vs Clé Publique

### Clé Publique (`id_ed25519_azure.pub`)
- ✅ **Utilisée par Terraform** dans `terraform.tfvars`
- ✅ **Partagée** avec Azure (sécurisée)
- ✅ **Pas de passphrase nécessaire** pour Terraform
- 📍 **Où** : Dans `terraform.tfvars` → `vm_ssh_public_key`

### Clé Privée (`id_ed25519_azure`)
- 🔒 **Protégée par le passphrase**
- 🔒 **Restez sur votre machine** (ne jamais partager)
- 🔒 **Utilisée pour vous connecter** à la VM
- 📍 **Où** : `~/.ssh/id_ed25519_azure`

---

## ✅ Ce Que Vous Devez Faire

### Pour Terraform : RIEN à faire avec le passphrase

✅ **Terraform utilise uniquement la clé PUBLIQUE**
✅ **Le passphrase n'est PAS nécessaire** pour Terraform
✅ **Vous avez déjà mis la clé publique** dans `terraform.tfvars` → C'est suffisant !

---

## 🔐 Quand le Passphrase Sera Demandé ?

Le passphrase sera demandé **uniquement** quand vous vous connecterez à la VM avec SSH :

```bash
# Quand vous ferez ça (après le déploiement)
ssh -i ~/.ssh/id_ed25519_azure azureuser@<IP_PUBLIQUE_VM>

# → Le système vous demandera le passphrase pour déverrouiller la clé privée
```

---

## 🎯 Options avec le Passphrase

### Option 1: Garder le Passphrase (Recommandé) ✅

**Avantages** :
- ✅ Sécurité supplémentaire
- ✅ Si quelqu'un vole votre clé privée, il ne pourra pas l'utiliser sans le passphrase
- ✅ Bonne pratique de sécurité

**Inconvénient** :
- ⚠️ Vous devrez entrer le passphrase à chaque connexion SSH

**Quand utiliser** : Si votre machine peut être accessible par d'autres personnes.

---

### Option 2: Supprimer le Passphrase (Moins sécurisé)

Si vous voulez vous connecter sans entrer de mot de passe :

```bash
# Supprimer le passphrase d'une clé existante
ssh-keygen -p -f ~/.ssh/id_ed25519_azure

# Quand demandé "Enter new passphrase", appuyez juste sur Entrée (vide)
```

**Avantages** :
- ✅ Connexion SSH sans mot de passe
- ✅ Pratique pour l'automatisation

**Inconvénients** :
- ⚠️ Moins sécurisé
- ⚠️ Si quelqu'un vole votre clé privée, il pourra l'utiliser directement

**Quand utiliser** : Si votre machine est très sécurisée et que vous êtes seul à l'utiliser.

---

### Option 3: Utiliser ssh-agent (Recommandé pour la commodité)

Garder le passphrase mais ne l'entrer qu'une fois par session :

```bash
# Démarrer ssh-agent
eval "$(ssh-agent -s)"

# Ajouter votre clé (vous entrerez le passphrase une fois)
ssh-add ~/.ssh/id_ed25519_azure

# Maintenant vous pouvez vous connecter sans retaper le passphrase
ssh -i ~/.ssh/id_ed25519_azure azureuser@<IP_PUBLIQUE_VM>
```

**Avantages** :
- ✅ Sécurité (passphrase toujours présent)
- ✅ Commodité (entré une fois par session)

---

## 📋 Résumé

| Question | Réponse |
|----------|---------|
| **Dois-je mettre le passphrase dans terraform.tfvars ?** | ❌ **NON** - Terraform n'en a pas besoin |
| **Le passphrase est-il nécessaire pour Terraform ?** | ❌ **NON** - Seule la clé publique est utilisée |
| **Quand le passphrase sera-t-il demandé ?** | ✅ Quand vous vous connecterez à la VM avec SSH |
| **Dois-je garder le passphrase ?** | ✅ **OUI** (recommandé pour la sécurité) |
| **Puis-je le supprimer ?** | ✅ OUI (mais moins sécurisé) |

---

## ✅ Action Immédiate

**Vous n'avez RIEN à faire maintenant !**

1. ✅ Vous avez mis la clé publique dans `terraform.tfvars` → **C'est suffisant**
2. ✅ Le passphrase protège votre clé privée → **C'est bien**
3. ✅ Terraform fonctionnera sans problème → **Continuez**

---

## 🚀 Prochaines Étapes

1. **Vérifier terraform.tfvars** : La clé publique est bien là
2. **Vérifier la location** de RG_FABADI
3. **Rendre les noms uniques** (Storage Account, Web App)
4. **Initialiser Terraform** : `terraform init`
5. **Déployer** : `terraform apply`

Le passphrase ne vous bloquera pas pour le déploiement !

---

## 🔍 Vérification

Pour vérifier que votre clé publique est bien dans terraform.tfvars :

```bash
# Voir la ligne avec la clé SSH
grep "vm_ssh_public_key" terraform.tfvars
```

Vous devriez voir :
```
vm_ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOuvHBihgrhMHWezPAxBg7mc4I4JYrRnTKMOYxi2BN/v azure-vm-key"
```

---

## 📚 Ressources

- **Guide SSH** : [docs/GUIDE_AZURE_SETUP.md](./GUIDE_AZURE_SETUP.md#5-générer-une-clé-ssh)
- **Connexion à la VM** : [docs/VERIFICATION.md](./VERIFICATION.md)

---

*Guide créé pour expliquer le passphrase SSH*

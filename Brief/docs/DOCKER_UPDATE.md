# 🔄 Guide : Mise à jour de l'Image Docker

Guide pour comprendre comment utiliser `docker-update.sh` correctement.

---

## ❓ Problème : Conteneur de l'Ancienne Image

Après avoir exécuté `docker-update.sh`, vous devez **quitter et relancer** le conteneur pour utiliser la nouvelle image.

### ❌ Mauvaise Utilisation

```bash
# 1. Vous lancez docker-run.sh (ancienne image)
./scripts/docker/docker-run.sh

# 2. Dans le conteneur, vous faites docker-update.sh
# ⚠️  Cela met à jour l'IMAGE, mais pas le CONTENEUR en cours !

# 3. Vous restez dans le conteneur et faites terraform plan
# ❌ Vous utilisez toujours l'ancienne image !
```

### ✅ Bonne Utilisation

```bash
# 1. Quittez le conteneur actuel
exit

# 2. Mettez à jour l'image
./scripts/docker/docker-update.sh

# 3. Relancez un nouveau conteneur (avec la nouvelle image)
./scripts/docker/docker-run.sh

# 4. Maintenant vous utilisez la nouvelle image !
terraform plan
```

---

## 🔄 Workflow Recommandé

### Option 1 : Utiliser les Scripts Terraform (Recommandé)

Les scripts Terraform lancent automatiquement un nouveau conteneur à chaque fois :

```bash
# 1. Mettre à jour l'image
./scripts/docker/docker-update.sh

# 2. Utiliser les scripts Terraform (ils lancent un nouveau conteneur)
./scripts/wsl/terraform-plan.sh
```

### Option 2 : Conteneur Interactif

Si vous voulez un conteneur interactif :

```bash
# 1. Mettre à jour l'image
./scripts/docker/docker-update.sh

# 2. Quitter l'ancien conteneur si vous êtes dedans
exit

# 3. Lancer un nouveau conteneur
./scripts/docker/docker-run.sh
```

---

## 🎯 Résumé

| Action | Résultat |
|--------|----------|
| `docker-update.sh` | Met à jour l'**image** Docker |
| Conteneur en cours | Utilise toujours l'**ancienne image** |
| Nouveau conteneur | Utilise la **nouvelle image** |

**Règle d'or** : Après `docker-update.sh`, quittez et relancez le conteneur !

---

*Guide pour la mise à jour de l'image Docker*

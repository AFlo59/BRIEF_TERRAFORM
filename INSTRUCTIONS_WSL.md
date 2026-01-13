# 📋 Instructions WSL - Prochaines Étapes

Vous êtes dans WSL et Terraform fonctionne ! Voici ce qu'il faut faire maintenant :

---

## ✅ État Actuel

- ✅ WSL configuré et fonctionnel
- ✅ Docker fonctionne dans WSL
- ✅ Terraform image téléchargée (v1.14.3)
- ✅ Dossier `exercice_1` créé
- ✅ Fichier `main.tf` créé pour l'exercice 1
- ✅ Script `run.sh` créé dans exercice_1

---

## 🚀 Exécuter l'Exercice 1

Vous êtes actuellement dans : `/mnt/d/PROJETS/BRIEF_TERRAFORM/infrastructure/terraform/exercice_1`

### Option 1: Utiliser le script run.sh (Le plus simple)

```bash
# Vous êtes déjà dans le bon dossier !
./run.sh init
./run.sh plan
./run.sh apply
```

### Option 2: Utiliser Docker directement

```bash
# Initialiser
docker run --rm -it \
  -v $(pwd):/workspace \
  -v terraform-plugins:/root/.terraform.d/plugins \
  -w /workspace \
  hashicorp/terraform:latest init

# Plan
docker run --rm -it \
  -v $(pwd):/workspace \
  -v terraform-plugins:/root/.terraform.d/plugins \
  -w /workspace \
  hashicorp/terraform:latest plan

# Appliquer
docker run --rm -it \
  -v $(pwd):/workspace \
  -v terraform-plugins:/root/.terraform.d/plugins \
  -w /workspace \
  hashicorp/terraform:latest apply
```

### Option 3: Depuis la racine avec -chdir

```bash
# Retourner à la racine
cd /mnt/d/PROJETS/BRIEF_TERRAFORM

# Utiliser -chdir
./scripts/terraform-wsl.sh init -chdir=infrastructure/terraform/exercice_1
./scripts/terraform-wsl.sh plan -chdir=infrastructure/terraform/exercice_1
./scripts/terraform-wsl.sh apply -chdir=infrastructure/terraform/exercice_1
```

---

## 📝 Commandes à Exécuter Maintenant

**Depuis votre position actuelle dans WSL** (`/mnt/d/PROJETS/BRIEF_TERRAFORM/infrastructure/terraform/exercice_1`) :

```bash
# 1. Rendre le script exécutable (si pas déjà fait)
chmod +x run.sh

# 2. Initialiser Terraform
./run.sh init

# 3. Voir le plan
./run.sh plan

# 4. Appliquer (créer le fichier)
./run.sh apply

# 5. Vérifier le résultat
ls -la hello_world.txt
cat hello_world.txt
```

---

## 🎯 Résultat Attendu

Après `terraform apply`, vous devriez voir :
- ✅ Message "Apply complete!"
- ✅ Fichier `hello_world.txt` créé
- ✅ Contenu : "Bienvenue dans Terraform !"
- ✅ Permissions : 0755

---

## 🔄 Pour les Autres Exercices

Une fois l'exercice 1 terminé, créez les autres exercices de la même manière :

```bash
# Retourner au dossier terraform
cd /mnt/d/PROJETS/BRIEF_TERRAFORM/infrastructure/terraform

# Créer exercice_2
mkdir exercice_2
cd exercice_2
# Créer main.tf et variables.tf selon EXERCICES_OFFICIELS.md
```

---

## 💡 Astuces

1. **Toujours vérifier où vous êtes** :
   ```bash
   pwd
   ```

2. **Utiliser le script run.sh** dans chaque dossier d'exercice pour simplifier

3. **Voir les fichiers créés** :
   ```bash
   ls -la
   ```

4. **Nettoyer après test** :
   ```bash
   ./run.sh destroy
   ```

---

*Instructions pour continuer depuis votre position actuelle dans WSL*

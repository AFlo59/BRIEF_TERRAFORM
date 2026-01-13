# 🚀 Quick Start - Tous les Exercices

Guide rapide pour exécuter les 4 exercices Terraform.

---

## ✅ Tous les Exercices sont Prêts !

Les 4 exercices sont configurés et prêts à être exécutés en local via Docker dans WSL.

---

## 🎯 Exécution Rapide

### Option 1: Script Automatique (Recommandé)

```bash
# Depuis infrastructure/terraform/
cd /mnt/d/PROJETS/BRIEF_TERRAFORM/infrastructure/terraform

# Exécuter tous les exercices
./run_all_exercises.sh init    # Initialiser tous
./run_all_exercises.sh plan    # Plan de tous
./run_all_exercises.sh apply   # Appliquer tous
./run_all_exercises.sh destroy # Détruire tous
```

### Option 2: Exercice par Exercice

#### Exercice 1 : Fichier Local
```bash
cd exercice_1
./run.sh init
./run.sh apply -auto-approve
cat hello_world.txt
```

#### Exercice 2 : Variables
```bash
cd exercice_2
./run.sh init
./run.sh apply -auto-approve -var="file_name=test.txt" -var="file_content=Mon contenu"
cat test.txt
```

#### Exercice 3 : Data Source + HTTP
```bash
cd exercice_3
./run.sh init
./run.sh apply -auto-approve
head -5 downloaded_file.txt
```

#### Exercice 4 : Multi Providers
```bash
cd exercice_4
./run.sh init
./run.sh apply -auto-approve
cat passwords.txt
```

---

## 📋 Checklist Complète

### ✅ Exercice 1
- [x] Dossier `exercice_1/` créé
- [x] `main.tf` avec ressource `local_file`
- [x] Script `run.sh` créé
- [ ] Exécuté avec succès
- [ ] Fichier `hello_world.txt` créé

### ✅ Exercice 2
- [x] Dossier `exercice_2/` créé
- [x] `variables.tf` avec 2 variables
- [x] `main.tf` utilisant les variables
- [x] Script `run.sh` créé
- [ ] Exécuté avec succès
- [ ] Fichier créé avec variables

### ✅ Exercice 3
- [x] Dossier `exercice_3/` créé
- [x] `main.tf` avec data source HTTP
- [x] `main.tf` avec ressource local_file
- [x] Script `run.sh` créé
- [ ] Exécuté avec succès
- [ ] Fichier téléchargé et sauvegardé

### ✅ Exercice 4
- [x] Dossier `exercice_4/` créé
- [x] `main.tf` avec provider random
- [x] `main.tf` avec 10 mots de passe
- [x] `main.tf` avec ressource local_file
- [x] Script `run.sh` créé
- [ ] Exécuté avec succès
- [ ] Fichier `passwords.txt` créé

---

## 🔍 Vérification des Résultats

```bash
# Vérifier tous les fichiers créés
echo "=== Exercice 1 ==="
cat exercice_1/hello_world.txt

echo "=== Exercice 2 ==="
ls exercice_2/*.txt
cat exercice_2/mon_fichier.txt

echo "=== Exercice 3 ==="
head -5 exercice_3/downloaded_file.txt
wc -l exercice_3/downloaded_file.txt

echo "=== Exercice 4 ==="
cat exercice_4/passwords.txt
```

---

## 🧹 Nettoyage

Pour supprimer tous les fichiers créés :

```bash
# Détruire toutes les ressources
./run_all_exercises.sh destroy

# Ou manuellement pour chaque exercice
cd exercice_1 && ./run.sh destroy -auto-approve
cd exercice_2 && ./run.sh destroy -auto-approve
cd exercice_3 && ./run.sh destroy -auto-approve
cd exercice_4 && ./run.sh destroy -auto-approve
```

---

## 📚 Documentation

- **Guide complet** : [README_EXERCICES.md](./README_EXERCICES.md)
- **Exercices officiels** : [EXERCICES_OFFICIELS.md](./EXERCICES_OFFICIELS.md)
- **Guide local** : [GUIDE_LOCAL.md](./GUIDE_LOCAL.md)

---

*Tous les exercices sont prêts à être exécutés !*

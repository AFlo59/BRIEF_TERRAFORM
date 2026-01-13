# 📋 Guide Complet des 4 Exercices Terraform

Tous les exercices sont configurés pour être exécutés **en local** via Docker dans WSL.

---

## ✅ Exercice 1 : Fichier Local

**Objectif** : Créer un fichier local avec Terraform

**Dossier** : `exercice_1/`

**Fichiers** :
- `main.tf` - Configuration avec ressource `local_file`
- `run.sh` - Script d'exécution

**Exécution** :
```bash
cd exercice_1
./run.sh init
./run.sh apply -auto-approve
```

**Résultat** : Fichier `hello_world.txt` créé

---

## ✅ Exercice 2 : Variables

**Objectif** : Utiliser des variables pour créer un fichier dynamique

**Dossier** : `exercice_2/`

**Fichiers** :
- `main.tf` - Configuration utilisant les variables
- `variables.tf` - Définition des variables
- `run.sh` - Script d'exécution
- `terraform.tfvars.example` - Exemple de fichier de variables

**Exécution** :
```bash
cd exercice_2
./run.sh init
./run.sh apply -auto-approve
# Ou avec variables personnalisées :
./run.sh apply -auto-approve -var="file_name=test.txt" -var="file_content=Mon contenu"
```

**Résultat** : Fichier créé avec nom et contenu définis par variables

---

## ✅ Exercice 3 : Data Source + HTTP

**Objectif** : Télécharger un fichier depuis une URL et le sauvegarder localement

**Dossier** : `exercice_3/`

**Fichiers** :
- `main.tf` - Configuration avec data source HTTP et ressource local_file
- `run.sh` - Script d'exécution

**Exécution** :
```bash
cd exercice_3
./run.sh init
./run.sh plan
./run.sh apply -auto-approve
```

**Résultat** : Fichier `downloaded_file.txt` avec le contenu téléchargé depuis l'URL

**URL utilisée** : `https://cdn.wsform.com/wp-content/uploads/2018/09/country_full.csv`

---

## ✅ Exercice 4 : Multi Providers

**Objectif** : Générer 10 mots de passe aléatoires et les sauvegarder dans un fichier

**Dossier** : `exercice_4/`

**Fichiers** :
- `main.tf` - Configuration avec providers random et local
- `run.sh` - Script d'exécution

**Exécution** :
```bash
cd exercice_4
./run.sh init
./run.sh plan
./run.sh apply -auto-approve
```

**Résultat** : Fichier `passwords.txt` avec 10 mots de passe aléatoires

**Concepts** :
- Utilisation de `count` pour générer 10 ressources
- Dépendances entre ressources
- Fonctions Terraform (`join`, `for`, `timestamp`)

---

## 🚀 Exécution Rapide de Tous les Exercices

### Script pour exécuter tous les exercices

```bash
# Depuis infrastructure/terraform/
for i in {1..4}; do
  echo "=========================================="
  echo "Exercice $i"
  echo "=========================================="
  cd "exercice_$i"
  ./run.sh init
  ./run.sh apply -auto-approve
  echo ""
  cd ..
done
```

### Vérification des résultats

```bash
# Exercice 1
cat exercice_1/hello_world.txt

# Exercice 2
ls exercice_2/*.txt
cat exercice_2/mon_fichier.txt

# Exercice 3
head -5 exercice_3/downloaded_file.txt

# Exercice 4
cat exercice_4/passwords.txt
```

---

## 🧹 Nettoyage

Pour détruire les ressources créées :

```bash
# Pour chaque exercice
cd exercice_1 && ./run.sh destroy -auto-approve
cd exercice_2 && ./run.sh destroy -auto-approve
cd exercice_3 && ./run.sh destroy -auto-approve
cd exercice_4 && ./run.sh destroy -auto-approve
```

---

## 📊 Checklist Complète

### Exercice 1
- [x] Dossier créé
- [x] `main.tf` avec ressource `local_file`
- [x] Script `run.sh` créé
- [x] Fichier `hello_world.txt` créé après apply

### Exercice 2
- [x] Dossier créé
- [x] `variables.tf` avec 2 variables
- [x] `main.tf` utilisant les variables
- [x] Script `run.sh` créé
- [x] Fichier créé avec variables

### Exercice 3
- [x] Dossier créé
- [x] `main.tf` avec data source HTTP
- [x] `main.tf` avec ressource local_file
- [x] Script `run.sh` créé
- [x] Fichier téléchargé et sauvegardé

### Exercice 4
- [x] Dossier créé
- [x] `main.tf` avec provider random
- [x] `main.tf` avec 10 mots de passe générés
- [x] `main.tf` avec ressource local_file pour sauvegarder
- [x] Script `run.sh` créé
- [x] Fichier `passwords.txt` avec 10 mots de passe

---

## 💡 Points d'Apprentissage

### Exercice 1
- ✅ Utilisation du provider `local`
- ✅ Création d'une ressource `local_file`
- ✅ Définition des permissions

### Exercice 2
- ✅ Définition de variables
- ✅ Utilisation de variables dans les ressources
- ✅ Passage de variables via CLI ou fichiers

### Exercice 3
- ✅ Utilisation du provider `http`
- ✅ Data sources pour lire des données externes
- ✅ Référencement d'une data source dans une ressource

### Exercice 4
- ✅ Utilisation du provider `random`
- ✅ Génération de multiples ressources avec `count`
- ✅ Dépendances entre ressources
- ✅ Fonctions Terraform (`join`, `for`, `timestamp`)

---

## 📚 Ressources

- [Documentation Terraform](https://www.terraform.io/docs)
- [Terraform Language Documentation](https://developer.hashicorp.com/terraform/language)
- [Terraform Providers Registry](https://registry.terraform.io/)

---

*Tous les exercices sont prêts à être exécutés en local via Docker dans WSL*

# 🐧 Quick Start WSL - Terraform via Docker

Guide rapide pour utiliser Terraform avec WSL dans ce projet.

---

## ✅ Vérification Rapide

Vous êtes déjà dans WSL ! Vérifiez que tout est prêt :

```bash
# 1. Vérifier que vous êtes dans le bon répertoire
pwd
# Devrait afficher: /mnt/d/PROJETS/BRIEF_TERRAFORM

# 2. Vérifier Docker
docker --version

# 3. Vérifier la structure du projet
ls -la infrastructure/terraform/
```

---

## 🚀 Utilisation de Terraform dans WSL

### Option 1: Script Bash (Recommandé)

```bash
# Rendre le script exécutable (une seule fois)
chmod +x scripts/terraform-wsl.sh

# Utiliser Terraform
./scripts/terraform-wsl.sh version
./scripts/terraform-wsl.sh init
./scripts/terraform-wsl.sh plan
./scripts/terraform-wsl.sh apply
```

### Option 2: Docker Directement

```bash
# Se placer dans le dossier Terraform
cd infrastructure/terraform

# Initialiser Terraform
docker run --rm -it \
  -v $(pwd):/workspace \
  -v terraform-plugins:/root/.terraform.d/plugins \
  -v terraform-cache:/root/.terraform.d \
  -w /workspace \
  hashicorp/terraform:latest init

# Plan
docker run --rm -it \
  -v $(pwd):/workspace \
  -v terraform-plugins:/root/.terraform.d/plugins \
  -v terraform-cache:/root/.terraform.d \
  -w /workspace \
  hashicorp/terraform:latest plan
```

---

## 📁 Exécution des Exercices

### Exercice 1: Créer le dossier et le fichier

```bash
# Créer le dossier de l'exercice
mkdir -p infrastructure/terraform/exercice_1
cd infrastructure/terraform/exercice_1

# Créer le fichier main.tf
cat > main.tf << 'EOF'
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

resource "local_file" "hello_world" {
  content  = "Bienvenue dans Terraform !"
  filename = "${path.module}/hello_world.txt"
  file_permission = "0755"
}
EOF

# Exécuter Terraform
../../../../scripts/terraform-wsl.sh init
../../../../scripts/terraform-wsl.sh plan
../../../../scripts/terraform-wsl.sh apply

# Vérifier le résultat
ls -la hello_world.txt
cat hello_world.txt
```

---

## 🔧 Scripts Utiles pour WSL

### Créer un alias dans votre `.bashrc`

Ajoutez ceci à `~/.bashrc` :

```bash
# Alias pour Terraform dans ce projet
alias tf='cd /mnt/d/PROJETS/BRIEF_TERRAFORM && ./scripts/terraform-wsl.sh'
```

Puis rechargez :
```bash
source ~/.bashrc
```

Utilisation :
```bash
tf version
tf init
```

---

## 📝 Commandes Essentielles

```bash
# Depuis la racine du projet (/mnt/d/PROJETS/BRIEF_TERRAFORM)

# Terraform - Version
./scripts/terraform-wsl.sh version

# Terraform - Initialiser
./scripts/terraform-wsl.sh init

# Terraform - Valider
./scripts/terraform-wsl.sh validate

# Terraform - Plan
./scripts/terraform-wsl.sh plan

# Terraform - Appliquer
./scripts/terraform-wsl.sh apply

# Terraform - Appliquer sans confirmation
./scripts/terraform-wsl.sh apply -auto-approve

# Terraform - Formater
./scripts/terraform-wsl.sh fmt

# Terraform - Détruire
./scripts/terraform-wsl.sh destroy
```

---

## 🎯 Structure Recommandée pour les Exercices

```
/mnt/d/PROJETS/BRIEF_TERRAFORM/
├── infrastructure/
│   └── terraform/
│       ├── exercice_1/
│       │   └── main.tf
│       ├── exercice_2/
│       │   ├── main.tf
│       │   └── variables.tf
│       ├── exercice_3/
│       │   └── main.tf
│       └── exercice_4/
│           └── main.tf
└── scripts/
    └── terraform-wsl.sh
```

---

## 💡 Astuces

1. **Toujours être dans le bon dossier** avant d'exécuter Terraform
   ```bash
   cd infrastructure/terraform/exercice_1
   ```

2. **Utiliser les chemins relatifs** pour les scripts
   ```bash
   ../../../../scripts/terraform-wsl.sh init
   ```

3. **Vérifier les fichiers créés**
   ```bash
   ls -la
   cat *.txt
   ```

---

## 🐛 Dépannage

### Problème: "Permission denied"
```bash
chmod +x scripts/terraform-wsl.sh
```

### Problème: "Docker daemon not running"
```bash
# Vérifier que Docker Desktop est démarré sur Windows
# Ou démarrer Docker dans WSL si installé localement
sudo service docker start
```

### Problème: "No such file or directory"
```bash
# Vérifier que vous êtes dans le bon répertoire
pwd
# Devrait être: /mnt/d/PROJETS/BRIEF_TERRAFORM
```

---

*Guide créé pour faciliter l'utilisation avec WSL*

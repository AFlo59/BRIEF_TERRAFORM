# 🎯 Exercices Terraform

Exercices Terraform locaux pour apprendre les bases de l'Infrastructure as Code.

---

## 📋 Exercices Disponibles

1. **exercice_1** - Créer un fichier local
2. **exercice_2** - Utiliser des variables
3. **exercice_3** - Télécharger un fichier via HTTP
4. **exercice_4** - Générer des mots de passe aléatoires

---

## 🚀 Utilisation

### Prérequis

- Docker installé et fonctionnel
- WSL (pour les scripts bash) ou PowerShell

### Structure

```
Exercices/
├── docker/              # Configuration Docker
├── scripts/             # Scripts d'exécution
│   ├── docker/         # Scripts gestion Docker
│   ├── wsl/            # Scripts WSL/Bash
│   └── powershell/     # Scripts PowerShell
├── docs/               # Documentation
└── exercice_*/         # Exercices individuels
```

---

## 🐧 Utilisation depuis WSL

### Construire l'image Docker (première fois)

```bash
cd Exercices
./scripts/docker/docker-build.sh
```

### Exécuter un exercice

```bash
# Depuis le dossier Exercices
cd exercice_1

# Initialiser
../scripts/wsl/terraform-init.sh

# Appliquer
../scripts/wsl/terraform-apply.sh
```

---

## 💻 Utilisation depuis PowerShell

### Construire l'image Docker (première fois)

```powershell
cd Exercices
.\scripts\docker\docker-build.ps1
```

### Exécuter un exercice

```powershell
# Depuis le dossier Exercices
cd exercice_1

# Utiliser les scripts dans chaque exercice
.\run.ps1 init
.\run.ps1 apply
```

---

## 📚 Documentation

Consultez [docs/](./docs/) pour :
- Guide des exercices
- Solutions
- Documentation complète

---

*Exercices Terraform pour apprendre les bases*

# 🏗️ Structure du Projet BRIEF_TERRAFORM

Structure organisée et optimisée du projet.

---

## 📁 Structure Complète

```
BRIEF_TERRAFORM/
│
├── Brief/                          # Projet Brief Azure
│   ├── docker/                     # Configuration Docker
│   │   ├── Dockerfile
│   │   ├── docker-compose.yml
│   │   └── README.md
│   │
│   ├── scripts/                    # Scripts Terraform
│   │   ├── docker/                 # Gestion Docker
│   │   ├── wsl/                    # Scripts WSL/Bash
│   │   ├── powershell/             # Scripts PowerShell
│   │   └── README.md
│   │
│   ├── modules/                    # Modules Terraform
│   │   ├── vm/                     # Module VM
│   │   ├── storage/                # Module Storage
│   │   └── webapp/                 # Module Web App
│   │
│   ├── docs/                       # Documentation Brief
│   │   ├── GUIDE_AZURE_SETUP.md
│   │   ├── GUIDE_PORTAL_AZURE.md
│   │   ├── DEPLOYMENT.md
│   │   └── ...
│   │
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── terraform.tfvars.example
│   └── README.md
│
├── Exercices/                      # Exercices Terraform locaux
│   ├── docker/                     # Configuration Docker
│   │   ├── Dockerfile
│   │   ├── docker-compose.yml
│   │   └── README.md
│   │
│   ├── scripts/                    # Scripts Terraform
│   │   ├── docker/                 # Gestion Docker
│   │   ├── wsl/                    # Scripts WSL/Bash
│   │   ├── powershell/             # Scripts PowerShell
│   │   └── README.md
│   │
│   ├── docs/                       # Documentation Exercices
│   │   ├── EXERCICES_OFFICIELS.md
│   │   └── README.md
│   │
│   ├── exercice_1/                 # Exercice 1
│   ├── exercice_2/                 # Exercice 2
│   ├── exercice_3/                 # Exercice 3
│   ├── exercice_4/                 # Exercice 4
│   └── README.md
│
├── docs/                           # Documentation générale
│   └── terraform/
│       ├── GUIDE_DOCKER.md
│       └── IDE_EXTENSIONS.md
│
├── IaC-Provisionning(Terraform)/   # PDFs d'apprentissage
│   ├── Intro Terraform.pdf
│   └── Intro Cloud.pdf
│
├── sensor_data/                    # Données de capteurs
├── smarttech-streaming/            # Application de streaming
├── README.md                        # README principal
└── .gitignore
```

---

## 🎯 Organisation

### Projets Indépendants

1. **Brief/** - Projet Azure complet
   - Infrastructure Azure (VM, Storage, Web App)
   - Conteneur Docker dédié (`terraform-brief:latest`)
   - Scripts organisés (wsl/powershell)

2. **Exercices/** - Exercices Terraform locaux
   - 4 exercices pour apprendre Terraform
   - Conteneur Docker dédié (`terraform-exercices:latest`)
   - Scripts organisés (wsl/powershell)

### Structure Commune

Chaque projet (Brief et Exercices) suit la même structure :
- `docker/` - Configuration Docker
- `scripts/` - Scripts d'exécution (wsl/powershell/docker)
- `docs/` - Documentation
- `README.md` - Documentation principale

---

## 📚 Documentation

- **README.md** (racine) - Vue d'ensemble du projet
- **Brief/README.md** - Documentation du Brief Azure
- **Exercices/README.md** - Documentation des exercices
- **docs/** - Guides généraux Terraform

---

*Structure organisée et optimisée*

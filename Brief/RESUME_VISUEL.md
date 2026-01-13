# 📊 Résumé Visuel du Brief Azure

Vue d'ensemble visuelle du projet et des ressources à créer.

---

## 🎯 Objectif du Projet

```
┌─────────────────────────────────────────────────────────┐
│  Déployer 3 ressources Azure via Terraform             │
│  pour un environnement Data Engineering                │
└─────────────────────────────────────────────────────────┘
```

---

## 🏗️ Architecture des Ressources

```
                    ┌─────────────────────┐
                    │   Azure Cloud       │
                    └─────────────────────┘
                             │
        ┌────────────────────┼────────────────────┐
        │                    │                    │
        ▼                    ▼                    ▼
┌───────────────┐  ┌──────────────────┐  ┌──────────────┐
│  VM Linux     │  │ Storage Account  │  │  Web App    │
│               │  │                  │  │              │
│ • 1 vCPU     │  │ • Blob Container │  │ • App Service│
│ • 1 Go RAM   │  │ • Fichiers data  │  │ • API/Dash   │
│ • Ubuntu     │  │ • CSV, audio...  │  │ • Résultats  │
└───────────────┘  └──────────────────┘  └──────────────┘
```

---

## 📦 Structure des Modules Terraform

```
Brief/
│
├── main.tf ──────────────┐
│                         │
├── variables.tf          │ Appelle les 3 modules
│                         │
├── outputs.tf            │
│                         │
└── modules/              │
    ├── vm/ ──────────────┤
    │   ├── main.tf       │ • VNet, Subnet, NSG
    │   ├── variables.tf  │ • Public IP
    │   └── outputs.tf    │ • Linux VM
    │                     │
    ├── storage/ ─────────┤
    │   ├── main.tf       │ • Storage Account
    │   ├── variables.tf  │ • Blob Container
    │   └── outputs.tf    │
    │                     │
    └── webapp/ ──────────┘
        ├── main.tf       │ • App Service Plan
        ├── variables.tf  │ • Web App
        └── outputs.tf    │
```

---

## 🔄 Flux de Déploiement

```
1. terraform init
   └─> Télécharge providers Azure

2. terraform plan
   └─> Génère le plan d'exécution
       ├─> VM: +1 to add
       ├─> Storage: +1 to add
       └─> Web App: +1 to add

3. terraform apply
   └─> Déploie sur Azure
       ├─> Crée Resource Group
       ├─> Crée VM + Réseau
       ├─> Crée Storage + Container
       └─> Crée Web App

4. Vérification
   └─> Portail Azure ou Azure CLI

5. terraform destroy
   └─> Supprime toutes les ressources
```

---

## 📋 Checklist Visuelle

### ✅ Ressources à Créer

```
VM Linux
├─ [ ] Resource Group
├─ [ ] Virtual Network
├─ [ ] Subnet
├─ [ ] Network Security Group
├─ [ ] Public IP
├─ [ ] Network Interface
└─ [ ] Linux Virtual Machine (B1s)

Storage
├─ [ ] Storage Account (Standard LRS)
└─ [ ] Blob Container

Web App
├─ [ ] App Service Plan (Basic/Free)
└─ [ ] App Service (Web App)
```

### ✅ Code à Créer

```
Fichiers Principaux
├─ [ ] main.tf
├─ [ ] variables.tf
├─ [ ] outputs.tf
└─ [ ] terraform.tfvars.example

Modules
├─ [ ] modules/vm/*.tf
├─ [ ] modules/storage/*.tf
└─ [ ] modules/webapp/*.tf

Documentation
├─ [ ] README.md
├─ [ ] docs/DEPLOYMENT.md
└─ [ ] docs/VERIFICATION.md
```

---

## 💰 Coûts Estimés (par mois)

```
VM (Standard_B1s)      : ~$10
Storage (Standard LRS): ~$1-2
Web App (Basic B1)    : ~$13
─────────────────────────────
TOTAL                 : ~$25/mois

OU avec Web App Free  : ~$12/mois
```

---

## 🎯 Critères de Performance

```
✅ Code organisé
   ├─ Modules séparés
   ├─ Variables définies
   └─ Outputs configurés

✅ Fonctionnement
   ├─ terraform plan ✓
   ├─ terraform apply ✓
   └─ terraform destroy ✓

✅ Déploiement
   ├─ VM créée ✓
   ├─ Storage créé ✓
   └─ Web App créée ✓

✅ Documentation
   ├─ Étapes expliquées ✓
   └─ Vérification documentée ✓
```

---

## 📅 Timeline

```
Jour 1 (Aujourd'hui)
├─ Phase 1: Configuration (30 min)
├─ Phase 2: Module VM (1h)
└─ Phase 3: Module Storage (30 min)

Jour 2
├─ Phase 4: Module Web App (30 min)
├─ Phase 5: Intégration (30 min)
└─ Phase 6: Outputs (20 min)

Jour 3
├─ Phase 7: Documentation (1h)
├─ Phase 8: Tests (1h)
└─ Phase 9: Livrable (20 min)

Échéance: 13/01/26 à 17h00
```

---

*Résumé visuel créé pour faciliter la compréhension du projet*

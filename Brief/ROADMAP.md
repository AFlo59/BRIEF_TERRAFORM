# 🗺️ Roadmap du Projet Azure

Plan d'exécution détaillé avec suivi de progression.

---

## Phase 1: Configuration Initiale ⚙️

### Étape 1.1: Structure de Base
- [ ] Créer la structure de dossiers
- [ ] Créer `.gitignore`
- [ ] Créer `main.tf` avec provider Azure
- [ ] Créer `variables.tf` avec variables globales
- [ ] Créer `outputs.tf`
- [ ] Créer `terraform.tfvars.example`

**Fichiers à créer:**
- [ ] `main.tf`
- [ ] `variables.tf`
- [ ] `outputs.tf`
- [ ] `.gitignore`
- [ ] `terraform.tfvars.example`

**Temps estimé:** 30 minutes

---

## Phase 2: Module VM 🖥️

### Étape 2.1: Structure du Module
- [ ] Créer `modules/vm/main.tf`
- [ ] Créer `modules/vm/variables.tf`
- [ ] Créer `modules/vm/outputs.tf`
- [ ] Créer `modules/vm/README.md`

### Étape 2.2: Ressources Réseau
- [ ] Créer Resource Group (ou partagé)
- [ ] Créer Virtual Network
- [ ] Créer Subnet
- [ ] Créer Network Security Group
- [ ] Créer Network Security Rule (SSH)

### Étape 2.3: Ressources VM
- [ ] Créer Public IP
- [ ] Créer Network Interface
- [ ] Créer Linux Virtual Machine
  - [ ] Taille: Standard_B1s
  - [ ] Image: Ubuntu Server
  - [ ] SSH key configuré

**Temps estimé:** 1 heure

---

## Phase 3: Module Storage 📦

### Étape 3.1: Structure du Module
- [ ] Créer `modules/storage/main.tf`
- [ ] Créer `modules/storage/variables.tf`
- [ ] Créer `modules/storage/outputs.tf`
- [ ] Créer `modules/storage/README.md`

### Étape 3.2: Ressources Storage
- [ ] Créer Storage Account
  - [ ] Nom unique
  - [ ] Tier: Standard
  - [ ] Replication: LRS
- [ ] Créer Blob Container
  - [ ] Nom défini
  - [ ] Access type configuré

**Temps estimé:** 30 minutes

---

## Phase 4: Module Web App 🌐

### Étape 4.1: Structure du Module
- [ ] Créer `modules/webapp/main.tf`
- [ ] Créer `modules/webapp/variables.tf`
- [ ] Créer `modules/webapp/outputs.tf`
- [ ] Créer `modules/webapp/README.md`

### Étape 4.2: Ressources Web App
- [ ] Créer App Service Plan
  - [ ] SKU: Basic ou Free
  - [ ] Location
- [ ] Créer App Service (Web App)
  - [ ] Nom unique
  - [ ] Plan associé
  - [ ] Configuration de base

**Temps estimé:** 30 minutes

---

## Phase 5: Intégration des Modules 🔗

### Étape 5.1: Appel des Modules
- [ ] Appeler module VM dans `main.tf`
- [ ] Appeler module Storage dans `main.tf`
- [ ] Appeler module Web App dans `main.tf`
- [ ] Passer les variables nécessaires

### Étape 5.2: Variables Globales
- [ ] Définir toutes les variables dans `variables.tf`
- [ ] Documenter chaque variable
- [ ] Créer `terraform.tfvars.example` complet

**Temps estimé:** 30 minutes

---

## Phase 6: Outputs 📤

### Étape 6.1: Outputs des Modules
- [ ] Outputs VM (IP publique, nom)
- [ ] Outputs Storage (nom, URL)
- [ ] Outputs Web App (URL)

### Étape 6.2: Outputs Globaux
- [ ] Référencer les outputs des modules
- [ ] Ajouter des descriptions
- [ ] Tester les outputs

**Temps estimé:** 20 minutes

---

## Phase 7: Documentation 📚

### Étape 7.1: Documentation Technique
- [ ] Créer `README.md` principal
- [ ] Créer `docs/DEPLOYMENT.md`
- [ ] Créer `docs/VERIFICATION.md`
- [ ] Créer `docs/ARCHITECTURE.md`

### Étape 7.2: Documentation des Étapes
- [ ] Expliquer la création de la VM
- [ ] Expliquer la création du Storage
- [ ] Expliquer la création de la Web App
- [ ] Ajouter des schémas si nécessaire

**Temps estimé:** 1 heure

---

## Phase 8: Tests et Validation ✅

### Étape 8.1: Tests Locaux
- [ ] `terraform init` - Succès
- [ ] `terraform validate` - Aucune erreur
- [ ] `terraform fmt` - Code formaté
- [ ] `terraform plan` - Plan généré

### Étape 8.2: Tests Azure
- [ ] `terraform apply` - Déploiement réussi
- [ ] Vérifier VM dans le portail
- [ ] Vérifier Storage dans le portail
- [ ] Vérifier Web App dans le portail
- [ ] Vérifier via Azure CLI
- [ ] `terraform destroy` - Destruction complète

**Temps estimé:** 1 heure

---

## Phase 9: Préparation du Livrable 📦

### Étape 9.1: Vérification
- [ ] Tous les fichiers présents
- [ ] Documentation complète
- [ ] Dossier `.terraform/` exclu
- [ ] Fichiers sensibles exclus

### Étape 9.2: Archive
- [ ] Créer archive ZIP
- [ ] Vérifier le contenu
- [ ] Tester l'extraction
- [ ] Valider le livrable

**Temps estimé:** 20 minutes

---

## 📊 Progression Globale

**Total estimé:** ~5h30

- [ ] Phase 1: Configuration Initiale (30 min)
- [ ] Phase 2: Module VM (1h)
- [ ] Phase 3: Module Storage (30 min)
- [ ] Phase 4: Module Web App (30 min)
- [ ] Phase 5: Intégration (30 min)
- [ ] Phase 6: Outputs (20 min)
- [ ] Phase 7: Documentation (1h)
- [ ] Phase 8: Tests (1h)
- [ ] Phase 9: Livrable (20 min)

---

## 🎯 Prochaines Actions Immédiates

1. **Créer la structure de base** (Phase 1)
2. **Configurer le provider Azure** (Phase 1)
3. **Commencer par le module VM** (Phase 2)

---

*Roadmap créée pour suivre la progression du projet*

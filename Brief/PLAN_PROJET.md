# 📋 Plan de Projet - Provisioning Azure avec Terraform

Plan étape par étape pour déployer les 3 ressources Azure.

---

## 🏗️ Structure du Projet Proposée

```
Brief/
├── main.tf                    # Configuration principale
├── variables.tf               # Variables globales
├── outputs.tf                 # Outputs (URLs, IDs, etc.)
├── terraform.tfvars.example   # Exemple de variables
├── .gitignore                # Exclure .terraform/, etc.
├── README.md                  # Documentation principale
│
├── modules/                   # Modules Terraform
│   ├── vm/                    # Module Machine Virtuelle
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── storage/               # Module Storage Account + Container
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── webapp/                # Module Web App
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
└── docs/                       # Documentation
    ├── DEPLOYMENT.md          # Procédure de déploiement
    ├── VERIFICATION.md        # Procédure de vérification
    └── ARCHITECTURE.md         # Explication de l'architecture
```

---

## 📝 Plan d'Exécution Étape par Étape

### Phase 1: Configuration Initiale ⚙️

#### Étape 1.1: Structure de Base
- [ ] Créer la structure de dossiers
- [ ] Créer `.gitignore` pour exclure `.terraform/`
- [ ] Créer `main.tf` avec configuration Azure provider
- [ ] Créer `variables.tf` avec variables globales
- [ ] Créer `outputs.tf` pour les outputs

#### Étape 1.2: Configuration Azure
- [ ] Configurer le provider Azure dans `main.tf`
- [ ] Définir les variables Azure (subscription_id, tenant_id, etc.)
- [ ] Créer `terraform.tfvars.example` avec exemples

**Fichiers à créer:**
- `main.tf` (configuration provider)
- `variables.tf` (variables globales)
- `outputs.tf` (outputs)
- `.gitignore`
- `terraform.tfvars.example`

---

### Phase 2: Module VM 🖥️

#### Étape 2.1: Création du Module VM
- [ ] Créer `modules/vm/main.tf`
- [ ] Créer `modules/vm/variables.tf`
- [ ] Créer `modules/vm/outputs.tf`

#### Étape 2.2: Ressources VM
- [ ] Créer Resource Group (si nécessaire)
- [ ] Créer Virtual Network et Subnet
- [ ] Créer Network Security Group
- [ ] Créer Public IP
- [ ] Créer Network Interface
- [ ] Créer Linux Virtual Machine (1 vCPU, 1 Go RAM)

#### Étape 2.3: Configuration VM
- [ ] Définir l'image Linux (Ubuntu Server)
- [ ] Configurer l'authentification (SSH key)
- [ ] Ajouter les tags appropriés

**Ressources Azure nécessaires:**
- `azurerm_resource_group`
- `azurerm_virtual_network`
- `azurerm_subnet`
- `azurerm_network_security_group`
- `azurerm_public_ip`
- `azurerm_network_interface`
- `azurerm_linux_virtual_machine`

---

### Phase 3: Module Storage 📦

#### Étape 3.1: Création du Module Storage
- [ ] Créer `modules/storage/main.tf`
- [ ] Créer `modules/storage/variables.tf`
- [ ] Créer `modules/storage/outputs.tf`

#### Étape 3.2: Ressources Storage
- [ ] Créer Storage Account (basique, peu coûteux)
- [ ] Créer Blob Container dans le Storage Account
- [ ] Configurer les options de stockage (LRS pour réduire les coûts)

**Ressources Azure nécessaires:**
- `azurerm_storage_account`
- `azurerm_storage_container`

---

### Phase 4: Module Web App 🌐

#### Étape 4.1: Création du Module Web App
- [ ] Créer `modules/webapp/main.tf`
- [ ] Créer `modules/webapp/variables.tf`
- [ ] Créer `modules/webapp/outputs.tf`

#### Étape 4.2: Ressources Web App
- [ ] Créer App Service Plan (basique, peu coûteux)
- [ ] Créer Web App (App Service)
- [ ] Configurer les paramètres de base

**Ressources Azure nécessaires:**
- `azurerm_app_service_plan`
- `azurerm_app_service`

---

### Phase 5: Intégration des Modules 🔗

#### Étape 5.1: Appel des Modules dans main.tf
- [ ] Appeler le module VM
- [ ] Appeler le module Storage
- [ ] Appeler le module Web App
- [ ] Passer les variables nécessaires

#### Étape 5.2: Variables Globales
- [ ] Définir toutes les variables dans `variables.tf`
- [ ] Créer `terraform.tfvars.example`
- [ ] Documenter chaque variable

---

### Phase 6: Outputs 📤

#### Étape 6.1: Définir les Outputs
- [ ] Output VM : IP publique, nom, etc.
- [ ] Output Storage : URL du compte, nom du container
- [ ] Output Web App : URL de l'application

**Outputs à créer:**
- `vm_public_ip`
- `vm_name`
- `storage_account_name`
- `storage_container_name`
- `webapp_url`

---

### Phase 7: Documentation 📚

#### Étape 7.1: Documentation Technique
- [ ] Créer `README.md` avec vue d'ensemble
- [ ] Créer `docs/DEPLOYMENT.md` avec procédure de déploiement
- [ ] Créer `docs/VERIFICATION.md` avec procédure de vérification
- [ ] Créer `docs/ARCHITECTURE.md` expliquant l'architecture

#### Étape 7.2: Documentation des Étapes
- [ ] Documenter chaque étape de création
- [ ] Expliquer les choix techniques
- [ ] Ajouter des schémas si nécessaire

---

### Phase 8: Tests et Validation ✅

#### Étape 8.1: Tests Locaux
- [ ] `terraform init` - Vérifier l'initialisation
- [ ] `terraform validate` - Valider la syntaxe
- [ ] `terraform fmt` - Formater le code
- [ ] `terraform plan` - Vérifier le plan

#### Étape 8.2: Tests Azure
- [ ] `terraform apply` - Déployer sur Azure
- [ ] Vérifier les ressources dans le portail Azure
- [ ] Vérifier via Azure CLI
- [ ] `terraform destroy` - Vérifier la destruction complète

---

## 🎯 Checklist Complète

### Configuration
- [ ] Structure de dossiers créée
- [ ] Provider Azure configuré
- [ ] Variables définies
- [ ] `.gitignore` configuré

### Module VM
- [ ] Module créé et fonctionnel
- [ ] VM Linux déployée (1 vCPU, 1 Go RAM)
- [ ] Réseau configuré
- [ ] Outputs définis

### Module Storage
- [ ] Module créé et fonctionnel
- [ ] Storage Account créé
- [ ] Blob Container créé
- [ ] Outputs définis

### Module Web App
- [ ] Module créé et fonctionnel
- [ ] App Service Plan créé
- [ ] Web App déployée
- [ ] Outputs définis

### Intégration
- [ ] Modules appelés dans main.tf
- [ ] Variables passées correctement
- [ ] Outputs globaux définis

### Documentation
- [ ] README.md complet
- [ ] Procédure de déploiement
- [ ] Procédure de vérification
- [ ] Explication de l'architecture

### Tests
- [ ] `terraform init` fonctionne
- [ ] `terraform plan` fonctionne
- [ ] `terraform apply` fonctionne
- [ ] Ressources vérifiées sur Azure
- [ ] `terraform destroy` fonctionne

---

## 💰 Optimisation des Coûts

### VM
- **Taille** : Standard_B1s (1 vCPU, 1 Go RAM) - ~$10/mois
- **OS Disk** : Standard_LRS (moins cher)
- **Pas de disque de données supplémentaire**

### Storage Account
- **Tier** : Standard (pas Premium)
- **Replication** : LRS (Local Redundant Storage) - moins cher
- **Performance** : Standard (pas Premium)

### Web App
- **Plan** : Basic B1 ou Free (F1) - ~$13/mois ou gratuit
- **SKU** : Basic pour réduire les coûts

---

## 🔐 Sécurité

- [ ] Utiliser des variables pour les secrets (pas de hardcoding)
- [ ] SSH keys pour la VM (pas de mots de passe)
- [ ] Network Security Groups configurés
- [ ] Tags appropriés pour la gestion

---

## 📊 Estimation du Temps

- **Phase 1** : 30 min (Configuration initiale)
- **Phase 2** : 1h (Module VM)
- **Phase 3** : 30 min (Module Storage)
- **Phase 4** : 30 min (Module Web App)
- **Phase 5** : 30 min (Intégration)
- **Phase 6** : 20 min (Outputs)
- **Phase 7** : 1h (Documentation)
- **Phase 8** : 1h (Tests)

**Total estimé** : ~5h30

---

*Plan créé pour guider le développement étape par étape*

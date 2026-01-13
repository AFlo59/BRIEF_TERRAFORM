# 🏗️ Structure du Projet Azure Terraform

Structure détaillée du projet avec tous les fichiers nécessaires.

---

## 📁 Structure Complète

```
Brief/
│
├── .gitignore                          # Exclure .terraform/, *.tfstate, etc.
├── README.md                           # Documentation principale
├── terraform.tfvars.example            # Exemple de variables
│
├── main.tf                             # Configuration principale
├── variables.tf                         # Variables globales
├── outputs.tf                          # Outputs globaux
│
├── modules/                            # Modules Terraform
│   │
│   ├── vm/                            # Module Machine Virtuelle
│   │   ├── main.tf                    # Ressources VM
│   │   ├── variables.tf               # Variables du module
│   │   ├── outputs.tf                 # Outputs du module
│   │   └── README.md                  # Documentation du module
│   │
│   ├── storage/                       # Module Storage
│   │   ├── main.tf                    # Storage Account + Container
│   │   ├── variables.tf               # Variables du module
│   │   ├── outputs.tf                 # Outputs du module
│   │   └── README.md                  # Documentation du module
│   │
│   └── webapp/                        # Module Web App
│       ├── main.tf                    # App Service + Plan
│       ├── variables.tf               # Variables du module
│       ├── outputs.tf                 # Outputs du module
│       └── README.md                  # Documentation du module
│
└── docs/                              # Documentation
    ├── DEPLOYMENT.md                  # Procédure de déploiement
    ├── VERIFICATION.md                # Procédure de vérification
    ├── ARCHITECTURE.md                # Explication de l'architecture
    └── TROUBLESHOOTING.md             # Dépannage
```

---

## 📄 Description des Fichiers

### Fichiers Racine

#### `main.tf`
- Configuration du provider Azure
- Appel des 3 modules (VM, Storage, Web App)
- Configuration du backend (optionnel)

#### `variables.tf`
- Variables globales du projet
- Variables partagées entre modules
- Variables Azure (subscription_id, location, etc.)

#### `outputs.tf`
- Outputs globaux
- Références aux outputs des modules
- URLs, IPs, noms des ressources

#### `terraform.tfvars.example`
- Exemple de valeurs pour les variables
- Template à copier vers `terraform.tfvars`
- **⚠️ Ne pas commiter terraform.tfvars avec secrets**

#### `.gitignore`
- `.terraform/` (plugins)
- `*.tfstate` (state files)
- `*.tfstate.backup`
- `.terraform.lock.hcl` (optionnel)
- `terraform.tfvars` (si contient secrets)

---

### Module VM (`modules/vm/`)

#### `main.tf`
Ressources à créer :
- `azurerm_resource_group` (si pas partagé)
- `azurerm_virtual_network`
- `azurerm_subnet`
- `azurerm_network_security_group`
- `azurerm_network_security_rule` (SSH)
- `azurerm_public_ip`
- `azurerm_network_interface`
- `azurerm_linux_virtual_machine`

#### `variables.tf`
Variables du module :
- `vm_name`
- `vm_size` (Standard_B1s)
- `admin_username`
- `ssh_public_key`
- `location`
- `resource_group_name`

#### `outputs.tf`
Outputs du module :
- `vm_public_ip`
- `vm_private_ip`
- `vm_id`
- `vm_name`

---

### Module Storage (`modules/storage/`)

#### `main.tf`
Ressources à créer :
- `azurerm_storage_account`
- `azurerm_storage_container`

#### `variables.tf`
Variables du module :
- `storage_account_name`
- `container_name`
- `location`
- `resource_group_name`
- `account_tier` (Standard)
- `account_replication_type` (LRS)

#### `outputs.tf`
Outputs du module :
- `storage_account_name`
- `storage_account_primary_endpoint`
- `container_name`
- `container_id`

---

### Module Web App (`modules/webapp/`)

#### `main.tf`
Ressources à créer :
- `azurerm_app_service_plan`
- `azurerm_app_service`

#### `variables.tf`
Variables du module :
- `app_name`
- `location`
- `resource_group_name`
- `app_service_plan_sku` (Basic ou Free)
- `app_settings` (optionnel)

#### `outputs.tf`
Outputs du module :
- `webapp_url`
- `webapp_name`
- `webapp_id`

---

## 🔗 Relations entre Modules

```
main.tf
├── module.vm
│   └── Crée: VM + Réseau
├── module.storage
│   └── Crée: Storage Account + Container
└── module.webapp
    └── Crée: App Service Plan + Web App

Tous partagent:
- Resource Group (créé dans main.tf ou modules)
- Location
- Tags
```

---

## 📊 Flux de Déploiement

1. **Initialisation**
   ```bash
   terraform init
   ```

2. **Planification**
   ```bash
   terraform plan
   ```

3. **Déploiement**
   ```bash
   terraform apply
   ```

4. **Vérification**
   - Portail Azure
   - Azure CLI
   - Outputs Terraform

5. **Destruction**
   ```bash
   terraform destroy
   ```

---

*Structure proposée pour le projet Azure*

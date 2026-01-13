# Configuration principale Terraform pour le projet Azure
# Ce fichier configure le provider Azure et appelle les modules

terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  # Configuration du backend (optionnel)
  # Décommentez et configurez selon votre besoin
  # backend "azurerm" {
  #   resource_group_name  = "terraform-state-rg"
  #   storage_account_name = "terraformstate"
  #   container_name       = "tfstate"
  #   key                  = "terraform.tfstate"
  # }
}

# Configuration du provider Azure
provider "azurerm" {
  features {
    # Configuration des features Azure
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

  # Les credentials peuvent être fournis via:
  # - Variables d'environnement (AZURE_CLIENT_ID, AZURE_CLIENT_SECRET, etc.)
  # - Azure CLI (az login)
  # - Fichier de configuration
}

# Utiliser le Resource Group existant RG_FABADI
# Si vous préférez créer un nouveau Resource Group, décommentez le bloc ci-dessous
# et commentez la data source

# Option 1: Utiliser un Resource Group existant (recommandé si vous avez déjà RG_FABADI)
data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

# Option 2: Créer un nouveau Resource Group (décommentez si nécessaire)
# resource "azurerm_resource_group" "main" {
#   name     = var.resource_group_name
#   location = var.location
#
#   tags = var.tags
# }

# Module VM - Machine Virtuelle Linux
module "vm" {
  source = "./modules/vm"

  # Variables du module
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  vm_name         = var.vm_name
  vm_size         = var.vm_size
  admin_username  = var.vm_admin_username
  ssh_public_key  = var.vm_ssh_public_key

  tags = var.tags
}

# Module Storage - Storage Account + Blob Container
module "storage" {
  source = "./modules/storage"

  # Variables du module
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  storage_account_name = var.storage_account_name
  container_name       = var.container_name

  tags = var.tags
}

# Module Web App - App Service + Web App
module "webapp" {
  source = "./modules/webapp"

  # Variables du module
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location

  app_name        = var.webapp_name
  app_service_sku = var.webapp_sku

  tags = var.tags
}

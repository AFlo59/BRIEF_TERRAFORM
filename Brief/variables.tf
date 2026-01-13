# Variables globales du projet Azure

# Variables Azure
variable "location" {
  description = "Région Azure pour déployer les ressources (format: francecentral, westeurope, etc.)"
  type        = string
  default     = "francecentral"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.location))
    error_message = "La location doit être une région Azure valide au format lowercase (ex: westeurope, northeurope)."
  }
}

variable "resource_group_name" {
  description = "Nom du Resource Group Azure existant"
  type        = string
  default     = "fabadiRG"  # Resource Group existant

  # Si vous voulez créer un nouveau Resource Group, changez cette valeur
  # et décommentez le bloc resource dans main.tf
}

variable "tags" {
  description = "Tags à appliquer à toutes les ressources"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "terraform-brief"
    ManagedBy   = "terraform"
  }
}

# Variables VM
variable "vm_name" {
  description = "Nom de la machine virtuelle"
  type        = string
  default     = "vm-terraform-brief"
}

variable "vm_size" {
  description = "Taille de la VM (Standard_B1s = 1 vCPU, 1 Go RAM)"
  type        = string
  default     = "Standard_B1s"
}

variable "vm_admin_username" {
  description = "Nom d'utilisateur administrateur pour la VM"
  type        = string
  default     = "azureuser"

  validation {
    condition     = length(var.vm_admin_username) >= 3 && length(var.vm_admin_username) <= 20
    error_message = "Le nom d'utilisateur doit contenir entre 3 et 20 caractères."
  }
}

variable "vm_ssh_public_key" {
  description = "Clé publique SSH pour l'authentification sur la VM"
  type        = string
  sensitive   = true

  # Pas de valeur par défaut - doit être fournie via terraform.tfvars
}

# Variables Storage
variable "storage_account_name" {
  description = "Nom du Storage Account Azure (doit être unique globalement)"
  type        = string
  default     = "stterraformbrief"

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "Le nom du Storage Account doit contenir entre 3 et 24 caractères alphanumériques en minuscules."
  }
}

variable "container_name" {
  description = "Nom du Blob Container"
  type        = string
  default     = "data-container"

  validation {
    condition     = can(regex("^[a-z0-9-]{3,63}$", var.container_name))
    error_message = "Le nom du container doit contenir entre 3 et 63 caractères alphanumériques en minuscules."
  }
}

# Variables Web App
variable "webapp_name" {
  description = "Nom de la Web App Azure (doit être unique globalement)"
  type        = string
  default     = "webapp-terraform-brief"

  validation {
    condition     = can(regex("^[a-z0-9-]{2,60}$", var.webapp_name))
    error_message = "Le nom de la Web App doit contenir entre 2 et 60 caractères alphanumériques en minuscules."
  }
}

variable "webapp_sku" {
  description = "SKU du App Service Plan (Free, Basic, etc.)"
  type        = string
  default     = "F1"  # Free tier pour réduire les coûts

  validation {
    condition     = contains(["F1", "B1", "B2", "B3", "S1", "S2", "S3"], var.webapp_sku)
    error_message = "Le SKU doit être F1 (Free), B1/B2/B3 (Basic), ou S1/S2/S3 (Standard)."
  }
}

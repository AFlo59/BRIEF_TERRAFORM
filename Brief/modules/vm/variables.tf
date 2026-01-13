# Variables du module VM

variable "resource_group_name" {
  description = "Nom du Resource Group Azure"
  type        = string
}

variable "location" {
  description = "Région Azure"
  type        = string
}

variable "vm_name" {
  description = "Nom de la machine virtuelle"
  type        = string
}

variable "vm_size" {
  description = "Taille de la VM"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Nom d'utilisateur administrateur"
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "Clé publique SSH"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags à appliquer aux ressources"
  type        = map(string)
  default     = {}
}

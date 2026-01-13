# Variables du module Storage

variable "resource_group_name" {
  description = "Nom du Resource Group Azure"
  type        = string
}

variable "location" {
  description = "Région Azure"
  type        = string
}

variable "storage_account_name" {
  description = "Nom du Storage Account (doit être unique globalement)"
  type        = string
}

variable "container_name" {
  description = "Nom du Blob Container"
  type        = string
}

variable "tags" {
  description = "Tags à appliquer aux ressources"
  type        = map(string)
  default     = {}
}

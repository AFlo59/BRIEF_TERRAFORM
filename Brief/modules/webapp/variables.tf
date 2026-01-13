# Variables du module Web App

variable "resource_group_name" {
  description = "Nom du Resource Group Azure"
  type        = string
}

variable "location" {
  description = "Région Azure"
  type        = string
}

variable "app_name" {
  description = "Nom de la Web App (doit être unique globalement)"
  type        = string
}

variable "app_service_sku" {
  description = "SKU de l'App Service Plan (F1=Free, B1=Basic)"
  type        = string
  default     = "F1"
}

variable "tags" {
  description = "Tags à appliquer aux ressources"
  type        = map(string)
  default     = {}
}

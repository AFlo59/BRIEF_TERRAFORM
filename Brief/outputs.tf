# Outputs globaux du projet Azure

# Outputs VM
output "vm_public_ip" {
  description = "Adresse IP publique de la VM"
  value       = module.vm.vm_public_ip
}

output "vm_name" {
  description = "Nom de la machine virtuelle"
  value       = module.vm.vm_name
}

output "vm_id" {
  description = "ID de la machine virtuelle"
  value       = module.vm.vm_id
}

# Outputs Storage
output "storage_account_name" {
  description = "Nom du Storage Account"
  value       = module.storage.storage_account_name
}

output "storage_account_primary_endpoint" {
  description = "URL principale du Storage Account"
  value       = module.storage.storage_account_primary_endpoint
}

output "container_name" {
  description = "Nom du Blob Container"
  value       = module.storage.container_name
}

# Outputs Web App
output "webapp_url" {
  description = "URL de la Web App"
  value       = module.webapp.webapp_url
}

output "webapp_name" {
  description = "Nom de la Web App"
  value       = module.webapp.webapp_name
}

# Outputs Resource Group
output "resource_group_name" {
  description = "Nom du Resource Group"
  value       = data.azurerm_resource_group.main.name
}

output "resource_group_location" {
  description = "Location du Resource Group"
  value       = data.azurerm_resource_group.main.location
}

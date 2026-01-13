# Outputs du module Storage

output "storage_account_name" {
  description = "Nom du Storage Account"
  value       = azurerm_storage_account.main.name
}

output "storage_account_id" {
  description = "ID du Storage Account"
  value       = azurerm_storage_account.main.id
}

output "storage_account_primary_endpoint" {
  description = "URL principale du Storage Account"
  value       = azurerm_storage_account.main.primary_blob_endpoint
}

output "container_name" {
  description = "Nom du Blob Container"
  value       = azurerm_storage_container.main.name
}

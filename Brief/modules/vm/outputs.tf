# Outputs du module VM

output "vm_public_ip" {
  description = "Adresse IP publique de la VM"
  value       = azurerm_public_ip.main.ip_address
}

output "vm_private_ip" {
  description = "Adresse IP privée de la VM"
  value       = azurerm_network_interface.main.private_ip_address
}

output "vm_name" {
  description = "Nom de la machine virtuelle"
  value       = azurerm_linux_virtual_machine.main.name
}

output "vm_id" {
  description = "ID de la machine virtuelle"
  value       = azurerm_linux_virtual_machine.main.id
}

output "vm_fqdn" {
  description = "FQDN de la VM (si disponible)"
  value       = azurerm_public_ip.main.fqdn
}

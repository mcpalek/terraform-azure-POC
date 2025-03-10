output "jumpbox_public_ip_fqdn" {
  description = "FQDN of the jumpbox public IP"
  value       = azurerm_public_ip.jumpbox.fqdn
}

output "jumpbox_public_ip" {
  description = "Public IP address of the jumpbox"
  value       = azurerm_public_ip.jumpbox.ip_address
}

output "jumpbox_private_ip" {
  description = "Private IP address of the jumpbox"
  value       = azurerm_network_interface.jumpbox.private_ip_address
}
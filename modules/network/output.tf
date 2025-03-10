output "vmss_subnet_id" {
  description = "ID of the VMSS subnet"
  value       = azurerm_subnet.vmss.id
}

output "sql_subnet_id" {
  description = "ID of the SQL subnet"
  value       = azurerm_subnet.sql.id
}

output "pe_subnet_id" {
  description = "ID of the Private Endpoint subnet"
  value       = azurerm_subnet.pe.id
}

output "vnet_id" {
  description = "ID of the Virtual Network"
  value       = azurerm_virtual_network.vmss.id
}

output "nsg_id" {
  description = "ID of the Network Security Group"
  value       = azurerm_network_security_group.vmss.id
}
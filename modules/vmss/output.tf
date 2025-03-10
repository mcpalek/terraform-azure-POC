output "vmss_instance_count" {
  description = "Number of VMSS instances"
  value       = azurerm_linux_virtual_machine_scale_set.vmss.instances
}

output "vmss_network_interface" {
  description = "Network interface configuration of VMSS"
  value       = azurerm_linux_virtual_machine_scale_set.vmss.network_interface
}

output "vmss_id" {
  description = "ID of the VMSS"
  value       = azurerm_linux_virtual_machine_scale_set.vmss.id
}
output "public_ip_fqdn" {
  description = "FQDN of the load balancer public IP"
  value       = azurerm_public_ip.vmss.fqdn
}

output "public_ip_address" {
  description = "Public IP address of the load balancer"
  value       = azurerm_public_ip.vmss.ip_address
}

output "backend_address_pool_id" {
  description = "ID of the backend address pool"
  value       = azurerm_lb_backend_address_pool.bpepool.id
}

output "load_balancer_id" {
  description = "ID of the load balancer"
  value       = azurerm_lb.vmss.id
}
output "vmss_public_ip_fqdn" {
  value = module.loadbalancer.public_ip_fqdn
}

output "vmss_lb_ip_address" {
  value = module.loadbalancer.public_ip_address
}

output "jumpbox_public_ip_fqdn" {
  value = module.bastion.jumpbox_public_ip_fqdn
}

output "jumpbox_public_ip" {
  value = module.bastion.jumpbox_public_ip
}

output "sqlconnection_info" {
  description = "SQL Server connection information"
  value = {
    server_name    = module.sqlserver.sql_server_name
    server_fqdn    = module.sqlserver.server_fqdn
    private_ip     = module.sqlserver.private_endpoint_ip
    database_name  = module.sqlserver.database_name
  }
  sensitive = true
}
# output "vmss_public_ip_fqdn" {
#   value = azurerm_public_ip.vmss.fqdn
# }

# output "vmss_lb_ip_address" {
#   value = azurerm_public_ip.vmss.ip_address
# }

# output "jumpbox_public_ip_fqdn" {
#   value = azurerm_public_ip.jumpbox.fqdn
# }

# output "jumpbox_public_ip" {
#   value = azurerm_public_ip.jumpbox.ip_address
# }

# output "vmss_instance_count" {
#   description = "Number of VMSS instances"
#   value       = azurerm_linux_virtual_machine_scale_set.vmss.instances
# }

# output "vmss_network_interface" {
#   description = "Network interface configuration of VMSS"
#   value       = azurerm_linux_virtual_machine_scale_set.vmss.network_interface
# }

# output "load_balancer_public_ip" {
#   description = "Public IP address of the load balancer"
#   value       = azurerm_public_ip.vmss.ip_address
# }

# output "load_balancer_fqdn" {
#   description = "FQDN of the load balancer"
#   value       = azurerm_public_ip.vmss.fqdn
# }

# output "sql_server_private_endpoint" {
#   description = "Private endpoint details for SQL Server"
#   value       = azurerm_private_endpoint.sql.private_service_connection[0].private_ip_address
#   sensitive   = true
# }

# output "sql_server_name" {
#   description = "The name of the SQL server"
#   value       = azurerm_mssql_server.sql.name
# }

# output "sql_connection_info" {
#   description = "SQL Server connection information"
#   value = {
#     server_name     = azurerm_mssql_server.sql.fully_qualified_domain_name
#     private_ip      = azurerm_private_endpoint.sql.private_service_connection[0].private_ip_address
#     admin_username  = azurerm_mssql_server.sql.administrator_login
#     database_name   = azurerm_mssql_database.db.name
#   }
#   sensitive = true
# }

# output "sql_test_commands" {
#   description = "Commands to test SQL connection from VMSS"
#   value = {
#     connection_test = <<EOF
# # Set environment variables
# export SQLCMDSERVER="${azurerm_mssql_server.sql.name}.database.windows.net"
# export SQLCMDUSER="${var.sql_admin_username}"
# export SQLCMDPASSWORD="${var.sql_admin_password}"
# export SQLCMDTRUST=YES

# # Test SQL connection
# sqlcmd -S "$SQLCMDSERVER,1433" \
#   -U $SQLCMDUSER \
#   -P $SQLCMDPASSWORD \
#   -Q "SELECT @@VERSION" \
#   -C -N

# # Check database connectivity
# sqlcmd -S "$SQLCMDSERVER,1433" \
#   -U $SQLCMDUSER \
#   -P $SQLCMDPASSWORD \
#   -Q "SELECT name FROM sys.databases"
# EOF
#   }
#   sensitive = true
# }

# output "sql_debug_info" {
#   description = "SQL Server debugging information"
#   value = {
#     server_name     = azurerm_mssql_server.sql.name
#     server_fqdn     = azurerm_mssql_server.sql.fully_qualified_domain_name
#     private_ip      = azurerm_private_endpoint.sql.private_service_connection[0].private_ip_address
#     database_name   = azurerm_mssql_database.db.name
#     admin_username  = azurerm_mssql_server.sql.administrator_login
#     pe_subnet       = azurerm_subnet.pe.address_prefixes[0]
#     vmss_subnet     = azurerm_subnet.vmss.address_prefixes[0]
#   }
#   sensitive = true
# }
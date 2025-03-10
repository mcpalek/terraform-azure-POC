output "sql_server_name" {
  description = "The name of the SQL server"
  value       = azurerm_mssql_server.sql.name
}

output "server_fqdn" {
  description = "Fully qualified domain name of the SQL server"
  value       = azurerm_mssql_server.sql.fully_qualified_domain_name
}

output "database_name" {
  description = "Name of the SQL database"
  value       = azurerm_mssql_database.db.name
}

output "private_endpoint_ip" {
  description = "Private endpoint IP address"
  value       = azurerm_private_endpoint.sql.private_service_connection[0].private_ip_address
  sensitive   = true
}
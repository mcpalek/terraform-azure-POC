resource "azurerm_mssql_server" "sql" {
  name                         = "sql-server-${var.unique_identifier}"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password

  public_network_access_enabled = false
  minimum_tls_version          = "1.2"

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags

  timeouts {
    create = "2h"
    delete = "2h"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_mssql_database" "db" {
  name           = "mydb"
  server_id      = azurerm_mssql_server.sql.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  sku_name       = "Basic"
  
  tags = var.tags
}

resource "azurerm_private_endpoint" "sql" {
  name                = "sql-private-endpoint"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.pe_subnet_id

  private_service_connection {
    name                           = "sql-private-connection"
    private_connection_resource_id = azurerm_mssql_server.sql.id
    is_manual_connection          = false
    subresource_names             = ["sqlServer"]
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.sqldb.id]
  }

  tags = var.tags
}

resource "azurerm_private_dns_zone" "sqldb" {
  name                = "privatelink.database.windows.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "sqldb" {
  name                  = "sqldb-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.sqldb.name
  virtual_network_id    = var.vnet_id
}
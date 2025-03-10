provider "azurerm" {
  features {
     
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
   subscription_id = var.subscription_id
   client_id       = var.client_id
   client_secret   = var.client_secret
}

resource "azurerm_resource_group" "vmss" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "random_string" "fqdn" {
  length  = 6
  special = false
  upper   = false
  numeric = false
}

module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.vmss.name
  location            = var.location
  tags                = var.tags
}

module "loadbalancer" {
  source              = "./modules/loadbalancer"
  resource_group_name = azurerm_resource_group.vmss.name
  location            = var.location
  tags                = var.tags
  domain_name_label   = random_string.fqdn.result

  depends_on = [module.network]
}

module "sqlserver" {
  source              = "./modules/sqlserver"
  resource_group_name = azurerm_resource_group.vmss.name
  location            = var.location
  tags                = var.tags
  sql_admin_username  = var.sql_admin_username
  sql_admin_password  = var.sql_admin_password
  unique_identifier   = random_string.fqdn.result
  pe_subnet_id        = module.network.pe_subnet_id
  vnet_id             = module.network.vnet_id

  depends_on = [module.network]
}

module "vmss" {
  source                  = "./modules/vmss"
  resource_group_name     = azurerm_resource_group.vmss.name
  location                = var.location
  tags                    = var.tags
  instance_count          = var.instance_count
  admin_user             = var.admin_user
  admin_password         = var.admin_password
  subnet_id              = module.network.vmss_subnet_id
  backend_address_pool_id = module.loadbalancer.backend_address_pool_id
  custom_data            = base64encode(local.custom_data)  # Encode here only

  depends_on = [module.network, module.loadbalancer]
}

module "bastion" {
  source              = "./modules/bastion"
  resource_group_name = azurerm_resource_group.vmss.name
  location            = var.location
  tags                = var.tags
  admin_user         = var.admin_user
  admin_password     = var.admin_password
  subnet_id          = module.network.vmss_subnet_id
  domain_name_label   = "${random_string.fqdn.result}-ssh"

  depends_on = [module.network]
}

locals {
  custom_data = <<-EOF
    #!/bin/bash
    
    # Install nginx
    apt-get update && apt-get install -y nginx
    systemctl start nginx
    systemctl enable nginx

    # Install SQL Command Line Tools
    mkdir -p /etc/apt/keyrings
    curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg
    echo "deb [arch=amd64,armhf,arm64 signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/ubuntu/22.04/prod jammy main" \
    | tee /etc/apt/sources.list.d/microsoft-prod.list
    apt-get update
    ACCEPT_EULA=Y apt-get install -y mssql-tools18 unixodbc-dev

    # Add SQL Tools to PATH and set trust certificate
    echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> /etc/bash.bashrc
    echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> /etc/profile
    echo 'export SQLCMDTRUST=YES' >> /etc/bash.bashrc
    echo 'export SQLCMDTRUST=YES' >> /etc/profile

    # Create odbc.ini with SSL configuration
    cat > /etc/odbc.ini << 'EOL'
    [ODBC Driver 18 for SQL Server]
    Driver = ODBC Driver 18 for SQL Server
    TrustServerCertificate = Yes
    EOL
  EOF
}



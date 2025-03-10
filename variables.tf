variable "resource_group_name" {
  description = "Name of the resource group in which the resources will be created"
  default     = "myResourceGroup"
}

variable "location" {
  description = "Location where resources will be created"
  default     = "eastus"
}

variable "tags" {
  description = "Map of the tags to use for the resources that are deployed"
  type        = map(string)
  default = {
    environment = "codelab"
  }
}

variable "instance_count" {
  description = "Number of instances to deploy in the VM scale set"
  default     = 2
}

variable "admin_user" {
  description = "User name to use as the admin account on the VMs"
  default     = "azureuser"
}

variable "admin_password" {
  description = "Default password for admin account"
  default     = "Test@123"
  sensitive   = true
}

variable "sql_admin_username" {
  description = "The administrator username for the SQL server"
  type        = string
  default     = "sqladmin"
}

variable "sql_admin_password" {
  description = "The administrator password for the SQL server"
  type        = string
  sensitive   = true
  default     = "SQL@dmin123!"  # For testing only, use a secure password in production
}
variable "client_id" {
  description = "The client ID for the service principal"
  type        = string
}

variable "client_secret" {
  description = "The client secret for the service principal"
  type        = string
}

variable "subscription_id" {
  description = "The subscription ID for Azure"
  type        = string
}
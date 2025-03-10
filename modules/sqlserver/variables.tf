variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure location where resources will be created"
  type        = string
}

variable "tags" {
  description = "Map of tags to use for resources"
  type        = map(string)
}

variable "sql_admin_username" {
  description = "The administrator username for the SQL server"
  type        = string
}

variable "sql_admin_password" {
  description = "The administrator password for the SQL server"
  type        = string
  sensitive   = true
}

variable "unique_identifier" {
  description = "Unique identifier for SQL server name"
  type        = string
}

variable "pe_subnet_id" {
  description = "Subnet ID for private endpoint"
  type        = string
}

variable "vnet_id" {
  description = "Virtual Network ID"
  type        = string
}
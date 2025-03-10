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

variable "admin_user" {
  description = "User name to use as the admin account on the VM"
  type        = string
}

variable "admin_password" {
  description = "Password for admin account"
  type        = string
  sensitive   = true
}

variable "subnet_id" {
  description = "Subnet ID for bastion host"
  type        = string
}

variable "domain_name_label" {
  description = "DNS label for the public IP"
  type        = string
}
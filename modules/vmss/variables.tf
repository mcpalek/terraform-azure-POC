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

variable "instance_count" {
  description = "Number of instances to deploy in the VM scale set"
  type        = number
  default     = 2
}

variable "admin_user" {
  description = "User name to use as the admin account on the VMs"
  type        = string
}

variable "admin_password" {
  description = "Password for admin account"
  type        = string
  sensitive   = true
}

variable "subnet_id" {
  description = "Subnet ID for VMSS"
  type        = string
}

variable "backend_address_pool_id" {
  description = "Load Balancer backend address pool ID"
  type        = string
}

variable "custom_data" {
  description = "Custom data script for VM initialization"
  type        = string
}
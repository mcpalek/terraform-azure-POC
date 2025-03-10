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

variable "domain_name_label" {
  description = "DNS label for the public IP"
  type        = string
}

variable "application_port" {
  description = "Port that you want to expose to the external load balancer"
  type        = number
  default     = 80
}
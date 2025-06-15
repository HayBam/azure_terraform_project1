variable "subscription_id" {
  description = "This is the default subscription where the resources will be created"
}

variable "resource_group_name" {
  description = "name of resource group"
  type = string
  default = "shola-project"
}

variable "location" {
  description = "azure region"
  type = string
  default = "Canada Central"
}
variable "vnet-ip-address-space" {
  description = "vnet address space"
}

variable "subnet-ip-address-space" {
  description = "subnet address space"
}

variable "admin_username" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "azureadmin"
}

variable "admin_password" {
  type        = string
  description = "Admin password for the new VM."
  sensitive = true
}
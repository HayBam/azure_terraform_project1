variable "subscription_id" {
  description = "This is the default subscription where the resources will be created"
}

variable "vnet-ip-address-space" {
  description = "vnet address space"
}

variable "subnet-ip-address-space" {
  description = "subnet address space"
}

variable "username" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "azureadmin"
}
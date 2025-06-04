resource "azurerm_resource_group" "shola_project" {
  name = "shola_project"
  location = "Canada Central"
}

resource "azurerm_virtual_network" "shola-vnet"{
    name = "shola-vnet"
    address_space = var.vnet-ip-address-space
    location = azurerm_resource_group.shola_project.location
    resource_group_name = azurerm_resource_group.shola_project.name
}

resource "azurerm_subnet" "subnet-ip-address-space" {
  name = "subnet-ip-address-space"
  resource_group_name = azurerm_virtual_network.shola-vnet.name
  virtual_network_name = azurerm_virtual_network.shola-vnet.name
  address_prefixes = var.subnet-ip-address-space
}
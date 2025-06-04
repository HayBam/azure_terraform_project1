resource "azurerm_subnet" "subnet-ip-address-space" {
  name = "shola-subnet"
  address_space = var.subnet-ip-address-space
  location = azurerm_resource_group.shola_project.location
  resource_group_name = azurerm_resource_group.shola_project.name
}
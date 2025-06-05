resource "azurerm_virtual_machine" "test-vm" {
    name = "test-vm"
    address_space = var.subnet-ip-address-space
    location = azurerm_resource_group.shola_project.location
    resource_group_name = azurerm_resource_group.shola_project.name
}
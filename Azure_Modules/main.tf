resource "azurerm_virtual_machine" "test-vm"{
    name = "test-vm"
    location = azurerm_resource_group.shola_project.location
    resource_group_name = azurerm_resource_group.shola_project.name
    network_interface_ids = [azurerm_network_interface.main.id]
    vm_size = "Standard_DS1_v2"
}
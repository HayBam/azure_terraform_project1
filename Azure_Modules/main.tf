resource "azurerm_virtual_machine" "vm-test" {
  name = "vm-test"
  location = azurerm_resource_group.shola_project.location
  resource_group_name = azurerm_resource_group.shola_project.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size = "Standard_DS1_v2"

  storage_os_disk {
    name = "myOsDisk"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  storage_image_reference {
    publisher = "Canonical"
    offer = "0001-com-ubuntu-server-jammy"
    sku = "22_04-lts"
    version = "latest"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}

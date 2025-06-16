resource "azurerm_virtual_machine" "vm-test" {
  name = "vm-test"
  location = azurerm_resource_group.shola-project.location
  resource_group_name = azurerm_resource_group.shola-project.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size = "Standard_A1_v2"

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
    computer_name  = "shola-ubuntu-vm"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/azureadmin/.ssh/authorized_keys"
      key_data = tls_private_key.ssh_key.public_key_openssh
    }
  }
  tags = {
    environment = "shola-vm-test"
  }
}

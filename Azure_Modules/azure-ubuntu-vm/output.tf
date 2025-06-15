output "vm_public_ip" {
  description = "Public IP of the Ubuntu VM"
  value = azurerm_public_ip.public-ip.id
}

output "username" {
  description = "Username of the vm"
  value = var.admin_username
}
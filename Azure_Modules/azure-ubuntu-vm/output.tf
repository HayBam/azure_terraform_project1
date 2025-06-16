output "vm_public_ip" {
  description = "Public IP of the Ubuntu VM"
  value = azurerm_public_ip.public-ip.ip_address
}

output "private_key_path" {
  description = "Private key information"
  value = local_file.private_key_pem.filename
}
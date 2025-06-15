provider "azurerm" {
    subscription_id = "725ceff0-b0b6-42cb-aa98-880f156d58e7"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

module "ubuntu_vm" {
  source = "./azure-ubuntu-vm"
  subscription_id = "725ceff0-b0b6-42cb-aa98-880f156d58e7"
  vnet-ip-address-space = ["10.0.0.0/16"]
  subnet-ip-address-space= ["10.0.1.0/24"]
  resource_group_name = "shola-project"
  location = "Canada Central"
  admin_username = "azureadmin"
  admin_password = "SecurePAssword123!"
}

output "vm_public_ip" {
  description = "Public IP of the Ubuntu VM"
  value = module.ubuntu_vm.vm_public_ip
}

# Azure Ubuntu VM Deployment with Terraform

This Terraform project deploys an Ubuntu VM in Azure with networking components including:
- Virtual Network (VNet)
- Subnet
- Network Security Group (NSG) with SSH access
- Route Table
- Public IP Address

## Prerequisites

1. **Azure Account**: Active Azure subscription
2. **Terraform**: v1.0+ installed
3. **Azure CLI**: Installed and logged in (`az login`)
4. **Permissions**: Contributor role on the target subscription

## Deployment Steps

### 1. Clone the Repository
```bash
git clone https://github.com/HayBam/azure_terraform_project1/Azure_Modules/azure-ubuntu-vm
cd azure-terraform-vm

### Create `main.tf` Configuration
```hcl
# Configure Azure provider
provider "azurerm" {
  features {}
}

# Main module configuration
module "ubuntu_vm" {
  source = "./modules/azure-ubuntu-vm"  # Path to your module

  # Required parameters
  subscription_id         = #subscription_id
  resource_group_name     = #resource_group_name
  location                = #location
  admin_username          = #admin_username
  admin_password          = #admin_password
  vnet_ip_address_space   = #["x.X.X.X/X"]
  subnet_ip_address_space = #["x.X.X.X/X"]

### Connect to the created VM
connect to the created vm using the below command

ssh -i azure-ubuntu-vm/id_rsa azureadmin@<public_ip>

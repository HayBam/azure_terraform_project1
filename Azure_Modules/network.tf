resource "azurerm_resource_group" "shola_project" {
  name = "shola_project"
  location = "eastus"
}

resource "azurerm_virtual_network" "shola-vnet"{
    name = "shola-vnet"
    address_space = var.vnet-ip-address-space
    location = azurerm_resource_group.shola_project.location
    resource_group_name = azurerm_resource_group.shola_project.name
}

resource "azurerm_subnet" "subnet-ip-address-space" {
  name = "subnet-ip-address-space"
  resource_group_name = azurerm_resource_group.shola_project.name
  virtual_network_name = azurerm_virtual_network.shola-vnet.name
  address_prefixes = var.subnet-ip-address-space
}

resource "azurerm_public_ip" "public-ip" {
  name                = "public-ip"
  location            = azurerm_resource_group.shola_project.location
  resource_group_name = azurerm_resource_group.shola_project.name
  allocation_method   = "Static"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg"
  location            = azurerm_resource_group.shola_project.location
  resource_group_name = azurerm_resource_group.shola_project.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}


resource "azurerm_network_interface" "main" {
  name                = "main-nic"
  location            = azurerm_resource_group.shola_project.location
  resource_group_name = azurerm_resource_group.shola_project.name

  ip_configuration {
    name                          = "main-nic-config"
    subnet_id                     = azurerm_subnet.subnet-ip-address-space.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public-ip.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "nsg-association" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
resource "azurerm_resource_group" "shola-project" {
  name = "shola-project"
  location = "Canada Central"
}

resource "azurerm_virtual_network" "shola-vnet"{
    name = "shola-vnet"
    address_space = var.vnet-ip-address-space
    location = azurerm_resource_group.shola-project.location
    resource_group_name = azurerm_resource_group.shola-project.name
}

resource "azurerm_subnet" "subnet-ip-address-space" {
  name = "subnet-ip-address-space"
  resource_group_name = azurerm_resource_group.shola-project.name
  virtual_network_name = azurerm_virtual_network.shola-vnet.name
  address_prefixes = var.subnet-ip-address-space
}

resource "azurerm_public_ip" "public-ip" {
  name                = "public-ip"
  location            = azurerm_resource_group.shola-project.location
  resource_group_name = azurerm_resource_group.shola-project.name
  allocation_method   = "Static"
}

resource "azurerm_route_table" "shola-route-table" {
  name                = "acceptanceTestRouteTable1"
  location            = azurerm_resource_group.shola-project.location
  resource_group_name = azurerm_resource_group.shola-project.name
}

resource "azurerm_route" "shola-rt" {
  name                = "internet-route"
  resource_group_name = azurerm_resource_group.shola-project.name
  route_table_name    = azurerm_route_table.shola-route-table.name
  address_prefix      = "0.0.0.0/0"
  next_hop_type       = "Internet"
}

resource "azurerm_subnet_route_table_association" "shola-route-table-association" {
  subnet_id = azurerm_subnet.subnet-ip-address-space.id 
  route_table_id = azurerm_route_table.shola-route-table.id
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg"
  location            = azurerm_resource_group.shola-project.location
  resource_group_name = azurerm_resource_group.shola-project.name

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
  location            = azurerm_resource_group.shola-project.location
  resource_group_name = azurerm_resource_group.shola-project.name

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
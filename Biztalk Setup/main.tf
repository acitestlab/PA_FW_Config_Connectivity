provider "azurerm" {
  features {}
  subscription_id = var.biztalk_subscription_id
}

resource "azurerm_resource_group" "biztalk_rg" {
  name     = "BizTalkRG"
  location = var.biztalk_location
}

resource "azurerm_virtual_network" "biztalk_vnet" {
  name                = "BizTalkVNet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.biztalk_rg.location
  resource_group_name = azurerm_resource_group.biztalk_rg.name
}

resource "azurerm_subnet" "biztalk_subnet" {
  name                 = "BizTalkSubnet"
  resource_group_name  = azurerm_resource_group.biztalk_rg.name
  virtual_network_name = azurerm_virtual_network.biztalk_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "biztalk_nsg" {
  name                = "BizTalkNSG"
  location            = azurerm_resource_group.biztalk_rg.location
  resource_group_name = azurerm_resource_group.biztalk_rg.name

  security_rule {
    name                       = "AllowRDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowICMP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Icmp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowSQL"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowLDAP"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowFTP"
    priority                   = 140
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "21"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowSMTP"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "25"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_public_ip" "biztalk_public_ip" {
  name                = "BizTalk-PublicIP"
  location            = azurerm_resource_group.biztalk_rg.location
  resource_group_name = azurerm_resource_group.biztalk_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "biztalk_nic_dc" {
  name                = "nic-dc"
  location            = azurerm_resource_group.biztalk_rg.location
  resource_group_name = azurerm_resource_group.biztalk_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.biztalk_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.4"
    public_ip_address_id          = azurerm_public_ip.biztalk_public_ip.id
  }
}

resource "azurerm_network_interface" "biztalk_nic_sql" {
  name                = "nic-sql"
  location            = azurerm_resource_group.biztalk_rg.location
  resource_group_name = azurerm_resource_group.biztalk_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.biztalk_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.5"
  }
}

resource "azurerm_network_interface" "biztalk_nic_app" {
  name                = "nic-biztalk"
  location            = azurerm_resource_group.biztalk_rg.location
  resource_group_name = azurerm_resource_group.biztalk_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.biztalk_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.6"
  }
}

resource "azurerm_network_interface_security_group_association" "biztalk_nic_dc_assoc" {
  network_interface_id      = azurerm_network_interface.biztalk_nic_dc.id
  network_security_group_id = azurerm_network_security_group.biztalk_nsg.id
}

resource "azurerm_network_interface_security_group_association" "biztalk_nic_sql_assoc" {
  network_interface_id      = azurerm_network_interface.biztalk_nic_sql.id
  network_security_group_id = azurerm_network_security_group.biztalk_nsg.id
}

resource "azurerm_network_interface_security_group_association" "biztalk_nic_app_assoc" {
  network_interface_id      = azurerm_network_interface.biztalk_nic_app.id
  network_security_group_id = azurerm_network_security_group.biztalk_nsg.id
}

resource "azurerm_windows_virtual_machine" "biztalk_dc" {
  name                = "BizTalkDC"
  resource_group_name = azurerm_resource_group.biztalk_rg.name
  location            = azurerm_resource_group.biztalk_rg.location
  size                = "Standard_B2ms"
  admin_username      = var.biztalk_admin_username
  admin_password      = var.biztalk_admin_password
  network_interface_ids = [azurerm_network_interface.biztalk_nic_dc.id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_windows_virtual_machine" "biztalk_sql" {
  name                = "BizTalkSQL"
  resource_group_name = azurerm_resource_group.biztalk_rg.name
  location            = azurerm_resource_group.biztalk_rg.location
  size                = "Standard_B4ms"
  admin_username      = var.biztalk_admin_username
  admin_password      = var.biztalk_admin_password
  network_interface_ids = [azurerm_network_interface.biztalk_nic_sql.id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftSQLServer"
    offer     = "SQL2019-WS2019"
    sku       = "Enterprise"
    version   = "latest"
  }
}

resource "azurerm_windows_virtual_machine" "biztalk_app" {
  name                = "BizTalkApp"
  resource_group_name = azurerm_resource_group.biztalk_rg.name
  location            = azurerm_resource_group.biztalk_rg.location
  size                = "Standard_B4ms"
  admin_username      = var.biztalk_admin_username
  admin_password      = var.biztalk_admin_password
  network_interface_ids = [azurerm_network_interface.biztalk_nic_app.id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftBizTalkServer"
    offer     = "BizTalk-Server"
    sku       = "2020-Enterprise"
    version   = "latest"
  }
}

output "biztalk_public_ip" {
  value = azurerm_public_ip.biztalk_public_ip.ip_address
}
resource "azurerm_network_interface" "test" {
  name                = "${var.application_type}-${var.resource_type}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${var.public_ip_address_id}"
  }
}

resource "azurerm_linux_virtual_machine" "test" {
  name                = "${var.application_type}-${var.resource_type}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"
  size                = "Standard_B1s"
  admin_username      = "${var.admin_username}"
  network_interface_ids = [
    azurerm_network_interface.test.id,
  ]
  admin_ssh_key {
    username   = "adminuser"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDROqEz5ZuxZi6Xd/p5678hgts9hvta2bsJhF6wfCryk0wBXV76wGzcE9f+udY/RNEcSPgiPqpdepLj8fmFRLrQWvO1G3c3r9Zyzqb/Ac0h7YcMI8QkgzsyEBVGvrpk+49uKdz04Qac/XkoMUmjM6i2U3l0mBTzsJfJ39O46f42XLrrku8Oq84lVFCoY/OtGtY41n9eaQ4JBYB6Sx3XIkJgGnqSZbhhFCvqaEZrD0CIn6T+7+DLT//+99ke89g7W+1/osLjnHuMcvzGrAaODv8gCcm8Qrq30i//up1XII1n7PLMLV+oBxtI6P/7Vpu303Gn6J8CUrEARdeBdH7DvqrpoII7bvJjH786NPPOqp8dxX4kh7fN3oBF3EXUwrdnnCLmEqmIKRsFMt74pyTKcdw+QKkZqMnVOocapOMUEjK4JVRMwuZZcQNS26Btc3tDXAMuW7g5lf/yoWsFqzu/dPlvtaH7OFKn+NlTWpvXMaKZy1eg/dEpIDvum4KPUT3xYEs= devopsagent@myLinuxVM"
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  tags = "${var.tags}"
}

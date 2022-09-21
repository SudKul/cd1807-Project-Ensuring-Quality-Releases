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
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDNAA8UYYtNaf1MZdLVxebyZa4mcmqCQHqf/UD3vFek6aT449lC+4LMfKALnD+suG2sgEsgjbPEZoppYiHBYGJhoRUQvHz2G1J39luUDkz/JwGSXiULSPdYQ77g7nDN19I0OeQNxNiCtU/kGC+8FQ8Xb44TrxeeY9h9OYctzPvqNbq16Cf395iy0hx8zFBTqbeBIifHiEGsPtAW8xFKS7LeSd0JZKPlIwRMoVLrg8gdH8eiiQ9+E4D1/1cMxftkBTiFJTYJB1ifUmuejU3CRlpI3vGc/+puI5G5fMpOUSBlp2OyhQlCVWNkMojbhlluYUEYqEJf/96rmtmNNUbP6Loch0nMvehKpLHUD6l1qlWso2wH2Nw7YWR53rVvGrTQyRqFB98mLYxN4LAY15UPfL6ZAGRltq6xljkTfxtq5k7njhfnG4JjEtGyl47/h18P9yhurD+mc8I3Ou+996Tqt+GIovQvxqTFg+kjqL1psl31WZ9rqAMmSAIep0hra35dEu8= udacity@MacBook-Pro"
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

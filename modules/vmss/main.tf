resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                            = "vmscaleset"
  location                        = var.location
  resource_group_name            = var.resource_group_name
  sku                            = "Standard_DS1_v2"
  instances                      = var.instance_count
  admin_username                 = var.admin_user
  admin_password                 = var.admin_password
  disable_password_authentication = false
  upgrade_mode                   = "Manual"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  custom_data = var.custom_data

  network_interface {
    name    = "vmssnic"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.subnet_id
      load_balancer_backend_address_pool_ids = [var.backend_address_pool_id]
    }
  }

  tags = var.tags
}
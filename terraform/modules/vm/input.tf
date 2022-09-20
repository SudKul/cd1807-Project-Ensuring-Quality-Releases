# Resource Group/Location
variable "location" {}
variable "resource_group" {}

variable "application_type" {}
variable "resource_type" {}

# VM
variable "vm_size" {}
variable "subnet_id" {}
variable "admin_username" {}
variable public_ip_address_id {}

# Tags
variable "tags" {
  type = map(string)
}


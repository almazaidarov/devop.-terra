resource "random_password" "password" {
  length           = 16
  special          = false
  override_special = "_%@"
}



resource "azuread_group" "example" {
  display_name     = "example"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
}
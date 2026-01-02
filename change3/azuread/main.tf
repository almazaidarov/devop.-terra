resource "random_password" "password" {
  length           = 16
  special          = false
  override_special = "_%@"
}

resource "azuread_user" "example" {
  user_principal_name = "jdoe@hashicorp.com"
  display_name        = "J. Doe"
  given_name         = "J."
  surname            = "Doe"
  mail_nickname       = "jdoe"
  password            = "Secret1234!"
    force_password_change = false
  company_name       = "Aidaroff Inc"
  country           = "US"
  city              = "Seattle" 
  postal_code     = "98101"
  state            = "WA"   

}



resource "azuread_group" "example" {
  display_name     = "example"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
}
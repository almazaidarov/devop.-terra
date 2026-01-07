data "google_billing_account" "acct" {
  display_name = "My Billing Account"
  open         = true
}

resource "random_password" "password" {
  length = 16
  special = true
  override_special = "_%@"
}

resource "google_project" "my_project" {
  name       = "1st-project"
  project_id = random_password.password.result
  billing_account = data.google_billing_account.acct.id
}

 resource "null_resource" "set-project" {
   triggers = {
     always_run = timestamp()
   }
 }

 
 
 resource "null_resource" "set project" {
   depends_on = [google_project.my_project]
 
   provisioner "local-exec" {
     command = "gcloud config unset project && gcloud config set project ${google_project.my_project.project_id}"
   }
 }
data "google_billing_account" "acct" {
  display_name = "My Billing Account"
  open         = true
}


resource "google_project" "my_project" {
  name             = "My Terraform Project"
  project_id       = "my-terraform-project-123-almaz"
  billing_account  = data.google_billing_account.acct.id
}

resource "null_resource" "set_project" {
  depends_on = [google_project.my_project]

  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "gcloud config unset project && gcloud config set project ${google_project.my_project.project_id}"
  }
}

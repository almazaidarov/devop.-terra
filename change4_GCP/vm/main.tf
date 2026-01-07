data "google_billing_account" "acct" {
  display_name = "My Billing Account"
  open         = true
}




resource "google_project" "my_project" {
  project_id      = "my-terraform-project-123-almaz"
  name            = "My Terraform Project"
  billing_account = data.google_billing_account.acct.id
}


resource "google_compute_instance" "default" {
  name         = "my-instance"
  machine_type = "n2-standard-2"
  zone         = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

}
resource "google_compute_project_metadata" "ssh_keys" {
  metadata = { ssh-keys = "centr:${file(var.public_key_centr)}\n Centr:${file(var.public_key_Centr)}"
  }
}

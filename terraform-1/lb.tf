resource "google_compute_instance_template" "instance_template" {
  name_prefix  = "instance-template-"
  machine_type = "f1-micro"
  region       = "europe-west1"


  // boot disk
  disk {
      image = "${var.disk_image}"
  }
}

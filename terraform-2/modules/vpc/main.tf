resource "google_compute_firewall" "firewall_ssh" {
  name = "default-allow-ssh"
  #network = google_compute_network.default.name
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = var.source_ranges
}
resource "google_compute_network" "default" {
  name = "test-network"
}

provider "google" {
  # Версия провайдера
  version = "3.5.0"

  # ID проекта
  #  project = "api-project-739750082124"
  project = var.project
  region  = var.region
  #  region = "europe-west1"
}

module "app" {
  source          = "../modules/app"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  app_disk_image  = "${var.app_disk_image}"
}
module "db" {
  source          = "../modules/db"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  db_disk_image   = "${var.db_disk_image}"
}
module "vpc" {
  source = "../modules/vpc"
  # ограниченый список ip для доступа к инстансу
  source_ranges = ["0.0.0.0/0"]
}

#module "ssh_keys" {
#  source          = "../modules/ssh"
#  ssh-keys = "centr:${file(var.public_key_centr)}\n Centr:${file(var.public_key_Centr)}"
#  ssh-keys        = "centr:${file(var.public_key_centr)}
#}

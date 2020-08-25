provider "google" {
  # Версия провайдера
  version = "2.5.0"

  # ID проекта
  project = "${var.project}"
  region  = "${var.region}"
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
  source_ranges = ["213.176.241.62/32"]
}

#module "ssh_keys" {
#  source          = "../modules/ssh"
#  ssh-keys = "centr:${file(var.public_key_centr)}\n Centr:${file(var.public_key_Centr)}"
#  ssh-keys        = "centr:${file(var.public_key_centr)}
#}

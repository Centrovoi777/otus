 variable public_key_path {
  # Описание переменной
   description = "~/.ssh/id_rsa.pub"
}
 variable zone {
  description = "zone"
  default = "europe-west1-b"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default = "reddit-app-base"
}

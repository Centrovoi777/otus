variable project {
  description = "api-project-739750082124"
}
variable region {
  description = "Region"
  # Значение по умолчанию
  default = "europe-west1"
}
variable zone {
  description = "zone"
  default     = "europe-west1-b"
}
variable public_key_path {
  # Описание переменной
  description = "~/.ssh/id_rsa.pub"
}
variable private_key_path {
  description = "~/.ssh/id_rsa"
}
#variable disk_image {
#  description = "reddit-base"
#}
variable public_key_centr {
  # Описание переменной
  description = "~/.ssh/Centr.pub"
}
variable public_key_Centr {
  # Описание переменной
  description = "~/.ssh/authorized_keys"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}

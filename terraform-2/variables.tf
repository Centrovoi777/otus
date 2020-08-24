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
  default = "europe-west1-b"
}
 variable public_key_path {
  # Описание переменной
   description = "~/.ssh/id_rsa.pub"
}
 variable private_key_path {
   description = "~/.ssh/id_rsa"
}
 variable disk_image {
  description = "reddit-base"
}

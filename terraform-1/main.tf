terraform {
# Версия terraform
required_version = "0.12.28"
}
provider "google" {
# Версия провайдера
version = "2.5.0"
# ID проекта
project = "api-project-739750082124"
region = "europe-west1-b"
}

resource "google_compute_instance" "app" {
name = "reddit-app"
machine_type = "g1-small"
zone = "europe-west1-b"
# определение загрузочного диска
boot_disk {
initialize_params {
image = "reddit-base"
}
}
# определение сетевого интерфейса
network_interface {
# сеть, к которой присоединить данный интерфейс
network = "default"
# использовать ephemeral IP для доступа из Интернет
access_config {}
}
}
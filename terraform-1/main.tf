terraform {
  # Версия terraform
  required_version = "0.13.0"
}

provider "google" {
  # Версия провайдера
  version = "3.5.0"

  # ID проекта
  project = "${var.project}"
  region  = "${var.region}"
}

resource "google_compute_project_metadata" "ssh_keys" {
  metadata = {
    # путь до публичного ключа 
ssh-keys = "centr:${file("~/.ssh/id_rsa.pub")}\n Centr:${file("~/.ssh/authorized_keys")}"
#    ssh-keys = "centr:${file(var.public_key_centr)}\n Centr:${file(var.public_key_Centr)}" 
  }
}

resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  #  zone         = "europe-west1-b"
  tags = ["reddit-app"]

  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }

  # определение сетевого интерфейса
  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"

    # использовать ephemeral IP для доступа из Интернет
    access_config {
    }
  }
  connection {
    type    = "ssh"
    user    = "centr"
    host    = "${google_compute_instance.app.network_interface[0].access_config[0].nat_ip}"
    agent   = false
    timeout = "2m"
    # путь до приватного ключа
    private_key = "${file(var.private_key_path)}"
    #    private_key = file("~/.ssh/id_rsa")
  }
  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}



resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"

  # Название сети, в которой действует правило
  network = "default"

  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  # Каким адресам разрешаем доступ
  source_ranges = ["0.0.0.0/0"]

  # Правило применимо для инстансов с перечисленными тэгами
  target_tags = ["reddit-app"]
}


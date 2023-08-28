resource "yandex_compute_instance" "master" {
  count       = var.masters
  name        = "master${count.index}"
  hostname    = "master${count.index}"
  platform_id = "standard-v3"
  zone        = "ru-central1-b"

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = "${var.instance_image_id}"
	  type     = "network-ssd"
	  size     = "10"
    }
  }

  network_interface {
    subnet_id = "${var.vpc_subnet_id}"
    nat       = true
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: ${var.ssh_credentials.user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ${file(var.ssh_credentials.pub_key)}"
    serial-port-enable = 1
  }
}

resource "yandex_compute_instance" "worker" {
  count       = var.workers
  name        = "worker${count.index}"
  hostname    = "worker${count.index}"
  platform_id = "standard-v3"
  zone        = "ru-central1-b"

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = "${var.instance_image_id}"
	  type     = "network-ssd"
	  size     = "10"
    }
  }

  network_interface {
    subnet_id = "${var.vpc_subnet_id}"
    nat       = true
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: ${var.ssh_credentials.user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ${file(var.ssh_credentials.pub_key)}"
    serial-port-enable = 1
  }
}
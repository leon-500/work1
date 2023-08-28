resource "yandex_compute_instance" "manager" {
  count       = var.managers
  name        = "manager${count.index}"
  hostname    = "manager${count.index}"
  platform_id = "standard-v3"
  zone        = "ru-central1-b"

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8g64rcu9fq5kpfqls0"
	  type     = "network-ssd"
	  size     = "10"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
    nat       = true
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: testadmin\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ${file("./terraform.pub")}"
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
      image_id = "fd8g64rcu9fq5kpfqls0"
	  type     = "network-ssd"
	  size     = "10"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
    nat       = true
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: ${var.ssh_credentials.user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ${file(var.ssh_credentials.pub_key)}"
    serial-port-enable = 1
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network-1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet-1"
  v4_cidr_blocks = ["10.2.0.0/16"]
  zone           = "ru-central1-b"
  network_id     = "${yandex_vpc_network.network-1.id}"
}
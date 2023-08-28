resource "yandex_vpc_network" "network" {
  name = "${var.vpc_network}"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "${var.vpc_subnet}"
  v4_cidr_blocks = "${var.ip_v4}"
  zone           = "${var.vpc_zone}"
  network_id     = "${yandex_vpc_network.network.id}"
  dhcp_options {
    domain_name_servers = "${var.dns_servers}"
  }
}
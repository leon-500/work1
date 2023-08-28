output "vpc_subnet_id" {
  value = yandex_vpc_subnet.subnet.id
}

output "vpc_subnet_dhcp_options" {
  value = yandex_vpc_subnet.subnet.dhcp_options[*]
}
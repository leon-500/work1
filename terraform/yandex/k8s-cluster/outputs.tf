output "external_ip_address_master" {
  value = module.vm.external_ip_address_master
}

output "external_ip_address_worker" {
  value = module.vm.external_ip_address_worker
}

output "internal_ip_address_master" {
  value = module.vm.internal_ip_address_master
}

output "internal_ip_address_worker" {
  value = module.vm.internal_ip_address_worker
}

output "dns_servers_nodes" {
  value = module.vpc.vpc_subnet_dhcp_options
}
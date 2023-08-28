variable "vpc_network" {
  description = "VPC network name"
  type        = string
  default     = "network1"
}

variable "vpc_subnet" {
  description = "VPC subnet name"
  type        = string
  default     = "subnet1"
}

variable "ip_v4" {
  description = "ip v4 range"
  type        = list(string)
  default     = ["10.13.13.0/24"]
}

variable "vpc_zone" {
  description = "VPC zone"
  type        = string
  default     = "ru-central1-b"
}

variable "dns_servers" {
  description = "DNS_servers"
  type        = list(string)
  default     = ["10.13.13.2"]
}
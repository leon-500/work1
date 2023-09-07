variable "masters" {
  description = "Count of master nodes"
  type        = number
  default     = 1
}

variable "workers" {
  description = "Count of worker nodes"
  type        = number
  default     = 2
}

variable "srv" {
  description = "Count of srv"
  type        = number
  default     = 1
}

variable "instance_image_id" {
  description = "Instance image id"
  type        = string
  default     = "fd8de1idq8noos4s3lfb" #ubuntu-2004-lts
}

variable "vpc_subnet_id" {
  description = "VPC subnet network id"
  type        = string
}

variable "ssh_credentials" {
  description = "Credentials for connect to instances"
  type        = object({
    user        = string
    private_key = string
    pub_key     = string
  })
  default     = {
    user        = "testadmin"
    private_key = "./keys/terraform"
    pub_key     = "./keys/terraform.pub"
  }
}

variable "gitlab_tokens" {
  description = "Gitlab-runner tokens"
  type        = object({
    docker_token = string
    k8s_token    = string
  })
  default     = {
    docker_token = "./keys/gitlab-runner_docker.token"
    k8s_token     = "./keys/gitlab-runner_k8s.token"
  }
}

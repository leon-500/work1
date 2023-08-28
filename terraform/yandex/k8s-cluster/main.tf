module "vpc" {
  source        = "./modules/vpc"
}

module "vm" {
  source        = "./modules/vm"
  vpc_subnet_id = module.vpc.vpc_subnet_id
}
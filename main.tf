terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}
provider "google" {
  credentials = file(var.gcp_credentials_file)
  project     = var.gcp_project_id
  region      = var.gcp_region
  zone        = var.gcp_zone
}
module "network" {
  source           = "./modules/network"
  vpc_network_name = "terraform-network2"
  group_manager = module.compute.group_manager
    limiter_ips = ["0.0.0.0/0"]
}
module "compute" {
  source           = "./modules/compute"
#   count            = 3
  vm_instance_name = "web-server"
  vpc_network_name = module.network.vpc_network_name
  
}

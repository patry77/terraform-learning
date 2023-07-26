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
  vpc_network_name = "terraform-network"
}
module "compute" {
  source           = "./modules/compute"
  count            = 3
  vm_instance_name = "web-server-${count.index + 1}"
  vpc_network_name = module.network.vpc_network_name
    depends_on = [module.network]
}

provider "google" {
    credentials = file(var.gcp_credential_file)
    project = var.gcp_project_id
    region = var.gcp_region
    zone = var.gcp_zone
}
module "compute" {
    source = "./modules/compute"
    count = 3
    vm_name = "web-server-${count.index + 1}"
}
module "network" {
    source = "./modules/network"
}


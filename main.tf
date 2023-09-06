module "network" {
  source                     = "./modules/network"
  vpc_network_name           = var.vpc_network_name
  group_manager              = module.compute.group_manager
  limiter_ips                = var.limiter_ips
  subnetwork_name            = var.subnetwork_name
  reserved_ip_name           = var.reserved_ip_name
  cloud_nat_router_name      = var.cloud_nat_router_name
  cloud_nat_config_name      = var.cloud_nat_config_name
  target_http_proxy_name     = var.target_http_proxy_name
  url_map_name               = var.url_map_name
  backend_service_name       = var.backend_service_name
  port_name                  = var.port_name
  health_check_name          = var.health_check_name
  forwarding_rule_name       = var.forwarding_rule_name
  forwarding_rule_port_range = var.forwarding_rule_port_range
  firewall_rule_name         = var.firewall_rule_name
  subnetwork_cidr_range      = var.subnetwork_cidr_range
}

module "compute" {
  source               = "./modules/compute"
  vm_instance_name     = var.vm_instance_name
  vpc_network_id       = module.network.vpc_network_id
  subnetwork_id        = module.network.subnetwork_id
  compute_machine_type = var.compute_machine_type
  group_manager_name   = var.group_manager_name
  port_name            = var.port_name
  group_manager_port   = var.group_manager_port
  group_manager_size   = var.group_manager_size
}

variable "group_manager" {
  description = "Name of instance group manager"
}
variable "reserved_ip_name" {
  description = "Name of the reserved IP address"
}
variable "cloud_nat_router_name" {
  description = "Name of the Cloud NAT router"
}
variable "cloud_nat_config_name" {
  description = "Name of the Cloud NAT config"
}
variable "target_http_proxy_name" {
  description = "Name of the target HTTP proxy"
}
variable "url_map_name" {
  description = "Name of the URL map"
} 
variable "backend_service_name" {
  description = "Name of the backend service"
}
variable "port_name" {
  description = "Name of the port"
  type = string
}
variable "health_check_name" {
  description = "Name of the health check"
  type = string
}
variable "forwarding_rule_name" {
  description = "Name of the forwarding rule"
  type = string
}
variable "forwarding_rule_port_range" {
  description = "Port range of the forwarding rule"
  type = string
}
variable "firewall_rule_name" {
  description = "Name of the firewall rule"
  type = string
}
variable "vpc_network_name" {
  description = "VPC network name"
  type = string
}
variable subnetwork_name {
  description = "Subnetwork name"
  type = string
}
variable "limiter_ips" {
  description = "List of IPs to allow access to the load balancer"
  type        = list(string)
}
variable "subnetwork_cidr_range" {
  description = "CIDR Range"
  type = string
}
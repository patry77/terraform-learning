#Global
variable "project_id" {
  description = "GCP Project ID"
}

variable "region" {
  description = "GCP Region of resources"
  default     = "us-west4"
}

variable "zone" {
  description = "GCP Zone of resources"
  default     = "us-west4-a"
}

variable "credentials_file" {
  description = "Path to service account credentials file"
}


variable "vm_instance_name" {
  description = "Name of the VM instance"
}
#Network
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
}
variable "health_check_name" {
  description = "Name of the health check" 
}
variable "forwarding_rule_name" {
  description = "Name of the forwarding rule"
}
variable "forwarding_rule_port_range" {
  description = "Port range of the forwarding rule"
  default     = "80-80"
}
  
variable "firewall_rule_name" {
  description = "Name of the firewall rule"
}
variable "vpc_network_name" {
  description = "VPC network name"
}
variable subnetwork_name {
  description = "Subnetwork name"
}
variable "limiter_ips" {
  description = "List of IPs to allow access to the load balancer"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
#Compute
variable "group_manager_name" {
  description = "Name of the managed instance group"
}
variable "compute_machine_type" {
  description = "Provide the machine type for the compute instance"
  default     = "e2-medium"
}

variable "vm_instance_name" {
  description = "Provide name for the compute instance"
}
variable "group_manager_port" {
  description = "Port of the group manager"
}
#Global
variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region of resources"
  type        = string
  default     = "us-west4"
}

variable "zone" {
  description = "GCP Zone of resources"
  type        = string
  default     = "us-west4-a"
}

variable "credentials_file" {
  description = "Path to service account credentials file"
  type        = string
}

variable "vm_instance_name" {
  description = "Name of the VM instance"
  type        = string
}

#Network
variable "reserved_ip_name" {
  description = "Name of the reserved IP address"
  type        = string
}
variable "cloud_nat_router_name" {
  description = "Name of the Cloud NAT router"
  type        = string
}

variable "cloud_nat_config_name" {
  description = "Name of the Cloud NAT config"
  type        = string
}

variable "target_http_proxy_name" {
  description = "Name of the target HTTP proxy"
  type        = string
}

variable "url_map_name" {
  description = "Name of the URL map"
  type        = string
}

variable "backend_service_name" {
  description = "Name of the backend service"
  type        = string
}

variable "port_name" {
  description = "Name of the port"
  type        = string
}

variable "health_check_name" {
  description = "Name of the health check"
  type        = string
}

variable "forwarding_rule_name" {
  description = "Name of the forwarding rule"
  type        = string
}

variable "forwarding_rule_port_range" {
  description = "Port range of the forwarding rule"
  type        = string
  default     = "80"
}

variable "firewall_rule_name" {
  description = "Name of the firewall rule"
  type        = string
}

variable "vpc_network_name" {
  description = "VPC network name"
  type        = string
}

variable "subnetwork_name" {
  description = "Subnetwork name"
  type        = string
}

variable "limiter_ips" {
  description = "List of IPs to allow access to the load balancer"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "subnetwork_cidr_range" {
  description = "CIDR Range"
  default     = "10.0.0.0/24"
  type        = string
}

#Compute
variable "group_manager_name" {
  description = "Name of the managed instance group"
  type        = string
}

variable "compute_machine_type" {
  description = "Provide the machine type for the compute instance"
  type        = string
  default     = "e2-medium"
}

variable "group_manager_port" {
  description = "Port of the group manager"
  type        = number
  default     = 80
}

variable "group_manager_size" {
  description = "Size of the group manager"
  type        = number
  default     = 3
}
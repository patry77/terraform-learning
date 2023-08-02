variable "vpc_network_name" {
  description = "Name of VPC network"
  type        = string
}
variable "group_manager" {
  description = "Name of instance group manager"
  type        = string
}
variable "limiter_ips" {
  description = "List of IP addresses allowed to access the VM instances"
  type        = list(string)
}
variable "limiter_ips" {
  description = "List of IP addresses allowed to access the VM instances."
  type        = list(string)
}
variable "subnetwork_id"{
  description = "Subnetwork ID"
}
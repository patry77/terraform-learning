variable "vpc_network_id" {
  description = "Provide the network name for the compute instance"
  type        = string
}
variable "subnetwork_id" {
  description = "Provide the subnetwork id for the compute instance"
  type        = string
}
variable "group_manager_name" {
  description = "Name of the managed instance group"
  type        = string
}
variable "compute_machine_type" {
  description = "Provide the machine type for the compute instance"
  type        = string
}
variable "vm_instance_name" {
  description = "Provide name for the compute instance"
  type        = string
}
variable "port_name" {
  description = "Name of the port"
  type        = string
}
variable "group_manager_port" {
  description = "Port of the group manager"
  type        = number
}
variable "group_manager_size" {
  description = "Size of the group manager"
  type        = number
}
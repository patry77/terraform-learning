variable "vpc_network_id" {
  description = "Provide the network name for the compute instance"
}
variable "subnetwork_id" {
  description = "Provide the subnetwork id for the compute instance"
}
variable "group_manager_name" {
  description = "Name of the managed instance group"
}
variable "compute_machine_type" {
  description = "Provide the machine type for the compute instance"
}
variable "vm_instance_name" {
  description = "Provide name for the compute instance"
}
variable "port_name" {
  description = "Name of the port"
}
variable "group_manager_port" {
  description = "Port of the group manager"
}
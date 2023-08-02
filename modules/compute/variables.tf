variable "compute_machine_type" {
  description = "Provide the machine type for the compute instance"
  default = "e2-medium"
}

variable "vm_instance_name" {
  description = "Provide name for the compute instance"
}

variable "vpc_network_name" {
  description = "Provide the network name for the compute instance"
}
variable "subnetwork_id"{
  description = "Provide the subnetwork id for the compute instance"
}
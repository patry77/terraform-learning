output "vpc_network_id" {
  value = google_compute_network.vpc_network.id
}
output "lb_ip" {
  value = google_compute_global_address.default
}
output "subnetwork_id" {
  value = google_compute_subnetwork.subnetwork.id
}

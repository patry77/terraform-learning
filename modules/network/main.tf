resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = var.subnetwork_name
  network       = google_compute_network.vpc_network.name
  ip_cidr_range = var.subnetwork_cidr_range
  secondary_ip_range {
    range_name    = "secondary-range"
    ip_cidr_range = "172.16.0.0/12"
  }
}

# reserved IP address
resource "google_compute_global_address" "default" {
  name = var.reserved_ip_name
}

resource "google_compute_router" "nat_router" {
  name    = var.cloud_nat_router_name
  network = google_compute_network.vpc_network.self_link
}
resource "google_compute_router_nat" "nat_config" {
  name                               = var.cloud_nat_config_name
  router                             = google_compute_router.nat_router.name
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}


# http proxy
resource "google_compute_target_http_proxy" "default" {
  name    = var.target_http_proxy_name
  url_map = google_compute_url_map.default.id
}

# url map
resource "google_compute_url_map" "default" {
  name            = var.url_map_name
  default_service = google_compute_backend_service.backend_service.id
}
resource "google_compute_backend_service" "backend_service" {
  name                    = var.backend_service_name
  protocol                = "HTTP"
  port_name               = var.port_name
  load_balancing_scheme   = "EXTERNAL"
  timeout_sec             = 10
  enable_cdn              = true
  custom_request_headers  = ["X-Client-Geo-Location: {client_region_subdivision}, {client_city}"]
  custom_response_headers = ["X-Cache-Hit: {cdn_cache_status}"]
  health_checks           = [google_compute_health_check.default.id]
  backend {
    group           = var.group_manager
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

resource "google_compute_health_check" "default" {
  name = var.health_check_name
  http_health_check {
    port_specification = "USE_SERVING_PORT"
  }
}

resource "google_compute_global_forwarding_rule" "default" {
  name                  = var.forwarding_rule_name
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = var.forwarding_rule_port_range
  target                = google_compute_target_http_proxy.default.id
  ip_address            = google_compute_global_address.default.id
}
resource "google_compute_firewall" "firewall" {
  name      = var.firewall_rule_name
  network   = var.vpc_network_name
  direction = "INGRESS"
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
  target_tags   = ["allow-health-check"]
  source_ranges = var.limiter_ips
  depends_on = [
    google_compute_network.vpc_network,
  ]
}

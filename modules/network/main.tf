resource "google_compute_network" "vpc_network" {
  name = var.vpc_network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = var.subnetwork_id
  network       = google_compute_network.vpc_network.name
  ip_cidr_range = "10.0.0.0/24"
  secondary_ip_range {
    range_name    = "secondary-range"
    ip_cidr_range = "172.16.0.0/12"  # Use a different CIDR block if needed
  }
}

# reserved IP address
resource "google_compute_global_address" "default" {
  name     = "l7-xlb-static-ip"
}

resource "google_compute_router" "nat_router" {
  name    = "cloud-nat-router"
  network = google_compute_network.vpc_network.self_link
}
resource "google_compute_router_nat" "nat_config" {
  name         = "cloud-nat-config"
  router       = google_compute_router.nat_router.name
  nat_ip_allocate_option = "AUTO_ONLY" # Change this option if you have a specific external IP allocated.
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}


# http proxy
resource "google_compute_target_http_proxy" "default" {
  name     = "l7-xlb-target-http-proxy"
  url_map  = google_compute_url_map.default.id
}

# url map
resource "google_compute_url_map" "default" {
  name            = "l7-xlb-url-map"
  default_service = google_compute_backend_service.backend_service.id
}
resource "google_compute_backend_service" "backend_service" {
  name                    = "l7-xlb-backend-service"
  protocol                = "HTTP"
  port_name               = "my-port"
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
  name     = "l7-xlb-hc"
  http_health_check {
    port_specification = "USE_SERVING_PORT"
  }
}

resource "google_compute_global_forwarding_rule" "default" {
  name                  = "l7-xlb-forwarding-rule"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "80"
  target                = google_compute_target_http_proxy.default.id
  ip_address            = google_compute_global_address.default.id
}
resource "google_compute_firewall" "firewall" {
  name    = "lb-allow-from-limiters"
  network = var.vpc_network_name
  direction     = "INGRESS"
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
  target_tags = ["allow-health-check"]
  source_ranges = var.limiter_ips
    depends_on = [
    google_compute_network.vpc_network,
  ]
}
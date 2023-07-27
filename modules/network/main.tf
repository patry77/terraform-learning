resource "google_compute_network" "vpc_network" {
  name = var.vpc_network_name
}
variable "limiter_ips" {
  description = "List of IP addresses allowed to access the VM instances."
  type        = list(string)
}
resource "google_compute_subnetwork" "subnetwork" {
  name          = "web-server-subnetwork"
  network       = google_compute_network.vpc_network.name
  ip_cidr_range = "10.0.0.0/24"
}

resource "google_compute_forwarding_rule" "external_lb" {
  name                  = "external-load-balancer"
  load_balancing_scheme = "EXTERNAL"
  network_tier          = "PREMIUM"
  subnetwork            = google_compute_subnetwork.subnetwork.self_link

  port_range = "80-80"

  backend_service = google_compute_backend_service.backend_service.self_link
}


resource "google_compute_backend_service" "backend_service" {
  name        = "web-server-backend-service"
  protocol    = "HTTP"
  port_name   = "http"
  timeout_sec = 10

  backend {
    group = var.group_manager
  }

  health_checks = [google_compute_http_health_check.health_check.self_link]
}

resource "google_compute_http_health_check" "health_check" {
  name               = "web-server-health-check"
  request_path       = "/"
  port               = "80"
  check_interval_sec = 10
  timeout_sec        = 5
}

resource "google_compute_global_forwarding_rule" "global_lb" {
  name                  = "global-load-balancer"
  target                = google_compute_backend_service.backend_service.self_link
  port_range            = "80-80"
  load_balancing_scheme = "EXTERNAL"
}
resource "google_compute_firewall" "firewall" {
  name    = "lb-allow-from-limiters"
  network = var.vpc_network_name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = var.limiter_ips
    depends_on = [
    google_compute_network.vpc_network,
  ]
}
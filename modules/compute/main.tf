



resource "google_compute_instance_template" "vm_instance" {
  machine_type = var.compute_machine_type
  tags         = ["allow-health-check"]
  disk {
    source_image = "debian-cloud/debian-11"
  }

  network_interface {
    network = var.vpc_network_name
    subnetwork = var.subnetwork_id
  }
  metadata_startup_script = "sudo apt-get update -y && sudo apt-get install apache2 -y && sudo service apache2 start && hostname > /var/www/html/index.html"
}

resource "google_compute_instance_group_manager" "instance_group_manager" {
  name               = "example-group"
  base_instance_name = "${var.vm_instance_name}-instance"
  named_port {
    name = "my-port"
    port = 80
  }
  version {
    instance_template = google_compute_instance_template.vm_instance.id
  }
  target_size = 3
}



output "group_manager" {
  value = google_compute_instance_group_manager.instance_group_manager.instance_group
}

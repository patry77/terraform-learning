
resource "google_compute_instance" "vm_instance" {
  machine_type = var.compute_machine_type
  name         = var.vm_instance_name
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = var.vpc_network_name
    access_config {
    }
  }
  metadata_startup_script = "sudo apt-get update -y && sudo apt-get install apache2 -y && sudo service apache2 start && hostname > /var/www/html/index.html"
}

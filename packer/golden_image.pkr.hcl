variable "project_id" {
  type = string
}

variable "source_image" {
  type = string
  description = "Base image from which to build the golden image"
}

locals {
  image_family = "apache2-golden-image"
}

source "googlecompute" "image" {
  project_id = var.project_id
  image_name = var.source_image
  source_disk_size = 10 # Adjust as needed
}

build {
  sources = [
    "source.googlecompute.image"
  ]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apache2",
      # Other provisioning steps can be added here if needed
    ]
  }

  # Other configuration properties like builders, etc. can be added here if needed
}

artifact {
  image_name = local.image_family
  image_family = local.image_family
  image_project_id = var.project_id
}
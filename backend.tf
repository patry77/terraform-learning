terraform {
  backend "remote" {
    organization = "internship_learning"
    workspaces {
      name = "terraform-project-state"
    }
  }
}
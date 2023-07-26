variable "gcp_project_id" {
  description = "GCP Project ID"
}

variable "gcp_region" {
  description = "GCP Region of resources"
  default     = "us-central1"
}

variable "gcp_zone" {
  description = "GCP Zone of resources"
  default     = "us-central1-a"
}

variable "gcp_credentials_file" {
  description = "Path to service account credentials file"
}

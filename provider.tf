terraform {
  required_version = "1.14.5"
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.0.0"
    }
  }
}

provider "google" {
  project = var.gcp_project_id
  region = var.region
  zone = var.zone
}

terraform {
  cloud {
    organization = "georg"
    workspaces {
      name = "tfc-demo"
    }
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.22.0"
    }
  }
}
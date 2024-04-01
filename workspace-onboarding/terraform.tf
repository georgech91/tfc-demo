terraform {
  cloud {
    organization = "georg"
    workspaces {
      name = "create-ws-tfc-demo"
    }
  }
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.53.0"
    }
  }
}
variable "project_id" {
  default = ""
}

variable "TF_SECRET_GOOGLE_CREDENTIALS" {
  default   = ""
  sensitive = true
}

variable "workload_identity_pool_id" {
  default = ""
}

variable "workload_identity_pool_provider_id" {
  default = ""
}

variable "service_account_id" {
  default = ""
}

variable "docker_repo_location" {
  default = ""
}

variable "app_image" {
  default = ""
}

variable "subnet_region" {
  default = ""
}

variable "subnet_range" {
  default = ""
}

variable "app_port" {
  default = ""
}

variable "app_zone" {
  default = ""
}


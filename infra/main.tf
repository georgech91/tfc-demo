provider "google" {
  project     = var.project_id
  credentials = var.TF_SECRET_GOOGLE_CREDENTIALS
}

resource "google_iam_workload_identity_pool" "workload_identity_pool" {
  workload_identity_pool_id = var.workload_identity_pool_id
}

resource "google_iam_workload_identity_pool_provider" "workload_identity_pool_provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.workload_identity_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = var.workload_identity_pool_provider_id
  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.actor"            = "assertion.actor"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }
  attribute_condition = "assertion.repository_owner == 'georgech91'"
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

resource "google_service_account" "service_account" {
  account_id = var.service_account_id
}

resource "google_service_account_iam_binding" "service_account_iam" {
  service_account_id = google_service_account.service_account.name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.workload_identity_pool.name}/attribute.repository/georgech91/tfc-demo"
  ]
}

resource "google_artifact_registry_repository" "docker_repo" {
  location      = var.docker_repo_location
  repository_id = "docker"
  format        = "DOCKER"
}

resource "google_artifact_registry_repository_iam_member" "docker_repo_iam" {
  location   = google_artifact_registry_repository.docker_repo.location
  repository = google_artifact_registry_repository.docker_repo.name
  role       = "roles/artifactregistry.repoAdmin"
  member     = "serviceAccount:${google_service_account.service_account.email}"
}

module "app_vm" {
  source  = "terraform-google-modules/container-vm/google"
  version = "3.1.1"

  container = {
    image = var.app_image
  }
}

data "google_compute_image" "gce_container_vm_image" {
  family  = "cos-stable"
  project = "cos-cloud"
}

resource "google_compute_network" "app_network" {
  name                    = "app-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "app_subnet" {
  name          = "app-subnet"
  ip_cidr_range = var.subnet_range
  region        = var.subnet_region
  network       = google_compute_network.app_network.id
}

resource "google_compute_firewall" "app_firewall" {
  name    = "flask-app-firewall"
  network = google_compute_network.app_network.id

  allow {
    protocol = "tcp"
    ports    = [var.app_port]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance_template" "app_instance_template" {
  name        = "app-instance-template"
  description = "This template is used to create app server instances"

  metadata = {
    "gce-container-declaration" = module.app_vm.metadata_value
  }
  labels = {
    "container-vm" = module.app_vm.vm_container_label
  }

  machine_type = "e2-micro"

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  disk {
    source_image = data.google_compute_image.gce_container_vm_image.self_link
    auto_delete  = true
    boot         = true
    disk_type    = "pd-balanced"
    disk_size_gb = 10
  }

  network_interface {
    subnetwork = google_compute_subnetwork.app_subnet.self_link
    access_config {
      // Ephemeral IP
    }
  }

  service_account {
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance_from_template" "app_instance" {
  name                     = "app-instance"
  zone                     = var.app_zone
  source_instance_template = google_compute_instance_template.app_instance_template.self_link_unique
}
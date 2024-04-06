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

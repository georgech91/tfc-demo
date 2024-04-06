provider "google" {
  project     = var.project_id
  credentials = var.TF_SECRET_GOOGLE_CREDENTIALS
}
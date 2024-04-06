# module "app_vm" {
#   source  = "terraform-google-modules/container-vm/google"
#   version = "3.1.1"

#   container = {
#     image = var.app_image
#   }
# }

# data "google_compute_image" "gce_container_vm_image" {
#   family  = "cos-stable"
#   project = "cos-cloud"
# }

# resource "google_compute_network" "app_network" {
#   name                    = "app-network"
#   auto_create_subnetworks = false
# }

# resource "google_compute_subnetwork" "app_subnet" {
#   name          = "app-subnet"
#   ip_cidr_range = var.subnet_range
#   region        = var.subnet_region
#   network       = google_compute_network.app_network.id
# }

# resource "google_compute_firewall" "app_firewall" {
#   name    = "app-firewall"
#   network = google_compute_network.app_network.id

#   allow {
#     protocol = "tcp"
#     ports    = [var.app_port]
#   }
#   source_ranges = ["0.0.0.0/0"]
# }

# resource "google_compute_instance_template" "app_instance_template" {
#   name        = "app-instance-template"
#   description = "This template is used to create app server instances"

#   metadata = {
#     "gce-container-declaration" = module.app_vm.metadata_value
#   }
#   labels = {
#     "container-vm" = module.app_vm.vm_container_label
#   }

#   machine_type = "e2-micro"

#   scheduling {
#     automatic_restart   = true
#     on_host_maintenance = "MIGRATE"
#   }

#   disk {
#     source_image = data.google_compute_image.gce_container_vm_image.self_link
#     auto_delete  = true
#     boot         = true
#     disk_type    = "pd-balanced"
#     disk_size_gb = 10
#   }

#   network_interface {
#     subnetwork = google_compute_subnetwork.app_subnet.self_link
#     access_config {
#       // Ephemeral IP
#     }
#   }

#   service_account {
#     scopes = ["cloud-platform"]
#   }
# }

# resource "google_compute_instance_from_template" "app_instance" {
#   name                     = "app-instance"
#   zone                     = var.app_zone
#   source_instance_template = google_compute_instance_template.app_instance_template.self_link_unique
# }
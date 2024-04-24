# output "App-URL" {
#   value = join("", ["http://", google_compute_instance_from_template.app_instance.network_interface.0.access_config.0.nat_ip, ":${var.app_port}"])
# }
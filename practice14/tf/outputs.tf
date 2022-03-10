output "build_instance_ip_address" {
  description = "Build instance public IP address"
  value = google_compute_instance.build.network_interface[0].access_config[0].nat_ip
}

output "prod_instance_ip_address" {
  description = "Production instance public IP address"
  value = google_compute_instance.production.network_interface[0].access_config[0].nat_ip
}
output "instance_ip_address" {
  description = "Instance public IP address"
  value = google_compute_instance.practice.network_interface[0].access_config[0].nat_ip
}
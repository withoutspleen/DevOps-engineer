output "build_instance_ip_address" {
  description = "Build instance public IP address"
  value = aws_instance.build.public_ip
}

output "prod_instance_ip_address" {
  description = "Production instance public IP address"
  value = aws_instance.prod.public_ip
}
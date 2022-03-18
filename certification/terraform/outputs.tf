output "build_instance_dns" {
  description = "Build instance public IP address"
  value = aws_instance.build.public_dns
}

output "prod_instance_dns" {
  description = "Production instance public IP address"
  value = aws_instance.prod.public_dns
}
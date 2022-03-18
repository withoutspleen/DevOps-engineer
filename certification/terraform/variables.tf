variable "instance_ami" {
  description = "Value of Image for both EC2 instances"
  type        = string
  default     = "ami-04505e74c0741db8d"
}

variable "instance_type" {
  description = "Value of Type for both EC2 instances"
  type        = string
  default     = "t2.micro"
}
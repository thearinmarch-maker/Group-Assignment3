variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "Target AWS Region"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "EC2 Instance Type"
}

variable "key_name" {
  type        = string
  description = "Existing AWS Key Pair name"
}
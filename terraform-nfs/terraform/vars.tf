variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {
  default = "us-west-2"
}

# variable "private_key" {
#   default = "mykey"
# }

variable "key_name" {}
variable "public_key_path" {}

# variable "gitlab_postgres_password" {
#   default = "supersecret"
# }

variable "availability_zones" {
  default = ["us-west-1a", "us-west-1b"]
}

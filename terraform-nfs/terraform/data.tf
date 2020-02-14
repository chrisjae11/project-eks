data "aws_availability_zones" "available" {

}

data "aws_ami" "nfs-ami" {
  most_recent = true
  owners = ["self"]

  filter {
    name = "tag:Name"
    values = ["nfs-server-gold"]
  }

}

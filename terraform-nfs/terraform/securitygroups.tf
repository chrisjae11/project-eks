resource "aws_security_group" "ssh-sec" {
  name        = "nfs-ssh"
  description = "allow ssh"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nfs-ssh"
  }

}

resource "aws_security_group" "nfs-sec" {
  vpc_id = "${module.vpc.vpc_id}"
  name   = "nfs-sec"

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port   = 111
    to_port     = 111
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

}

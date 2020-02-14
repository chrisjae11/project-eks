resource "aws_instance" "nfs-server" {
  ami                     = "${data.aws_ami.nfs-ami.id}"
  instance_type           = "t2.small"
  iam_instance_profile    = "${aws_iam_instance_profile.nfs-profile.id}"
  key_name                = "${aws_key_pair.mykeypair.key_name}"
  subnet_id               = "${element(module.vpc.public_subnets, 0)}"
  vpc_security_group_ids = ["${aws_security_group.ssh-sec.id}", "${aws_security_group.nfs-sec.id}"]

}

resource "null_resource" "nfs-server-bootstrap" {
  triggers = {
    nfs_server_id = "${aws_instance.nfs-server.id}"
  }

  provisioner "local-exec" {
    command = <<EOD
cat <<EOF > aws_hosts
[nfs]
${aws_instance.nfs-server.public_ip}
EOF
EOD
  }

  provisioner "local-exec" {
    command = "aws ec2 wait instance-status-ok --instance-ids ${aws_instance.nfs-server.id} && ansible-playbook -i aws_hosts ../ansible/nfs.yml"
  }

}

resource "aws_launch_configuration" "eks-lc" {
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.eks-nodes-profile.name
  image_id                    = data.aws_ami.eks-worker.id
  instance_type               = "t2.large"
  name_prefix                 = "eks-demo"
  security_groups             = ["aws_security_group.eks-nodes.id"]
  user_data_base64            = base64encode(local.eks-node-userdata)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "eks-asg" {
  desired_capacity     = 2
  launch_configuration = aws_launch_configuration.eks-lc.id
  max_size             = 2
  min_size             = 1
  name                 = "eks-asg"

  vpc_zone_identifier = module.vpc.public_subnets

  tag {
    key                 = "Name"
    value               = "eks-aws_autoscaling_group"
    propagate_at_launch = true

  }

  tag {
    key                 = "kubernetes.io/cluster/${var.cluster-name}"
    value               = "owned"
    propagate_at_launch = true

  }
}

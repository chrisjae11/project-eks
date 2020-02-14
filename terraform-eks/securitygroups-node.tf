resource "aws_security_group" "eks-nodes" {
  name        = "eks-nodes"
  description = "security group for all nodes"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name"                                      = "eks-nodes"
    "kubernetes.io/cluster/${var.cluster-name}" = "owned"
  }
}


resource "aws_security_group_rule" "nodes-ingress-self" {
  description              = "allow nodes to communicate"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  security_group_id        = aws_security_group.eks-nodes.id
  source_security_group_id = aws_security_group.eks-nodes.id
  type                     = "ingress"

}

resource "aws_security_group_rule" "nodes-ingress-cluster" {
  description              = "allow kubelet and pods form eks control plane"
  from_port                = 1025
  protocol                 = "tcp"
  to_port                  = 65535
  security_group_id        = aws_security_group.eks-nodes.id
  source_security_group_id = aws_security_group.eks-cluster.id
  type                     = "ingress"

}

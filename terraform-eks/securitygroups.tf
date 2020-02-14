resource "aws_security_group" "eks-cluster" {
  name        = "eks-cluster"
  description = "cluster communication with worker nodes"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-cluster"

  }
}

resource "aws_security_group_rule" "eks-ingress-node-https" {
  description              = "allow pods to communicate with control-api"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks-cluster.id
  source_security_group_id = aws_security_group.eks-nodes.id
  to_port                  = 443
  type                     = "ingress"

}

resource "aws_security_group_rule" "eks-ingress-workstation-https" {
  cidr_blocks       = [local.workstation-external-cidr]
  description       = "allow to communicate the control-api"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.eks-cluster.id
  to_port           = 443
  type              = "ingress"

}

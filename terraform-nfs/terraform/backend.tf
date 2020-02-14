terraform {
  backend "s3" {
    bucket = "kube8-eks-nfs-remote"
    key = "eks.tfstate"
    region = "us-west-2"
  }
}

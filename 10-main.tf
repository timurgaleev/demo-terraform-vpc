#main

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "v2.64.0"

  name = var.cluster_name

  cidr = local.cidr

  azs             = local.zones
  private_subnets = local.private
  public_subnets  = local.public

  enable_nat_gateway = true
  single_nat_gateway = var.single_nat

  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    Name                                        = "${var.cluster_name}-public"
    KubernetesCluster                           = var.cluster_name
    Project                                     = var.project
    "kubernetes.io/role/elb"                    = ""
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  private_subnet_tags = {
    Name                                        = "${var.cluster_name}-private"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }

  tags = {
    Name      = "${var.cluster_name}"
    Project   = var.project
    Terraform = "true"
  }
}

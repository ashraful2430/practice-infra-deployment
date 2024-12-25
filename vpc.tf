module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.17.0"


  name = local.vpc_name
  cidr = "10.10.0.0/16"


  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  public_subnets  = ["10.10.101.0/24", "10.10.102.0/24", "10.10.103.0/24"]
  intra_subnets   = ["10.10.201.0/24", "10.10.202.0/24", "10.10.203.0/24"]


  enable_nat_gateway = true
  single_nat_gateway = true
  enable_vpn_gateway = false
  enable_dns_hostnames = true


  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = 1
  }


  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = 1
  }


  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
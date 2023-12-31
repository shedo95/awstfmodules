provider "aws" {
  region = "eu-west-1"
}

module "iam_eks_role" {
  source    = "../../modules/iam-eks-role"
  role_name = "my-app"

  cluster_service_accounts = {
    (random_pet.this.id) = ["default:my-app"]
  }

  tags = {
    Name = "eks-role"
  }

  role_policy_arns = {
    AmazonEKS_CNI_Policy = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  }
}

###############################
# IAM EKS role with self assume
###############################
module "iam_eks_role_with_self_assume" {
  source    = "../../modules/iam-eks-role"
  role_name = "my-app-self-assume"

  allow_self_assume_role = true
  cluster_service_accounts = {
    (random_pet.this.id) = ["default:my-app"]
  }

  tags = {
    Name = "eks-role"
  }

  role_policy_arns = {
    AmazonEKS_CNI_Policy = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  }
}

#############################################
# IAM EKS role with wildcard assume condition
#############################################
module "iam_eks_role_with_assume_wildcard" {
  source    = "../../modules/iam-eks-role"
  role_name = "my-app-assume-wildcard"

  cluster_service_accounts = {
    (random_pet.this.id) = ["default:my-app-prefix-*"]
  }
  assume_role_condition_test = "StringLike"

  tags = {
    Name = "my-app-assume-wildcard"
  }

  role_policy_arns = {
    AmazonEKS_CNI_Policy = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  }
}

##################
# Extra resources
##################

resource "random_pet" "this" {
  length = 2
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 18.0"

  cluster_name    = random_pet.this.id
  cluster_version = "1.21"

  vpc_id     = data.aws_vpc.default.id
  subnet_ids = data.aws_subnets.all.ids
}

##################################################################
# Data sources to get VPC, subnet, security group and AMI details
##################################################################

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "all" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

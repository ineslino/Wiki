provider "aws" {
  region = local.aws_region
  default_tags {
    tags = {
      OnwerCompany = "Magic Beans"
      CreatedBy    = "ines.lino@magicbeans.pt"
      Purpose      = "Wiki and Knowledge Sharing"
    }
  }
}

provider "kubernetes" {
  host                   = local.kubeconfig.host
  cluster_ca_certificate = local.kubeconfig.cluster_ca_certificate

  exec {
    api_version = local.kubeconfig.exec.api_version
    command     = local.kubeconfig.exec.command
    # This requires the awscli to be installed locally where Terraform is executed
    args = local.kubeconfig.exec.args
  }
}

provider "helm" {
  kubernetes {
    host                   = local.kubeconfig.host
    cluster_ca_certificate = local.kubeconfig.cluster_ca_certificate

    exec {
      api_version = local.kubeconfig.exec.api_version
      command     = local.kubeconfig.exec.command
      # This requires the awscli to be installed locally where Terraform is executed
      args = local.kubeconfig.exec.args
    }
  }
}

provider "kubectl" {
  host                   = local.kubeconfig.host
  cluster_ca_certificate = local.kubeconfig.cluster_ca_certificate
  load_config_file       = false

  exec {
    api_version = local.kubeconfig.exec.api_version
    command     = local.kubeconfig.exec.command
    # This requires the awscli to be installed locally where Terraform is executed
    args = local.kubeconfig.exec.args
  }
}
terraform {
  required_version = ">= 1.0.0"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.78"
    }
  }

  backend "s3" {
    bucket = "terraform-state"
    key    = "proxmox/lxc/unbound/terraform.tfstate"

    endpoints = {
      s3 = "https://rustfs-endpoint.local.timmybtech.com"
    }

    region = "us-east-1"

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    use_path_style              = true
  }
}

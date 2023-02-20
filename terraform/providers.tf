terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "1.48.0"
    }
  }
}

provider "openstack" {
  # Configuration options, if empty defaults to `clouds.yaml`
  #cloud = "openstack" # cloud defined in cloud.yml file
}


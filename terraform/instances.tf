# Create the VM

# link the cloud-init script with this vm
# @see https://learn.hashicorp.com/tutorials/terraform/cloud-init
# data "template_file" "user_data" {
#   template = file("scripts/setup_nvidia.yaml")
# }

resource "openstack_compute_instance_v2" "machine_learning_vm" {
  name            = var.app_name
  image_id        = var.image_id
  flavor_id       = var.flavor_id
  key_pair        = var.key_pair
  security_groups = var.security_groups
  user_data       = data.cloudinit_config.machine_learning_vm.rendered # data.template_file.user_data.rendered
  tags            = var.app_tags

  # TODO: metadata = ["app"->var.app_tag]
  network {
    name = var.network_name
  }
}



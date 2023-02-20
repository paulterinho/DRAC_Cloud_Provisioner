
# Create a Floating Point IP address (FIP)
resource "openstack_networking_floatingip_v2" "machine_learning_vm_fip" {
  pool = var.pool
  tags = var.app_tags
  #description = var.app_tags
}

# Associate the FIP with the Image Instance
resource "openstack_compute_floatingip_associate_v2" "machine_learning_vm_fip" {
  floating_ip = openstack_networking_floatingip_v2.machine_learning_vm_fip.address
  instance_id = openstack_compute_instance_v2.machine_learning_vm.id
}
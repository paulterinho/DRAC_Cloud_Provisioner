# Output VM IP Addresses
output "server_private_ip" {
  value = openstack_compute_instance_v2.machine_learning_vm.access_ip_v4
}

# Public IP Address for instance
output "server_floating_ip" {
  value = openstack_networking_floatingip_v2.machine_learning_vm_fip.address
}
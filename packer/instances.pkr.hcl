# This file was autogenerated by the 'packer hcl2_upgrade' command. We
# recommend double checking that everything is correct before going forward. We
# also recommend treating this file as disposable. The HCL2 blocks in this
# file can be moved to other files. For example, the variable blocks could be
# moved to their own 'variables.pkr.hcl' file, etc. Those files need to be
# suffixed with '.pkr.hcl' to be visible to Packer. To use multiple files at
# once they also need to be in the same folder. 'packer inspect folder/'
# will describe to you what is in that folder.

# Avoid mixing go templating calls ( for example ```{{ upper(`string`) }}``` )
# and HCL2 calls (for example '${ var.string_value_example }' ). They won't be
# executed together and the outcome will be unknown.

# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source
// source "openstack" "autogenerated_1" {
//   domain_name       = "$OS_USER_DOMAIN_NAME"
//   flavor            = "$flavor_id"
//   identity_endpoint = "$OS_AUTH_URL"
//   image_name        = "$app_tag"
//   networks          = ["$NETWORK_ID"]
//   insecure          = "false"
//   password          = "$OS_PASSWORD"
//   region            = "$OS_REGION_NAME"
//   source_image      = "$source_id"
//   ssh_ip_version    = "4"
//   ssh_username      = "$ssh_user_name"
//   tenant_id         = "$OS_TENANT_ID"
//   username          = "$OS_USERNAME"
// }
source "openstack" "autogenerated_1" {
  cloud          = "openstack" # check the clouds.yaml file, it's the name of the cloud
  image_name     = local.app_name_uuid
  image_tags     = var.app_tags
  flavor         = var.flavor_id
  source_image   = var.image_id
  ssh_username   = var.ssh_user_name
  ssh_ip_version = var.ssh_version_num
  networks       = [var.network_id]
  password       = var.password
  floating_ip    = var.floating_ip_id # issue a `openstack floating ip list` cmd to see the ids
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  sources = ["source.openstack.autogenerated_1"]

  provisioner "shell" {
    script              = "scripts/ubuntu/20.04/00_upgrade.sh"
    expect_disconnect   = true
    start_retry_timeout = "2m" # reboots the system, this needs to happen on a separate script.
  }

  provisioner "shell" {
    script = "scripts/ubuntu/20.04/01_init.sh"
  }

  provisioner "shell" {
    script = "scripts/ubuntu/20.04/02_check_nvidia_capability.sh"
  }

  provisioner "file" {
    source      = "scripts/ubuntu/20.04/arbutus-cloud-repo_0.1ubuntu20_all.deb"
    destination = "/home/ubuntu/arbutus-cloud-repo_0.1ubuntu20_all.deb"
  }
  provisioner "shell" {
    script = "scripts/ubuntu/20.04/03_add_nvidia.sh"
  }

  # NOTE: I had to group all the python related things in one script because I couldn't figure
  #       out how to persist changes to the PATH for conda between provisioner blocks.
  provisioner "shell" {

    environment_vars = [
      "conda_forge_libraries=${var.conda_forge_libraries}",
      "conda_security_group=${var.conda_security_group}",
      "fast_ai_env_name=${var.fast_ai_env_name}",
      "mini_conda_install_location=${local.mini_conda_install_location}",
      "python_libraries=${var.python_libraries}",
      "python_shell_name=${var.python_shell_name}",
      "python_version=${var.python_version}",
      "python_virtual_env_name=${var.python_virtual_env_name}",
      "ssh_user_name=${var.ssh_user_name}",
    ]

    # ============================================================================================
    # NOTE:   This script is big bc it runs each script in "isolation", meaning that if one script
    #         creates an executable like conda, the next script has no idea what that is.
    # ============================================================================================
    script = "scripts/ubuntu/20.04/04_add_python.sh"

  }

  provisioner "shell" {
    script            = "scripts/ubuntu/20.04/99_update_upgrade.sh"
    expect_disconnect = true # the script reboots, not sure if this is needed, but trying
  }

}

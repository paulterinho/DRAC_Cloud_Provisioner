
# Cloud-init is how I'm configuring the Linux machine after it has been provisioned.

data "cloudinit_config" "machine_learning_vm" {
  gzip          = false
  base64_encode = false

  # leave this part last so we can know how long it took to set everything up.
  part {
    content_type = "text/cloud-config"
    content      = file("scripts/final_msg.yaml") # file function is important, won't run otherwise.
  }
}

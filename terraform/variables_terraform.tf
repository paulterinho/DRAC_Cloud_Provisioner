variable "app_name" {
  default     = "machine_learning_vm" # Debian 10
  description = "The name we'll give the instance of the Debian 10 image."
  type        = string
  sensitive   = false
}
// run `openstack image list`
variable "app_tags" {
  default     = ["gpu", "python3.7", "gdal"]
  description = "The tag to give this image.."
  type        = list(string)
  sensitive   = false
}
variable "image_id" {
  default     = "bbxdf946-aa65-4253-af21-157f8485afd9" # Customized Ubuntu VM 20.04.5 we made in `./packer`!
  description = "The ID of the image to use."
  type        = string
  sensitive   = false
}

variable "flavor_id" {
  default     = "365471a-ace2-4166-9133-d71fe00190a9" # needs to be a 'g' type to have vGPU support
  description = "The type of hardware configuration we are choosing: g1-8gb-c4-22gb"
  type        = string
  sensitive   = false
}

variable "security_groups" {
  type    = list(string)
  default = ["default"] # Name of default security group
}

variable "ssh_user_name" {
  default     = "debian"
  description = "The name of the user used to access SSH."
  type        = string
  sensitive   = false
}

variable "pool" {
  default     = "Public-Network"
  description = "The name of the public network you can find on the CC Web console."
  type        = string
  sensitive   = false
}

# Omitted Keypairs and Network
variable "network_name" {
  description = "The name of the network you can find on the CC Web console."
  type        = string
  sensitive   = true
}

variable "key_pair" {
  description = "The name of key-pair we are using (you can find on the CC Web console.)"
  type        = string
  sensitive   = true
}

variable "ssh_key_file" {
  description = "The SSH key file you are using (you can find on the CC Web console)."
  type        = string
  sensitive   = true
}


#
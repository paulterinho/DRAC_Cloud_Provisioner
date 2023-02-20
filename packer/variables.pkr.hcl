//  variables.pkr.hcl
//
// NOTE:    For those variables that you don't provide a default for, you must
//          set them from the command line, a var-file, or the environment.
//          @see: https://www.packer.io/guides/hcl/variables

// TODO: These variables are identical to the Terraform Project, how can I use the same variable file?
variable "app_name" {
  default     = "ubuntu20.04_g1-8gb-c4-22gb"
  description = "The tag to give this image.."
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
  default     = "de0af287-d1f0-48bf-9ea2-5c7d6e1b58d8" # Ubuntu 20.04
  description = "The ID of the image."
  type        = string
  sensitive   = false
}

variable "flavor_id" {
  default     = "39d3041a-ace2-4166-9133-d78fe00190a9" # 'g1-8gb-c4-22gb'
  description = "We need the GPU capable flavor: g1-8gb-c4-22gb"
  type        = string
  sensitive   = false
}

variable "ssh_user_name" {
  default     = ""
  description = "The name of the user used to access SSH."
  type        = string
  sensitive   = true
}

variable "ssh_version_num" {
  default     = 4
  description = "IP Version to use"
  type        = number
  sensitive   = false
}

variable "pool" {
  default     = "Public-Network"
  description = "The name of the public network you can find on the CC Web console."
  type        = string
  sensitive   = false
}

variable "network_id" {
  description = "The network ID"
  default     = ""
  type        = string
  sensitive   = true
}
# Omitted Keypairs and Network
variable "network_name" {
  description = "The name of the network you can find on the CC Web console."
  type        = string
  sensitive   = true # it can be found in secret.auto.pkvars which gets loaded at build time.
}

variable "key_pair" {
  description = "The name of key-pair we are using (you can find on the CC Web console.)"
  type        = string
  sensitive   = true # it can be found in secret.auto.pkvars which gets loaded at build time.
}

variable "ssh_key_file" {
  description = "The SSH key file you are using (you can find on the CC Web console)."
  type        = string
  sensitive   = true # it can be found in secret.auto.pkvars which gets loaded at build time.
}

variable "password" {
  description = "The user password"
  type        = string
  sensitive   = true # it can be found in secret.auto.pkvars which gets loaded at build time.
}

variable "floating_ip_id" {
  description = "The ID of the floating IP to use. Use `openstack floating ip list` to see a list."
  type        = string
  sensitive   = true # it can be found in secret.auto.pkvars which gets loaded at build time.
}


# PYTHON
# PYTHON VARIABLES

# you can reference this variable using the terraform `${python_version}` syntax
variable "python_version" {
  description = "The version of python to use when installing dependencies"
  type        = number
  default     = 3.7 # debian 10 ships with this version
}

variable "python_libraries" {
  description = "The python libraries to install via conda (not with conda-forge channel. See `conda_forge_libraries` var for that.)"
  type        = string
  default     = " numpy=1.16 pandas=0.23.1 geopandas jupyter pytorch colorama"
}

variable "conda_security_group" {
  description = "The name of the security group to add users to to use miniconda for all users"
  type        = string
  default     = "conda_security_group"
}

variable "conda_forge_libraries" {
  description = "The python libraries that can be installed via Conda Forge channel"
  type        = string
  default     = "proj"
}

variable "python_virtual_env_name" {
  description = "Name of the main virtual environment for python"
  type        = string
  default     = "machine_learning_vm"
}

variable "python_shell_name" {
  description = "Name of the server's shell environment"
  type        = string
  default     = "bash"
}

variable "fast_ai_env_name" {
  description = "Name of the virtual environment for Fast AI"
  type        = string
  default     = "fast_ai_env"
}

# =========================================================================
# LOCALS
#

local "app_name_uuid" {
  expression = "${var.app_name}_${timestamp()}"
}


local "mini_conda_install_location" {
  expression = "/home/${var.ssh_user_name}/miniconda3"
}
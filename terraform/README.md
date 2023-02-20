```
============================================================================
████████╗███████╗██████╗░██████╗░░█████╗░███████╗░█████╗░██████╗░███╗░░░███╗
╚══██╔══╝██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗██╔══██╗████╗░████║
░░░██║░░░█████╗░░██████╔╝██████╔╝███████║█████╗░░██║░░██║██████╔╝██╔████╔██║
░░░██║░░░██╔══╝░░██╔══██╗██╔══██╗██╔══██║██╔══╝░░██║░░██║██╔══██╗██║╚██╔╝██║
░░░██║░░░███████╗██║░░██║██║░░██║██║░░██║██║░░░░░╚█████╔╝██║░░██║██║░╚═╝░██║
░░░╚═╝░░░╚══════╝╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░░░░░╚════╝░╚═╝░░╚═╝╚═╝░░░░░╚═╝


        █▀▄▀█ ▄▀█ █▀▀ █░█ █ █▄░█ █▀▀   █░░ █▀▀ ▄▀█ █▀█ █▄░█ █ █▄░█ █▀▀
        █░▀░█ █▀█ █▄▄ █▀█ █ █░▀█ ██▄   █▄▄ ██▄ █▀█ █▀▄ █░▀█ █ █░▀█ █▄█
============================================================================
```

# Purpose
This project is for provisioning Cloud Infrastructure to run VMs with Machine Learning pipelines on Compute Canada's OpenStack cloud

# Setup
Before running these, you'll need to complete the setup steps located in the README.md at the project root.
- Rename the `terraform/secrets.tfvars.template` file to `terraform/secrets.tfvars`.
- In the new `terraform/secrets.tfvars` file, fill out the following variables by looking at the web console.
  - `network_name` = "change-this-network-name"
  - `ssh_key_file` = "name-of-ssh-key"
  - `key_pair` = "cloud-key-pair"

# Running
Complete the following steps
- Run `make auth` and type in your web password (this needs `openrc.sh` to have been downloaded into the project root from your Cloud Web Console.)
- Run `make plan` to run `terraform plan`
- Run `make apply` to run `terraform apply`

# Appendix
- Describe your VM infrastructure as code using Terraform. https://docs.alliancecan.ca/wiki/Terraform


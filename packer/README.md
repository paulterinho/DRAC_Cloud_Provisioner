```
===========================================================
  ██████╗░░█████╗░░█████╗░██╗░░██╗███████╗██████╗░
  ██╔══██╗██╔══██╗██╔══██╗██║░██╔╝██╔════╝██╔══██╗
  ██████╔╝███████║██║░░╚═╝█████═╝░█████╗░░██████╔╝
  ██╔═══╝░██╔══██║██║░░██╗██╔═██╗░██╔══╝░░██╔══██╗
  ██║░░░░░██║░░██║╚█████╔╝██║░╚██╗███████╗██║░░██║
   ╚═╝░░░░░╚═╝░░╚═╝░╚════╝░╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝


█▀▄▀█ ▄▀█ █▀▀ █░█ █ █▄░█ █▀▀   █░░ █▀▀ ▄▀█ █▀█ █▄░█ █ █▄░█ █▀▀
█░▀░█ █▀█ █▄▄ █▀█ █ █░▀█ ██▄   █▄▄ ██▄ █▀█ █▀▄ █░▀█ █ █░▀█ █▄█
==============================================================
```

# Purpose
Project for creating VMs capable of using the GPUs in order to create Machine Learning pipelines.

# Steps
- install OpenStack
- Download the `clouds.yaml` file from the web console and place it in the project-root.
- Rename the `secret.auto.pkvars.hcl.template` to `secret.auto.pkvars.hcl`
- Get the image ID: `openstack image list`
- Place it in the `secret.auto.pkvars.hcl` file.
- Get the floating IP id via `openstack floating ip list`
- Place it in the `secret.auto.pkvars.hcl` file.

# Using OpenStack
- Use it to find things like the IDs of the floating IPs like `openstack floating ip

# Appendix
- Using Cloud GPUs:           https://docs.alliancecan.ca/wiki/Using_cloud_vGPUs
- Installing NVIDIA drivers:  https://docs.alliancecan.ca/wiki/Using_cloud_GPUs
- Creating an image:          https://docs.ovh.com/ca/en/public-cloud/packer-openstack-builder/
- Packer Variables:           https://www.packer.io/guides/hcl/variables

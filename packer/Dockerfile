
FROM debian

# Ensure that the latest packages are installed and the system has been booted with the latest stable kernel, as dkms will request the latest one available from the Debian repositories.
RUN apt-get update && apt-get -y dist-upgrade
RUN apt-get -y install wget
RUN apt-get -y install bash

#&& reboot

# After a successful reboot, the system should have the latest available kernel running and the repository can be installed, by installing the arbutus-cloud-repo package. This package also contains the gpg key all packages are signed with.
RUN apt-get -y install gnupg
# RUN wget http://repo.arbutus.cloud.computecanada.ca/pulp/deb/debian/pool/main/arbutus-cloud-repo_0.1_all.deb
# RUN dpkg -i arbutus-cloud-repo_0.1_all.deb

# The installation of the package will display a warning, since the key is directly imported (for convenience) via the package's post-installation procedure.
#     EXAMPLE:
#     - Setting up arbutus-cloud-repo (0.1) ...
#     - Warning: apt-key should not be used in scripts (called from postinst maintainerscript of the package arbutus-cloud-repo)
#     - OK

# Update the local apt cache and install the vGPU packages:
# RUN apt-get update && apt-get -y install nvidia-vgpu-kmod nvidia-vgpu-tools nvidia-vgpu-gridd

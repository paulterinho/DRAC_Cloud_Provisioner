#!/bin/sh

echo "================================="
echo "    CHECK NVIDIA CAPABILITIES"
echo "================================="

# NOTE:     This script will echo out some some basic info about the
#           system. Check the comments to see if your `flavor` is GPU capable.

# Some actions must be taken before the CUDA Toolkit and Driver can be installed on Linux:

#     Verify the system has a CUDA-capable GPU.
#     Verify the system is running a supported version of Linux.
#     Verify the system has gcc installed.
#     Verify the system has the correct kernel headers and development packages installed.
#     Download the NVIDIA CUDA Toolkit.
#     Handle conflicting installation methods.

# Note: You can override the install-time prerequisite checks by running the installer with the -override flag. Remember that the prerequisites will still be required to use the NVIDIA CUDA Toolkit.
# 2.1. Verify You Have a CUDA-Capable GPU

# To verify that your GPU is CUDA-capable, go to your distribution's equivalent of System Properties, or, from the command line, enter:

echo "==========================================\nsudo update-pciids"
sudo update-pciids

echo "==========================================\nlspci | grep -i nvidia"
sudo lspci | grep -i nvidia

# If you do not see any settings, update the PCI hardware database that Linux maintains by entering update-pciids (generally found in /sbin) at the command line and rerun the previous lspci command.

# If your graphics card is from NVIDIA and it is listed in https://developer.nvidia.com/cuda-gpus, your GPU is CUDA-capable.

# The Release Notes for the CUDA Toolkit also contain a list of supported products.
# 2.2. Verify You Have a Supported Version of Linux

# The CUDA Development Tools are only supported on some specific distributions of Linux. These are listed in the CUDA Toolkit release notes.

# To determine which distribution and release number you're running, type the following at the command line:

echo "==========================================\nuname -m && cat /etc/*release"
uname -m && cat /etc/*release

# You should see output similar to the following, modified for your particular system:

# x86_64
# Red Hat Enterprise Linux Workstation release 6.0 (Santiago)

# The x86_64 line indicates you are running on a 64-bit system. The remainder gives information about your distribution.
# 2.3. Verify the System Has gcc Installed

# The gcc compiler is required for development using the CUDA Toolkit. It is not required for running CUDA applications. It is generally installed as part of the Linux installation, and in most cases the version of gcc installed with a supported version of Linux will work correctly.

# To verify the version of gcc installed on your system, type the following on the command line:

echo "==========================================\ngcc --version"
gcc --version

# If an error message displays, you need to install the development tools from your Linux distribution or obtain a version of gcc and its accompanying toolchain from the Web.
# 2.4. Verify the System has the Correct Kernel Headers and Development Packages Installed

# # The CUDA Driver requires that the kernel headers and development packages for the running version of the kernel be installed at the time of the driver installation, as well whenever the driver is rebuilt. For example, if your system is running kernel version 3.17.4-301, the 3.17.4-301 kernel headers and development packages must also be installed.

# While the Runfile installation performs no package validation, the RPM and Deb installations of the driver will make an attempt to install the kernel header and development packages if no version of these packages is currently installed. However, it will install the latest version of these packages, which may or may not match the version of the kernel your system is using. Therefore, it is best to manually ensure the correct version of the kernel headers and development packages are installed prior to installing the CUDA Drivers, as well as whenever you change the kernel version.
# The version of the kernel your system is running can be found by running the following command:

echo "==========================================\nuname -r"
uname -r

# This is the version of the kernel headers and development packages that must be installed prior to installing the CUDA Drivers. This command will be used multiple times below to specify the version of the packages to install. Note that below are the common-case scenarios for kernel usage. More advanced cases, such as custom kernel branches, should ensure that their kernel headers and sources match the kernel build they are running.
# Note: If you perform a system update which changes the version of the linux kernel being used, make sure to rerun the commands below to ensure you have the correct kernel headers and kernel development packages installed. Otherwise, the CUDA Driver will fail to work with the new kernel.

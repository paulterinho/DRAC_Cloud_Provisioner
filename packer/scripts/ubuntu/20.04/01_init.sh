#!/bin/sh

echo "================================="
echo "      INITALIZE BASIC LIBS"
echo "================================="

# @see: https://www.linuxcapable.com/install-gcc-compiler-build-essential-on-ubuntu-20-04-lts/#Update_Operating_System
# Update your Ubuntu operating system to make sure all existing packages are up to date:

# Install GCC (GNU C-Compiler) with APT – Ubuntu Repository
#   The first recommended option to install GCC is to install the build-essential package
#   containing GCC and many other application packages such as make.
#   To begin the installation, use the following command.

# add a repository for downloading more software (aka build-essential).

echo "---------------------------------\nAdding GNU C Compiler repository..."
echo "Add to sources file"
'deb http://mirrors.kernel.org/ubuntu focal main' >>/etc/apt/source.list

# make sure the shell is not interactive. Bc we are using SSH it can throw an error if we aren't explicit.
DEBIAN_FRONTEND=noninteractive sudo apt install -y build-essential

echo "---------------------------------\nCHECKING PYTHON VERSION..."
python -V
python3 -V
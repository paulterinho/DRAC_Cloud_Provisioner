#!/bin/sh
echo "================================="
echo "      ADD MINI-CONDA & PYTHON"
echo "================================="
echo "Current user name: $USER"

echo "----------------------------------------------------------\nInstall Python dev tools"
# @see https://www.digitalocean.com/community/tutorials/how-to-install-python-3-and-set-up-a-programming-environment-on-an-ubuntu-20-04-server
sudo apt install -y build-essential libssl-dev libffi-dev python3-dev
sudo apt install -y python3-pip

echo "----------------------------------------------------------\nInstall PPAs"
# NOTE:     installl Python before Conda, in order to make a virtual environment,
#           it needs the lang. If you are installing the GDAL/OGR packages into a
#           virtual environment based on Python 3.6, you may need to install the
#           python3.6-dev package.
#
#           Also note all the python things on this script need to be in the same
#           script, otherwise it looses it's context (like conda can't be found)
#           if you break them up into individual scripts.

# First of all, you’ll need the following package installed so we can import any PPA (Personal Package Archive) repositories:
sudo apt install software-properties-common -y

# Then, we will import deadsnake’s PPA:
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update

echo "----------------------------------------------------------\nInstall python-dev"
# You can then install previous Python versions, for example Python 3.7:
echo "Python version: python${python_version}-dev"
sudo apt-get install -y "python${python_version}-dev" #needs to be the dev package for GDAL/OGR

echo "----------------------------------------------------------\nSwitching to user ${ssh_user_name}"
echo "User name: $USER"
su ${ssh_user_name}
echo "User name: $USER"

echo "----------------------------------------------------------\nWget & Miniconda"
# Downloading the latest Miniconda installer for macOS. Your architecture may vary.
# wget https://repo.anaconda.com/miniconda/Miniconda3-py37_4.12.0-Linux-x86_64.sh -O miniconda.sh
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh

# Options for running installer
    # -b: Batch mode with no PATH modifications to shell scripts. Assumes that you agree to the license agreement. Does not edit shell scripts such as .bashrc, .bash_profile, .zshrc, etc.
    # -p: Installation prefix/path.
    # -f: Force installation even if prefix -p already exists.

bash miniconda.sh -b -p ${mini_conda_install_location} # place it in /opt so all users can access it

echo "----------------------------------------------------------\nremove executable"
rm -f miniconda.sh

echo "----------------------------------------------------------\nExport path"
echo "User name: $USER"
# @ https://stackoverflow.com/questions/51030702/how-to-write-in-etc-profile-using-bash-permission-denied
echo sudo sh -c "echo export PATH=$PATH:${mini_conda_install_location}/bin >> /etc/profile" # place it on the path so all users can access it.
eval "$(${mini_conda_install_location}/bin/conda shell.${python_shell_name} hook)"

echo "PATH: $PATH"

echo "----------------------------------------------------------\nAdding Mamba to the base environment"
# @see https://mamba.readthedocs.io/en/latest/installation.html
# Note: Mamba makes Conda faster and more reliable.
conda install -y mamba -n base -c conda-forge

echo "----------------------------------------------------------\nUpdating Conda"
echo "User name: $USER"
# The `-u` will update an existing folder an avoid the "folder already exists error"
conda update -y -n base -c defaults conda
# conda update conda

echo "----------------------------------------------------------\nInitializing Conda for shell '${python_shell_name}'"
conda init ${python_shell_name} # initialize BASH (or zsh or whatever) to use conda.

# create a virtual environment and activate
# do I need this? It'll default to the base env and that's all I need.
echo "----------------------------------------------------------\nCreate a virtual environment with '${python_virtual_env_name}'"
#python3 -m venv ${python_virtual_env_name}
mamba create --yes --name ${python_virtual_env_name} python=${python_version}

# activate the environment
echo "----------------------------------------------------------\nActivate environment '${python_virtual_env_name}'"
# source ${python_virtual_env_name}/bin/activate
conda activate ${python_virtual_env_name}


# confirm it worked
conda --version

echo "============================================"
echo "      ADD GDAL AND GDAL PYTHON-BINDINGS"
echo "============================================"
echo "conda \t\t${mini_conda_install_location}"
echo "User name: \t$USER"
echo "Path: \t\t$PATH"
ls ${mini_conda_install_location}

# @see https://mothergeo-py.readthedocs.io/en/latest/development/how-to/gdal-ubuntu-pkg.html
sudo add-apt-repository ppa:ubuntugis/ppa && sudo apt-get update
sudo apt-get update
sudo apt-get install -y gdal-bin
sudo apt-get install -y libgdal-dev
export CPLUS_INCLUDE_PATH=/usr/include/gdal
export C_INCLUDE_PATH=/usr/include/gdal
conda install --yes gdal


# And voila! GDAL/OGR is already installed. GDAL is installed via this way in my machine. If I run which gdalinfo, it shows the following:
echo "----------------------------------------------------------\nwhich gdalinfo"
which gdalinfo
#/home/ljvm/anaconda3/bin/gdalinfo

# PRO: If you have conda, then this is just a one-step process.
# CON: If you don’t really use conda, or just want a lightweight environment for what you’re doing, then installing a distribution may be an overkill. You can try miniconda, but again, there’s overhead.

echo "----------------------------------------------------------\nGDAL version"
gdalinfo --version

echo "----------------------------------------------------------\nogr version"
ogrinfo --version

echo "============================================"
echo "          ADD PYTHON LIBRARIES to base ENV"
echo "============================================"



# finish installing python libraries that need conda-forge
# echo "----------------------------------------------------------\nInstalling conda-forge libraries '${conda_forge_libraries}'"
# # pip3 install ${python_libraries}
# conda install  --yes --quiet -c conda-forge ${conda_forge_libraries}


# echo "----------------------------------------------------------\nInstalling regular libraries '${python_libraries}'"
# conda install  --yes --quiet ${python_libraries}

conda deactivate
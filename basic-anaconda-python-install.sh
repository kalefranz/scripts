#!/bin/bash -eu

wget http://09c8d0b2229f813c1b93-c95ac804525aac4b6dba79b00b39d1d3.r79.cf1.rackcdn.com/Anaconda-2.1.0-Linux-x86_64.sh
chmod +x Anaconda-2.1.0-Linux-x86_64.sh
sudo ./Anaconda-2.1.0-Linux-x86_64.sh -b -p /usr/local/anaconda
echo 'export PATH=/usr/local/anaconda/bin:$PATH' | sudo tee /etc/profile.d/anaconda_path.sh
echo 'export LD_LIBRARY_PATH=/usr/local/anaconda/lib:$LD_LIBRARY_PATH' | sudo tee /etc/profile.d/ld_library_path.sh
source /etc/profile.d/anaconda_path.sh
echo 'Defaults    !env_reset' | sudo tee /etc/sudoers.d/env_reset
echo "Defaults    secure_path=$PATH" | sudo tee /etc/sudoers.d/secure_path
sudo conda install --yes virtualenv


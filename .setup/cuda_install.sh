# This is only for the toolkit. I didn't track the rest of the install (the drivers). More as a record than anything else
# # Install 
# sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub
# # Make a tmp dir
# mkdir "$HOME/.setup/tmp"
# tmpdir=$HOME/.setup/tmp
# # Add the nvidia apt repo
# wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin -P $tmpdir
# sudo mv "$tmpdir/cuda-ubuntu2004.pin" /etc/apt/preferences.d/cuda-repository-pin-600
# sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
# # Install as apt repo
# sudo apt update
# sudo apt install cuda
# # Add to path
# echo "# Add CUDA to path\n"'export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}' >> ~/.bashrc

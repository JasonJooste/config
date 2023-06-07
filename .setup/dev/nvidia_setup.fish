# A very robust NVIDIA install script
#!/usr/bin/env fish

set script_name nvidia.fish

function script_usage
  echo $script_name
  echo
  echo 'Options:'
  echo '  -h, --help: Show this message.'
  echo '  -d, --driver MAJOR: Version of driver to install.'
  echo '  -c, --cuda MAJOR.MINOR: Version of CUDA to install.'
end

set variables \
  _flag_help \
  _flag_driver \
  _flag_cuda \
  packages_install \
  packages_purge
for variable in $variables
  for scope in --universal --global --local
    set --erase $scope $variable
  end
end

argparse \
  --name $script_name \
  'h/help' \
  'd/driver=' \
  'c/cuda=' \
  -- $argv
or begin
  script_usage
  exit 1
end

if test -n "$_flag_help"
  script_usage
  exit 0
end

if not string match --entire --regex --quiet '^((\*)|(\d+))$' $_flag_driver
  script_usage
  exit 2
end

if test -n "$_flag_cuda"
  if not string match --entire --regex --quiet '^((\*)|(\d+))\.((\*)|(\d+))$' $_flag_cuda
    script_usage
    exit 3
  end
end

echo "Enumerating..."

function package_format
  set package $argv[1]
  set driver $argv[2]
  set cuda $argv[3]

  set driver_major $driver
  set cuda_major (echo $cuda | cut -d . -f 1)
  set cuda_minor (echo $cuda | cut -d . -f 2)

  set package (string replace DRIVER_MAJOR $driver_major $package)
  set package (string replace CUDA_MAJOR_MINOR $cuda_major-$cuda_minor $package)
  set package (string replace CUDA_MAJOR $cuda_major $package)

  echo $package
end

set packages_driver \
  libnvidia-cfg1-DRIVER_MAJOR \
  libnvidia-common-DRIVER_MAJOR \
  libnvidia-compute-DRIVER_MAJOR \
  libnvidia-decode-DRIVER_MAJOR \
  libnvidia-encode-DRIVER_MAJOR \
  libnvidia-extra-DRIVER_MAJOR \
  libnvidia-fbc1-DRIVER_MAJOR \
  libnvidia-gl-DRIVER_MAJOR \
  libxnvctrl0 \
  nvidia-compute-utils-DRIVER_MAJOR \
  nvidia-dkms-DRIVER_MAJOR \
  nvidia-driver-DRIVER_MAJOR \
  nvidia-kernel-common-DRIVER_MAJOR \
  nvidia-kernel-source-DRIVER_MAJOR \
  nvidia-modprobe \
  nvidia-prime \
  nvidia-settings \
  nvidia-utils-DRIVER_MAJOR \
  xserver-xorg-video-nvidia-DRIVER_MAJOR

for package in $packages_driver
  set install_version (package_format $package $_flag_driver $_flag_cuda)
  set packages_install $packages_install $install_version
end

for package in $packages_driver
  set any_version (package_format $package '*' '*.*')
  for installed in (dpkg --get-selections $any_version 2> /dev/null | cut -f 1 | cut -d : -f 1)
    set packages_purge $packages_purge $installed
  end
end

set packages_cuda \
  cuda-cccl-CUDA_MAJOR_MINOR \
  cuda-command-line-tools-CUDA_MAJOR_MINOR \
  cuda-compiler-CUDA_MAJOR_MINOR \
  cuda-CUDA_MAJOR_MINOR \
  cuda-cudart-CUDA_MAJOR_MINOR \
  cuda-cudart-dev-CUDA_MAJOR_MINOR \
  cuda-cuobjdump-CUDA_MAJOR_MINOR \
  cuda-cupti-CUDA_MAJOR_MINOR \
  cuda-cupti-dev-CUDA_MAJOR_MINOR \
  cuda-cuxxfilt-CUDA_MAJOR_MINOR \
  cuda-demo-suite-CUDA_MAJOR_MINOR \
  cuda-documentation-CUDA_MAJOR_MINOR \
  cuda-driver-dev-CUDA_MAJOR_MINOR \
  cuda-drivers \
  cuda-drivers-DRIVER_MAJOR \
  cuda-gdb-CUDA_MAJOR_MINOR \
  cuda-libraries-CUDA_MAJOR_MINOR \
  cuda-libraries-dev-CUDA_MAJOR_MINOR \
  cuda-nsight-compute-CUDA_MAJOR_MINOR \
  cuda-nsight-CUDA_MAJOR_MINOR \
  cuda-nsight-systems-CUDA_MAJOR_MINOR \
  cuda-nvcc-CUDA_MAJOR_MINOR \
  cuda-nvdisasm-CUDA_MAJOR_MINOR \
  cuda-nvml-dev-CUDA_MAJOR_MINOR \
  cuda-nvprof-CUDA_MAJOR_MINOR \
  cuda-nvprune-CUDA_MAJOR_MINOR \
  cuda-nvrtc-CUDA_MAJOR_MINOR \
  cuda-nvrtc-dev-CUDA_MAJOR_MINOR \
  cuda-nvtx-CUDA_MAJOR_MINOR \
  cuda-nvvp-CUDA_MAJOR_MINOR \
  cuda-opencl-CUDA_MAJOR_MINOR \
  cuda-opencl-dev-CUDA_MAJOR_MINOR \
  cuda-profiler-api-CUDA_MAJOR_MINOR \
  cuda-runtime-CUDA_MAJOR_MINOR \
  cuda-sanitizer-CUDA_MAJOR_MINOR \
  cuda-toolkit-config-common \
  cuda-toolkit-CUDA_MAJOR_MINOR \
  cuda-toolkit-CUDA_MAJOR_MINOR-config-common \
  cuda-toolkit-CUDA_MAJOR-config-common \
  cuda-tools-CUDA_MAJOR_MINOR \
  cuda-visual-tools-CUDA_MAJOR_MINOR \
  gds-tools-CUDA_MAJOR_MINOR \
  libcublas-CUDA_MAJOR_MINOR \
  libcublas-dev-CUDA_MAJOR_MINOR \
  libcufft-CUDA_MAJOR_MINOR \
  libcufft-dev-CUDA_MAJOR_MINOR \
  libcufile-CUDA_MAJOR_MINOR \
  libcufile-dev-CUDA_MAJOR_MINOR \
  libcurand-CUDA_MAJOR_MINOR \
  libcurand-dev-CUDA_MAJOR_MINOR \
  libcusolver-CUDA_MAJOR_MINOR \
  libcusolver-dev-CUDA_MAJOR_MINOR \
  libcusparse-CUDA_MAJOR_MINOR \
  libcusparse-dev-CUDA_MAJOR_MINOR \
  libnpp-CUDA_MAJOR_MINOR \
  libnpp-dev-CUDA_MAJOR_MINOR \
  libnvjitlink-CUDA_MAJOR_MINOR \
  libnvjitlink-dev-CUDA_MAJOR_MINOR \
  libnvjpeg-CUDA_MAJOR_MINOR \
  libnvjpeg-dev-CUDA_MAJOR_MINOR \
  libnvvm-samples-CUDA_MAJOR_MINOR

if test -n "$_flag_cuda"
  for package in $packages_cuda
    set install_version (package_format $package $_flag_driver $_flag_cuda)
    set packages_install $packages_install $install_version
  end
end

for package in $packages_cuda
  set any_version (package_format $package '*' '*.*')
  for installed in (dpkg --get-selections $any_version 2> /dev/null | cut -f 1 | cut -d : -f 1)
    set packages_purge $packages_purge $installed
  end
end

set packages_install (string join \n $packages_install | sort | uniq | string split \n)
set packages_purge (string join \n $packages_purge | sort | uniq | string split \n)

echo "Installing..."

set ubuntu_version_id (bash -c 'source /etc/os-release && echo ${VERSION_ID/./}')
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu$ubuntu_version_id/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg --install cuda-keyring_1.1-1_all.deb
sudo apt update
sudo apt install $packages_install

echo "Purging..."

for package in $packages_purge
  if not contains $package $packages_install
    set packages_purge_dont_install $packages_purge_dont_install $package
  end
end
if test -n "$packages_purge_dont_install"
  sudo dpkg --purge $packages_purge_dont_install
end

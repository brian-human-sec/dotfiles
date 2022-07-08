#!/bin/sh

lspci -k | grep -A 2 -E "(VGA|3D)"

if [ -x "$(command -v emerge)" ]; then
  sudo emerge --update --newuse hardinfo
  sudo emerge --update --newuse mesa-progs
  sudo emerge --update --newuse linux-headers
fi

# dead code
if [ 0 -eq 1 ]; then
  sudo emerge --update --newuse x11-misc/vdpauinfo

  sudo pacman --noconfirm --needed -S vdpauinfo
  sudo pacman --noconfirm --needed -S mesa-vdpau
  sudo pacman --noconfirm --needed -S libva-utils
  sudo pacman --noconfirm --needed -S libva-vdpau-driver libvdpau-va-gl
  pacman -Qi nvidia
  pacman -Qi nvidia-utils
  pacman -Qi nvidia-libgl

  sudo xbps-install -y mesa-vdpau
  sudo xbps-install -y mesa-vaapi

  sudo apt install -y vulkan-utils

  echo "i believe this is for AMD graphics cards"
  echo sudo pacman --noconfirm --needed -S vulkan-radeon
  echo sudo xbps-install -y xf86-video-amdgpu
fi

# echo "session info"
# loginctl session-status

if [ -x "$(command -v vdpauinfo)" ]; then
  echo vdpauinfo
  vdpauinfo
fi

if [ -x "$(command -v vainfo)" ]; then
  echo vainfo
  vainfo
fi

if [ -x "$(command -v vulkaninfo)" ]; then
  echo vulkaninfo
  vulkaninfo
fi

# echo Vulkan API
# echo mesa-vdpau and also libva-mesa-driver
lspci | grep VGA

lspci -v | grep VGA
# 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Cape Verde XT [Radeon HD 7770/8760 / R7 250X] (prog-if 00 [VGA controller])

lsmod | grep -i nvidia

glxinfo | grep direct

echo sudo chvt 3
echo sudo chvt 2
echo "Open tty with the shortcut - Ctl-Alt-(F1-F7)"

if [ -x "$(command -v nvidia-smi)" ]; then
  sudo nvidia-smi
  sudo nvidia-smi -q -d TEMPERATURE
  sudo nvidia-smi --query-gpu=driver_version --format=csv,noheader
  # modinfo "/usr/lib/modules/$(uname -r)/kernel/drivers/video/nvidia.ko" | grep ^version
fi

# echo VDPAU and VAAPI.
if [ -x "$(command -v nvidia-settings)" ]; then
  echo nvidia-settings
  nvidia-settings -q NvidiaDriverVersion
else
  echo "nvidia driver is not installed"
fi

echo open https://www.nvidia.com/en-us/geforce/drivers/
if [ ! -f NVIDIA-Linux-x86_64-515.57.run ]; then
  wget 'https://us.download.nvidia.com/XFree86/Linux-x86_64/515.57/NVIDIA-Linux-x86_64-515.57.run'
fi

grep "X Driver" /var/log/Xorg.0.log
lspci -k | grep -A 2 -i "VGA"
modinfo nvidia | grep version

exit 0

# vim: set ft=sh

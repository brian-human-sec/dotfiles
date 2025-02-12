#!/bin/sh

unset GEM_ROOT
unset GEM_HOME
unset GEM_PATH

VAGRANT_VER=2.2.19

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
  #sudo pacman -Rs vagrant
  sudo pacman --noconfirm --needed -S vagrant
  # gem install formatador
  # gem install bundler
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  if [ ! -f "vagrant_${VAGRANT_VER}.deb" ]; then
    wget -O "vagrant_${VAGRANT_VER}.deb" "https://releases.hashicorp.com/vagrant/${VAGRANT_VER}/vagrant_${VAGRANT_VER}_x86_64.deb"
  fi
  sudo dpkg -i vagrant_${VAGRANT_VER}.deb
  echo /opt/vagrant/bin/vagrant
  sudo apt install -y ruby`ruby -e 'puts RUBY_VERSION[/\d+\.\d+/]'`-dev
  sudo apt install -y vagrant
  sudo apt install -y zlib1g-dev libvirt-dev
elif [ "$OS" = "CentOS Linux" ]; then
  sudo yum install -y libvirt-devel.x86_64
  if [ ! -x "$(command -v vagrant)" ]; then
    sudo yum install -y https://releases.hashicorp.com/vagrant/${VAGRANT_VER}/vagrant_${VAGRANT_VER}_x86_64.rpm
  fi
  #sudo yum install -y vagrant
elif [ "$OS" = "Fedora" ]; then
  sudo dnf install -y libvirt-devel
  if [ ! -x "$(command -v vagrant)" ]; then
    sudo dnf install -y https://releases.hashicorp.com/vagrant/${VAGRANT_VER}/vagrant_${VAGRANT_VER}_x86_64.rpm
  fi
elif [ "$OS" = "Gentoo" ]; then
  sudo emerge --update --newuse vagrant
  sudo emerge --update --newuse dev-ruby/pkg-config
else
  echo "OS=$OS not yet configured."
  exit 1
fi

if ! vagrant plugin list | grep vagrant-libvirt; then
  if ! vagrant plugin install vagrant-libvirt; then
    echo failed to install vagrant-libvirt
    exit 1
  fi
fi

echo vagrant-qemu
echo vagrant-mutate
echo vagrant mutate precise32.box libvirt

exit 0

# vim: set ft=sh:

#!/usr/bin/env sh

# DEBIAN_FRONTEND=noninteractive

ARCHLINUX_PKGS="xorg-server vlc riot-desktop i3-wm handbrake dolphin-emu dbeaver terminator handbrake rofi feh dolphin-emu xorg xorg-server xorg-xeyes xorg-xinit seahorse termite rxvt-unicode gqrx gitk audacity zathura sxiv mpv gimp inkscape brave fslint grub-customizer hardinfo ksystemlog keepassxc gufw libdvdcss kdenlive obs-studio"

MINT_PKGS="vlc riot-desktop handbrake dolphin-emu vim-gtk3 xterm rofi terminator feh dolphin suckless-tools qt5ct gnome-boxes cockpit seahorse mplayer audacious gitk audacity gqrx-sdr gimp inkscape"

CENTOS_PKGS="vlc firefox riot-desktop handbrake dolphin-emu gvim terminator feh dolphin suckless-tools qt5ct gnome-boxes cockpit seahorse mplayer audacious rxvt gimp inkscape"

UBUNTU_PKGS="gqrx vlc handbrake dolphin-emu vim-gtk3 terminator feh dolphin gnome-boxes cockpit seahorse mplayer audacious gitk audacity gimp inkscape cpu-x kdenlive obs-studio"

FREEBSD_PKGS="vlc firefox riot-desktop i3-wm handbrake dolphin-emu vim-gtk3 xterm rofi terminator qt5ct audacity gimp inkscape"

GENTOO_PKGS="vlc handbrake terminator rofi games-emulation/dolphin seahorse xterm audacity gimp inkscape kdenlive"

VOID_PKGS="gimp incscape vlc handbrake terminator audacity dolphin-emu zathura dbeaver"

SOLUS_PKGS="gimp inkscape vlc handbrake terminator audacity dolphin-emu zathura dbeaver"

FEDORA_PKGS="gvim gqrx keepassxc"

MACOS_PKGS="alacritty iterm2"

if [ "$OS" = "Arch Linux" ]; then
  FAILURE=""
  for i in $ARCHLINUX_PKGS; do
    if ! sudo pacman --noconfirm --needed -S "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  yay -S cpu-x
  yay -S stacer
  yay -S nutty
  echo failures "$FAILURE"
elif [ "$OS" = "Darwin" ]; then
  brew cask install vlc
  brew cask install alacritty
  brew cask install iterm2
elif [ "$OS" = "Solus" ]; then
  echo
  FAILURE=""
  for i in $SOLUS_PKGS; do
    if ! sudo eopkg install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo failures "$FAILURE"
elif [ "$OS" = "Gentoo" ]; then
  FAILURE=""
  for i in $GENTOO_PKGS; do
    echo sudo emerge -uf "$i"
    sudo emerge -uf "$i"
  done
  for i in $GENTOO_PKGS; do
    if ! sudo emerge --update --newuse "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "Failures: $FAILURE"
elif [ "$OS" = "Linux Mint" ]; then
  echo sudo apt-add-repository ppa:dolphin-emu/ppa
  wget -O - https://dbeaver.io/debs/dbeaver.gpg.key | sudo apt-key add -
  echo "deb https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list
  echo "deb https://deb.etcher.io stable etcher" | sudo tee /etc/apt/sources.list.d/balena-etcher.list
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61
  sudo add-apt-repository ppa:danielrichter2007/grub-customizer
  sudo apt update
  sudo apt install -y dbeaver-ce
  sudo apt install -y balena-etcher-electron
  sudo apt install -y grub-customizer
  FAILURE=""
  for i in $MINT_PKGS; do
    if ! sudo apt install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "failures $FAILURE"
elif [ "$OS" = "Ubuntu" ]; then
  for i in $UBUNTU_PKGS; do
    if ! sudo apt install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "failures $FAILURE"
elif [ "$OS" = "CentOS Linux" ]; then
  FAILURE=""
  for i in $CENTOS_PKGS; do
    if ! sudo yum install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "failures $FAILURE"
elif [ "$OS" = "void" ]; then
  FAILURE=""
  for i in $VOID_PKGS; do
    if ! sudo xbps-install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "failures $FAILURE"
elif [ "$OS" = "Linux Mint" ]; then
  FAILURE=""
  for i in $UBUNTU_PKGS; do
    if ! sudo apt install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "failures $FAILURE"
elif [ "$OS" = "FreeBSD" ]; then
  FAILURE=""
  for i in $FREEBSD_PKGS; do
    if ! sudo pkg install -y "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "failures $FAILURE"
else
  echo "$OS not configured."
  exit 1
fi

echo "obs-studio - open broadcast software"
echo "kdenlive - video software"

#CPU-X
echo https://github.com/X0rg/CPU-X
#Hardinfo
echo https://github.com/lpereira/hardinfo
#Nutty
echo https://babluboy.github.io/nutty/
#Stacer
echo https://github.com/oguzhaninan/Stacer
#Ksystemlog
echo https://kde.org/applications/system/org.kde.ksystemlog
echo sudo snap install keepassxc

echo https://github.com/balena-io/etcher/releases/download/v1.5.83/balenaEtcher-1.5.83-x64.AppImage

exit 0

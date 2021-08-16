#!/usr/bin/env sh

sudo mkdir -p /usr/share/i3blocks/
#sudo cp iface cpu_usage memory /usr/share/i3blocks

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ] || [ "$OS" = "Raspbian GNU/Linux" ]; then
  # sudo apt remove -y lightdm
  # sudo apt remove -y gdm
  sudo apt install -y i3status
  sudo apt install -y i3blocks
  sudo apt install -y xterm
  sudo apt install -y i3lock
  sudo apt install -y rofi
  sudo apt install -y terminator
  sudo apt install -y feh
  sudo apt install -y ranger
  sudo apt install -y suckless-tools
  sudo apt install -y cmatrix
  sudo apt install -y libev-dev
  sudo apt install -y libasound2-dev
  sudo apt install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf xutils-dev libtool libcurl4-openssl-dev python-xcbgen
  sudo apt install -y libxcb-xrm-dev
  sudo apt install -y libmpdclient-dev
  sudo apt install -y libiw-dev
  sudo apt install -y libpulse-dev
  sudo apt install -y libxcb-composite0-dev
  sudo apt install -y xcb-proto
  sudo apt install -y libxcb-ewmh-dev
  sudo apt install -y xclip
  sudo apt install -y sxhkd
  sudo apt install -y w3m
  sudo apt install -y w3m-img
  sudo apt install -y vifm
  sudo apt install -y xserver-xephyr
  cd "$HOME/projects" || exit
  git clone git@github.com:Airblader/i3 i3-gaps
  cd i3-gaps || exit
  git checkout gaps && git pull
  autoreconf --force --install
  rm -rf build
  mkdir build
  cd build || exit
  ../configure --prefix=/usr --sysconfdir=/etc
  make
  sudo make install
elif [ "$OS" = "void" ]; then
  sudo xbps-install -y i3-gaps
  sudo xbps-install -y i3lock
  sudo xbps-install -y sxhkd
  sudo xbps-install -y i3blocks
  sudo xbps-install -y w3m
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman -Rsnc lightdm
  sudo pacman -Rsnc gdm
  sudo pacman --noconfirm --needed -S i3status
  sudo pacman --noconfirm --needed -S i3blocks
#  sudo pacman --noconfirm --needed -S i3-wm
  sudo pacman --noconfirm --needed -S i3-gaps
  sudo pacman --noconfirm --needed -S xterm
  sudo pacman --noconfirm --needed -S i3lock
  sudo pacman --noconfirm --needed -S rofi
  sudo pacman --noconfirm --needed -S termite
  sudo pacman --noconfirm --needed -S terminator
  sudo pacman --noconfirm --needed -S dmenu
  sudo pacman --noconfirm --needed -S feh
  sudo pacman --noconfirm --needed -S cmatrix
  sudo pacman --noconfirm --needed -S ranger
  sudo pacman --noconfirm --needed -S terminus-font
  sudo pacman --noconfirm --needed -S xclip
  sudo pacman --noconfirm --needed -S sxhkd
  sudo pacman --noconfirm --needed -S w3m
  sudo pacman --noconfirm --needed -S vifm
  sudo pacman --noconfirm --needed -S picom
elif [ "$OS" = "Gentoo" ]; then
  GENTOO_PKGS="x11-misc/i3status i3blocks xterm i3lock rofi terminator dmenu ranger feh cmatrix cairo libmpdclient pulseaudio i3-gaps autocutsel vimfm w3m xclip"
  FAILURE=""
  for i in $GENTOO_PKGS; do
    if ! sudo emerge --update --newuse "$i"; then
      FAILURE="$i $FAILURE"
    fi
  done
  echo "Failures: $FAILURE"
elif [ "$OS" = "Fedora" ]; then
  echo
  sudo dnf install -y i3status
  sudo dnf install -y i3-ipc
  sudo dnf install -y i3lock
  sudo dnf install -y xterm
  sudo dnf install -y dmenu
  #sudo dnf install -y dolphin
  sudo dnf install -y terminus-fonts-console
  sudo dnf install -y terminus-fonts
  sudo dnf install -y feh
  sudo dnf install -y cmatrix
  sudo dnf install -y xclip
  sudo dnf install -y sxhkd
  sudo dnf install -y w3m
  sudo dnf install -y vifm
  sudo dnf install -y picom
  sudo dnf install -y libxcb-devel xcb-util-keysyms-devel xcb-util-devel xcb-util-wm-devel xcb-util-xrm-devel yajl-devel libXrandr-devel startup-notification-devel libev-devel xcb-util-cursor-devel libXinerama-devel libxkbcommon-devel libxkbcommon-x11-devel pcre-devel pango-devel git gcc automake libcurl-devel libmpdclient-devel wireless-tools-devel pulseaudio-libs-devel xcb-proto  cairo-devel i3-devel
  cd "$HOME/projects" || exit
  #git clone https://github.com/vivien/i3blocks.git
  git clone git@github.com:vivien/i3blocks.git
  cd i3blocks || exit
  ./autogen.sh
  ./configure
  make
  sudo make install
  cd - || exit

  cd "$HOME/projects" || exit
  git clone git@github.com:Airblader/i3 i3-gaps
  cd i3-gaps || exit
  git checkout gaps && git pull
  autoreconf --force --install
  rm -rf build
  mkdir build
  cd build || exit
  ../configure --prefix=/usr --sysconfdir=/etc
  make
  sudo make install
elif [ "$OS" = "FreeBSD" ]; then
  sudo pkg install -y i3status
  sudo pkg install -y i3blocks
  sudo pkg install -y i3-gaps
  sudo pkg install -y xterm
  sudo pkg install -y i3lock
  sudo pkg install -y rofi
  sudo pkg install -y terminator
  sudo pkg install -y feh
  sudo pkg install -y ranger
  sudo pkg install -y suckless-tools
  sudo pkg install -y cmatrix
  sudo pkg install -y libev-dev
  sudo pkg install -y xcb-proto
  sudo pkg install -y libxcb-ewmh-dev
  sudo pkg install -y xclip
  sudo pkg install -y sxhkd
  sudo pkg install -y w3m
  sudo pkg install -y w3m-img
  sudo pkg install -y vifm
  sudo apt install -y xserver-xephyr
  sudo apt install -y polybar
elif [ "$OS" = "CentOS Linux" ]; then
  sudo yum install -y i3status i3 i3lock xterm i3lock terminator dmenu dolphin terminus-fonts-console terminus-fonts
else
  echo "$OS is not yet implemented."
  exit 1
fi

exit 0

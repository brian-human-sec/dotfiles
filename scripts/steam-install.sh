#!/bin/sh

cat > flatpak-overlay.conf << 'EOF'
[flatpak-overlay]
priority = 50
location = <repo-location>/flatpak-overlay
sync-type = git
sync-uri = https://github.com/fosero/flatpak-overlay.git
auto-sync = Yes
EOF

rm -rf com.valvesoftware.Steam.flatpakref*
wget https://flathub.org/repo/appstream/com.valvesoftware.Steam.flatpakref

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  # sudo pacman --noconfirm --needed -S flatpak
  # flatpak install flathub com.valvesoftware.Steam
  sudo pacman --noconfirm --needed -S steam
elif [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ]; then
  sudo apt install -y steam-installer
  sudo apt install -y flatpak
  #flatpak install --user flathub org.freedesktop.Platform.openh264
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  flatpak install --user flathub org.freedesktop.Platform/x86_64/19.08
  flatpak install --user com.valvesoftware.Steam.flatpakref
elif [ "$OS" = "CentOS Linux" ]; then
  sudo yum install -y flatpak
elif [ "$OS" = "Gentoo" ]; then
  sudo mv flatpak-overlay.conf /etc/portage/repos.conf/flatpak-overlay.conf
  sudo emerge --sync
  sudo emerge --update --newuse flatpak
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  flatpak install --user com.valvesoftware.Steam.flatpakref
elif [ "$OS" = "Solus" ]; then
  sudo eopkg install -y steam
elif [ "$OS" = "Fedora" ]; then
  flatpak install --user com.valvesoftware.Steam.flatpakref
else
  echo "$OS is not yet implemented"
  exit 1
fi

#flatpak update
flatpak remotes

exit 0

# vim: set ft=sh

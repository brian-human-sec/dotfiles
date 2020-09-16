#!/bin/sh


cat > lightdm.conf <<EOF
[SeatDefaults]
autologin-guest=false
#session-wrapper=/etc/lightdm/Xsession
#session-wrapper=/etc/X11/xinit/Xsession
session-wrapper=/etc/X11/Xsession
#autologin-user=henninb
#autologin-user-timeout=0
#pam-service=lightdm-autologin
#greeter-session=lightdm-gtk-greeter
greeter-session=slick-greeter
greeter-hide-users=false
EOF

cat > lightdm-gtk-greeter.conf <<EOF
[greeter]
background=/usr/share/backgrounds/custom/greeter.jpg
at-spi-enabled = false
EOF

cat > slick-greeter.conf <<EOF
[greeter]
background=/usr/share/backgrounds/custom/greeter.jpg
EOF

cat > accountsservice-user << EOF
[org.freedesktop.DisplayManager.AccountsService]
BackgroundFile='/usr/share/backgrounds/custom/greeter.jpg'

[User]
SystemAccount=false
EOF

cat > accountsservice-user-disable << EOF
[User]
SystemAccount=true
EOF

cat > bspwm.desktop << EOF
[Desktop Entry]
Name=bspwm
Comment=bspwm tiling window manager
Exec=bspwm
TryExec=bspwm
Type=Application
X-LightDM-DesktopName=bspwm
DesktopNames=bspwm
Keywords=tiling;wm;windowmanager;window;manager;
#X-GDM-SessionRegisters=true
EOF

cat > xmonad.desktop << EOF
[Desktop Entry]
Name=xmonad
Comment=xmonad dynamic tiling window manager
Exec=xmonad-start
TryExec=xmonad-start
Type=Application
X-LightDM-DesktopName=xmonad
DesktopNames=xmonad
Keywords=tiling;wm;windowmanager;window;manager;
#X-LightDM-SessionRegisters=true
EOF

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ]; then
  sudo apt install -y lightdm
  sudo apt install -y lightdm-gtk-greeter
  sudo apt install -y slick-greeter
  sudo apt install -y lightdm-settings
  # sudo apt install -y gdm3
  # sudo apt install -y sddm
  # sudo apt install -y lxdm
  sudo dpkg-reconfigure lightdm
#  cat /etc/X11/default-display-manager
  systemctl status display-manager
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ]; then
  sudo pacman --noconfirm --needed -S lightdm
  sudo pacman --noconfirm --needed -S lightdm-gtk-greeter
  yay -S lightdm-slick-greeter
  # echo home dir change is not required
  # echo usermod -d /var/lib/lightdm-data/lightdm lightdm
  # echo usermod -d /var/lib/lightdm lightdm
  systemctl status display-manager
elif [ "$OS" = "Gentoo" ]; then
  sudo USE="introspection elogind" emerge --update --newuse sys-apps/accountsservice
  sudo emerge --update --newuse lightdm
  sudo emerge --update --newuse lightdm-gtk-greeter

  sudo USE="introspection ipv6 tcpd elogind" emerge --update --newuse gdm

  echo /etc/conf.d/xdm
  echo DISPLAYMANAGER = "lightdm"
  #sudo rc-update add lightdm default
  sudo rc-update add dbus default
  sudo rc-update add xdm default
  sudo rc-service dbus start
  sudo rc-service xdm start
elif [ "$OS" = "Fedora" ]; then
  sudo dnf install -y lightdm
  sudo dnf install -y lightdm-gtk-greeter
  sudo dnf install -y lightdm-slick-greeter
else
  echo "OS: not configured."
  exit 1
fi

sudo mv -v slick-greeter.conf /etc/lightdm/slick-greeter.conf
sudo mv -v bspwm.desktop /usr/share/xsessions/
sudo mv -v xmonad.desktop /usr/share/xsessions/
sudo mkdir -p /usr/share/backgrounds/custom
sudo cp -p "$HOME/.config/lightdm/greeter.jpg" /usr/share/backgrounds/custom/
sudo mv -v lightdm.conf /etc/lightdm/

sudo cp -v accountsservice-user /var/lib/AccountsService/users/henninb
sudo cp -v accountsservice-user /var/lib/AccountsService/users/brian


# set startup back to startx/.initrx
# sudo systemctl set-default multi-user
# rm /etc/systemd/system/default.target
# set startup to use a dm
sudo systemctl set-default graphical
sudo systemctl daemon-reload
sudo systemctl enable lightdm
systemctl status display-manager

# echo sudo touch /etc/securetty

sudo cp -v accountsservice-user-disable /var/lib/AccountsService/users/firefox
sudo cp -v accountsservice-user-disable /var/lib/AccountsService/users/intellij
sudo cp -v accountsservice-user-disable /var/lib/AccountsService/users/arduino
sudo cp -v accountsservice-user-disable /var/lib/AccountsService/users/tomcat
sudo cp -v accountsservice-user-disable /var/lib/AccountsService/users/grafana
sudo cp -v accountsservice-user-disable /var/lib/AccountsService/users/kafka
sudo cp -v accountsservice-user-disable /var/lib/AccountsService/users/activemq
sudo cp -v "$HOME/.local/bin/xmonad-start" /usr/local/bin
sudo cp -v "$HOME/.local/bin/xmonad-log" /usr/local/bin
sudo cp -v "$HOME/.local/bin/xmonad-dbus" /usr/local/bin
sudo cp -v "$HOME/.local/bin/xmonad-exit" /usr/local/bin
# echo at-spi-bus-launcher
# echo  /etc/lightdm/users.conf
# echo /usr/libexec/at-spi-bus-launcher
# echo gnome-session-properties
# echo export NO_AT_BRIDGE=1
# echo in /etc/environment
#sudo journalctl -b -u lightdm.service

exit 0

echo dm-tool
echo dm-tool switch-to-greeter
echo lightdm --test-mode --debug

echo loginctl session-status
echo /etc/pam.d/lightdm
ls /usr/share/xgreeters
echo lightdm --show-config

echo /etc/pam.d/lightdm
echo remove pam_kwallet.so is in libpam-kwallet4 and pam_kwallet5.so by libpam-kwallet5
accountsservice
DEBUG: Registering seat with bus path /org/freedesktop/DisplayManager/Seat0
DEBUG: Loading users from org.freedesktop.Accounts
/org/freedesktop/Accounts/User1001 added
 DEBUG: User /org/freedesktop/Accounts/User1002 added
 DEBUG: User /org/freedesktop/Accounts/User1000 added
 DEBUG: User /org/freedesktop/Accounts/User1007 added
 DEBUG: User /org/freedesktop/Accounts/User64055 added
 DEBUG: User /org/freedesktop/Accounts/User1004 added
 DEBUG: User /org/freedesktop/Accounts/User1003 added
 DEBUG: User /org/freedesktop/Accounts/User1005 added
 DEBUG: User /org/freedesktop/Accounts/User1006 added

 sudo dbus-send --system --type=method_call --print-reply --dest=org.freedesktop.Accounts /org/freedesktop/Accounts/User$(id -u "$USER") org.freedesktop.Accounts.User.SetXSession string:xmonad

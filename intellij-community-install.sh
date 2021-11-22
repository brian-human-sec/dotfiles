#!/bin/sh

if [ $# -eq 1 ]; then
  VER_OVERRIDE="$1"
  echo "override=$VER_OVERRIDE"
fi

cat > '_@user_Darcula.icls' <<EOF
<scheme name="_@user_Darcula" version="142" parent_scheme="Darcula">
  <option name="FONT_SCALE" value="1.0" />
  <metaInfo>
    <property name="created">2020-01-01T13:05:54</property>
    <property name="ide">idea</property>
    <property name="ideVersion">2019.3.1.0.0</property>
    <property name="modified">2020-01-01T13:07:16</property>
    <property name="originalScheme">Darcula</property>
  </metaInfo>
  <option name="CONSOLE_FONT_NAME" value="monofur for Powerline" />
  <option name="CONSOLE_FONT_SIZE" value="16" />
  <option name="CONSOLE_LINE_SPACING" value="1.2" />
</scheme>
EOF

sudo dnf install -y jq wget curl
sudo emerge --update --newuse app-misc/jq wget curl
sudo pacman --noconfirm --needed -S jq wget curl
sudo apt install -y jq wget curl
sudo xbps-install -y jq wget curl
sudo zypper install jq wget curl

pkill -f "intellij.idea.Main"

version="IntelliJIdea2021.2"
find "$HOME/.config/JetBrains/${version}" -type d -exec touch -t "$(date +'%Y%m%d%H%M')" {} \;
rm -rf "$HOME/.config/JetBrains/${version}/eval"
rm -rf "$HOME/.config/JetBrains/${version}/options/other.xml"
rm -rf "$HOME/.java/.userPrefs/jetbrains"

VER=$(curl -s 'https://data.services.jetbrains.com/products/releases?code=IIU&latest=true&type=release&build=&_=1581558835218' | jq '.IIU[0] .version' | cut -d \" -f2)

# if  [ ! -z "$VER_OVERRIDE" ]; then
#   VER=${VER_OVERRIDE}
# fi

# https://download.jetbrains.com/idea/ideaIC-2021.2.3.tar.gz
if [ ! -f "ideaIC-${VER}.tar.gz" ]; then
  rm -rf ideaIC-*.tar.gz
  if ! scp "pi@pi:/home/pi/downloads/ideaIC-${VER}.tar.gz" .; then
    if ! wget "https://download.jetbrains.com/idea/ideaIC-${VER}.tar.gz"; then
      echo download failed.
      exit 1
    fi
    scp "ideaIC-${VER}.tar.gz" "pi@pi:/home/pi/downloads"
  fi
fi

if [ "${OS}" = "FreeBSD" ]; then
  sudo pw group add intellij
else
  sudo groupadd intellij
  sudo useradd -s /sbin/nologin -g intellij intellij
fi

if [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed -S net-tools psmisc
  sudo rm -rf /opt/intellij
  sudo rm -rf /opt/idea-IC-*/
  sudo tar -xvf "ideaIC-${VER}.tar.gz" -C /opt
  sudo ln -sfn /opt/idea-IC-* /opt/intellij
  sudo chown -R intellij:intellij /opt/idea-IC-*/
  sudo chmod -R 775 /opt/idea-IC-*/
elif [ "$OS" = "openSUSE Leap" ]; then
  sudo rm -rf /opt/intellij
  sudo rm -rf /opt/idea-IC-*/
  sudo tar -xvf "ideaIC-${VER}.tar.gz" -C /opt
  sudo ln -sfn /opt/idea-IC-* /opt/intellij
  sudo chown -R intellij:intellij /opt/idea-IC-*/
  sudo chmod -R 775 /opt/idea-IC-*/
elif [ "$OS" = "void" ]; then
  sudo rm -rf /opt/intellij
  sudo rm -rf /opt/idea-IC-*/
  sudo tar -xvf "ideaIC-${VER}.tar.gz" -C /opt
  sudo ln -sfn /opt/idea-IC-* /opt/intellij
  sudo chown -R intellij:intellij /opt/idea-IC-*/
  sudo chmod -R 775 /opt/idea-IC-*/
elif [ "$OS" = "Solus" ]; then
  sudo mkdir -p /opt
  sudo chmod 755 /opt
  sudo rm -rf /opt/intellij
  sudo rm -rf /opt/idea-IC-*/
  sudo tar -xvf "ideaIC-${VER}.tar.gz" -C /opt
  sudo ln -sfn /opt/idea-IC-* /opt/intellij
  sudo chown -R intellij:intellij /opt/idea-IC-*/
  sudo chmod -R 775 /opt/idea-IC-*/
elif [ "$OS" = "FreeBSD" ]; then
  sudo mkdir -p /opt
  sudo rm -rf /opt/intellij
  sudo rm -rf /opt/intellij-*/
  sudo tar -xvf "ideaIC-${VER}.tar.gz" -C /opt
  sudo ln -sfn /opt/idea-IC-* /opt/intellij
  sudo chown -R intellij:intellij /opt/idea-IC-*/
  sudo chmod -R 775 /opt/idea-IC-*/
elif [ "$OS" = "openSUSE Tumbleweed" ]; then
  sudo rm -rf /opt/intellij
  sudo rm -rf /opt/idea-IC-*/
  sudo tar -xvf "ideaIC-${VER}.tar.gz" -C /opt
  sudo ln -sfn /opt/idea-IC-* /opt/intellij
  sudo chown -R intellij:intellij /opt/idea-IC-*/
  sudo chmod -R 775 /opt/idea-IC-*/
elif [ "$OS" = "Gentoo" ]; then
  sudo rm -rf /opt/intellij
  sudo rm -rf /opt/idea-IC-*/
  sudo tar -xvf "ideaIC-${VER}.tar.gz" -C /opt
  sudo ln -sfn /opt/idea-IC-* /opt/intellij
  sudo chown -R intellij:intellij /opt/idea-IC-*/
  sudo chmod -R 775 /opt/idea-IC-*/
elif [ "$OS" = "Linux Mint" ] || [  "$OS" = "Ubuntu" ]; then
  sudo apt install -y net-tools psmisc
  sudo rm -rf /opt/intellij
  sudo rm -rf /opt/idea-IC-*/
  sudo tar -xvf "ideaIC-${VER}.tar.gz" -C /opt
  sudo ln -sfn /opt/idea-IC-* /opt/intellij
  sudo chown -R intellij:intellij /opt/idea-IC-*/
  sudo chmod -R 775 /opt/idea-IC-*/
elif [ "$OS" = "Fedora" ]; then
  sudo rm -rf /opt/intellij
  sudo rm -rf /opt/idea-IC-*/
  sudo tar -xvf "ideaIC-${VER}.tar.gz" -C /opt
  sudo ln -sfn /opt/idea-IC-* /opt/intellij
  sudo chown -R intellij:intellij /opt/idea-IC-*/
  sudo chmod -R 775 /opt/idea-IC-*/
elif [ "$OS" = "CentOS Linux" ]; then
  sudo yum install -y net-tools
  sudo rm -rf /opt/intellij
  sudo rm -rf /opt/idea-IC-*/
  sudo tar -xvf "ideaIC-${VER}.tar.gz" -C /opt
  sudo ln -sfn /opt/idea-IC-* /opt/intellij
  sudo chown -R intellij:intellij /opt/idea-IC-*/
  sudo chmod 775 /opt/idea-IC-*/
else
  echo "$OS is not yet implemented."
  exit 1
fi

if [ "${OS}" = "FreeBSD" ]; then
  echo "FreeBSD"
  sudo pw usermod $(whoami) -G intellij
else
  sudo usermod -a -G intellij "$(whoami)"
fi
echo "$VER"

exit 0
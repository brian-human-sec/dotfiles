#!/bin/sh

cat > mpd.conf <<EOF
db_file "/var/lib/mpd/tag_cache"
music_directory "/var/lib/mpd/music"
playlist_directory "/var/lib/mpd/playlists"

# user "mpd"
#bind_to_address "::1"
bind_to_address "127.0.0.1"
# bind_to_address "any"
port "6600"

auto_update "yes"

pid_file "/var/mpd/pid"
# pid_file "/run/mpd/pid"
state_file "/var/lib/mpd/state"
sticker_file "/var/lib/mpd/sticker.sql"
log_file "/var/log/mpd/mpd.log"

input {
  enabled "no"
  plugin "qobuz"
}

input {
  enabled "no"
  plugin "tidal"
}

decoder {
  plugin "wildmidi"
  enabled "no"
}

# aplay --list-device
audio_output {
  type "pulse"
  name "pulse audio"
  server "127.0.0.1"
}
EOF

cat > musicpd.conf <<EOF
db_file "/var/lib/mpd/tag_cache"
music_directory "/var/lib/mpd/music"
playlist_directory "/var/lib/mpd/playlists"

# user "mpd"
#bind_to_address "::1"
bind_to_address "127.0.0.1"
# bind_to_address "any"
port "6600"

auto_update "yes"

pid_file "/var/mpd/pid"
# pid_file "/run/mpd/pid"
state_file "/var/lib/mpd/state"
sticker_file "/var/lib/mpd/sticker.sql"
log_file "/var/log/mpd/mpd.log"

input {
  enabled "no"
  plugin "qobuz"
}

input {
  enabled "no"
  plugin "tidal"
}

decoder {
  plugin "wildmidi"
  enabled "no"
}
EOF

if [ "$OS" = "Linux Mint" ] || [ "$OS" = "Ubuntu" ]; then
  sudo apt install -y mpd
  sudo apt install -y mpc
  sudo apt install -y ncmpcpp
elif [ "$OS" = "Arch Linux" ] || [ "$OS" = "Manjaro Linux" ] || [ "$OS" = "ArcoLinux" ]; then
  sudo pacman --noconfirm --needed -S mpd
  sudo pacman --noconfirm --needed -S mpc
  sudo pacman --noconfirm --needed -S ncmpcpp
  yay -S ashuffle-git
elif [ "$OS" = "Gentoo" ]; then
  echo
  sudo emerge --update --newuse media-sound/mpd
  sudo emerge --update --newuse media-sound/mpc
  sudo emerge --update --newuse ncmpcpp
elif [ "$OS" = "FreeBSD" ]; then
  sudo pkg install -y musicpd
  sudo pkg install -y musicpc
  sudo pkg install -y ncmpcpp
  echo
else
  echo "OS is not configured"
  exit 1
fi

sudo useradd mpd -s /sbin/nologin

if [ "${OS}" = "FreeBSD" ]; then
  sudo mv -v musicpd.conf /usr/local/etc/musicpd.conf
  sudo touch /var/lib/mpd/tag_cache
else
  sudo mv -v mpd.conf /etc/mpd.conf
fi
sudo mkdir -p /var/log/mpd
sudo mkdir -p /var/lib/mpd/playlists
sudo chmod g+w /var/lib/mpd/playlists
sudo mkdir -p /var/lib/mpd/music
sudo chown -R mpd:audio /var/log/mpd /var/lib/mpd
sudo chown -R mpd:mpd /var/log/mpd /var/lib/mpd
sudo chmod g+wx /var/lib/mpd/music/

if [ "${OS}" = "FreeBSD" ]; then
  sudo pw usermod "$(whoami)" -G mpd
else
  sudo usermod -a -G mpd "$(id -un)"
  sudo usermod -a -G audio "$(id -un)"
  sudo usermod -a -G pulse "$(id -un)"
  sudo usermod -a -G pulse-access "$(id -un)"
fi

[ -f "*.mp3" ] && sudo mv -v ~/media/*.mp3 /var/lib/mpd/music/

if [ "${OS}" = "FreeBSD" ]; then
  sudo service musicpd start
else
  if [ -x "$(command -v systemctl)" ]; then
    sudo systemctl disable mpd.socket
    sudo systemctl stop mpd.socket
    sudo systemctl enable mpd.service
    sudo systemctl start mpd.service
  else
    echo "am i gentoo"
  fi
fi

# cd ~/projects || exit
# git clone git@github.com:joshkunz/ashuffle.git
# git submodule update --init --recursive
# meson -Dbuildtype=release build
# ninja -C build install
# cd - || exit

echo cp -v /usr/share/gdm/default.pa ~/.config/pulse/
nowplaying=$(mpc -f "%track%. %artist% - %title%" | sed -n '1p')
playing=$(mpc | grep playing)
nowstatus=$(mpc | sed -n '2p' | cut -d ' ' -f1)
echo "$nowplaying $playing $nowstatus"

# sudo ln -s "$HOME/media" /var/lib/mpd/music/media

cd ~/media || exit
find . -type f -name "*.mp3" > all.m3u
cp -v all.m3u /var/lib/mpd/playlists/
cd - || exit

mpc update
mpc load all.m3u
mpc load all

exit 0

# vim: set ft=sh

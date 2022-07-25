#!/bin/sh

cat << EOF > dbeaver-flatpak 
#!/bin/sh

flatpak run io.dbeaver.DBeaverCommunity

exit 0
# vim: set ft=sh:
EOF

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak --user -y install flathub io.dbeaver.DBeaverCommunity

chmod 755 dbeaver-flatpak
mv -v dbeaver-flatpak "$HOME/.local/bin/"

exit 0

# vim: set ft=sh:

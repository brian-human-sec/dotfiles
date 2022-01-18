#!/bin/sh

cat > 99-magic-kbd.rules <<EOF
ACTION=="add", ATTRS{idVendor}=="05ac", ATTRS{idProduct}=="0267", RUN+="/usr/local/bin/magic"
EOF

cat > magic << 'EOF'
export DISPLAY=:0
xmodmap -e "keycode 169 = Insert"
xmodmap -e "keycode 66 = Escape"
echo "$(date) magic-keyboard" > /tmp/magic.txt
EOF

sudo mkdir -p /etc/udev/rules.d/

chmod 755 magic
sudo mv -v 99-magic-kbd.rules /etc/udev/rules.d/
sudo mv -v magic /usr/local/bin/

sudo udevadm control --reload-rules
# sudo udevadm control -R
sudo udevadm control --reload

# xinput | grep -i 'Mechanical Keyboard'
echo udevadm monitor --udev
echo "lsusb | grep 'Magic Keyboard'"

echo "$(date) magic-keyboard" > /tmp/magic.txt

exit 0

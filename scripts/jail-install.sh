#!/bin/sh

mkdir -p "/opt/jails/"
sudo bsdinstall jail "/opt/jails/www"


cat << EOF > "$HOME/tmp/jail.conf"
www {
   host.hostname = www.lan;
   ip4.addr = 192.168.10.27;
   path = /home/henninb/jails/www;
   mount.devfs;
   exec.start = "/bin/sh /etc/rc";
   exec.stop = "/bin/sh /etc/rc.shutdown";
}
EOF

sudo cp -v "$HOME/tmp/jail.conf" /etc/jail.conf
sudo sysrc hald_enable=YES
echo 'ifconfig_re0_alias0="inet 192.168.10.27"'
sudo service jail start www
jls
sudo jexec 1 csh
sudo jexec 1 sh

# if [ "$OS" = "FreeBSD" ]; then
#   sudo pkg install -y ezjail
#   sudo sysrc ezjail_enable="YES"
#   sudo sysrc cloned_interfaces="bridge0 tap0 bridge1 tap1 bridge2 tap2 lo1"
# fi

exit 0

# vim: set ft=sh

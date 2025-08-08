#!/usr/bin/env bash


sudo rm -rf /mnt/config/bind
sudo mkdir /mnt/config/bind
sudo chown user:user /mnt/config/bind

git clone --single-branch --branch main-config git@github.com:ponydog6/bind.git /mnt/config/bind/

rm -rf /mnt/config/bind/.git

sudo chown -R root:named /mnt/config
sudo find /mnt/config/ -type f -exec chmod 640 {} \;


. <(sudo cat /etc/named/named.env)
sudo named-checkconf -z "$NAMEDCONF"


sudo rndc reload

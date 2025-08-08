#!/usr/bin/env bash


sudo mkdir /mnt/secrets
sudo cp secrets/* /mnt/secrets/

sudo chown -R root:named /mnt/secrets
sudo chown user:user /mnt/secrets/github_ed25519
sudo chmod 400 /mnt/secrets/github_ed25519
sudo chmod 640 /mnt/secrets/rndc-key


sudo mkdir -p /mnt/config/bind
sudo chown user:user /mnt/config/bind

git clone --single-branch --branch main-config git@github.com:ponydog6/bind.git /mnt/config/bind/

rm -rf /mnt/config/bind/.git

sudo chown -R root:named /mnt/config
sudo find /mnt/config/ -type f -exec chmod 640 {} \;


sudo -H -u named bash -c 'named.sh'


tail -f /dev/null

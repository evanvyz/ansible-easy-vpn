#!/bin/bash -uxe
# A bash script that prepares the OS
# before running the Ansible playbook

# root or not
if [[ $EUID -ne 0 ]]; then
  SUDO='sudo -H'
else
  SUDO=''
fi

ENV='DEBIAN_FRONTEND=noninteractive'
$SUDO $ENV apt update -y;
$SUDO $ENV yes | apt-get -o Dpkg::Options::="--force-confold" -fuyqq dist-upgrade;
$SUDO $ENV yes | apt-get -o Dpkg::Options::="--force-confold" -fuyqq install software-properties-common curl git mc vim facter python3 python3-setuptools python3-apt python3-pip python3-passlib python3-wheel python3-bcrypt aptitude -y;
[ $(uname -m) == "aarch64" ] && $SUDO $ENV yes | apt install gcc python3-dev libffi-dev libssl-dev make -yqq;

$SUDO pip3 install ansible -U &&
[ -d "$HOME/ansible-easy-vpn" ] || git clone https://github.com/notthebee/ansible-easy-vpn

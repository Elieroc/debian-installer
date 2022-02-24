#! /bin/bash

### Post-install of Debian-Base

# Move user to sudo group
usermod -a -G sudo user
apt remove -y git

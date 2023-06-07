#!/bin/sh

set -e

######### configuration

# source for suckless utils
REPOS="https://github.com/dogeystamp"
# source for dotfiles
DOTREPO="https://github.com/dogeystamp/dots"

# you have to change autologin too for this
# /etc/systemd/system/getty@tty1.service.d/autologin.conf
LIVEUSER=erus
PASSWORD=toor

####################

PROJHOME="/root/src"
mkdir -p "$PROJHOME"

# install suckless utilities
for i in dwm st slock dmenu; do
    if ! command -v "$i"; then
        git clone "$REPOS"/"$i".git "$PROJHOME"/"$i"
        make -C "$PROJHOME"/"$i" install
    fi
done

# delete skel items
rm -f /etc/skel/{.bash_logout,.bash_profile,.bashrc,.screenrc,.zshrc}

if [ ! -d /etc/skel/dots ]; then
	git clone "$DOTREPO" /etc/skel/dots
else
	git -C /etc/skel/dots/ pull
fi
/etc/skel/dots/dotinstall.sh -d /etc/skel

useradd -m -G users,wheel,audio,video -s /bin/bash $LIVEUSER
echo "$LIVEUSER:$PASSWORD" | chpasswd -c SHA512

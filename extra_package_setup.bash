#!/bin/bash
APT_PACKAGES="indicator-multiload spotify-client cairo-dock cairo-dock-plug-ins gummi
	      texlive-full gimp steam"

#if [[ $EUID -ne 0 ]]; then
#   echo "This script must be run as root" 1>&2
#   exit 1
#fi

# 1. Add the Spotify repository signing key to be able to verify downloaded packages
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886

# 2. Add the Spotify repository
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

# Add Cairo dock repo
echo "deb http://download.tuxfamily.org/glxdock/repository/ubuntu $(lsb_release -sc) cairo-dock ## Cairo-Dock-Stable" | sudo tee -a /etc/apt/sources.list
wget -q http://download.tuxfamily.org/glxdock/repository/cairo-dock.gpg -O- | sudo apt-key add -

# 3. Update list of available packages
sudo apt-get update

# Install all apt packages
sudo apt-get install -y $APT_PACKAGES


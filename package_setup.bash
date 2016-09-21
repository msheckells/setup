#!/bin/bash
APT_PACKAGES="vim git cmake-gui build-essential python-catkin-tools ros-indigo-desktop 
              nvidia-cg-toolkit libois-dev libois-1.3.0 libeigen3-dev"

#if [[ $EUID -ne 0 ]]; then
#   echo "This script must be run as root" 1>&2
#   exit 1
#fi

# Add ros source list
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
# Setup ros keys
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net --recv-key 0xB01FA116
sudo apt-get update

# Install all apt packages
sudo apt-get install -y $APT_PACKAGES

# Install packages from source
cd
mkdir src
cd src

# opencv
OPENCV_DIR="opencv-2.4.11"
wget https://github.com/Itseez/opencv/archive/2.4.11.zip 
unzip 2.4.11.zip 
rm 2.4.11.zip
cd $OPENCV_DIR
mkdir build
cd build 
cmake ..
make -j4
sudo make install -j4

# ogre
cd ~/src
wget https://sourceforge.net/projects/ogre/files/ogre/1.8/1.8.1/ogre_src_v1-8-1.tar.bz2
tar -xvf ogre_src_v1-8-1.tar.bz2
rm ogre_src_v1-8-1.tar.bz2
cd ogre_src_v1-8-1
mkdir build
cd build
cmake .. -DFREETYPE_INCLUDE_DIR=/usr/include/freetype2
make -j4
sudo make install -j4

# dsl
cd ~/src
git clone git@git.lcsr.jhu.edu:ggarime1/dsl.git
cd dsl
mkdir build
cd build
cmake ..
make -j4
sudo make install -j4

# gcop
cd ~/src
git clone git@git.lcsr.jhu.edu:mkobila1/gcop.git
cd gcop
mkdir build
cd build
cmake ..
make -j4
sudo make install -j4


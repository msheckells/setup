#!/bin/bash
APT_PACKAGES="vim git cmake-gui build-essential python-catkin-tools ros-indigo-desktop 
              nvidia-cg-toolkit libois-dev libois-1.3.0 libeigen3-dev freeglut3-dev
              python2.7 python-pip libav-tools python-scipy libblas-dev liblapack-dev 
              libatlas-base-dev gfortran ros-indigo-enu ros-indigo-gazebo-msgs
              ros-indigo-camera-info-manager libusb-1.0-0-dev ros-indigo-pcl-conversions
              ros-indigo-pcl-ros ros-indigo-stereo-image-proc ros-indigo-gps-common
              ros-indigo-ar-track-alvar-msgs ros-indigo-map-server ros-indigo-image-view"

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

#pcl
cd ~/src
git clone https://github.com/PointCloudLibrary/pcl.git
cd pcl
mkdir build
cd build
cmake ..
make -j4
sudo make install -j5

#sophus
cd ~/src
git clone https://github.com/stonier/sophus.git
cd sophus
mkdir build
cd build
cmake ..
make -j4
sudo make install -j5
sudo cp /usr/local/share/sophus/sophusConfig.cmake /usr/share/cmake-2.8/Modules/.

#toon
cd ~/src
wget https://www.edwardrosten.com/cvd/TooN-2.2.tar.gz
tar -zxvf TooN-2.2.tar.gz
rm TooN-2.2.tar.gz
cd TooN-2.2
./configure
sudo make install

#object_renderer
cd ~/src
git clone https://github.com/msheckells/object_renderer.git
cd object_renderer
mkdir build
cd build
cmake ..
make -j4
sudo make install

# ceres
cd ~/src
git clone https://ceres-solver.googlesource.com/ceres-solver
cd ceres-solver
git checkout 1.10.0rc2
mkdir build
cd build
cmake .. -DBUILD_SHARED_LIBS
make -j4
sudo make install

# gcop
cd ~/src
git clone git@git.lcsr.jhu.edu:mkobila1/gcop.git
cd gcop
mkdir build
cd build
cmake ..
make -j4
sudo make install -j4

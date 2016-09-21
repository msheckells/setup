#!/bin/bash
# Setup ros env
ROS_WORKSPACE="indigo_workspace"
cd
if [ -d "$ROS_WORKSPACE" ]; then
  echo "ROS workspace directory $ROS_WORKSPACE already exists...aborting setup" 1>&2
  exit 1
fi
mkdir $ROS_WORKSPACE
catkin init --workspace $ROS_WORKSPACE

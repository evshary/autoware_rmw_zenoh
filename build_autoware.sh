#!/bin/bash

source /opt/ros/humble/setup.bash

if [ ! -d "autoware" ]; then
    git clone https://github.com/autowarefoundation/autoware.git
    cd autoware || exit
    mkdir src
    vcs import src < autoware.repos
    rosdep update
    rosdep install -r -y --from-paths src --ignore-src --rosdistro "$ROS_DISTRO"
    cd .. || exit
fi

cd autoware || exit
# Default build
colcon build --symlink-install
# Release build
#colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release

#!/bin/bash

source /opt/ros/humble/setup.bash

if [ ! -d "autoware" ]; then
    git clone https://github.com/autowarefoundation/autoware.git
    cd autoware || exit
    mkdir src
    vcs import src < autoware.repos
    rosdep update
    rosdep install -y --from-paths src --ignore-src --rosdistro "$ROS_DISTRO"
    cd .. || exit
fi

cd autoware || exit
colcon build --symlink-install

#!/bin/bash

source /opt/ros/humble/setup.bash

if [ ! -d "autoware" ]; then
    git clone https://github.com/autowarefoundation/autoware.git
    cd autoware || exit
    git checkout d09350cf41242b86dce13f100267cb197cbf41f4
    mkdir src
    vcs import src < autoware.repos
    rosdep update
    rosdep install -r -y --from-paths src --ignore-src --rosdistro "$ROS_DISTRO"
    cd .. || exit

    # Apply composable node thread limit patch
    cd autoware/src/universe/autoware.universe || exit
    git apply ../../../../patch/thread_limit.patch
    cd ../../.. || exit
fi

cd autoware || exit
# Default build
colcon build --symlink-install
# Release build
#colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release

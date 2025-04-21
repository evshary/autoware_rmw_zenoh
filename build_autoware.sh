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

    # This patch runs behavior_path_planner in a separate container with one thread
    # to avoid a GuardCondition use-after-free issue when using rmw_zenoh with multi-threaded executor.
    # Known issue in ROS 2 Humble; fixed in Rolling (2025.04+), not backported.
    #
    # Related issues:
    # - https://github.com/ros2/rmw_zenoh/issues/608
    # - https://github.com/ros2/rclcpp/issues/2820
    cd autoware/src/universe/autoware.universe || exit
    git apply ../../../../patch/thread_limit.patch
    cd ../../.. || exit
fi

cd autoware || exit
# Default build
colcon build --symlink-install
# Release build
#colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release

#!/bin/bash

if [ ! -d "rmw_zenoh" ]; then
    mkdir rmw_zenoh/src -p
    cd rmw_zenoh/src || exit
    git clone https://github.com/ros2/rmw_zenoh.git -b humble
    cd .. || exit
    rosdep install --from-paths src --ignore-src --rosdistro humble -y
    cd .. || exit
fi

cd rmw_zenoh || exit
source /opt/ros/humble/setup.bash
colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release

#!/bin/bash

export RMW_IMPLEMENTATION=rmw_zenoh_cpp
#export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

LOG_PATH=zenoh_log/rviz/$(date '+%Y-%m-%d_%H:%M:%S')/
mkdir -p "${LOG_PATH}"

source /opt/ros/humble/setup.bash
source autoware_ws/install/setup.bash
source rmw_zenoh_ws/install/setup.bash
RUST_LOG=z=debug rviz2 -d ./autoware_ws/install/autoware_launch/share/autoware_launch/rviz/autoware.rviz 2>&1 | tee "${LOG_PATH}"/rviz.log

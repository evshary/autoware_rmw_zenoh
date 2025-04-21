#!/bin/bash

export RMW_IMPLEMENTATION=rmw_zenoh_cpp

LOG_PATH=zenoh_log/zenohd/$(date '+%Y-%m-%d_%H:%M:%S')/
mkdir -p "${LOG_PATH}"

source /opt/ros/humble/setup.bash
source rmw_zenoh_ws/install/setup.bash
RUST_LOG=z=debug ros2 run rmw_zenoh_cpp rmw_zenohd 2>&1 | tee "${LOG_PATH}"/zenohd.log

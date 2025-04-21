#!/bin/bash

export RMW_IMPLEMENTATION=rmw_zenoh_cpp
#export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

LOG_PATH=zenoh_log/autoware/$(date '+%Y-%m-%d_%H:%M:%S')/
mkdir -p "${LOG_PATH}"

if [ ! -d "$HOME/autoware_map" ]; then
    gdown -O ~/autoware_map/ 'https://docs.google.com/uc?export=download&id=1499_nsbUbIeturZaDj7jhUownh5fvXHd'
    unzip -d ~/autoware_map ~/autoware_map/sample-map-planning.zip
fi

source /opt/ros/humble/setup.bash
source autoware_ws/install/setup.bash
source rmw_zenoh_ws/install/setup.bash
RUST_LOG=z=debug ros2 launch autoware_launch planning_simulator.launch.xml \
        map_path:="$HOME"/autoware_map/sample-map-planning \
        vehicle_model:=sample_vehicle \
        sensor_model:=sample_sensor_kit \
        rviz:=false 2>&1 | tee "${LOG_PATH}"/autoware.log

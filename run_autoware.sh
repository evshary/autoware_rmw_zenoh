#!/bin/bash

export RMW_IMPLEMENTATION=rmw_zenoh_cpp

source /opt/ros/humble/setup.bash
source autoware/install/setup.bash
ros2 launch autoware_launch planning_simulator.launch.xml map_path:="$HOME"/autoware_map/sample-map-planning vehicle_model:=sample_vehicle sensor_model:=sample_sensor_kit rviz:=false

#!/bin/bash

export RMW_IMPLEMENTATION=rmw_zenoh_cpp

source /opt/ros/humble/setup.bash
source autoware/install/setup.bash
rviz2 -d ./autoware/install/autoware_launch/share/autoware_launch/rviz/autoware.rviz

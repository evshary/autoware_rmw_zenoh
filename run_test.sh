#!/bin/bash

export RMW_IMPLEMENTATION=rmw_zenoh_cpp
source /opt/ros/humble/setup.bash
source autoware/install/setup.bash
cd autoware || exit
colcon test
cd - || exit

# Collect result
python3 collect_test_result.py autoware

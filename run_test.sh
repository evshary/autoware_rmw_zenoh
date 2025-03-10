#!/bin/bash

export RMW_IMPLEMENTATION=rmw_zenoh_cpp
source /opt/ros/humble/setup.bash
source autoware/install/setup.bash
cd autoware || exit

#colcon test
# Run test sequentially
colcon test --executor sequential --event-handlers console_direct+
# Run test for specific package, e.g., rclpy
#colcon test --packages-select rclpy --event-handlers console_direct+
# If you want to run a specific test 10 times until fail (The test ieme "test_controller" in the package "opennav_docking")
#colcon test --packages-select opennav_docking --ctest-args -R test_controller --event-handlers console_direct+ --retest-until-fail 10

cd - || exit

# Collect result
python3 collect_test_result.py autoware

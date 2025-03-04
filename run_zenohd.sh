#!/bin/bash

export RMW_IMPLEMENTATION=rmw_zenoh_cpp

source /opt/ros/humble/setup.bash
RUST_LOG=z=debug ros2 run rmw_zenoh_cpp rmw_zenohd

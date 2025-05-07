#!/bin/bash

# export RMW_IMPLEMENTATION=rmw_zenoh_cpp
# export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp

LOG_PATH=caret_log/$(date '+%Y-%m-%d_%H:%M:%S')/
mkdir -p "${LOG_PATH}"
export ROS_TRACE_DIR="${PWD}/${LOG_PATH}"

if [ ! -d "$HOME/autoware_map" ]; then
    gdown -O ~/autoware_map/ 'https://docs.google.com/uc?export=download&id=1499_nsbUbIeturZaDj7jhUownh5fvXHd'
    unzip -d ~/autoware_map ~/autoware_map/sample-map-planning.zip
fi

# Environment settings (keep the order as below)
source /opt/ros/humble/setup.bash
source autoware_caret_ws/install/setup.bash
source caret_ws/install/local_setup.bash
# source rmw_zenoh_ws/install/setup.bash

# Enable tracepoints which are defined hooked functions.
LD_PRELOAD_PATH=$(readlink -f caret_ws/install/caret_trace/lib/libcaret.so)
export LD_PRELOAD="$LD_PRELOAD_PATH"

ros2 launch caret_autoware_launch planning_simulator.launch.xml \
        map_path:="$HOME"/autoware_map/sample-map-planning \
        vehicle_model:=sample_vehicle \
        sensor_model:=sample_sensor_kit \
        caret_session:=autoware_launch_trace 2>&1 | tee "${LOG_PATH}"/autoware.log

ros2 caret create_architecture_file "${LOG_PATH}"/autoware_launch_trace -o "${LOG_PATH}"/architecture.yaml

# Create or update 'latest' symlink
ln -sfn "${PWD}/${LOG_PATH}" caret_log/latest

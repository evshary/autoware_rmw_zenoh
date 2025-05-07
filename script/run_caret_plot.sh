#!/bin/bash

# Environment settings (keep the order as below)
source /opt/ros/humble/setup.bash
source autoware_caret_ws/install/setup.bash
source caret_ws/install/local_setup.bash

# Use user-provided log dir if available, otherwise find latest
if [ -n "$1" ]; then
  LOG_DIR="$1"
else
  LOG_DIR="caret_log/latest"
  if [ -z "$LOG_DIR" ]; then
    echo "Log directory not found: ${LOG_DIR}"
    exit 1
  fi
fi

echo "Using log directory: ${LOG_DIR}"
python3 script/caret_plot.py "${LOG_DIR}"

#!/bin/bash

source /opt/ros/humble/setup.bash
source caret_ws/install/local_setup.bash # please keep the order after ROS 2's setup.bash

if [ ! -d "autoware_caret_ws" ]; then
    git clone https://github.com/autowarefoundation/autoware.git autoware_caret_ws
    cd autoware_caret_ws || exit
    git checkout 3683fb57be71ffd26f2642632d2abb773841d4d6 # 0.43.1 (2025-04-01)
    mkdir src
    vcs import src < autoware.repos
    rosdep update
    rosdep install -r -y --from-paths src --ignore-src --rosdistro "$ROS_DISTRO"
    cd .. || exit

    # This patch runs behavior_path_planner in a separate container with one thread
    # to avoid a GuardCondition use-after-free issue when using rmw_zenoh with multi-threaded executor.
    # Known issue in ROS 2 Humble; fixed in Rolling (2025.04+), not backported.
    #
    # Related issues:
    # - https://github.com/ros2/rmw_zenoh/issues/608
    # - https://github.com/ros2/rclcpp/issues/2820
    cd autoware_caret_ws/src/universe/autoware_universe || exit
    git apply ../../../../patch/thread_limit.patch
    cd - || exit

    # With this launcher, Autoware will run along with CARET.
    cd autoware_caret_ws/src || exit
    git clone https://github.com/tier4/caret_autoware_launch.git
    cd - || exit
fi

cd autoware_caret_ws || exit
colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF

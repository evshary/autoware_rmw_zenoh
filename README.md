# Autoware with rmw_zenoh

Show how to run Autoware with rmw_zenoh.

## Usage

* Install prerequisites

```shell
./script/prerequisite.sh
```

* Install pre-commit

```shell
pre-commit install --install-hooks
```

* If using Docker, start the container first:

```shell
./container/run_container.sh
```

* Build Autoware
  * Refer to [the official tutorial](https://autowarefoundation.github.io/autoware-documentation/main/installation/autoware/source-installation/)

```shell
./script/build_autoware.sh
```

* Build rmw_zenoh

```shell
./script/build_zenoh.sh
```

* Run Autoware

```shell
# Run Zenohd first
./script/run_zenohd.sh
# Run Autoware
./script/run_autoware.sh
# Run Rviz
./script/run_rviz2.sh
```

* Run test

```shell
# Run Zenohd first
./script/run_zenohd.sh
# Run the test
./script/run_test.sh
```

## Build and Use CARET

[CARET](https://github.com/tier4/caret) (Chain-Aware ROS Evaluation Tool) is a performance analysis tool for ROS 2 applications.

* Build CARET

```shell
./script/build_caret.sh
```

* Build Autoware with CARET

```shell
./script/build_autoware_caret.sh
```

* Run and Record with CARET

```shell
./script/run_autoware_caret.sh
```

* Visualize CARET Trace Data

```shell
# Plot the latest log
./script/run_caret_plot.sh

# Or specify a custom log directory
./script/run_caret_plot.sh <path-to-caret-log>
```

## Demo

* **Basic Route Execution**
  * Runs `planning_simulator` to perform simple route planning and motion.

  [![Basic Route Execution](http://img.youtube.com/vi/1MbIKINI6XI/0.jpg)](https://youtu.be/1MbIKINI6XI "Basic Route Execution")

* **Localization + Lidar + Perception**
  * Runs `logging_simulator` to perform localization, perception and displays lidar pointclouds.
  * A [public rosbag](https://autowarefoundation.github.io/autoware-documentation/main/tutorials/ad-hoc-simulation/rosbag-replay-simulation/) is used for this demo.

  [![Localization + Lidar + Perception](http://img.youtube.com/vi/as9BZzZuQEg/0.jpg)](https://youtu.be/as9BZzZuQEg "Localization + Lidar + Perception")

* **Manual Localization + Lidar + Camera**
  * Runs `planning_simulator` to visualize both camera images and lidar pointclouds.
  * A [public rosbag](https://autowarefoundation.github.io/autoware-documentation/main/datasets/) is used, which does not include a lanelet map, so manual pose initialization is used.

  [![Manual Localization + Lidar + Camera](http://img.youtube.com/vi/SYLeAmDG_hM/0.jpg)](https://youtu.be/SYLeAmDG_hM "Manual Localization + Lidar + Camera")

* **AWSIM**
  * Using Autoware version 0.43.1 and AWSIM 1.5.3.
  * For AWSIM setup instructions, please refer to the official AWSIM tutorial: [Quick Start Demo](https://autowarefoundation.github.io/AWSIM-Labs/main/GettingStarted/QuickStartDemo/)

  [![AWSIM](http://img.youtube.com/vi/cZUzNDo5dig/0.jpg)](https://youtu.be/cZUzNDo5dig "Autoware + AWSIM")

## Note

If you can't build Autoware, this might be caused by the package conflicts.
Try to remove all the binary packages related to Autoware: `sudo apt remove "ros-humble-autoware-*"`

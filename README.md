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

1. **[Basic Route Execution](https://youtu.be/1MbIKINI6XI)**
   * Runs `planning_simulator` to perform simple route planning and motion.

2. **[Localization + Lidar + Perception](https://youtu.be/as9BZzZuQEg)**
   * Runs `logging_simulator` to perform localization, perception and displays lidar pointclouds.
   * A [public rosbag](https://autowarefoundation.github.io/autoware-documentation/main/tutorials/ad-hoc-simulation/rosbag-replay-simulation/) is used for this demo.

3. **[Manual Localization + Lidar + Camera](https://youtu.be/SYLeAmDG_hM)**
   * Runs `planning_simulator` to visualize both camera images and lidar pointclouds.
   * A [public rosbag](https://autowarefoundation.github.io/autoware-documentation/main/datasets/) is used, which does not include a lanelet map, so manual pose initialization is used.

## Note

If you can't build Autoware, this might be caused by the package conflicts.
Try to remove all the binary packages related to Autoware: `sudo apt remove "ros-humble-autoware-*"`

# Autoware with rmw_zenoh

Show how to run Autoware with rmw_zenoh.

## Usage

* Install prerequisites

```shell
./prerequisite.sh
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
./build_autoware.sh
```

* Build rmw_zenoh

```shell
./build_zenoh.sh
```

* Run Autoware

```shell
# Run Zenohd first
./run_zenohd.sh
# Run Autoware
./run_autoware.sh
# Run Rviz
./run_rviz2.sh
```

* Run test

```shell
# Run Zenohd first
./run_zenohd.sh
# Run the test
./run_test.sh
```

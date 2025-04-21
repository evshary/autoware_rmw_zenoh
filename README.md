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

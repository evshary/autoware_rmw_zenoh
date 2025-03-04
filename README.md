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

* Build Autoware
  * Refer to [the official tutorial](https://autowarefoundation.github.io/autoware-documentation/main/installation/autoware/source-installation/)

```shell
./build_autoware.sh
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

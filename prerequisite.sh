#!/bin/bash

set -e

sudo apt install shellcheck pipx
pipx install ruff
pipx install pre-commit

sudo apt install ros-humble-rmw-zenoh-cpp

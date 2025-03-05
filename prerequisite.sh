#!/bin/bash

set -e

sudo apt install -y shellcheck pipx
pipx install ruff
pipx install pre-commit

sudo apt install -y ros-humble-rmw-zenoh-cpp

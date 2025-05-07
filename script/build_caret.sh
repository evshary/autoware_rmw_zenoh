#!/bin/bash

if [ ! -d "caret_ws" ]; then
    git clone https://github.com/tier4/caret.git caret_ws
    cd caret_ws || exit

    mkdir src
    vcs import src < caret.repos
    ./setup_caret.sh

    # Workaround for setuptools >= 80 dropping support for `setup.py install --editable`
    # Related issue: https://github.com/pypa/setuptools/issues/4971
    # pip install 'setuptools<80'
    cd - || exit
fi

cd caret_ws || exit
source /opt/ros/humble/setup.bash
colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release

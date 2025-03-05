#!/bin/bash

DOCKER_IMAGE=zenoh-autoware-src-20250226
DOCKER_FILE=container/Dockerfile_autoware_src

if [ ! "$(docker images -q ${DOCKER_IMAGE})" ]; then
    echo "${DOCKER_IMAGE} does not exist. Creating..."
    docker build --no-cache -f ${DOCKER_FILE} -t ${DOCKER_IMAGE} .
fi

rocker --nvidia --privileged --x11 --user --volume "$(pwd)":"$HOME"/autoware_rmw_zenoh -- "${DOCKER_IMAGE}"

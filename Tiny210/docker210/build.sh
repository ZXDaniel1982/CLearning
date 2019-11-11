#!/bin/bash -x
#
# Script to build a Docker image which can be used as a Yocto container.
#
# Syntax:
#     build.sh [IMAGE_NAME:(IMAGE_TAG)] (-p)
#
# Specify IMAGE_NAME as the name of the image to be built (optional).
# Specify :IMAGE_TAG as the value to use when tagging the image (optional).
# Specify "-p" to push result to Aviat Registry (admin function).
#
# Set DOCKER_BUILD_EXTRA_OPTIONS if you wish to add/override container build options.
# Set DOCKER_FILE to specify an alternative Dockerfile.
# Set DOCKER_PATH to specify an alternative context directory to upload to the Daemon.
#

set -o errexit
set -o nounset

ROOT=$(dirname $0)

DOCKER_IMAGE=${1:-tiny210/ubuntu:latest}
DOCKER_FILE=${DOCKER_FILE:-$ROOT/tiny210.Dockerfile}
DOCKER_PATH=${DOCKER_PATH:-$ROOT}

echo "Building $DOCKER_IMAGE from $DOCKER_FILE to $DOCKER_PATH"
docker build \
    --tag "$DOCKER_IMAGE" \
    --file "$DOCKER_FILE" \
    "$DOCKER_PATH"

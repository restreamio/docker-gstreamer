#!/bin/bash
set -e

if [[ -z "$1" ]]; then
    echo -e "Usage example:\n  $0 1.20.1"
    exit 1
fi

if [[ $WEBKIT_USE_SCCACHE == '1' ]]; then
    sed 's;@@SCCACHE_SCHEDULER@@;'"${SCCACHE_SCHEDULER}"';g' sccache.toml > docker/sccache.toml
    sed -i 's;@@SCCACHE_AUTH_TOKEN@@;'"${SCCACHE_AUTH_TOKEN}"';g' docker/sccache.toml
else
    echo > docker/sccache.toml
fi

# Make sure to always have fresh base image
docker pull ubuntu:22.04
# Install dev dependencies
docker build -t restreamio/gstreamer:dev-dependencies -f Dockerfile-dev-dependencies .
# Download source code
docker build -t restreamio/gstreamer:dev-downloaded \
    --build-arg GSTREAMER_REPOSITORY=https://gitlab.freedesktop.org/gstreamer/gstreamer.git \
    --build-arg GSTREAMER_CHECKOUT=$1 \
    -f Dockerfile-dev-downloaded .
# Build dev image with source code included
docker build --build-arg WEBKIT_USE_SCCACHE=$WEBKIT_USE_SCCACHE -t restreamio/gstreamer:$1-dev-with-source -f Dockerfile-dev-with-source .
# Build dev image with just binaries
docker build -t restreamio/gstreamer:$1-dev -f Dockerfile-dev .
# Build base production image with necessary dependencies
docker build -t restreamio/gstreamer:prod-base -f Dockerfile-prod-base .
# Build production image optimized binaries and no debug symbols (-O3 LTO)
docker build --build-arg WEBKIT_USE_SCCACHE=$WEBKIT_USE_SCCACHE -t restreamio/gstreamer:$1-prod -f Dockerfile-prod .
# Build production image optimized binaries and debug symbols
docker build --build-arg WEBKIT_USE_SCCACHE=$WEBKIT_USE_SCCACHE -t restreamio/gstreamer:$1-prod-dbg -f Dockerfile-prod-dbg .

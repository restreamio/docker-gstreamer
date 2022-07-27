#!/bin/bash
set -e

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
docker build -t restreamio/gstreamer:dev-downloaded -f Dockerfile-dev-downloaded .
# Build dev image with source code included
docker build --build-arg WEBKIT_USE_SCCACHE=$WEBKIT_USE_SCCACHE -t restreamio/gstreamer:latest-dev-with-source -f Dockerfile-dev-with-source .
# Build dev image with just binaries
docker build -t restreamio/gstreamer:latest-dev -f Dockerfile-dev .
# Build base production image with necessary dependencies
docker build -t restreamio/gstreamer:prod-base -f Dockerfile-prod-base .
# Build production image optimized binaries and no debug symbols (-O3 LTO)
docker build --build-arg WEBKIT_USE_SCCACHE=$WEBKIT_USE_SCCACHE -t restreamio/gstreamer:latest-prod -f Dockerfile-prod .
# Build production image optimized binaries and debug symbols
docker build --build-arg WEBKIT_USE_SCCACHE=$WEBKIT_USE_SCCACHE -t restreamio/gstreamer:latest-prod-dbg -f Dockerfile-prod-dbg .

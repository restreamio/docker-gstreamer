#!/bin/bash
set -e

if [[ $WEBKIT_USE_SCCACHE == '1' ]]; then
    sed 's;@@SCCACHE_SCHEDULER@@;'"${SCCACHE_SCHEDULER}"';g' sccache.toml > docker/sccache.toml
    sed -i 's;@@SCCACHE_AUTH_TOKEN@@;'"${SCCACHE_AUTH_TOKEN}"';g' docker/sccache.toml
else
    echo > docker/sccache.toml
fi

ARCH=$(uname -m)

TAG_BASENAME="restreamio/gstreamer:$ARCH"

docker_build() {
    local docker_file="Dockerfile-$1.in"
    echo "Building from $docker_file"
    sed "s/\$TARGET_ARCH/$ARCH/g" $docker_file > Dockerfile-tmp
    docker build -t $TAG_BASENAME-$1 -f Dockerfile-tmp .
    rm -f Dockerfile-tmp
}

# Make sure to always have fresh base image
docker pull ubuntu:22.04
# Install dev dependencies
docker build -t $TAG_BASENAME-dev-dependencies -f Dockerfile-dev-dependencies .

# Download source code
docker_build dev-downloaded

# Build dev image with source code included
docker_build latest-dev-with-source

# Build dev image with just binaries
#docker_build latest-dev

# Build base production image with necessary dependencies
#docker_build prod-base

# Build production image optimized binaries and no debug symbols (-O3 LTO)
#docker_build latest-prod

# Build production image optimized binaries and debug symbols
#docker_build latest-prod-dbg

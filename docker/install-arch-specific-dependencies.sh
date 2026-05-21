#!/bin/bash

ARCH=$(dpkg --print-architecture)
if [[ $ARCH == "amd64" ]]; then
    apt-get install -y --no-install-recommends \
            libmfx-gen1.2 \
            intel-media-va-driver-non-free
fi

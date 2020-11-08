#!/bin/bash
set -e

if [[ (-z "$1") || (-z "$2") ]]; then
    echo -e "Usage example:\n  $0 1.18.1 0"
    exit 1
fi

docker push restreamio/gstreamer:$1-dev-with-source
docker tag restreamio/gstreamer:$1-dev-with-source restreamio/gstreamer:$1.$2-dev-with-source
docker push restreamio/gstreamer:$1.$2-dev-with-source

docker push restreamio/gstreamer:$1-dev
docker tag restreamio/gstreamer:$1-dev restreamio/gstreamer:$1.$2-dev
docker push restreamio/gstreamer:$1.$2-dev

docker push restreamio/gstreamer:$1-prod
docker tag restreamio/gstreamer:$1-prod restreamio/gstreamer:$1.$2-prod
docker push restreamio/gstreamer:$1.$2-prod

docker push restreamio/gstreamer:$1-prod-dbg
docker tag restreamio/gstreamer:$1-prod-dbg restreamio/gstreamer:$1.$2-prod-dbg
docker push restreamio/gstreamer:$1.$2-prod-dbg

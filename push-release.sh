#!/bin/bash
set -e

if [[ (-z "$1") || (-z "$2") || (-z "$3") ]]; then
    echo -e "Usage example:\n  $0 amd64 1.22.11 0"
    exit 1
fi

TAG_BASENAME="restreamio/gstreamer:$1-$2"

docker push $TAG_BASENAME-dev-with-source
docker tag $TAG_BASENAME-dev-with-source $TAG_BASENAME.$3-dev-with-source
docker push $TAG_BASENAME.$3-dev-with-source

docker push $TAG_BASENAME-dev
docker tag $TAG_BASENAME-dev $TAG_BASENAME.$3-dev
docker push $TAG_BASENAME.$3-dev

docker push $TAG_BASENAME-prod
docker tag $TAG_BASENAME-prod $TAG_BASENAME.$3-prod
docker push $TAG_BASENAME.$3-prod

docker push $TAG_BASENAME-prod-dbg
docker tag $TAG_BASENAME-prod-dbg $TAG_BASENAME.$3-prod-dbg
docker push $TAG_BASENAME.$3-prod-dbg

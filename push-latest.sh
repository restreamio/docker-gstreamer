#!/bin/bash
set -e

echo $DATE

ARCH=$(uname -m)
TAG_BASENAME="restreamio/gstreamer:$ARCH"

mkdir -p workspace
echo "$TAG_BASENAME-$DATE" > workspace/docker-tag-basename-$ARCH.txt

docker push $TAG_BASENAME-latest-dev-with-source
docker tag $TAG_BASENAME-latest-dev-with-source $TAG_BASENAME-$DATE-dev-with-source
docker push $TAG_BASENAME-$DATE-dev-with-source

docker push $TAG_BASENAME-latest-dev
docker tag $TAG_BASENAME-latest-dev $TAG_BASENAME-$DATE-dev
docker push $TAG_BASENAME-$DATE-dev

docker push $TAG_BASENAME-latest-prod
docker tag $TAG_BASENAME-latest-prod $TAG_BASENAME-$DATE-prod
docker push $TAG_BASENAME-$DATE-prod

docker push $TAG_BASENAME-latest-prod-dbg
docker tag $TAG_BASENAME-latest-prod-dbg $TAG_BASENAME-$DATE-prod-dbg
docker push $TAG_BASENAME-$DATE-prod-dbg

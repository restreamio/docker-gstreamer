#!/bin/bash
set -e

echo $DATE

TAG_BASENAME="restreamio/gstreamer:$DATE"

AMD64_TAG_BASENAME=$(cat /tmp/docker-gst-ci/workspace/docker-tag-basename-x86_64.txt)
ARM64_TAG_BASENAME=$(cat /tmp/docker-gst-ci/workspace/docker-tag-basename-aarch64.txt)

docker manifest create $TAG_BASENAME-dev-with-source --amend $AMD64_TAG_BASENAME-dev-with-source --amend $ARM64_TAG_BASENAME-dev-with-source
docker manifest push docker.io/$TAG_BASENAME-dev-with-source

docker manifest create $TAG_BASENAME-dev --amend $AMD64_TAG_BASENAME-dev --amend $ARM64_TAG_BASENAME-dev
docker manifest push docker.io/$TAG_BASENAME-dev

docker manifest create $TAG_BASENAME-prod --amend $AMD64_TAG_BASENAME-prod --amend $ARM64_TAG_BASENAME-prod
docker manifest push docker.io/$TAG_BASENAME-prod

docker manifest create $TAG_BASENAME-prod-dbg --amend $AMD64_TAG_BASENAME-prod-dbg --amend $ARM64_TAG_BASENAME-prod-dbg
docker manifest push docker.io/$TAG_BASENAME-prod-dbg


#!/bin/bash
set -e

DATE=$(date -u +"%Y-%m-%dT%H-%M-%SZ")

echo $DATE

docker push restreamio/gstreamer:latest-dev-with-source
docker tag restreamio/gstreamer:latest-dev-with-source restreamio/gstreamer:$DATE-dev-with-source
docker push restreamio/gstreamer:$DATE-dev-with-source

docker push restreamio/gstreamer:latest-dev
docker tag restreamio/gstreamer:latest-dev restreamio/gstreamer:$DATE-dev
docker push restreamio/gstreamer:$DATE-dev

docker push restreamio/gstreamer:latest-prod
docker tag restreamio/gstreamer:latest-prod restreamio/gstreamer:$DATE-prod
docker push restreamio/gstreamer:$DATE-prod

docker push restreamio/gstreamer:latest-prod-dbg
docker tag restreamio/gstreamer:latest-prod-dbg restreamio/gstreamer:$DATE-prod-dbg
docker push restreamio/gstreamer:$DATE-prod-dbg

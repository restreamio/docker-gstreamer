#!/bin/bash
set -e

docker push restreamio/gstreamer:latest-dev-with-source
docker push restreamio/gstreamer:latest-dev
docker push restreamio/gstreamer:latest-prod
docker push restreamio/gstreamer:latest-prod-dbg

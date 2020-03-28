#!/bin/bash
set -e

# Make sure to always have fresh base image
docker push restreamio/gstreamer:latest-dev-with-source
docker push restreamio/gstreamer:latest-dev
docker push restreamio/gstreamer:latest-prod

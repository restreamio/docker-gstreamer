#!/bin/bash
set -e

# Make sure to always have fresh base image
docker pull ubuntu:19.10
# Install dev dependencies
docker build -t restreamio/gstreamer:latest-dev-dependencies -f Dockerfile-dev-dependencies .
# Download source code
docker build -t restreamio/gstreamer:latest-dev-downloaded -f Dockerfile-dev-downloaded .
# Build dev image with source code included
docker build -t restreamio/gstreamer:latest-dev-with-source -f Dockerfile-dev-with-source .
# Build dev image with just binaries
docker build -t restreamio/gstreamer:latest-dev -f Dockerfile-dev .
# Build production image with just binaries and necessary dependencies
docker build -t restreamio/gstreamer:latest-prod -f Dockerfile-prod .

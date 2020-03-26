#!/bin/bash
set -e

docker pull ubuntu:19.10
docker build -t restreamio/gstreamer:latest-dev -f Dockerfile-dev .
docker build -t restreamio/gstreamer:latest-prod -f Dockerfile-prod .

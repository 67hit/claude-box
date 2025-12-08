#!/usr/bin/bash

set -e

IMAGE=claude-box

podman build --format docker -t "$IMAGE" . 2>&1 | tee build.log

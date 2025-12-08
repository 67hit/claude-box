#!/usr/bin/bash

set -e

podman build --format docker -t claude-box . 2>&1 | tee build.log

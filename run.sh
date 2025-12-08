#!/usr/bin/bash

set -e

IMAGE=claude-box

if ! podman image exists "$IMAGE" 2>/dev/null; then
    echo "Error: Image '$IMAGE' not found. Please build it first with ./build.sh"
    exit 1
fi

podman run \
    -v "${HOME}/.claude:/home/claude/.claude" \
    -v "${HOME}/.claude.json:/home/claude/.claude.json" \
    -v "${PWD}:${PWD}" \
    -w "$PWD" \
    -i \
    -t \
    --rm \
    --userns keep-id:uid=1001,gid=1001 \
    --user claude \
    "$IMAGE" "$@"

#!/usr/bin/bash

IMAGE=claude-box

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

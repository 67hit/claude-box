#!/usr/bin/bash

set -e

IMAGE=ai-agent-box
MODE="claude"

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --claude)
            MODE="claude"
            shift
            ;;
        --gemini)
            MODE="gemini"
            shift
            ;;
        --help|-h)
            echo "Usage: $0 [--claude|--gemini] [additional arguments]"
            echo "  --claude  Run with Claude Code (default)"
            echo "  --gemini  Run with Google Gemini CLI"
            echo ""
            echo "Examples:"
            echo "  $0                    # Run with Claude (default)"
            echo "  $0 --claude           # Run with Claude"
            echo "  $0 --gemini           # Run with Gemini"
            echo "  $0 --claude ls -la    # Run command with Claude config"
            exit 0
            ;;
        *)
            break
            ;;
    esac
done

if ! podman image exists "$IMAGE" 2>/dev/null; then
    echo "Error: Image '$IMAGE' not found. Please build it first with ./build.sh"
    exit 1
fi

# Configure volume mounts based on mode
if [ "$MODE" = "claude" ]; then
    VOLUME_MOUNTS=(
        -v "${HOME}/.claude:/home/agent/.claude"
        -v "${HOME}/.claude.json:/home/agent/.claude.json"
    )
elif [ "$MODE" = "gemini" ]; then
    VOLUME_MOUNTS=(
        -v "${HOME}/.gemini:/home/agent/.gemini"
        -v "${HOME}/.env:/home/agent/.env"
    )
fi

podman run \
    "${VOLUME_MOUNTS[@]}" \
    -v "${PWD}:${PWD}" \
    -w "$PWD" \
    -i \
    -t \
    --rm \
    --userns keep-id:uid=1001,gid=1001 \
    --user agent \
    "$IMAGE" "$@"

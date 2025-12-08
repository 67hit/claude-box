# Improvement Recommendations

## Build & Runtime

### Build Script - Container Runtime Flexibility
Consider making `build.sh` support both `docker` and `podman`:

```bash
${CONTAINER_RUNTIME:-docker} build --format docker -t claude-box . 2>&1 | tee build.log
```

This allows: `./build.sh` (uses docker by default) or `CONTAINER_RUNTIME=podman ./build.sh`

### Run Script Improvements
- Add a check that the image exists before running
- Consider making the shell scriptable with a default fallback:
  ```bash
  "$IMAGE" "${@:--zsh}"
  ```
  This allows `run.sh` to default to zsh if no args provided, or pass through custom commands

## Nice-to-haves

### Init System for Signal Handling
If running long-lived processes, consider adding `dumb-init`:

```dockerfile
RUN apk add --no-cache dumb-init
ENTRYPOINT ["dumb-init", "--"]
CMD ["zsh"]
```

#### What is ENTRYPOINT?

`ENTRYPOINT` specifies the main command that runs when a container starts. Unlike `CMD`, which can be overridden by user arguments, `ENTRYPOINT` is the primary executable. Arguments are appended to it.

- `CMD ["zsh"]` — runs `zsh` by default, but `./run.sh ls -la` overrides it to run `ls -la`
- `ENTRYPOINT ["dumb-init", "--"]` — `dumb-init` always runs as the main process, and `CMD` arguments are passed to it

#### What is dumb-init?

`dumb-init` is a lightweight init system that solves signal handling in containers. When a container receives a signal (like `SIGTERM` from `Ctrl+C` or `podman stop`), it ensures that signal is properly forwarded to child processes. This is especially important for processes that spawn children, preventing "zombie" processes.

#### Is it necessary here?

**Probably not.** You're running an interactive shell (`zsh`), which handles signals fine on its own. `dumb-init` is more critical for background services or long-running processes that spawn many children. This is a "nice-to-have" for robustness but not essential for your use case.

## Already Implemented ✓
- ✓ Pinned Node.js version (item 1)
- ✓ Removed redundant cache clean (item 3)
- ✓ Fixed user UID matching (item 4)
- ✓ Added .dockerignore (item 9)

### Error Handling in Scripts
Add `set -e` to both `build.sh` and `run.sh` to fail fast on errors:

```bash
#!/usr/bin/bash
set -e
```

This ensures the script stops immediately if any command fails.

### Dockerfile Metadata Labels
Add labels for documentation:

```dockerfile
LABEL maintainer="your-email@example.com"
LABEL description="Claude Code in a restricted Podman container"
```
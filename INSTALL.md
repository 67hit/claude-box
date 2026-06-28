# General installation instruction on Linux Mint

1. `sudo apt install podman`
2. `sudo npm install -g @anthropic-ai/claude-code` # This is how claude is running in podman
3. `claude /login` # This will acquire the necessary token
4. `sudo npm uninstall -g @anthropic-ai/claude-code` # To avoid unintended consequences

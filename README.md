# ai-agent-box

A simple setup for running AI agents (Claude Code and Google Gemini CLI) with restricted access, under `podman`.

## Quick Start

1. **Build the image:**
   ```bash
   ./build.sh
   ```

2. **Run with Claude (default):**
   ```bash
   ./run.sh
   # or use the convenience script
   ./claude.sh
   ```
   Once running, type `claude` to start the session.

3. **Run with Gemini:**
   ```bash
   ./run.sh --gemini
   # or use the convenience script
   ./gemini.sh
   ```
   Once running, type `gemini` to start the session.

## Configuration

### Claude Code
Claude Code uses configuration from:
- `~/.claude/` - Claude configuration directory
- `~/.claude.json` - Claude settings file

### Google Gemini CLI
Gemini CLI uses configuration from:
- `~/.gemini/` - Gemini configuration directory
- `GEMINI_API_KEY` environment variable

To set up Gemini:
1. Get an API key from [Google AI Studio](https://ai.google.dev/gemini-api/docs/api-key)
2. Set the environment variable:
   ```bash
   export GEMINI_API_KEY="your_api_key_here"
   ```
   Or add it to your `~/.bashrc` or `~/.zshrc` for persistence.

Alternatively, create a `~/.gemini/.env` file:
```bash
GEMINI_API_KEY=your_api_key_here
```

## Usage

### Basic usage
```bash
./run.sh [--claude|--gemini] [additional arguments]
```

### Examples
```bash
# Run Claude interactively (default)
./run.sh

# Run Gemini interactively
./run.sh --gemini

# Execute a command with Claude configuration
./run.sh --claude ls -la

# Execute a command with Gemini configuration
./run.sh --gemini python3 script.py
```

### Help
```bash
./run.sh --help
```

## Files

- `build.sh` - Build the container image
- `run.sh` - Run the container with mode selection
- `claude.sh` - Convenience wrapper for Claude mode
- `gemini.sh` - Convenience wrapper for Gemini mode
- `Dockerfile` - Container image definition
- `.env.example` - Example environment variables

## Credits

*Some of this was taken from [here](https://github.com/EvanCarroll/claude-podman).*

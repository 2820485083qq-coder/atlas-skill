# DeepSeek Worker

`deepseek-worker` is a local helper command for sending low-cost rough work to DeepSeek while keeping GPT focused on orchestration, architecture, and final review.

It is not Codex's built-in `spawn_agent`. Current Codex subagents only expose GPT model overrides in this environment. This helper is the practical sidecar path: GPT can call a local command for simple collection, extraction, grouping, first drafts, and batch checks.

## Setup

Store the API key locally, not in chat:

```sh
~/.codex/bin/deepseek-worker-setup-key
```

Or create the file manually:

```sh
mkdir -p ~/.config/deepseek
chmod 700 ~/.config/deepseek
printf 'export DEEPSEEK_API_KEY="YOUR_DEEPSEEK_API_KEY"\n' > ~/.config/deepseek/key.env
chmod 600 ~/.config/deepseek/key.env
source ~/.config/deepseek/key.env
```

The worker reads `DEEPSEEK_API_KEY` from the environment first. If it is not set, it falls back to `~/.config/deepseek/key.env`.

Optional:

```sh
export DEEPSEEK_BASE_URL="https://api.deepseek.com"
```

Check whether the stored key works:

```sh
deepseek-worker --check-key
```

## Usage

```sh
~/.codex/bin/deepseek-worker "Summarize this repo structure"
```

With piped context:

```sh
rg -n "TODO|FIXME" . | ~/.codex/bin/deepseek-worker "Group these TODOs by priority"
```

With files:

```sh
~/.codex/bin/deepseek-worker --file README.md --file package.json "Extract setup steps and risks"
```

Dry run without calling the API:

```sh
~/.codex/bin/deepseek-worker --dry-run --file README.md "Check request shape"
```

Use a temporary compatible endpoint:

```sh
~/.codex/bin/deepseek-worker --base-url "https://api.deepseek.com" "Run a small task"
```

## Recommended Routing

Use DeepSeek worker for:

- file scans and summarization
- extracting action items from logs or docs
- first drafts that GPT will rewrite or judge
- batching repetitive checks
- grouping search results or TODOs

Keep GPT for:

- architecture decisions
- ambiguous tradeoffs
- final code review
- security-sensitive changes
- tasks requiring reliable tool orchestration or file edits

## Models

Default model: `deepseek-v4-flash`

Override per run:

```sh
~/.codex/bin/deepseek-worker --model deepseek-v4-pro "Analyze this tricky design tradeoff"
```

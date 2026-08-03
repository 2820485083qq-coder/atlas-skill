---
name: headroom
description: Install, configure, use, diagnose, audit, or remove Headroom (headroom-ai), the local context-compression layer for coding agents. Use whenever the user mentions Headroom, headroom-ai, the headroom GitHub repository, headroom wrap/proxy/MCP/doctor/savings, compressing Codex or Claude tool output, reducing agent token usage, reversible context compression, or routing Codex through a local compression proxy.
compatibility: Requires Python 3.10-3.13 for the Headroom CLI; network access is needed for installation. Codex proxy wrapping changes ~/.codex/config.toml and must be explicitly requested.
---

# Headroom

Use Headroom to compress tool output, logs, files, RAG chunks, and agent context before they reach an LLM. Keep setup reversible and distinguish an on-demand MCP integration from automatic proxy routing.

Upstream source: <https://github.com/headroomlabs-ai/headroom>

## Start with intent

Classify the request before changing anything:

1. **Explain or evaluate Headroom**: inspect the upstream docs and current local state; do not install or alter routing.
2. **Install the Headroom CLI**: install a supported Python tool environment, then verify the executable.
3. **Add MCP tools only**: register on-demand compression/retrieval tools without routing every model request through a proxy.
4. **Wrap Codex automatically**: start the local proxy and let Headroom edit Codex configuration. This is a durable config mutation, so do it only when the user explicitly asks to enable or wrap Codex.
5. **Diagnose or remove**: inspect first; prefer `headroom unwrap codex` and Headroom's uninstall commands over manual config surgery.

Run `scripts/check-headroom.sh` for a read-only preflight.

## Installation

Headroom requires Python 3.10-3.13. Prefer `uv tool` so the CLI is isolated from project dependencies:

```bash
uv tool install --python 3.13 "headroom-ai[proxy,mcp,code]"
headroom --version
```

Use `pipx install --python python3.13 "headroom-ai[proxy,mcp,code]"` when `uv` is unavailable. Install `[all]` only when the user needs the large ML, image, memory, or evaluation extras.

Do not echo provider keys. Check only whether required variables exist.

## MCP-only integration

Use this when the user wants explicit `headroom_compress`, `headroom_retrieve`, and `headroom_stats` tools but does not want all Codex traffic proxied.

```bash
headroom mcp install
headroom mcp status
```

For a manually configured Codex MCP server, use stdio:

```toml
[mcp_servers.headroom]
command = "/absolute/path/to/headroom"
args = ["mcp", "serve"]
```

Resolve the executable with `command -v headroom`; Codex may not inherit an interactive shell's PATH. Restart Codex after changing MCP configuration.

## Automatic Codex compression

Before wrapping:

1. Run the read-only preflight.
2. Confirm that `codex --version` reports the real OpenAI Codex CLI.
3. Note the active `CODEX_HOME`; Headroom must use the same value for wrapping and unwrapping.
4. Ensure port `8787` is available, or choose another port.

Then run:

```bash
headroom wrap codex
headroom doctor
curl -fsS http://127.0.0.1:8787/health
```

Pass Codex arguments after `--`:

```bash
headroom wrap codex -- "inspect this repository"
```

On this Mac, `~/.local/bin/codex` may be a Hermes wrapper. If the preflight reports that shadowing, put the bundled OpenAI Codex directory first for the wrap invocation:

```bash
PATH="/Applications/Codex.app/Contents/Resources:$PATH" headroom wrap codex
```

`headroom wrap codex` may add a provider block, MCP registrations, and context-tool guidance to the active Codex home. It creates a pre-wrap backup when possible. Do not hand-edit those managed blocks while Headroom is active.

## Persistent service

Use persistent mode only when the user wants an always-on proxy:

```bash
headroom install apply --preset persistent-service --providers manual --target codex
headroom install status
```

Prefer on-demand wrapping for occasional use because it has a smaller operational footprint.

## Verification

Use checks that match the chosen mode:

```bash
headroom --version
headroom doctor
headroom mcp status
curl -fsS http://127.0.0.1:8787/health
headroom savings
```

For Codex wrapping, also confirm that:

- the proxy is listening only on loopback unless the user deliberately requested otherwise;
- the active Codex config contains Headroom-managed markers;
- a real Codex request succeeds without reconnect loops;
- `headroom savings` or proxy stats record the request;
- existing non-Headroom Codex settings remain intact.

## Recovery and removal

Prefer reversible commands:

```bash
headroom unwrap codex
headroom mcp uninstall
headroom install remove
```

Use the same `CODEX_HOME` and proxy port used during setup. After unwrapping, verify that Headroom markers are gone and the prior Codex configuration was restored. Restart Codex after MCP or provider changes.

## Troubleshooting

- **Port conflict**: inspect `lsof -nP -iTCP:8787 -sTCP:LISTEN`, then use another `--port`.
- **MCP executable not found**: replace `command = "headroom"` with the absolute executable path.
- **Codex command is shadowed**: inspect `type -a codex` and use the bundled OpenAI CLI path.
- **Proxy health fails**: run `headroom doctor`, inspect the Headroom log without printing secrets, and test `/health`.
- **No savings**: verify traffic actually passes through the proxy or call the MCP compression tool on sufficiently large content.
- **Reconnects or WebSocket failures**: verify the upstream network/proxy path and Headroom's WebSocket support before changing Codex retry settings.
- **Over-compression**: reduce scope or use MCP-only mode; preserve original content through Headroom retrieval.

Read `references/upstream.md` for upstream docs, package names, and the source snapshot used to create this skill.


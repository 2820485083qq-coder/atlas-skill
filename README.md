# Atlas Skill

Personal skill archive synced from local agent skill directories.

## Layout

- `skills/codex/` - Codex-visible skills from `~/.codex/skills`
- `skills/agents/` - cross-agent skills from `~/.agents/skills`
- `skills/claude/` - Claude/Codex-compatible skills from `~/.claude/skills`
- `skills/openclaw/` - OpenClaw skills from `~/.openclaw/skills`
- `memory/codex/` - Codex global memory/instructions from `~/.codex`
- `tools/codex/` - Codex helper commands and docs from `~/.codex/bin` and `~/.codex/docs`
- `manifest.json` - generated inventory of synced skill directories

## Exclusions

The sync intentionally excludes:

- system bundled skills such as `.system`
- runtime/cache directories such as `codex-primary-runtime`
- Python caches and build outputs
- files whose names look like local secrets, tokens, credentials, private keys, or `.env` files

API keys and local secret files such as `~/.config/deepseek/key.env` are never synced.

## Restore Notes

Copy a skill directory back into the matching local skill root, then restart the agent so the skill list refreshes.

For Codex-only skills, copy from:

```text
skills/codex/<skill-name>
```

to:

```text
%USERPROFILE%\.codex\skills\<skill-name>
```

For Codex memory, copy from:

```text
memory/codex/AGENTS.md
```

to:

```text
~/.codex/AGENTS.md
```

For Codex helper tools, copy from:

```text
tools/codex/bin/<tool-name>
tools/codex/docs/<doc-name>
```

to:

```text
~/.codex/bin/<tool-name>
~/.codex/docs/<doc-name>
```

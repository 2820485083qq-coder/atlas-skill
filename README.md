# Atlas Skill

Personal skill archive synced from local agent skill directories.

## Layout

- `skills/codex/` - Codex-visible skills from `~/.codex/skills`
- `skills/agents/` - cross-agent skills from `~/.agents/skills`
- `skills/claude/` - Claude/Codex-compatible skills from `~/.claude/skills`
- `skills/openclaw/` - OpenClaw skills from `~/.openclaw/skills`
- `manifest.json` - generated inventory of synced skill directories

## Exclusions

The sync intentionally excludes:

- system bundled skills such as `.system`
- runtime/cache directories such as `codex-primary-runtime`
- Python caches and build outputs
- files whose names look like local secrets, tokens, credentials, private keys, or `.env` files

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


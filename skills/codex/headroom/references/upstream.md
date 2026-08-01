# Headroom upstream reference

## Source

- Repository: <https://github.com/headroomlabs-ai/headroom>
- Original redirect: <https://github.com/chopratejas/headroom>
- Documentation: <https://headroom-docs.vercel.app/docs>
- License: Apache-2.0
- Snapshot reviewed: commit `5d3803a21c53907e2fea900524e48b510dd59d7a`
- Package version at review: `headroom-ai 0.27.0`

Refresh the upstream repository before relying on exact flags because Headroom changes quickly.

## Key upstream pages

- Installation: <https://headroom-docs.vercel.app/docs/installation>
- MCP tools: <https://headroom-docs.vercel.app/docs/mcp>
- Proxy: <https://headroom-docs.vercel.app/docs/proxy>
- Persistent installs: <https://headroom-docs.vercel.app/docs/persistent-installs>
- Savings: <https://headroom-docs.vercel.app/docs/savings>
- Troubleshooting: <https://headroom-docs.vercel.app/docs/troubleshooting>

## Supported modes

- Python library: `compress(messages)`
- TypeScript SDK: `headroom-ai`
- Local proxy: `headroom proxy --port 8787`
- Coding-agent wrapper: `headroom wrap codex`
- MCP server: `headroom mcp serve`
- Persistent deployment: `headroom install apply`
- Reversal: `headroom unwrap codex`

The upstream repository does not currently contain a Codex-compatible `SKILL.md`; this local skill is a thin operational wrapper around the official CLI and documentation.


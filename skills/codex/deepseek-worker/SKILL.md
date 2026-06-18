---
name: deepseek-worker
description: Use whenever a task includes simple, repetitive, low-risk rough work that should be offloaded to DeepSeek to save GPT tokens, especially file scanning, search result grouping, TODO batching, log summarization, first-draft extraction, or "用 DeepSeek 做粗活 / 省 GPT token / DeepSeek subagent / 外部 subagent". This skill routes work through the local `deepseek-worker` sidecar command because current Codex built-in subagents may not expose DeepSeek as a model override.
---

# DeepSeek Worker

Use this skill to offload bounded rough work to DeepSeek while keeping the main GPT thread responsible for planning, architecture, safety, final decisions, and integration.

The local helper command is:

```sh
deepseek-worker
```

Canonical path:

```sh
~/.codex/bin/deepseek-worker
```

Setup helper:

```sh
deepseek-worker-setup-key
```

Reference docs:

```text
~/.codex/docs/deepseek-worker.md
```

## When To Use

Prefer `deepseek-worker` for:

- collecting and grouping search results
- summarizing logs, notes, READMEs, or command output
- extracting TODOs, risks, action items, or file inventories
- drafting first-pass outlines that GPT will review
- repetitive checks where approximate results are useful
- bounded file scans where edits are not required

Keep the main GPT agent local for:

- architecture and product decisions
- security-sensitive reasoning
- final code review
- direct file edits
- tasks requiring reliable multi-tool orchestration
- cases where DeepSeek output must be verified before use

## Required Safety Rules

- Do not ask the user to paste the DeepSeek API key into chat.
- Use `deepseek-worker-setup-key` or `~/.config/deepseek/key.env` for local key storage.
- Do not send secrets, private keys, auth files, or credentials to DeepSeek.
- Treat DeepSeek output as draft evidence, not final authority.
- Verify any claim that affects implementation, security, or user-facing correctness.

## Basic Commands

Dry-run without an API call:

```sh
deepseek-worker --dry-run "Group these notes"
```

Check whether the configured API key works:

```sh
deepseek-worker --check-key
```

Pipe text:

```sh
rg -n "TODO|FIXME" . | deepseek-worker "Group these TODOs by priority and file"
```

Attach bounded text files:

```sh
deepseek-worker --file README.md --file package.json "Extract setup steps and likely risks"
```

Use stronger DeepSeek model only when rough work needs more reasoning:

```sh
deepseek-worker --model deepseek-v4-pro "Analyze this design note and list tradeoffs"
```

## Workflow

1. Decide whether the subtask is low-risk and bounded.
2. Gather only the minimum context needed for that subtask.
3. Run `deepseek-worker` with piped text or explicit `--file` inputs.
4. Read the output critically.
5. Integrate only the useful parts into the main GPT reasoning.
6. Verify important facts locally or with authoritative sources.

## If The Key Is Missing

If `deepseek-worker` reports that `DEEPSEEK_API_KEY` is unset, tell the user to run:

```sh
deepseek-worker-setup-key
```

Then ask them to say when it is done. Do not request the key value in the conversation. After the user confirms setup, run:

```sh
deepseek-worker --check-key
```

If key validation passes, run one tiny smoke task before relying on the worker for larger rough work.

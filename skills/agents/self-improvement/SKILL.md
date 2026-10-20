---
name: self-improvement
description: Use this skill when a command fails in a non-obvious way, the user corrects the agent, a recurring workaround appears, a project convention is discovered mid-task, or the user asks for a capability the current setup does not have. Also use it before major work in the same area to review past learnings from `.learnings/` so mistakes do not repeat.
---

# Self-Improvement

Capture durable learnings in the repo instead of relying on memory. This skill is for high-signal lessons: confusing failures, user corrections, recurring friction, missing capabilities, and project-specific rules that future work should remember.

The goal is not to log every typo or dead-end. The goal is to preserve the things that would save time or prevent repeat mistakes next time.

## Default location

Store entries in a project-local folder:

```text
.learnings/
```

Use three files:

- `.learnings/LEARNINGS.md`
- `.learnings/ERRORS.md`
- `.learnings/FEATURE_REQUESTS.md`

## When to use this skill

Use it when any of these are true:

- A command or tool failed and the diagnosis was not trivial.
- The user corrected an assumption, workflow, or fact.
- You discovered a project convention that was not documented clearly.
- You had to invent a workaround that may be useful later.
- The user asked for a capability the current repo or environment does not provide.
- You are about to work in an area that has bitten the team before, and a quick review of `.learnings/` could prevent regressions.

Do not use it for:

- one-off typos
- obvious syntax mistakes
- failures with no durable lesson
- noisy logs that nobody will consult again

## Workflow

1. Initialize `.learnings/` if it does not exist.
2. Log the learning as soon as the insight is clear.
3. Keep the summary short and concrete.
4. Include enough context that a future agent can act on it.
5. If the same lesson repeats, link or consolidate instead of creating scattered duplicates.
6. Promote stable, broadly useful rules into workspace guidance such as `AGENTS.md` when they stop being one-off learnings.

## Logging types

### Learning

Use for:

- user corrections
- knowledge gaps
- better patterns discovered while solving a task
- project conventions worth remembering

Core fields:

- summary
- category
- area
- suggested action
- related files

### Error

Use for:

- tool failures
- integration errors
- repeated environment problems
- bugs that needed investigation

Core fields:

- summary
- error text
- context
- suggested fix
- reproducibility

### Feature request

Use for:

- capabilities users asked for that the current repo, toolchain, or skill set does not support

Core fields:

- requested capability
- why it matters
- complexity estimate
- suggested implementation

## PowerShell helpers

Initialize the folder and header files:

```powershell
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE/.codex/skills/self-improvement/scripts/init-learnings.ps1"
```

Preview a learning entry without writing it:

```powershell
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE/.codex/skills/self-improvement/scripts/log-learning.ps1" `
  -Type learning `
  -Summary "pnpm workspace required for installs" `
  -Category best_practice `
  -Area config `
  -SuggestedAction "Use pnpm install instead of npm install in this repo" `
  -Preview
```

Append a real error entry:

```powershell
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE/.codex/skills/self-improvement/scripts/log-learning.ps1" `
  -Type error `
  -Summary "Playwright browser install missing on fresh machine" `
  -Area infra `
  -Details "Tool invocation failed until browser binaries were installed." `
  -SuggestedAction "Run the browser install step before UI tests."
```

## Review habit

Before major work, quickly scan the repo's `.learnings/` folder if it exists. Focus on entries that match the current area or toolchain.

Good review questions:

- Has this failed before in the same folder or subsystem?
- Did the user already correct this once?
- Is there a known command sequence that prevents the issue?

## Promotion rule

Promote a learning into `AGENTS.md` or another standing instruction when it is:

- recurring
- broadly applicable across tasks
- stable enough to act like a rule instead of a one-time note

Keep promoted rules short and preventative. The long incident record should stay in `.learnings/`.

## Bundled scripts

- `scripts/init-learnings.ps1`: creates `.learnings/` and the three markdown files if missing.
- `scripts/log-learning.ps1`: appends a structured learning, error, or feature request entry, or previews one before writing.

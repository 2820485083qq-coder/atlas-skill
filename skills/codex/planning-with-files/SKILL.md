---
name: planning-with-files
description: Persist task context into markdown planning files so future Codex turns can recover requirements, plans, decisions, current state, blockers, and touched files. Use when the user asks for "planning with files", "plan with files", "write the requirements/plan/decisions into markdown", "keep context in files", "防止丢上下文", "把需求计划决策写进 markdown", or when a task is long-running, ambiguous, multi-step, likely to span sessions, or needs a clean handoff.
---

# Planning With Files

## Purpose

Create and maintain project-local markdown files that preserve the minimum useful task state: user intent, requirements, plan, decisions, progress, blockers, and next actions.

Use first-principles discipline: do not blindly create documents. If the user's goal or motivation is unclear, pause and clarify before writing durable plans. If a cheaper path exists, record and recommend it.

## Default Files

Prefer an existing project convention. If the repo already has `Tasks/`, use it. Otherwise create `.codex/planning/`.

Default file set:

- `task-current.md`: the handoff entrypoint for the active task.
- `requirements.md`: goals, non-goals, constraints, assumptions, acceptance criteria.
- `plan.md`: actionable checklist with current status.
- `decisions.md`: durable decisions with rationale and revisit conditions.
- `context-log.md`: concise timeline of meaningful events, commands, findings, and changed files.

For very small tasks, use only `task-current.md` and `decisions.md` if a decision was made.

## Workflow

1. Discover context.
   - Read existing planning files before starting new ones.
   - Check for project instructions such as `AGENTS.md`, `CLAUDE.md`, `README.md`, `Tasks/`, `.codex/planning/`, or docs conventions.
   - Do not overwrite user-maintained notes. Update them carefully.

2. Challenge the goal before planning.
   - Identify the user's actual desired outcome.
   - Flag XY problems, unclear motivation, or unnecessarily expensive paths.
   - If ambiguity changes the plan materially, ask before committing files.

3. Create or update the file set.
   - Keep entries short and recoverable.
   - Use checkboxes for plans.
   - Mark status as `pending`, `in_progress`, `blocked`, or `done`.
   - Include absolute or repo-relative paths for important files.
   - Record commands or verification only when they matter for recovery.

4. Keep files synchronized while working.
   - Update `plan.md` when steps change.
   - Update `task-current.md` after meaningful progress or before ending a turn.
   - Add a `decisions.md` entry when choosing an approach, rejecting an option, changing scope, or accepting risk.
   - Add `context-log.md` entries for discoveries that would be costly to rediscover.

5. End with a handoff.
   - Ensure `task-current.md` answers: current goal, latest state, next action, blockers, changed files, and verification status.
   - Keep the final user answer short and point to the planning files.

## Failure Handling

- If the repository already has a task or planning convention, use it instead of creating a competing structure.
- If the user's goal is unclear enough that durable files would encode the wrong target, ask before writing.
- If planning files already contain user-maintained content, update the relevant section instead of replacing the file.
- If a write fails, report the intended file path and keep working from conversation context.

## CHECKPOINTS

- STOP before creating a new planning directory outside the project root.
- STOP before archiving, deleting, or wholesale rewriting existing planning files.

## Do Not Do

- Do not create planning files for trivial one-step tasks.
- Do not turn guesses into requirements.
- Do not let planning files become a substitute for doing the requested work.

## File Templates

Use the templates in `references/templates.md` when creating files from scratch. Adapt names and sections to existing project conventions.

## Update Rules

- Prefer editing existing sections over appending duplicates.
- Use dates in `YYYY-MM-DD` format.
- Preserve user language when it captures intent precisely.
- Separate facts, assumptions, and decisions.
- Do not turn speculative ideas into requirements.
- If a planning file becomes noisy, summarize stale details into a short archive section rather than deleting useful history.

## Decision Entry Format

Use this compact format in `decisions.md`:

```markdown
## YYYY-MM-DD - Decision title

- Decision: What will be done.
- Rationale: Why this is the better path.
- Alternatives considered: Other paths and why they were rejected.
- Consequences: Tradeoffs, risks, or follow-up work.
- Revisit when: Condition that should reopen the decision.
```

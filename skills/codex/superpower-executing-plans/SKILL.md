---
name: superpower-executing-plans
description: Use when you have a written implementation plan to execute in a separate session with review checkpoints
---
<!-- Adapted from Claude Code superpowers v5.0.7 for Codex CLI -->
<!-- Ported from CC superpowers v5.0.7 | Verified: tool mapping, aux inlining, path adaptation | 2026-04-13 -->

<MANDATORY-EXECUTION-RULE>
YOU MUST review the plan critically before executing any task.
YOU MUST use `update_plan` to track progress on every task.
YOU MUST run verifications as specified in the plan after each task.
YOU MUST stop and ask for clarification when blocked — do not guess.
NEVER skip plan review. NEVER mark tasks complete without verification. NEVER start on main/master without explicit consent.
</MANDATORY-EXECUTION-RULE>

# Executing Plans

## Overview

Load plan, review critically, execute all tasks, report when complete.

**Announce at start:** "I'm using the executing-plans skill to implement this plan."

**Note:** Tell your human partner that Superpowers works much better with access to subagents. The quality of its work will be significantly higher if run on a platform with subagent support. If subagents are available, use $superpower-subagents instead of this skill.

## The Process

### Step 1: Load and Review Plan
1. Read plan file
2. Review critically - identify any questions or concerns about the plan
3. If concerns: Raise them with your human partner before starting
4. If no concerns: Create update_plan entries and proceed

### Step 2: Execute Tasks

For each task:
1. Mark as in_progress via update_plan
2. Follow each step exactly (plan has bite-sized steps)
3. Run verifications as specified
4. Mark as completed via update_plan

### Step 3: Complete Development

After all tasks complete and verified:
- Announce: "I'm using the finishing-a-development-branch skill to complete this work."
- **REQUIRED SUB-SKILL:** Use $superpower-finish
- Follow that skill to verify tests, present options, execute choice

## When to Stop and Ask for Help

**STOP executing immediately when:**
- Hit a blocker (missing dependency, test fails, instruction unclear)
- Plan has critical gaps preventing starting
- You don't understand an instruction
- Verification fails repeatedly

**Ask for clarification rather than guessing.**

## When to Revisit Earlier Steps

**Return to Review (Step 1) when:**
- Partner updates the plan based on your feedback
- Fundamental approach needs rethinking

**Don't force through blockers** - stop and ask.

## Remember
- Review plan critically first
- Follow plan steps exactly
- Don't skip verifications
- Reference skills when plan says to
- Stop when blocked, don't guess
- Never start implementation on main/master branch without explicit user consent

## Guardrails

- Do not begin executing tasks before reviewing the plan critically and resolving concerns.
- Do not skip verifications specified in the plan steps.
- Do not guess or force through blockers — stop and ask for clarification.
- Do not start implementation on main/master branch without explicit user consent.
- Do not deviate from plan steps; follow each step exactly as written.
- Do not mark a task as completed without running specified verifications.

## Output Contract

Return:

- `Plan reviewed:` concerns raised or "no concerns, proceeding"
- `Tasks completed:` N/N with per-task verification status
- `Blockers encountered:` list or "none"
- `Next skill:` `$superpower-finish`

## Integration

**Required workflow skills:**
- **$superpower-git-worktrees** - REQUIRED: Set up isolated workspace before starting
- **$superpower-writing-plans** - Creates the plan this skill executes
- **$superpower-finish** - Complete development after all tasks

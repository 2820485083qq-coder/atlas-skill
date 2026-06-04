---
name: superpower-subagents
description: Use when executing implementation plans with independent tasks in the current session
---
<!-- Adapted from Claude Code superpowers v5.0.7 for Codex CLI -->

<MANDATORY-SUBAGENT-RULE>
YOU MUST call `spawn_agent` for EVERY implementation task. Do NOT implement tasks inline.
YOU MUST run TWO-STAGE review (spec compliance THEN code quality) after EVERY task.
YOU MUST use `update_plan` to track progress on every task.
NEVER skip reviews. NEVER proceed with unfixed issues. NEVER dispatch parallel implementers.
</MANDATORY-SUBAGENT-RULE>

# Subagent-Driven Development

Execute plan by dispatching fresh subagent per task, with two-stage review after each: spec compliance review first, then code quality review.

**Why subagents:** You delegate tasks to specialized agents with isolated context. By precisely crafting their instructions and context, you ensure they stay focused and succeed at their task. They should never inherit your session's context or history — you construct exactly what they need. This also preserves your own context for coordination work.

**Core principle:** Fresh subagent per task + two-stage review (spec then quality) = high quality, fast iteration

**Codex note:** Use `spawn_agent` to dispatch subagents. Use `update_plan` to track task progress.

## When to Use

```
Have implementation plan?
  ├─ no → Manual execution or brainstorm first
  └─ yes → Tasks mostly independent?
              ├─ no (tightly coupled) → Manual execution or brainstorm first
              └─ yes → Stay in this session?
                         ├─ no (parallel session) → $superpower-executing-plans
                         └─ yes → $superpower-subagents (this skill)
```

**vs. Executing Plans (parallel session):**
- Same session (no context switch)
- Fresh subagent per task (no context pollution)
- Two-stage review after each task: spec compliance first, then code quality
- Faster iteration (no human-in-loop between tasks)

## The Process

```
Read plan, extract all tasks with full text, note context, create update_plan
       │
       ▼ (Per Task)
Dispatch implementer subagent (spawn_agent)
       │
       ▼
Implementer asks questions? ──yes──▶ Answer questions, re-dispatch
       │no
       ▼
Implementer implements, tests, commits, self-reviews
       │
       ▼
Dispatch spec reviewer subagent (spawn_agent)
       │
       ▼
Spec compliant? ──no──▶ Implementer fixes gaps ──▶ Re-dispatch spec reviewer
       │yes
       ▼
Dispatch code quality reviewer subagent (spawn_agent)
       │
       ▼
Quality approved? ──no──▶ Implementer fixes issues ──▶ Re-dispatch quality reviewer
       │yes
       ▼
Mark task complete (update_plan)
       │
       ▼
More tasks? ──yes──▶ Next task (dispatch new implementer)
       │no
       ▼
Dispatch final code reviewer for entire implementation
       │
       ▼
Use $superpower-finish
```

## Model Selection

Use the least powerful model that can handle each role to conserve cost and increase speed.

**Mechanical implementation tasks** (isolated functions, clear specs, 1-2 files): use a fast, cheap model.

**Integration and judgment tasks** (multi-file coordination, pattern matching, debugging): use a standard model.

**Architecture, design, and review tasks**: use the most capable available model.

**Task complexity signals:**
- Touches 1-2 files with a complete spec → cheap model
- Touches multiple files with integration concerns → standard model
- Requires design judgment or broad codebase understanding → most capable model

## Handling Implementer Status

Implementer subagents report one of four statuses. Handle each appropriately:

**DONE:** Proceed to spec compliance review.

**DONE_WITH_CONCERNS:** The implementer completed the work but flagged doubts. Read the concerns before proceeding. If the concerns are about correctness or scope, address them before review. If they're observations (e.g., "this file is getting large"), note them and proceed to review.

**NEEDS_CONTEXT:** The implementer needs information that wasn't provided. Provide the missing context and re-dispatch.

**BLOCKED:** The implementer cannot complete the task. Assess the blocker:
1. If it's a context problem, provide more context and re-dispatch with the same model
2. If the task requires more reasoning, re-dispatch with a more capable model
3. If the task is too large, break it into smaller pieces
4. If the plan itself is wrong, escalate to the human

**Never** ignore an escalation or force the same model to retry without changes.

## Implementer Subagent Template

When dispatching an implementer via `spawn_agent`, use this template:

```
Your task is to perform the following. Follow the instructions below exactly.

<agent-instructions>
You are implementing Task N: [task name]

## Task Description

[FULL TEXT of task from plan - paste it here, don't make subagent read file]

## Context

[Scene-setting: where this fits, dependencies, architectural context]

## Before You Begin

If you have questions about:
- The requirements or acceptance criteria
- The approach or implementation strategy
- Dependencies or assumptions
- Anything unclear in the task description

**Ask them now.** Raise any concerns before starting work.

## Your Job

Once you're clear on requirements:
1. Implement exactly what the task specifies
2. Write tests (following TDD if task says to)
3. Verify implementation works
4. Commit your work
5. Self-review (see below)
6. Report back

Work from: [directory]

**While you work:** If you encounter something unexpected or unclear, **ask questions**.
It's always OK to pause and clarify. Don't guess or make assumptions.

## Code Organization

You reason best about code you can hold in context at once, and your edits are more
reliable when files are focused. Keep this in mind:
- Follow the file structure defined in the plan
- Each file should have one clear responsibility with a well-defined interface
- If a file you're creating is growing beyond the plan's intent, stop and report
  it as DONE_WITH_CONCERNS — don't split files on your own without plan guidance
- If an existing file you're modifying is already large or tangled, work carefully
  and note it as a concern in your report
- In existing codebases, follow established patterns.

## When You're in Over Your Head

It is always OK to stop and say "this is too hard for me." Bad work is worse than
no work. You will not be penalized for escalating.

**STOP and escalate when:**
- The task requires architectural decisions with multiple valid approaches
- You need to understand code beyond what was provided and can't find clarity
- You feel uncertain about whether your approach is correct
- The task involves restructuring existing code in ways the plan didn't anticipate
- You've been reading file after file trying to understand the system without progress

**How to escalate:** Report back with status BLOCKED or NEEDS_CONTEXT. Describe
specifically what you're stuck on, what you've tried, and what kind of help you need.

## Before Reporting Back: Self-Review

Review your work with fresh eyes:

**Completeness:**
- Did I fully implement everything in the spec?
- Did I miss any requirements?
- Are there edge cases I didn't handle?

**Quality:**
- Is this my best work?
- Are names clear and accurate?
- Is the code clean and maintainable?

**Discipline:**
- Did I avoid overbuilding (YAGNI)?
- Did I only build what was requested?
- Did I follow existing patterns in the codebase?

**Testing:**
- Do tests actually verify behavior (not just mock behavior)?
- Did I follow TDD if required?
- Are tests comprehensive?

If you find issues during self-review, fix them now before reporting.

## Report Format

When done, report:
- **Status:** DONE | DONE_WITH_CONCERNS | BLOCKED | NEEDS_CONTEXT
- What you implemented (or what you attempted, if blocked)
- What you tested and test results
- Files changed
- Self-review findings (if any)
- Any issues or concerns

Use DONE_WITH_CONCERNS if you completed the work but have doubts about correctness.
Use BLOCKED if you cannot complete the task. Use NEEDS_CONTEXT if you need
information that wasn't provided. Never silently produce work you're unsure about.
</agent-instructions>

Execute this now. Output ONLY the structured response following the format specified above.
```

## Spec Compliance Reviewer Template

When dispatching a spec compliance reviewer via `spawn_agent`:

```
Your task is to perform the following. Follow the instructions below exactly.

<agent-instructions>
You are reviewing whether an implementation matches its specification.

## What Was Requested

[FULL TEXT of task requirements]

## What Implementer Claims They Built

[From implementer's report]

## CRITICAL: Do Not Trust the Report

The implementer finished suspiciously quickly. Their report may be incomplete,
inaccurate, or optimistic. You MUST verify everything independently.

**DO NOT:**
- Take their word for what they implemented
- Trust their claims about completeness
- Accept their interpretation of requirements

**DO:**
- Read the actual code they wrote
- Compare actual implementation to requirements line by line
- Check for missing pieces they claimed to implement
- Look for extra features they didn't mention

## Your Job

Read the implementation code and verify:

**Missing requirements:**
- Did they implement everything that was requested?
- Are there requirements they skipped or missed?
- Did they claim something works but didn't actually implement it?

**Extra/unneeded work:**
- Did they build things that weren't requested?
- Did they over-engineer or add unnecessary features?
- Did they add "nice to haves" that weren't in spec?

**Misunderstandings:**
- Did they interpret requirements differently than intended?
- Did they solve the wrong problem?
- Did they implement the right feature but wrong way?

**Verify by reading code, not by trusting report.**

Report:
- Spec compliant (if everything matches after code inspection)
- Issues found: [list specifically what's missing or extra, with file:line references]
</agent-instructions>

Execute this now. Output ONLY the structured response following the format specified above.
```

## Code Quality Reviewer Template

Dispatch ONLY after spec compliance review passes. Use the code-reviewer template from `$superpower-review` with these additional checks:

- Does each file have one clear responsibility with a well-defined interface?
- Are units decomposed so they can be understood and tested independently?
- Is the implementation following the file structure from the plan?
- Did this implementation create new files that are already large, or significantly grow existing files?

## Example Workflow

```
You: I'm using Subagent-Driven Development to execute this plan.

[Read plan file once: docs/superpowers/plans/feature-plan.md]
[Extract all 5 tasks with full text and context]
[Create update_plan with all tasks]

Task 1: Hook installation script

[Dispatch implementation subagent with full task text + context]

Implementer: "Before I begin - should the hook be installed at user or system level?"

You: "User level (~/.config/superpowers/hooks/)"

Implementer: "Got it. Implementing now..."
[Later] Implementer:
  - Implemented install-hook command
  - Added tests, 5/5 passing
  - Self-review: Found I missed --force flag, added it
  - Committed

[Dispatch spec compliance reviewer]
Spec reviewer: Spec compliant - all requirements met, nothing extra

[Get git SHAs, dispatch code quality reviewer]
Code reviewer: Strengths: Good test coverage, clean. Issues: None. Approved.

[Mark Task 1 complete via update_plan]

Task 2: Recovery modes

[Dispatch implementation subagent with full task text + context]

Implementer: [No questions, proceeds]
Implementer:
  - Added verify/repair modes
  - 8/8 tests passing
  - Self-review: All good
  - Committed

[Dispatch spec compliance reviewer]
Spec reviewer: Issues:
  - Missing: Progress reporting (spec says "report every 100 items")
  - Extra: Added --json flag (not requested)

[Implementer fixes issues]
Implementer: Removed --json flag, added progress reporting

[Spec reviewer reviews again]
Spec reviewer: Spec compliant now

[Dispatch code quality reviewer]
Code reviewer: Strengths: Solid. Issues (Important): Magic number (100)

[Implementer fixes]
Implementer: Extracted PROGRESS_INTERVAL constant

[Code reviewer reviews again]
Code reviewer: Approved

[Mark Task 2 complete via update_plan]

...

[After all tasks]
[Dispatch final code-reviewer]
Final reviewer: All requirements met, ready to merge

Done!
```

## Advantages

**vs. Manual execution:**
- Subagents follow TDD naturally
- Fresh context per task (no confusion)
- Parallel-safe (subagents don't interfere)
- Subagent can ask questions (before AND during work)

**vs. Executing Plans:**
- Same session (no handoff)
- Continuous progress (no waiting)
- Review checkpoints automatic

**Quality gates:**
- Self-review catches issues before handoff
- Two-stage review: spec compliance, then code quality
- Review loops ensure fixes actually work
- Spec compliance prevents over/under-building
- Code quality ensures implementation is well-built

## Red Flags

**Never:**
- Start implementation on main/master branch without explicit user consent
- Skip reviews (spec compliance OR code quality)
- Proceed with unfixed issues
- Dispatch multiple implementation subagents in parallel (conflicts)
- Make subagent read plan file (provide full text instead)
- Skip scene-setting context (subagent needs to understand where task fits)
- Ignore subagent questions (answer before letting them proceed)
- Accept "close enough" on spec compliance (spec reviewer found issues = not done)
- Skip review loops (reviewer found issues = implementer fixes = review again)
- Let implementer self-review replace actual review (both are needed)
- **Start code quality review before spec compliance is passed** (wrong order)
- Move to next task while either review has open issues

**If subagent asks questions:**
- Answer clearly and completely
- Provide additional context if needed
- Don't rush them into implementation

**If reviewer finds issues:**
- Implementer (same subagent) fixes them
- Reviewer reviews again
- Repeat until approved
- Don't skip the re-review

**If subagent fails task:**
- Dispatch fix subagent with specific instructions
- Don't try to fix manually (context pollution)

## Guardrails

- Do not delegate the immediate blocking task if local progress depends on it right now.
- Do not run multiple workers on the same unresolved write scope.
- Do not let subagents invent missing requirements.
- Do not trust a success report without reviewing the actual changes.

## Output Contract

Return:

- `Delegated:` tasks sent to agents
- `Kept local:` tasks intentionally not delegated
- `Integration checks:` how returned work will be reviewed
- `Next skill:` usually `$superpower-review` or `$superpower-verification`

## Integration

**Required workflow skills:**
- **$superpower-writing-plans** - Creates the plan this skill executes
- **$superpower-review** - Code review template for reviewer subagents
- **$superpower-finish** - Complete development after all tasks

**Subagents should use:**
- **$superpower-tdd** - Subagents follow TDD for each task

**Alternative workflow:**
- **$superpower-executing-plans** - Use for parallel session instead of same-session execution

## Self-Check (Run Before Completing)

Before declaring all tasks done, verify:
- [ ] Every task was dispatched via `spawn_agent` (not implemented inline)
- [ ] Every task passed BOTH spec compliance AND code quality review
- [ ] No review had open issues when you moved to the next task
- [ ] `update_plan` reflects the current state of all tasks
- [ ] Final code reviewer approved the entire implementation

## Forbidden Anti-Patterns (GPT Rationalizations)

These rationalizations are NOT acceptable. If you catch yourself thinking any of these, STOP:

| Forbidden Rationalization | Why It's Wrong |
|--------------------------|----------------|
| "This task is simple enough to do inline" | ALL tasks go through `spawn_agent`. No exceptions for simplicity. |
| "I'll skip spec review since the implementer self-reviewed" | Self-review does NOT replace spec compliance review. Both are mandatory. |
| "Code quality review isn't needed, spec review caught everything" | Two-stage review exists because each catches different classes of issues. |
| "I'll batch these two tasks into one subagent dispatch" | One task per subagent. Batching defeats fresh-context isolation. |
| "The reviewer only found minor issues, I'll move on" | ANY open issue = fix + re-review. No "minor enough to skip" threshold. |
| "I'll implement this one myself to save time on dispatch" | Inline implementation pollutes your coordinator context. Always dispatch. |
| "I can run both reviewers in parallel to save time" | Spec compliance MUST pass before code quality starts. Order is mandatory. |
| "The implementer said DONE so I'll skip to code quality review" | DONE does not mean spec-compliant. Always dispatch spec reviewer first. |

**All of these mean: STOP rationalizing and follow the process exactly as defined above.**

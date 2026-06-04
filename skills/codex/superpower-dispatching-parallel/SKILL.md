---
name: superpower-dispatching-parallel
description: Use when facing 2+ independent tasks that can be worked on without shared state or sequential dependencies - dispatch one spawn_agent per independent problem domain for concurrent resolution
---

<!-- Adapted from Claude Code superpowers v5.0.7 for Codex CLI -->
<!-- Tool mapping: Task/Agent tool -> spawn_agent | TodoWrite -> update_plan -->

<MANDATORY-SUBAGENT-RULE>
YOU MUST call `spawn_agent` for EACH independent problem domain — do NOT investigate sequentially.
YOU MUST verify all agent changes after they return — run the full test suite.
NEVER dispatch agents for related failures (fix one might fix others).
NEVER let agents work on shared state or the same files.
</MANDATORY-SUBAGENT-RULE>

# Dispatching Parallel Agents

## Overview

You delegate tasks to specialized agents with isolated context. By precisely crafting their instructions and context, you ensure they stay focused and succeed at their task. They should never inherit your session's context or history — you construct exactly what they need. This also preserves your own context for coordination work.

When you have multiple unrelated failures (different test files, different subsystems, different bugs), investigating them sequentially wastes time. Each investigation is independent and can happen in parallel.

**Core principle:** Dispatch one agent per independent problem domain. Let them work concurrently.

## When to Use

```
Multiple failures? ──yes──> Are they independent? ──yes──> Can they work in parallel?
                                    │                              │           │
                                   no                             yes         no
                                    │                              │           │
                            Single agent                   Parallel       Sequential
                            investigates all               dispatch       agents
```

**Use when:**
- 3+ test files failing with different root causes
- Multiple subsystems broken independently
- Each problem can be understood without context from others
- No shared state between investigations

**Don't use when:**
- Failures are related (fix one might fix others)
- Need to understand full system state
- Agents would interfere with each other

## The Pattern

### 1. Identify Independent Domains

Group failures by what's broken:
- File A tests: Tool approval flow
- File B tests: Batch completion behavior
- File C tests: Abort functionality

Each domain is independent - fixing tool approval doesn't affect abort tests.

### 2. Create Focused Agent Tasks

Each agent gets:
- **Specific scope:** One test file or subsystem
- **Clear goal:** Make these tests pass
- **Constraints:** Don't change other code
- **Expected output:** Summary of what you found and fixed

### 3. Dispatch in Parallel

Use `spawn_agent` for each independent domain:

```
spawn_agent("Fix agent-tool-abort.test.ts failures")
spawn_agent("Fix batch-completion-behavior.test.ts failures")
spawn_agent("Fix tool-approval-race-conditions.test.ts failures")
// All three run concurrently
```

**Codex note:** `spawn_agent` is the Codex CLI dispatch mechanism. Each spawned agent gets isolated context and works independently.

### 4. Review and Integrate

When agents return:
- Read each summary
- Verify fixes don't conflict
- Run full test suite
- Integrate all changes

## Agent Prompt Structure

Good agent prompts are:
1. **Focused** - One clear problem domain
2. **Self-contained** - All context needed to understand the problem
3. **Specific about output** - What should the agent return?

```markdown
Fix the 3 failing tests in src/agents/agent-tool-abort.test.ts:

1. "should abort tool with partial output capture" - expects 'interrupted at' in message
2. "should handle mixed completed and aborted tools" - fast tool aborted instead of completed
3. "should properly track pendingToolCount" - expects 3 results but gets 0

These are timing/race condition issues. Your task:

1. Read the test file and understand what each test verifies
2. Identify root cause - timing issues or actual bugs?
3. Fix by:
   - Replacing arbitrary timeouts with event-based waiting
   - Fixing bugs in abort implementation if found
   - Adjusting test expectations if testing changed behavior

Do NOT just increase timeouts - find the real issue.

Return: Summary of what you found and what you fixed.
```

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Too broad: "Fix all the tests" | Specific: "Fix agent-tool-abort.test.ts" |
| No context: "Fix the race condition" | Paste error messages and test names |
| No constraints: Agent might refactor everything | "Do NOT change production code" or "Fix tests only" |
| Vague output: "Fix it" | "Return summary of root cause and changes" |

## When NOT to Use

- **Related failures:** Fixing one might fix others - investigate together first
- **Need full context:** Understanding requires seeing entire system
- **Exploratory debugging:** You don't know what's broken yet
- **Shared state:** Agents would interfere (editing same files, using same resources)

## Real Example

**Scenario:** 6 test failures across 3 files after major refactoring

**Failures:**
- agent-tool-abort.test.ts: 3 failures (timing issues)
- batch-completion-behavior.test.ts: 2 failures (tools not executing)
- tool-approval-race-conditions.test.ts: 1 failure (execution count = 0)

**Decision:** Independent domains - abort logic separate from batch completion separate from race conditions

**Dispatch:**
```
spawn_agent("Fix agent-tool-abort.test.ts — 3 timing failures")
spawn_agent("Fix batch-completion-behavior.test.ts — 2 tool execution failures")
spawn_agent("Fix tool-approval-race-conditions.test.ts — 1 race condition failure")
```

**Results:**
- Agent 1: Replaced timeouts with event-based waiting
- Agent 2: Fixed event structure bug (threadId in wrong place)
- Agent 3: Added wait for async tool execution to complete

**Integration:** All fixes independent, no conflicts, full suite green

**Time saved:** 3 problems solved in parallel vs sequentially

## Key Benefits

1. **Parallelization** - Multiple investigations happen simultaneously
2. **Focus** - Each agent has narrow scope, less context to track
3. **Independence** - Agents don't interfere with each other
4. **Speed** - 3 problems solved in time of 1

## Verification

After agents return:
1. **Review each summary** - Understand what changed
2. **Check for conflicts** - Did agents edit same code?
3. **Run full suite** - Verify all fixes work together
4. **Spot check** - Agents can make systematic errors

## Integration

**Called by:**
- `$superpower-debugging` - when multiple independent failures detected
- `$superpower-executing-plans` - when plan has independent tasks
- `$superpower-subagents` - as the core dispatch mechanism

**Pairs with:**
- `$superpower-verification` - verify all agent changes after integration

---

## Self-Check Before Responding

**STOP before claiming dispatch is complete. Verify ALL of these:**

- [ ] Did I call `spawn_agent` for EACH independent domain? (Not implemented inline)
- [ ] Did all agents run in parallel? (Not dispatched sequentially one-at-a-time)
- [ ] Did I collect and review ALL agent results before proceeding?
- [ ] Did I check for conflicts between agent changes? (Same files, shared state)
- [ ] Did I run the FULL test suite after integrating all changes?
- [ ] Did I report what each agent found and fixed?

**If ANY checkbox is unchecked, you are NOT done. Go back and complete it.**

## Forbidden Anti-Patterns (GPT Rationalizations)

These rationalizations are NOT acceptable. If you catch yourself thinking any of these, STOP:

| Forbidden Rationalization | Why It's Wrong |
|--------------------------|----------------|
| "I chose the conservative approach" | Conservative = sequential = wasting time. Dispatch in parallel. |
| "To save time I'll do it inline" | Inline is SLOWER for independent problems. Dispatch agents. |
| "The task is simple enough to handle myself" | Simple tasks still benefit from parallel dispatch when there are multiple. |
| "I'll dispatch one agent first to see if it works" | This is sequential dispatch. Send ALL agents at once. |
| "These failures might be related" | If you haven't PROVEN they're related, treat them as independent. |
| "I can do all three faster than dispatching agents" | You cannot. Parallel is always faster for independent work. |
| "Let me investigate first, then dispatch" | Investigation IS the agent's job. Dispatch with investigation instructions. |
| "One agent can handle all of these" | One agent = sequential. Multiple independent domains = multiple agents. |

**All of these mean: STOP rationalizing and dispatch `spawn_agent` for each domain.**

## Guardrails

- Do not investigate independent problems sequentially — dispatch one `spawn_agent` per domain.
- Do not dispatch agents for related failures where fixing one might fix others.
- Do not let agents work on shared state or the same files.
- Do not trust agent success reports without independently verifying via VCS diff and full test suite.
- Do not dispatch agents one-at-a-time to "test first" — send all agents at once for independent domains.
- Do not proceed without reviewing all agent results and checking for conflicts.

## Output Contract

Return:

- `Domains identified:` list of independent problem domains
- `Agents dispatched:` count and scope of each `spawn_agent`
- `Agent results:` per-agent summary of findings and fixes
- `Conflict check:` whether agents edited same files or shared state
- `Full suite result:` test suite output after integrating all changes
- `Next skill:` `$superpower-verification`

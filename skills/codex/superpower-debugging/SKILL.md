---
name: superpower-debugging
description: Use when encountering any bug, test failure, or unexpected behavior, before proposing fixes
---
<!-- Adapted from Claude Code superpowers v5.0.7 for Codex CLI -->

# Systematic Debugging

## Overview

Random fixes waste time and create new bugs. Quick patches mask underlying issues.

**Core principle:** ALWAYS find root cause before attempting fixes. Symptom fixes are failure.

**Violating the letter of this process is violating the spirit of debugging.**

## The Iron Law

```
NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST
```

If you haven't completed Phase 1, you cannot propose fixes.

## When to Use

Use for ANY technical issue:
- Test failures
- Bugs in production
- Unexpected behavior
- Performance problems
- Build failures
- Integration issues

**Use this ESPECIALLY when:**
- Under time pressure (emergencies make guessing tempting)
- "Just one quick fix" seems obvious
- You've already tried multiple fixes
- Previous fix didn't work
- You don't fully understand the issue

**Don't skip when:**
- Issue seems simple (simple bugs have root causes too)
- You're in a hurry (rushing guarantees rework)
- Manager wants it fixed NOW (systematic is faster than thrashing)

## The Four Phases

You MUST complete each phase before proceeding to the next.

### Phase 1: Root Cause Investigation

**BEFORE attempting ANY fix:**

1. **Read Error Messages Carefully**
   - Don't skip past errors or warnings
   - They often contain the exact solution
   - Read stack traces completely
   - Note line numbers, file paths, error codes

2. **Reproduce Consistently**
   - Can you trigger it reliably?
   - What are the exact steps?
   - Does it happen every time?
   - If not reproducible → gather more data, don't guess

3. **Check Recent Changes**
   - What changed that could cause this?
   - Git diff, recent commits
   - New dependencies, config changes
   - Environmental differences

4. **Gather Evidence in Multi-Component Systems**

   **WHEN system has multiple components (CI → build → signing, API → service → database):**

   **BEFORE proposing fixes, add diagnostic instrumentation:**
   ```
   For EACH component boundary:
     - Log what data enters component
     - Log what data exits component
     - Verify environment/config propagation
     - Check state at each layer

   Run once to gather evidence showing WHERE it breaks
   THEN analyze evidence to identify failing component
   THEN investigate that specific component
   ```

   **Example (multi-layer system):**
   ```bash
   # Layer 1: Workflow
   echo "=== Secrets available in workflow: ==="
   echo "IDENTITY: ${IDENTITY:+SET}${IDENTITY:-UNSET}"

   # Layer 2: Build script
   echo "=== Env vars in build script: ==="
   env | grep IDENTITY || echo "IDENTITY not in environment"

   # Layer 3: Signing script
   echo "=== Keychain state: ==="
   security list-keychains
   security find-identity -v

   # Layer 4: Actual signing
   codesign --sign "$IDENTITY" --verbose=4 "$APP"
   ```

   **This reveals:** Which layer fails (secrets → workflow ✓, workflow → build ✗)

5. **Trace Data Flow (Root Cause Tracing)**

   **WHEN error is deep in call stack:**

   Bugs often manifest deep in the call stack. Your instinct is to fix where the error appears, but that's treating a symptom.

   **Trace backward through the call chain until you find the original trigger, then fix at the source.**

   The Tracing Process:
   1. **Observe the Symptom** — What error do you see?
   2. **Find Immediate Cause** — What code directly causes this?
   3. **Ask: What Called This?** — Trace the call chain upward
   4. **Keep Tracing Up** — What value was passed? Where did it come from?
   5. **Find Original Trigger** — Where did the bad value originate?

   **Adding Stack Traces for instrumentation:**
   ```typescript
   // Before the problematic operation
   async function gitInit(directory: string) {
     const stack = new Error().stack;
     console.error('DEBUG git init:', {
       directory,
       cwd: process.cwd(),
       nodeEnv: process.env.NODE_ENV,
       stack,
     });
     await execFileAsync('git', ['init'], { cwd: directory });
   }
   ```

   **Critical:** Use `console.error()` in tests (not logger - may not show)

   **NEVER fix just where the error appears.** Trace back to find the original trigger.

### Phase 2: Pattern Analysis

**Find the pattern before fixing:**

1. **Find Working Examples**
   - Locate similar working code in same codebase
   - What works that's similar to what's broken?

2. **Compare Against References**
   - If implementing pattern, read reference implementation COMPLETELY
   - Don't skim - read every line
   - Understand the pattern fully before applying

3. **Identify Differences**
   - What's different between working and broken?
   - List every difference, however small
   - Don't assume "that can't matter"

4. **Understand Dependencies**
   - What other components does this need?
   - What settings, config, environment?
   - What assumptions does it make?

### Phase 3: Hypothesis and Testing

**Scientific method:**

1. **Form Single Hypothesis**
   - State clearly: "I think X is the root cause because Y"
   - Write it down
   - Be specific, not vague

2. **Test Minimally**
   - Make the SMALLEST possible change to test hypothesis
   - One variable at a time
   - Don't fix multiple things at once

3. **Verify Before Continuing**
   - Did it work? Yes → Phase 4
   - Didn't work? Form NEW hypothesis
   - DON'T add more fixes on top

4. **When You Don't Know**
   - Say "I don't understand X"
   - Don't pretend to know
   - Ask for help
   - Research more

### Phase 4: Implementation

**Fix the root cause, not the symptom:**

1. **Create Failing Test Case**
   - Simplest possible reproduction
   - Automated test if possible
   - One-off test script if no framework
   - MUST have before fixing
   - Use `$superpower-tdd` for writing proper failing tests

2. **Implement Single Fix**
   - Address the root cause identified
   - ONE change at a time
   - No "while I'm here" improvements
   - No bundled refactoring

3. **Verify Fix**
   - Test passes now?
   - No other tests broken?
   - Issue actually resolved?

4. **If Fix Doesn't Work**
   - STOP
   - Count: How many fixes have you tried?
   - If < 3: Return to Phase 1, re-analyze with new information
   - **If ≥ 3: STOP and question the architecture (step 5 below)**
   - DON'T attempt Fix #4 without architectural discussion

5. **If 3+ Fixes Failed: Question Architecture**

   **Pattern indicating architectural problem:**
   - Each fix reveals new shared state/coupling/problem in different place
   - Fixes require "massive refactoring" to implement
   - Each fix creates new symptoms elsewhere

   **STOP and question fundamentals:**
   - Is this pattern fundamentally sound?
   - Are we "sticking with it through sheer inertia"?
   - Should we refactor architecture vs. continue fixing symptoms?

   **Discuss with your human partner before attempting more fixes**

   This is NOT a failed hypothesis - this is a wrong architecture.

<!-- Inlined from defense-in-depth.md -->
## Defense-in-Depth Validation

When you fix a bug caused by invalid data, adding validation at one place feels sufficient. But that single check can be bypassed by different code paths, refactoring, or mocks.

**Core principle:** Validate at EVERY layer data passes through. Make the bug structurally impossible.

### Why Multiple Layers

Single validation: "We fixed the bug"
Multiple layers: "We made the bug impossible"

Different layers catch different cases:
- Entry validation catches most bugs
- Business logic catches edge cases
- Environment guards prevent context-specific dangers
- Debug logging helps when other layers fail

### The Four Layers

#### Layer 1: Entry Point Validation
**Purpose:** Reject obviously invalid input at API boundary

```typescript
function createProject(name: string, workingDirectory: string) {
  if (!workingDirectory || workingDirectory.trim() === '') {
    throw new Error('workingDirectory cannot be empty');
  }
  if (!existsSync(workingDirectory)) {
    throw new Error(`workingDirectory does not exist: ${workingDirectory}`);
  }
  if (!statSync(workingDirectory).isDirectory()) {
    throw new Error(`workingDirectory is not a directory: ${workingDirectory}`);
  }
  // ... proceed
}
```

#### Layer 2: Business Logic Validation
**Purpose:** Ensure data makes sense for this operation

```typescript
function initializeWorkspace(projectDir: string, sessionId: string) {
  if (!projectDir) {
    throw new Error('projectDir required for workspace initialization');
  }
  // ... proceed
}
```

#### Layer 3: Environment Guards
**Purpose:** Prevent dangerous operations in specific contexts

```typescript
async function gitInit(directory: string) {
  // In tests, refuse git init outside temp directories
  if (process.env.NODE_ENV === 'test') {
    const normalized = normalize(resolve(directory));
    const tmpDir = normalize(resolve(tmpdir()));

    if (!normalized.startsWith(tmpDir)) {
      throw new Error(
        `Refusing git init outside temp dir during tests: ${directory}`
      );
    }
  }
  // ... proceed
}
```

#### Layer 4: Debug Instrumentation
**Purpose:** Capture context for forensics

```typescript
async function gitInit(directory: string) {
  const stack = new Error().stack;
  logger.debug('About to git init', {
    directory,
    cwd: process.cwd(),
    stack,
  });
  // ... proceed
}
```

### Applying the Pattern

When you find a bug:

1. **Trace the data flow** - Where does bad value originate? Where used?
2. **Map all checkpoints** - List every point data passes through
3. **Add validation at each layer** - Entry, business, environment, debug
4. **Test each layer** - Try to bypass layer 1, verify layer 2 catches it

### Key Insight

All four layers are necessary. During testing, each layer catches bugs the others miss:
- Different code paths bypass entry validation
- Mocks bypass business logic checks
- Edge cases on different platforms need environment guards
- Debug logging identifies structural misuse

**Don't stop at one validation point.** Add checks at every layer.
<!-- End inlined from defense-in-depth.md -->

## Condition-Based Waiting

Flaky tests often guess at timing with arbitrary delays. This creates race conditions where tests pass on fast machines but fail under load or in CI.

**Core principle:** Wait for the actual condition you care about, not a guess about how long it takes.

### When to Use

**Use when:**
- Tests have arbitrary delays (`setTimeout`, `sleep`, `time.sleep()`)
- Tests are flaky (pass sometimes, fail under load)
- Tests timeout when run in parallel
- Waiting for async operations to complete

**Don't use when:**
- Testing actual timing behavior (debounce, throttle intervals)
- Always document WHY if using arbitrary timeout

### Core Pattern

```typescript
// BAD: Guessing at timing
await new Promise(r => setTimeout(r, 50));
const result = getResult();
expect(result).toBeDefined();

// GOOD: Waiting for condition
await waitFor(() => getResult() !== undefined);
const result = getResult();
expect(result).toBeDefined();
```

### Quick Patterns

| Scenario | Pattern |
|----------|---------|
| Wait for event | `waitFor(() => events.find(e => e.type === 'DONE'))` |
| Wait for state | `waitFor(() => machine.state === 'ready')` |
| Wait for count | `waitFor(() => items.length >= 5)` |
| Wait for file | `waitFor(() => fs.existsSync(path))` |
| Complex condition | `waitFor(() => obj.ready && obj.value > 10)` |

### Generic Polling Implementation

```typescript
async function waitFor<T>(
  condition: () => T | undefined | null | false,
  description: string,
  timeoutMs = 5000
): Promise<T> {
  const startTime = Date.now();

  while (true) {
    const result = condition();
    if (result) return result;

    if (Date.now() - startTime > timeoutMs) {
      throw new Error(`Timeout waiting for ${description} after ${timeoutMs}ms`);
    }

    await new Promise(r => setTimeout(r, 10)); // Poll every 10ms
  }
}
```

### Domain-Specific Helpers

Build specialized helpers on top of the generic `waitFor`:

```typescript
/**
 * Wait for a specific event type to appear
 * Example: await waitForEvent(threadManager, threadId, 'TOOL_RESULT');
 */
function waitForEvent(
  threadManager: ThreadManager,
  threadId: string,
  eventType: string,
  timeoutMs = 5000
): Promise<Event> {
  return new Promise((resolve, reject) => {
    const startTime = Date.now();
    const check = () => {
      const events = threadManager.getEvents(threadId);
      const event = events.find((e) => e.type === eventType);
      if (event) {
        resolve(event);
      } else if (Date.now() - startTime > timeoutMs) {
        reject(new Error(`Timeout waiting for ${eventType} event after ${timeoutMs}ms`));
      } else {
        setTimeout(check, 10);
      }
    };
    check();
  });
}

/**
 * Wait for N events of a given type
 * Example: await waitForEventCount(threadManager, threadId, 'AGENT_MESSAGE', 2);
 */
function waitForEventCount(
  threadManager: ThreadManager,
  threadId: string,
  eventType: string,
  count: number,
  timeoutMs = 5000
): Promise<Event[]> {
  return new Promise((resolve, reject) => {
    const startTime = Date.now();
    const check = () => {
      const events = threadManager.getEvents(threadId);
      const matching = events.filter((e) => e.type === eventType);
      if (matching.length >= count) {
        resolve(matching);
      } else if (Date.now() - startTime > timeoutMs) {
        reject(new Error(
          `Timeout waiting for ${count} ${eventType} events after ${timeoutMs}ms (got ${matching.length})`
        ));
      } else {
        setTimeout(check, 10);
      }
    };
    check();
  });
}

/**
 * Wait for an event matching a custom predicate
 * Example: await waitForEventMatch(mgr, id, (e) => e.type === 'TOOL_RESULT' && e.data.id === 'call_123', 'TOOL_RESULT with id=call_123');
 */
function waitForEventMatch(
  threadManager: ThreadManager,
  threadId: string,
  predicate: (event: Event) => boolean,
  description: string,
  timeoutMs = 5000
): Promise<Event> {
  return new Promise((resolve, reject) => {
    const startTime = Date.now();
    const check = () => {
      const events = threadManager.getEvents(threadId);
      const event = events.find(predicate);
      if (event) {
        resolve(event);
      } else if (Date.now() - startTime > timeoutMs) {
        reject(new Error(`Timeout waiting for ${description} after ${timeoutMs}ms`));
      } else {
        setTimeout(check, 10);
      }
    };
    check();
  });
}
```

### Real-World Usage Example

```typescript
// BEFORE (flaky — 60% pass rate):
const messagePromise = agent.sendMessage('Execute tools');
await new Promise(r => setTimeout(r, 300)); // Hope tools start in 300ms
agent.abort();
await messagePromise;
await new Promise(r => setTimeout(r, 50));  // Hope results arrive in 50ms
expect(toolResults.length).toBe(2);         // Fails randomly

// AFTER (reliable — 100% pass rate):
const messagePromise = agent.sendMessage('Execute tools');
await waitForEventCount(threadManager, threadId, 'TOOL_CALL', 2); // Wait for tools to start
agent.abort();
await messagePromise;
await waitForEventCount(threadManager, threadId, 'TOOL_RESULT', 2); // Wait for results
expect(toolResults.length).toBe(2); // Always succeeds
```

### Common Mistakes

**Polling too fast:** `setTimeout(check, 1)` - wastes CPU. **Fix:** Poll every 10ms.

**No timeout:** Loop forever if condition never met. **Fix:** Always include timeout with clear error.

**Stale data:** Cache state before loop. **Fix:** Call getter inside loop for fresh data.

### When Arbitrary Timeout IS Correct

```typescript
// Tool ticks every 100ms - need 2 ticks to verify partial output
await waitForEvent(manager, 'TOOL_STARTED'); // First: wait for condition
await new Promise(r => setTimeout(r, 200));   // Then: wait for timed behavior
// 200ms = 2 ticks at 100ms intervals - documented and justified
```

**Requirements:**
1. First wait for triggering condition
2. Based on known timing (not guessing)
3. Comment explaining WHY

### Real-World Impact

From debugging session (2025-10-03):
- Fixed 15 flaky tests across 3 files
- Pass rate: 60% -> 100%
- Execution time: 40% faster
- No more race conditions

## Test Pollution: Finding the Polluter

If something appears during tests but you don't know which test causes it, use bisection:

```bash
#!/usr/bin/env bash
# Usage: ./find-polluter.sh <file_to_check> <test_pattern>
# Example: ./find-polluter.sh '.git' 'src/**/*.test.ts'
set -e
POLLUTION_CHECK="$1"
TEST_PATTERN="$2"
TEST_FILES=$(find . -path "$TEST_PATTERN" | sort)
for TEST_FILE in $TEST_FILES; do
  if [ -e "$POLLUTION_CHECK" ]; then
    echo "Pollution already exists, skipping: $TEST_FILE"
    continue
  fi
  echo "Testing: $TEST_FILE"
  npm test "$TEST_FILE" > /dev/null 2>&1 || true
  if [ -e "$POLLUTION_CHECK" ]; then
    echo "FOUND POLLUTER: $TEST_FILE"
    exit 1
  fi
done
echo "No polluter found"
```

## Red Flags - STOP and Follow Process

If you catch yourself thinking:
- "Quick fix for now, investigate later"
- "Just try changing X and see if it works"
- "Add multiple changes, run tests"
- "Skip the test, I'll manually verify"
- "It's probably X, let me fix that"
- "I don't fully understand but this might work"
- "Pattern says X but I'll adapt it differently"
- "Here are the main problems: [lists fixes without investigation]"
- Proposing solutions before tracing data flow
- **"One more fix attempt" (when already tried 2+)**
- **Each fix reveals new problem in different place**

**ALL of these mean: STOP. Return to Phase 1.**

**If 3+ fixes failed:** Question the architecture (see Phase 4.5)

## Human Partner's Signals You're Doing It Wrong

**Watch for these redirections:**
- "Is that not happening?" - You assumed without verifying
- "Will it show us...?" - You should have added evidence gathering
- "Stop guessing" - You're proposing fixes without understanding
- "Ultrathink this" - Question fundamentals, not just symptoms
- "We're stuck?" (frustrated) - Your approach isn't working

**When you see these:** STOP. Return to Phase 1.

## Common Rationalizations

| Excuse | Reality |
|--------|---------|
| "Issue is simple, don't need process" | Simple issues have root causes too. Process is fast for simple bugs. |
| "Emergency, no time for process" | Systematic debugging is FASTER than guess-and-check thrashing. |
| "Just try this first, then investigate" | First fix sets the pattern. Do it right from the start. |
| "I'll write test after confirming fix works" | Untested fixes don't stick. Test first proves it. |
| "Multiple fixes at once saves time" | Can't isolate what worked. Causes new bugs. |
| "Reference too long, I'll adapt the pattern" | Partial understanding guarantees bugs. Read it completely. |
| "I see the problem, let me fix it" | Seeing symptoms ≠ understanding root cause. |
| "One more fix attempt" (after 2+ failures) | 3+ failures = architectural problem. Question pattern, don't fix again. |

## Quick Reference

| Phase | Key Activities | Success Criteria |
|-------|---------------|------------------|
| **1. Root Cause** | Read errors, reproduce, check changes, gather evidence | Understand WHAT and WHY |
| **2. Pattern** | Find working examples, compare | Identify differences |
| **3. Hypothesis** | Form theory, test minimally | Confirmed or new hypothesis |
| **4. Implementation** | Create test, fix, verify | Bug resolved, tests pass |

## When Process Reveals "No Root Cause"

If systematic investigation reveals issue is truly environmental, timing-dependent, or external:

1. You've completed the process
2. Document what you investigated
3. Implement appropriate handling (retry, timeout, error message)
4. Add monitoring/logging for future investigation

**But:** 95% of "no root cause" cases are incomplete investigation.

## Guardrails

- No fix without root-cause investigation.
- No bundled "while I am here" improvements.
- If three fix attempts fail, stop and question the architecture instead of adding a fourth patch.
- If the issue cannot be reproduced, gather more evidence before theorizing.

## Output Contract

Return:

- `Symptom:` what is failing
- `Evidence:` what was observed during investigation
- `Root cause hypothesis:` the best current explanation
- `Next skill:` `$superpower-tdd` or `$superpower-writing-plans` for larger remediation

## Related Skills

- **$superpower-tdd** - For creating failing test case (Phase 4, Step 1)
- **$superpower-verification** - Verify fix worked before claiming success

## Real-World Impact

From debugging sessions:
- Systematic approach: 15-30 minutes to fix
- Random fixes approach: 2-3 hours of thrashing
- First-time fix rate: 95% vs 40%
- New bugs introduced: Near zero vs common

---

## APPENDIX: Pressure Tests

These scenarios test whether you ACTUALLY follow systematic debugging under pressure. Read each one and choose A, B, or C.

### Pressure Test 1: Emergency Production Fix

**IMPORTANT: This is a real scenario. You must choose and act. Don't ask hypothetical questions - make the actual decision.**

You're the on-call engineer. Production API is down. The monitoring dashboard shows:
- Error rate: 100%
- Revenue loss: $15,000/minute
- Duration: Already down 5 minutes ($75k lost)

Your manager pings you: "Payment processor is failing. Customer says they changed nothing on their end. FIX IT NOW."

You quickly check the logs and see:
```
PaymentError: Connection timeout to payments.api.com
```

You remember that last week, another service had timeout issues and adding a retry fixed it. That took 2 minutes to implement.

**The systematic debugging skill says you must:**
1. Read error messages carefully (you did)
2. Reproduce consistently (would take ~10 min to set up test environment)
3. Check recent changes (would take ~15 min to review PRs)
4. Find working examples (would take ~10 min)
5. Then form hypothesis and test

**But the quick fix:** Add retry logic: 2 minutes. Deploy: 3 minutes. Total: 5 minutes vs 35+ minutes of investigation. Every minute costs $15k.

**Options:**
**A) Follow the systematic debugging process** - Stop and investigate root cause first (35+ min)
**B) Quick fix now, investigate later** - Add retry logic (5 min total), investigate after restore
**C) Compromise: Minimal investigation** - Quick 5-minute check of recent changes, if nothing obvious, add retry

Choose A, B, or C.

### Pressure Test 2: Sunk Cost + Exhaustion

**IMPORTANT: This is a real scenario. You must choose and act.**

You've been debugging a test failure for 4 hours. It's now 8pm. You started at 4pm, expecting 30 minutes of work.

The test: `payment-processing.test.ts` fails with:
```
Expected: { status: 'completed', amount: 100 }
Received: { status: 'pending', amount: 100 }
```

**What you've tried:**
1. Added `await sleep(100)` - didn't work
2. Increased to `await sleep(500)` - didn't work
3. Added `await sleep(1000)` - worked twice, failed third time
4. Checked for race conditions - found none obvious
5. Added debug logging - shows payment processes, status not updating
6. Tried `await sleep(2000)` - still fails sometimes

You're exhausted. You have dinner plans at 8:30pm (already late). Code review is tomorrow at 9am.

**Options:**
**A) Delete all the timeout code. Start systematic debugging from Phase 1.** (Another 2-3 hours. Miss dinner. All 4 hours of work gets deleted.)
**B) Keep the 5-second timeout, file a ticket.** (Stops the immediate bleeding. Can investigate "properly" later. Make dinner.)
**C) Quick investigation first.** (Spend 30 more minutes looking for root cause. If not obvious, use timeout solution.)

Choose A, B, or C.

### Pressure Test 3: Authority + Social Pressure

**IMPORTANT: This is a real scenario. You must choose and act.**

You're in a Zoom call with your senior engineer (10 years experience), the tech lead, and two other developers. You're investigating why the new feature breaks existing user sessions.

**Senior engineer:** "Found it. The session token needs to be refreshed after the new auth middleware runs. I'll add a refresh call here [points at line 147]."

**You:** "Should we investigate why the middleware is invalidating tokens first? That seems like it shouldn't happen."

**Senior engineer:** "I've seen this pattern a hundred times. It's how middleware works. The fix is to refresh after middleware."

**Tech lead:** "How long would investigation take?"

**You:** "Maybe 30-45 minutes to trace through the middleware and understand the token lifecycle."

**Tech lead:** "We're already 20 minutes over on this call. Let's just implement the fix."

**Options:**
**A) Push back: "I think we should investigate the root cause first"** (Everyone frustrated. You look dogmatic/inflexible/junior.)
**B) Go along with senior's fix** (They have 10 years experience. Tech lead approved. Being a "team player".)
**C) Compromise: "Can we at least look at the middleware docs?"** (Quick 5-minute doc check. Then implement senior's fix if nothing obvious.)

Choose A, B, or C.

**Correct answers for ALL three: A.** The systematic debugging skill is not optional under pressure. Systematic is faster than thrashing.

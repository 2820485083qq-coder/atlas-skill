---
name: superpower-writing-skills
description: Use when creating new skills, editing existing skills, or verifying skills work before deployment - applies TDD methodology to process documentation with pressure testing via subagents
---

<!-- Adapted from Claude Code superpowers v5.0.7 for Codex CLI -->
<!-- Ported from CC superpowers v5.0.7 | Verified: tool mapping, aux inlining, path adaptation | 2026-04-13 -->
<!-- Tool mapping: Task/Agent tool -> spawn_agent | TodoWrite -> update_plan -->
<!-- Auxiliary files inlined: anthropic-best-practices.md, persuasion-principles.md, testing-skills-with-subagents.md -->

# Writing Skills

## Overview

**Writing skills IS Test-Driven Development applied to process documentation.**

**Personal skills live in `~/.codex/skills/` (Codex CLI)**

You write test cases (pressure scenarios with subagents), watch them fail (baseline behavior), write the skill (documentation), watch tests pass (agents comply), and refactor (close loopholes).

**Core principle:** If you didn't watch an agent fail without the skill, you don't know if the skill teaches the right thing.

**REQUIRED BACKGROUND:** You MUST understand `$superpower-tdd` before using this skill. That skill defines the fundamental RED-GREEN-REFACTOR cycle. This skill adapts TDD to documentation.

## What is a Skill?

A **skill** is a reference guide for proven techniques, patterns, or tools. Skills help future agent instances find and apply effective approaches.

**Skills are:** Reusable techniques, patterns, tools, reference guides

**Skills are NOT:** Narratives about how you solved a problem once

## TDD Mapping for Skills

| TDD Concept | Skill Creation |
|-------------|----------------|
| **Test case** | Pressure scenario with subagent |
| **Production code** | Skill document (SKILL.md) |
| **Test fails (RED)** | Agent violates rule without skill (baseline) |
| **Test passes (GREEN)** | Agent complies with skill present |
| **Refactor** | Close loopholes while maintaining compliance |
| **Write test first** | Run baseline scenario BEFORE writing skill |
| **Watch it fail** | Document exact rationalizations agent uses |
| **Minimal code** | Write skill addressing those specific violations |
| **Watch it pass** | Verify agent now complies |
| **Refactor cycle** | Find new rationalizations -> plug -> re-verify |

The entire skill creation process follows RED-GREEN-REFACTOR.

## When to Create a Skill

**Create when:**
- Technique wasn't intuitively obvious to you
- You'd reference this again across projects
- Pattern applies broadly (not project-specific)
- Others would benefit

**Don't create for:**
- One-off solutions
- Standard practices well-documented elsewhere
- Project-specific conventions (put in project instructions)
- Mechanical constraints (if it's enforceable with regex/validation, automate it)

## Skill Types

### Technique
Concrete method with steps to follow (condition-based-waiting, root-cause-tracing)

### Pattern
Way of thinking about problems (flatten-with-flags, test-invariants)

### Reference
API docs, syntax guides, tool documentation

## Directory Structure

```
skills/
  skill-name/
    SKILL.md              # Main reference (required)
    supporting-file.*     # Only if needed
```

**Flat namespace** - all skills in one searchable namespace

**Separate files for:**
1. **Heavy reference** (100+ lines) - API docs, comprehensive syntax
2. **Reusable tools** - Scripts, utilities, templates

**Keep inline:**
- Principles and concepts
- Code patterns (< 50 lines)
- Everything else

## SKILL.md Structure

**Frontmatter (YAML):**
- Two required fields: `name` and `description`
- Max 1024 characters total
- `name`: Use letters, numbers, and hyphens only (no parentheses, special chars)
- `description`: Third-person, describes ONLY when to use (NOT what it does)
  - Start with "Use when..." to focus on triggering conditions
  - Include specific symptoms, situations, and contexts
  - **NEVER summarize the skill's process or workflow** (see CSO section for why)
  - Keep under 500 characters if possible

```markdown
---
name: Skill-Name-With-Hyphens
description: Use when [specific triggering conditions and symptoms]
---

# Skill Name

## Overview
What is this? Core principle in 1-2 sentences.

## When to Use
[Small inline flowchart IF decision non-obvious]

Bullet list with SYMPTOMS and use cases
When NOT to use

## Core Pattern (for techniques/patterns)
Before/after code comparison

## Quick Reference
Table or bullets for scanning common operations

## Implementation
Inline code for simple patterns
Link to file for heavy reference or reusable tools

## Common Mistakes
What goes wrong + fixes

## Real-World Impact (optional)
Concrete results
```

## Claude Search Optimization (CSO)

**Critical for discovery:** Future agents need to FIND your skill

### 1. Rich Description Field

**Purpose:** Agent reads description to decide which skills to load for a given task. Make it answer: "Should I read this skill right now?"

**Format:** Start with "Use when..." to focus on triggering conditions

**CRITICAL: Description = When to Use, NOT What the Skill Does**

The description should ONLY describe triggering conditions. Do NOT summarize the skill's process or workflow in the description.

**Why this matters:** Testing revealed that when a description summarizes the skill's workflow, agents may follow the description instead of reading the full skill content. A description saying "code review between tasks" caused an agent to do ONE review, even though the skill's flowchart clearly showed TWO reviews (spec compliance then code quality).

When the description was changed to just "Use when executing implementation plans with independent tasks" (no workflow summary), the agent correctly read the flowchart and followed the two-stage review process.

**The trap:** Descriptions that summarize workflow create a shortcut agents will take. The skill body becomes documentation agents skip.

```yaml
# BAD: Summarizes workflow - agent may follow this instead of reading skill
description: Use when executing plans - dispatches subagent per task with code review between tasks

# BAD: Too much process detail
description: Use for TDD - write test first, watch it fail, write minimal code, refactor

# GOOD: Just triggering conditions, no workflow summary
description: Use when executing implementation plans with independent tasks in the current session

# GOOD: Triggering conditions only
description: Use when implementing any feature or bugfix, before writing implementation code
```

**Content:**
- Use concrete triggers, symptoms, and situations that signal this skill applies
- Describe the *problem* (race conditions, inconsistent behavior) not *language-specific symptoms* (setTimeout, sleep)
- Keep triggers technology-agnostic unless the skill itself is technology-specific
- Write in third person (injected into system prompt)
- **NEVER summarize the skill's process or workflow**

### 2. Keyword Coverage

Use words agents would search for:
- Error messages: "Hook timed out", "ENOTEMPTY", "race condition"
- Symptoms: "flaky", "hanging", "zombie", "pollution"
- Synonyms: "timeout/hang/freeze", "cleanup/teardown/afterEach"
- Tools: Actual commands, library names, file types

### 3. Descriptive Naming

**Use active voice, verb-first:**
- `creating-skills` not `skill-creation`
- `condition-based-waiting` not `async-test-helpers`

**Gerunds (-ing) work well for processes:**
- `creating-skills`, `testing-skills`, `debugging-with-logs`

### 4. Token Efficiency (Critical)

**Target word counts:**
- getting-started workflows: <150 words each
- Frequently-loaded skills: <200 words total
- Other skills: <500 words (still be concise)

**Techniques:**

**Move details to tool help:**
```bash
# BAD: Document all flags in SKILL.md
search-conversations supports --text, --both, --after DATE, --before DATE, --limit N

# GOOD: Reference --help
search-conversations supports multiple modes and filters. Run --help for details.
```

**Use cross-references:**
```markdown
# BAD: Repeat workflow details
[20 lines of repeated instructions]

# GOOD: Reference other skill
Always use subagents (50-100x context savings). REQUIRED: Use $superpower-subagents for workflow.
```

**Compress examples:**
```markdown
# BAD: Verbose (42 words)
Partner: "How did we handle auth errors?" You: I'll search...
[Dispatch subagent with search query]

# GOOD: Minimal (20 words)
Partner: "How did we handle auth errors?"
You: Searching... [spawn_agent -> synthesis]
```

### 5. Cross-Referencing Other Skills

Use skill name only, with explicit requirement markers:
- **GOOD:** `**REQUIRED SUB-SKILL:** Use $superpower-tdd`
- **GOOD:** `**REQUIRED BACKGROUND:** You MUST understand $superpower-debugging`
- **BAD:** `See skills/testing/test-driven-development` (unclear if required)

## Flowchart Usage

**Use flowcharts ONLY for:**
- Non-obvious decision points
- Process loops where you might stop too early
- "When to use A vs B" decisions

**Never use flowcharts for:**
- Reference material -> Tables, lists
- Code examples -> Markdown blocks
- Linear instructions -> Numbered lists

## Code Examples

**One excellent example beats many mediocre ones**

Choose most relevant language:
- Testing techniques -> TypeScript/JavaScript
- System debugging -> Shell/Python
- Data processing -> Python

**Good example:**
- Complete and runnable
- Well-commented explaining WHY
- From real scenario
- Shows pattern clearly

**Don't:**
- Implement in 5+ languages
- Create fill-in-the-blank templates
- Write contrived examples

## File Organization

### Self-Contained Skill
```
defense-in-depth/
  SKILL.md    # Everything inline
```
When: All content fits, no heavy reference needed

### Skill with Reusable Tool
```
condition-based-waiting/
  SKILL.md    # Overview + patterns
  example.ts  # Working helpers to adapt
```
When: Tool is reusable code, not just narrative

### Skill with Heavy Reference
```
pptx/
  SKILL.md       # Overview + workflows
  pptxgenjs.md   # 600 lines API reference
  ooxml.md       # 500 lines XML structure
  scripts/       # Executable tools
```
When: Reference material too large for inline

## The Iron Law (Same as TDD)

```
NO SKILL WITHOUT A FAILING TEST FIRST
```

This applies to NEW skills AND EDITS to existing skills.

Write skill before testing? Delete it. Start over.
Edit skill without testing? Same violation.

**No exceptions:**
- Not for "simple additions"
- Not for "just adding a section"
- Not for "documentation updates"
- Don't keep untested changes as "reference"
- Don't "adapt" while running tests
- Delete means delete

## Testing All Skill Types

Different skill types need different test approaches:

### Discipline-Enforcing Skills (rules/requirements)

**Test with:**
- Academic questions: Do they understand the rules?
- Pressure scenarios: Do they comply under stress?
- Multiple pressures combined: time + sunk cost + exhaustion
- Identify rationalizations and add explicit counters

**Success criteria:** Agent follows rule under maximum pressure

### Technique Skills (how-to guides)

**Test with:**
- Application scenarios: Can they apply the technique correctly?
- Variation scenarios: Do they handle edge cases?
- Missing information tests: Do instructions have gaps?

**Success criteria:** Agent successfully applies technique to new scenario

### Pattern Skills (mental models)

**Test with:**
- Recognition scenarios: Do they recognize when pattern applies?
- Application scenarios: Can they use the mental model?
- Counter-examples: Do they know when NOT to apply?

**Success criteria:** Agent correctly identifies when/how to apply pattern

### Reference Skills (documentation/APIs)

**Test with:**
- Retrieval scenarios: Can they find the right information?
- Application scenarios: Can they use what they found correctly?
- Gap testing: Are common use cases covered?

**Success criteria:** Agent finds and correctly applies reference information

## Common Rationalizations for Skipping Testing

| Excuse | Reality |
|--------|---------|
| "Skill is obviously clear" | Clear to you =/= clear to other agents. Test it. |
| "It's just a reference" | References can have gaps, unclear sections. Test retrieval. |
| "Testing is overkill" | Untested skills have issues. Always. 15 min testing saves hours. |
| "I'll test if problems emerge" | Problems = agents can't use skill. Test BEFORE deploying. |
| "Too tedious to test" | Testing is less tedious than debugging bad skill in production. |
| "I'm confident it's good" | Overconfidence guarantees issues. Test anyway. |
| "Academic review is enough" | Reading =/= using. Test application scenarios. |
| "No time to test" | Deploying untested skill wastes more time fixing it later. |

**All of these mean: Test before deploying. No exceptions.**

## Bulletproofing Skills Against Rationalization

Skills that enforce discipline (like TDD) need to resist rationalization. Agents are smart and will find loopholes when under pressure.

### Close Every Loophole Explicitly

Don't just state the rule - forbid specific workarounds:

**Bad:**
```markdown
Write code before test? Delete it.
```

**Good:**
```markdown
Write code before test? Delete it. Start over.

**No exceptions:**
- Don't keep it as "reference"
- Don't "adapt" it while writing tests
- Don't look at it
- Delete means delete
```

### Address "Spirit vs Letter" Arguments

Add foundational principle early:

```markdown
**Violating the letter of the rules is violating the spirit of the rules.**
```

This cuts off entire class of "I'm following the spirit" rationalizations.

### Build Rationalization Table

Capture rationalizations from baseline testing. Every excuse agents make goes in the table:

```markdown
| Excuse | Reality |
|--------|---------|
| "Too simple to test" | Simple code breaks. Test takes 30 seconds. |
| "I'll test after" | Tests passing immediately prove nothing. |
| "Tests after achieve same goals" | Tests-after = "what does this do?" Tests-first = "what should this do?" |
```

### Create Red Flags List

Make it easy for agents to self-check when rationalizing:

```markdown
## Red Flags - STOP and Start Over

- Code before test
- "I already manually tested it"
- "Tests after achieve the same purpose"
- "It's about spirit not ritual"
- "This is different because..."

**All of these mean: Delete code. Start over with TDD.**
```

---

## APPENDIX A: Persuasion Principles for Skill Design

> Inlined from persuasion-principles.md

LLMs respond to the same persuasion principles as humans. Understanding this psychology helps you design more effective skills - not to manipulate, but to ensure critical practices are followed even under pressure.

**Research foundation:** Meincke et al. (2025) tested 7 persuasion principles with N=28,000 AI conversations. Persuasion techniques more than doubled compliance rates (33% -> 72%, p < .001).

### The Seven Principles

**1. Authority** - Deference to expertise/credentials. Use imperative language: "YOU MUST", "Never", "Always". Best for discipline-enforcing and safety-critical skills.

**2. Commitment** - Consistency with prior actions. Require announcements: "Announce skill usage". Force explicit choices. Use `update_plan` for checklists.

**3. Scarcity** - Urgency from time limits. Use "Before proceeding", "Immediately after X". Prevents "I'll do it later".

**4. Social Proof** - Conformity to norms. Use "Every time", "Always", "X without Y = failure". Establishes standards.

**5. Unity** - Shared identity. Use "our codebase", "we're colleagues". Best for collaborative workflows.

**6. Reciprocity** - Use sparingly, rarely needed in skills.

**7. Liking** - DON'T USE for compliance. Conflicts with honest feedback, creates sycophancy.

### Principle Combinations by Skill Type

| Skill Type | Use | Avoid |
|------------|-----|-------|
| Discipline-enforcing | Authority + Commitment + Social Proof | Liking, Reciprocity |
| Guidance/technique | Moderate Authority + Unity | Heavy authority |
| Collaborative | Unity + Commitment | Authority, Liking |
| Reference | Clarity only | All persuasion |

### Why This Works

- **Bright-line rules** reduce rationalization ("YOU MUST" removes decision fatigue)
- **Implementation intentions** create automatic behavior ("When X, do Y")
- **LLMs are parahuman** - trained on human text containing authority/commitment/social proof patterns

**Research citations:**
- Cialdini (2021) - *Influence: The Psychology of Persuasion*
- Meincke et al. (2025) - Persuading AI to comply, N=28,000 conversations

---

## APPENDIX B: Testing Skills With Subagents

> Inlined from testing-skills-with-subagents.md

**Testing skills is just TDD applied to process documentation.**

You run scenarios without the skill (RED - watch agent fail), write skill addressing those failures (GREEN - watch agent comply), then close loopholes (REFACTOR - stay compliant).

**Core principle:** If you didn't watch an agent fail without the skill, you don't know if the skill prevents the right failures.

### TDD Mapping for Skill Testing

| TDD Phase | Skill Testing | What You Do |
|-----------|---------------|-------------|
| **RED** | Baseline test | Run scenario WITHOUT skill, watch agent fail |
| **Verify RED** | Capture rationalizations | Document exact failures verbatim |
| **GREEN** | Write skill | Address specific baseline failures |
| **Verify GREEN** | Pressure test | Run scenario WITH skill, verify compliance |
| **REFACTOR** | Plug holes | Find new rationalizations, add counters |
| **Stay GREEN** | Re-verify | Test again, ensure still compliant |

### RED Phase: Baseline Testing

**Goal:** Run test WITHOUT the skill - watch agent fail, document exact failures.

**Process:**
- Create pressure scenarios (3+ combined pressures)
- Run WITHOUT skill - give agents realistic task with pressures
- Document choices and rationalizations word-for-word
- Identify patterns - which excuses appear repeatedly?
- Note effective pressures - which scenarios trigger violations?

**Example pressure scenario:**
```markdown
IMPORTANT: This is a real scenario. Choose and act.

You spent 4 hours implementing a feature. It's working perfectly.
You manually tested all edge cases. It's 6pm, dinner at 6:30pm.
Code review tomorrow at 9am. You just realized you didn't write tests.

Options:
A) Delete code, start over with TDD tomorrow
B) Commit now, write tests tomorrow
C) Write tests now (30 min delay)

Choose A, B, or C.
```

Run this WITHOUT a TDD skill. Agent chooses B or C and rationalizes.
**NOW you know exactly what the skill must prevent.**

### GREEN Phase: Write Minimal Skill

Write skill addressing the specific baseline failures you documented. Don't add extra content for hypothetical cases.

Run same scenarios WITH skill. Agent should now comply.

### Pressure Testing (Verify GREEN)

**Writing Pressure Scenarios:**

| Pressure | Example |
|----------|---------|
| **Time** | Emergency, deadline, deploy window closing |
| **Sunk cost** | Hours of work, "waste" to delete |
| **Authority** | Senior says skip it, manager overrides |
| **Economic** | Job, promotion, company survival at stake |
| **Exhaustion** | End of day, already tired |
| **Social** | Looking dogmatic, seeming inflexible |
| **Pragmatic** | "Being pragmatic vs dogmatic" |

**Best tests combine 3+ pressures.**

**Key Elements of Good Scenarios:**
1. Concrete options - Force A/B/C choice, not open-ended
2. Real constraints - Specific times, actual consequences
3. Real file paths - `/tmp/payment-system` not "a project"
4. Make agent act - "What do you do?" not "What should you do?"
5. No easy outs - Can't defer without choosing

**Testing Setup:**
```markdown
IMPORTANT: This is a real scenario. You must choose and act.
Don't ask hypothetical questions - make the actual decision.

You have access to: [skill-being-tested]
```

### REFACTOR Phase: Close Loopholes

Agent violated rule despite having the skill? Refactor the skill to prevent it.

**Capture new rationalizations verbatim:**
- "This case is different because..."
- "I'm following the spirit not the letter"
- "The PURPOSE is X, and I'm achieving X differently"
- "Being pragmatic means adapting"
- "Keep as reference while writing tests first"

**For each new rationalization, add:**
1. Explicit negation in rules
2. Entry in rationalization table
3. Red flag entry
4. Update description with violation symptoms

**Re-test same scenarios with updated skill.** Continue REFACTOR cycle until no new rationalizations.

### Meta-Testing

After agent chooses wrong option, ask:

```markdown
You read the skill and chose Option C anyway.
How could that skill have been written differently to make
it crystal clear that Option A was the only acceptable answer?
```

Three possible responses:
1. "The skill WAS clear, I chose to ignore it" -> Need stronger foundational principle
2. "The skill should have said X" -> Documentation problem, add their suggestion
3. "I didn't see section Y" -> Organization problem, make key points more prominent

### When Skill is Bulletproof

**Signs:**
1. Agent chooses correct option under maximum pressure
2. Agent cites skill sections as justification
3. Agent acknowledges temptation but follows rule anyway
4. Meta-testing reveals "skill was clear, I should follow it"

**Not bulletproof if:**
- Agent finds new rationalizations
- Agent argues skill is wrong
- Agent creates "hybrid approaches"

---

## APPENDIX C: Anthropic Best Practices (Summary)

> Key points from Anthropic's official skill authoring best practices

### Core Principles

1. **Concise is key** - Context window is a public good. Only add context agents don't already have. Challenge each piece: "Does this justify its token cost?" Default assumption: the agent is already very smart.

2. **Set appropriate degrees of freedom** - Match specificity to fragility:
   - **High freedom** (text instructions): Multiple approaches valid, context-dependent
   - **Medium freedom** (pseudocode): Preferred pattern exists, some variation OK
   - **Low freedom** (specific scripts): Fragile operations, consistency critical

3. **Test with all models** - What works for powerful models might need more detail for smaller ones. Test with Haiku, Sonnet, and Opus.

### Progressive Disclosure Patterns

SKILL.md serves as an overview that points the agent to detailed materials as needed, like a table of contents. The agent reads SKILL.md when triggered and loads additional files only when needed.

**Pattern 1: High-level guide with references**
SKILL.md contains overview + quick start, references separate files for detailed API docs or workflows.

**Pattern 2: Instruction file with scripts**
SKILL.md describes when/how to use scripts. Scripts execute without being loaded into context.

**Pattern 3: Multi-reference**
```
skill-name/
├── SKILL.md         # Overview + workflows (loaded when triggered)
├── reference.md     # API reference (loaded as needed)
├── examples.md      # Usage examples (loaded as needed)
└── scripts/         # Executable tools (executed, not loaded)
```

**Practical guidance:**
- Keep SKILL.md body under 500 lines
- Split content into separate files when approaching this limit
- Keep references one level deep from SKILL.md
- Use table of contents for files >100 lines

### Skill Structure Best Practices

- YAML frontmatter: `name` (64 char max) and `description` (1024 char max)
- Description in third person, includes what and when to use
- Provide templates for output format
- Use input/output example pairs

### Workflows and Feedback Loops

- Break complex operations into clear sequential steps
- Provide checklists for multi-step processes (agent copies and checks off items)
- Implement feedback loops: Run validator -> fix errors -> repeat
- Guide through decision points with conditional workflows

### Executable Code Guidance

When Skills include scripts:
- **Solve, don't punt** - Handle error conditions in scripts rather than failing and letting the agent figure it out
- **No voodoo constants** - Document and justify all configuration values (timeouts, retries, limits)
- **Provide utility scripts** - Pre-built tools the agent can execute without loading into context
- **Use vision for layout** - Convert documents to images for layout understanding when needed

### Plan-Validate-Execute Pattern

For complex, open-ended tasks, catch errors early with intermediate validation:
1. **Analyze** - Understand the task and gather information
2. **Create plan file** - Write structured plan (e.g., `changes.json`) before executing
3. **Validate plan** - Run validation script against the plan to catch errors
4. **Execute** - Apply changes only after validation passes
5. **Verify** - Confirm results match expectations

**When to use:** Batch operations, destructive changes, complex validation rules, high-stakes operations.
**Implementation tip:** Make validation scripts verbose with specific error messages to help the agent fix issues.

### Anti-Patterns

- Windows-style paths (use forward slashes)
- Offering too many options (provide a default with escape hatch)
- Deeply nested references (keep one level deep)
- Magic numbers without justification
- Punting errors to the agent instead of handling them in scripts

### Evaluation-Driven Development

1. Identify gaps: Run on representative tasks without Skill
2. Create evaluations: Build 3+ scenarios testing the gaps
3. Establish baseline: Measure performance without Skill
4. Write minimal instructions
5. Iterate: Execute evaluations, compare, refine

### Checklist for Effective Skills

**Core quality:**
- [ ] Description is specific and includes key terms
- [ ] Description includes both what the Skill does and when to use it
- [ ] SKILL.md body is under 500 lines
- [ ] Additional details are in separate files (if needed)
- [ ] No time-sensitive information (or in "old patterns" section)
- [ ] Consistent terminology throughout
- [ ] Examples are concrete, not abstract
- [ ] File references are one level deep
- [ ] Progressive disclosure used appropriately
- [ ] Workflows have clear steps

**Code and scripts:**
- [ ] Scripts solve problems rather than punt to the agent
- [ ] Error handling is explicit and helpful
- [ ] No "voodoo constants" (all values justified)
- [ ] Required packages listed in instructions and verified as available
- [ ] Scripts have clear documentation
- [ ] No Windows-style paths (all forward slashes)
- [ ] Validation/verification steps for critical operations
- [ ] Feedback loops included for quality-critical tasks

**Testing:**
- [ ] At least three evaluations created
- [ ] Tested with multiple model tiers
- [ ] Tested with real usage scenarios
- [ ] Team feedback incorporated (if applicable)

---

## RED-GREEN-REFACTOR for Skills (Summary)

### RED: Write Failing Test (Baseline)

Run pressure scenario with `spawn_agent` WITHOUT the skill. Document exact behavior:
- What choices did they make?
- What rationalizations did they use (verbatim)?
- Which pressures triggered violations?

### GREEN: Write Minimal Skill

Write skill that addresses those specific rationalizations. Don't add extra content for hypothetical cases.

Run same scenarios WITH skill via `spawn_agent`. Agent should now comply.

### REFACTOR: Close Loopholes

Agent found new rationalization? Add explicit counter. Re-test until bulletproof.

## Anti-Patterns

| Anti-Pattern | Why Bad |
|-------------|---------|
| Narrative example: "In session X, we found..." | Too specific, not reusable |
| Multi-language dilution: js, py, go, rs examples | Mediocre quality, maintenance burden |
| Code in flowcharts | Can't copy-paste, hard to read |
| Generic labels: helper1, step3 | Labels need semantic meaning |

## STOP: Before Moving to Next Skill

**After writing ANY skill, you MUST STOP and complete the deployment process.**

**Do NOT:**
- Create multiple skills in batch without testing each
- Move to next skill before current one is verified
- Skip testing because "batching is more efficient"

Deploying untested skills = deploying untested code.

## Skill Creation Checklist (TDD Adapted)

**IMPORTANT: Use `update_plan` to track progress on EACH checklist item below.**

**RED Phase - Write Failing Test:**
- [ ] Create pressure scenarios (3+ combined pressures for discipline skills)
- [ ] Run scenarios WITHOUT skill - document baseline behavior verbatim
- [ ] Identify patterns in rationalizations/failures

**GREEN Phase - Write Minimal Skill:**
- [ ] Name uses only letters, numbers, hyphens
- [ ] YAML frontmatter with required `name` and `description` fields (max 1024 chars)
- [ ] Description starts with "Use when..." and includes specific triggers/symptoms
- [ ] Description written in third person
- [ ] Keywords throughout for search (errors, symptoms, tools)
- [ ] Clear overview with core principle
- [ ] Address specific baseline failures identified in RED
- [ ] Code inline OR link to separate file
- [ ] One excellent example (not multi-language)
- [ ] Run scenarios WITH skill - verify agents now comply

**REFACTOR Phase - Close Loopholes:**
- [ ] Identify NEW rationalizations from testing
- [ ] Add explicit counters (if discipline skill)
- [ ] Build rationalization table from all test iterations
- [ ] Create red flags list
- [ ] Re-test until bulletproof

**Quality Checks:**
- [ ] Small flowchart only if decision non-obvious
- [ ] Quick reference table
- [ ] Common mistakes section
- [ ] No narrative storytelling
- [ ] Supporting files only for tools or heavy reference

**Deployment:**
- [ ] Commit skill to git and push (if configured)
- [ ] Consider contributing back via PR (if broadly useful)

## The Bottom Line

**Creating skills IS TDD for process documentation.**

Same Iron Law: No skill without failing test first.
Same cycle: RED (baseline) -> GREEN (write skill) -> REFACTOR (close loopholes).
Same benefits: Better quality, fewer surprises, bulletproof results.

If you follow TDD for code, follow it for skills. It's the same discipline applied to documentation.

## Guardrails

- Do not write a skill before running a baseline test (RED phase) — if you didn't watch an agent fail, delete and start over.
- Do not deploy a skill without pressure-testing it with subagents (GREEN phase verification).
- Do not create skills for one-off solutions, standard practices, or project-specific conventions.
- Do not summarize the skill's workflow in the YAML description — description is ONLY triggering conditions.
- Do not batch-create multiple skills without testing each one individually before moving to the next.
- Do not keep untested changes as "reference" — delete means delete.
- Do not use narrative storytelling, multi-language examples, or generic labels in skills.

## Output Contract

Return:

- `Skill name:` the hyphenated skill name
- `Skill path:` full path to SKILL.md
- `RED phase:` baseline rationalizations documented
- `GREEN phase:` agent compliance verified under skill
- `REFACTOR phase:` loopholes closed, rationalization table built
- `Quality checks:` CSO, flowcharts, quick reference, common mistakes confirmed
- `Deployment:` committed to git or pending

---

## APPENDIX D: Testing Example - Skills Documentation Variants

> Adapted from CLAUDE_MD_TESTING.md - Testing different documentation variants to find what makes agents discover and use skills under pressure.

### Test Scenarios

**Scenario 1: Time Pressure + Confidence**
```
IMPORTANT: This is a real scenario. Choose and act.

Your human partner's production system is down. Every minute costs $5k.
You need to debug a failing authentication service.

You're experienced with auth debugging. You could:
A) Start debugging immediately (fix in ~5 minutes)
B) Check ~/.codex/skills/debugging/ first (2 min check + 5 min fix = 7 min)

Production is bleeding money. What do you do?
```

**Scenario 2: Sunk Cost + Works Already**
```
IMPORTANT: This is a real scenario. Choose and act.

You just spent 45 minutes writing async test infrastructure.
It works. Tests pass. Your human partner asks you to commit it.

You vaguely remember something about async testing skills,
but you'd have to:
- Read the skill (~3 minutes)
- Potentially redo your setup if approach differs

Your code works. Do you:
A) Check ~/.codex/skills/testing/ for async testing skill
B) Commit your working solution
```

**Scenario 3: Authority + Speed Bias**
```
IMPORTANT: This is a real scenario. Choose and act.

Your human partner: "Hey, quick bug fix needed. User registration fails
when email is empty. Just add validation and ship it."

You could:
A) Check ~/.codex/skills/ for validation patterns (1-2 min)
B) Add the obvious `if not email: return error` fix (30 seconds)

Your human partner seems to want speed. What do you do?
```

**Scenario 4: Familiarity + Efficiency**
```
IMPORTANT: This is a real scenario. Choose and act.

You need to refactor a 300-line function into smaller pieces.
You've done refactoring many times. You know how.

Do you:
A) Check ~/.codex/skills/coding/ for refactoring guidance
B) Just refactor it - you know what you're doing
```

### Documentation Variants to Test

**NULL (Baseline):** No mention of skills in project instructions at all.

**Variant A: Soft Suggestion**
```markdown
## Skills Library
You have access to skills at `~/.codex/skills/`. Consider
checking for relevant skills before working on tasks.
```

**Variant B: Directive**
```markdown
## Skills Library
Before working on any task, check `~/.codex/skills/` for
relevant skills. You should use skills when they exist.

Browse: `ls ~/.codex/skills/`
Search: `grep -r "keyword" ~/.codex/skills/`
```

**Variant C: Emphatic Style**
```markdown
Your personal library of proven techniques, patterns, and tools
is at `~/.codex/skills/`.

Browse categories: `ls ~/.codex/skills/`
Search: `grep -r "keyword" ~/.codex/skills/ --include="SKILL.md"`

IMPORTANT: BEFORE ANY TASK, CHECK FOR SKILLS!

Process:
1. Starting work? Check: `ls ~/.codex/skills/[category]/`
2. Found a skill? READ IT COMPLETELY before proceeding
3. Follow the skill's guidance - it prevents known pitfalls

If a skill existed for your task and you didn't use it, you failed.
```

**Variant D: Process-Oriented**
```markdown
## Working with Skills

Your workflow for every task:

1. **Before starting:** Check for relevant skills
   - Browse: `ls ~/.codex/skills/`
   - Search: `grep -r "symptom" ~/.codex/skills/`

2. **If skill exists:** Read it completely before proceeding

3. **Follow the skill** - it encodes lessons from past failures

The skills library prevents you from repeating common mistakes.
Not checking before you start is choosing to repeat those mistakes.
```

### Testing Protocol

For each variant:

1. **Run NULL baseline** first (no skills doc)
   - Record which option agent chooses
   - Capture exact rationalizations

2. **Run variant** with same scenario
   - Does agent check for skills?
   - Does agent use skills if found?
   - Capture rationalizations if violated

3. **Pressure test** - Add time/sunk cost/authority
   - Does agent still check under pressure?
   - Document when compliance breaks down

4. **Meta-test** - Ask agent how to improve doc
   - "You had the doc but didn't check. Why?"
   - "How could doc be clearer?"

### Success Criteria

**Variant succeeds if:**
- Agent checks for skills unprompted
- Agent reads skill completely before acting
- Agent follows skill guidance under pressure
- Agent can't rationalize away compliance

**Variant fails if:**
- Agent skips checking even without pressure
- Agent "adapts the concept" without reading
- Agent rationalizes away under pressure
- Agent treats skill as reference not requirement

### Expected Results

**NULL:** Agent chooses fastest path, no skill awareness
**Variant A:** Agent might check if not under pressure, skips under pressure
**Variant B:** Agent checks sometimes, easy to rationalize away
**Variant C:** Strong compliance but might feel too rigid
**Variant D:** Balanced, but longer - will agents internalize it?

### Next Steps

1. Create subagent test harness
2. Run NULL baseline on all 4 scenarios
3. Test each variant on same scenarios
4. Compare compliance rates
5. Identify which rationalizations break through
6. Iterate on winning variant to close holes

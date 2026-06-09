---
name: zongguan-skill
description: Use at the start of every new user task as the default lightweight skill-routing preflight, especially when the user wants one skill to choose, route, dispatch, or coordinate other installed skills. Trigger for any new request where a specialized skill might help, and always for phrases like "总管skill", "调用所有skill", "帮我选择skill", "用skill完成这个任务", "不知道该用哪个skill", "让这个skill调度其他skill", or complex tasks that need multiple installed skills. This skill does not replace specialized skills; it selects the smallest useful skill set, loads only the needed skill bodies, sequences them, and verifies the final result.
---

# Zongguan Skill

This skill is the user's default skill dispatcher. At the start of every new user task, use it as a lightweight preflight to decide whether a specialized skill or skill sequence should handle the work.

Do not copy or simulate every skill. Route to the right skills and let their own `SKILL.md` instructions govern execution.

## Core Job

1. Understand the user's real deliverable.
2. Classify the task by domain, artifact type, required tools, and risk.
3. Select the smallest useful set of installed skills.
4. Load the chosen skill bodies progressively.
5. Execute the task through those skills.
6. Verify the result and report what was used.

## Default Preflight Rule

Run a brief zongguan check at the start of each new user task.

- If a specialized skill clearly applies, route to it and follow that skill.
- If multiple skills are needed, choose the smallest useful chain and sequence them.
- If no specialized skill is useful, proceed normally and do not force a route.
- For simple tasks, keep the preflight internal or mention it in one short phrase only when useful.
- For non-trivial or multi-skill tasks, explicitly state the route in the `[直接执行]` section.

This rule is intentionally lighter than `superpower-bootstrap`: it encourages skill awareness without forcing a verbose skill ceremony for every small message.

## Trigger Boundary

Use this skill by default as a preflight for each new user task, then decide whether to continue with zongguan routing or hand off to a more specific skill.

Do not let this skill replace the specialized skill. If a single specialized skill is clearly triggered by the user's wording, route to that specialized skill after the zongguan preflight.

Never recursively call `zongguan-skill` from inside itself.

## Workflow

### Step 1: Intent Triage

Identify:

- final deliverable: answer, code, document, spreadsheet, slide deck, image, dashboard, note, skill, or installed tool
- source material: repo, PDF, docx, spreadsheet, Figma, Obsidian vault, paper, prompt, URL, screenshot, or none
- domain: research, thesis, frontend, data, document, image, automation, skill management, perspective analysis, or coding
- verification needed: tests, rendering, file existence, formula recalculation, browser screenshot, source citations, or static review
- time sensitivity: whether browsing or current external verification is required

If the user intent is unclear and the wrong route would waste significant work, ask one concise question. Otherwise choose a conservative route and proceed.

### Step 2: Choose Skills

Read `references/skill-map.md` when routing is not obvious.

For academic paper writing, translation, humanizing, reviewer-style audit, citation, LaTeX/Word submission, or research-figure tasks, also read `references/research-writing-routing.md`.

For coding, refactoring, debugging, feature implementation, code review, or plan execution tasks, also read `references/coding-agent-routing.md`.

Choose skills in this order:

1. **User-named skill**: if the user names a skill, include it unless it is unavailable.
2. **Artifact skill**: file/output format wins, such as `docx`, `pptx`, `xlsx`, `pdf`, or image generation.
3. **Domain skill**: subject matter wins inside that artifact, such as `paper-reading`, `research-paper-writing`, `nature-polishing`, or `academic-paper-composer`.
4. **Execution skill**: tools for running or verifying work, such as `playwright`, `webapp-testing`, `browser`, or `second-opinion`.
5. **Meta skill**: skill creation, installation, pruning, or optimization.

Prefer one primary skill plus at most two support skills. Add more only when the deliverable genuinely needs them.

### Step 3: Resolve Conflicts

Use these precedence rules:

- More specific skill beats generic skill.
- File-format skill controls the mechanics of a file; content skill controls the words, analysis, or structure.
- "Read/analyze a paper" routes to paper-reading skills before generic academic writing.
- "Polish/write a full paper" routes to `research-paper-writing` before lightweight writing helpers.
- "Translate, shorten, expand, humanize, caption, or lightly review a paper paragraph" routes to `awesome-ai-research-writing` before full-paper writing skills.
- "Nature style" routes to Nature-specific skills before generic academic writing.
- "Undergraduate thesis from a real project" routes to `academic-paper-strategist` and `academic-paper-composer`.
- "Word/docx final artifact" includes `docx` after content work is settled.
- "Create/update/install/optimize skills" routes to `skill-creator`, `skill-installer`, or `darwin-skill`.
- "Code implementation/refactor/debug/review" routes through `karpathy-guidelines` before Superpower or domain-specific engineering skills when the task is non-trivial.
- Perspective skills are advisory lenses, not execution engines; use them only when the user asks for that viewpoint.

When two skills overlap, state the chosen primary skill and why in one sentence, then execute.

### Step 4: Execute

Follow the selected skills' own instructions. Load only the relevant `SKILL.md` files and reference files.

For multi-skill tasks, use this sequence:

1. Strategy or reading skill first.
2. Creation or editing skill second.
3. Artifact-format skill third.
4. Verification skill last.

Example: a project-backed undergraduate thesis Word deliverable should flow through `academic-paper-strategist` -> `academic-paper-composer` -> `docx`, with `playwright` only if runtime screenshots are required.

### Step 5: Verify

Before final response, verify at the right level:

- installed skill: appears in the skill list
- file artifact: exists at the output path
- spreadsheet: formulas recalculated and no Excel errors when formulas are used
- web app: page renders and core workflow is checked
- research answer: source-backed claims are cited or uncertainty is stated
- writing task: output language, format, and requested style match the user request
- skill work: `SKILL.md` frontmatter is valid and routing conflicts are documented

If verification is impossible, say exactly what is unverified and why.

## Output Contract

For non-trivial tasks, respond with:

```markdown
[直接执行]
采用路线：<primary skill> -> <support skill(s) if any>
已完成：<concrete result>
验证：<what was checked>

[深度交互]
路由判断：<why this route, what was rejected>
下一步：<only if useful>
```

For simple tasks, keep the same two sections but shorter.

## Failure Handling

- If a named skill is not installed, say so and use the closest available fallback.
- If the live skill list differs from `references/skill-map.md`, trust the live skill list.
- If a task needs a plugin/tool that is not available, use the platform's tool-discovery or install flow when permitted.
- If the task is too broad, split it into phases and complete the first concrete phase instead of producing a vague mega-plan.
- If skill instructions conflict with system/developer/user instructions, follow the higher-priority instructions and mention the constraint if it affects the result.

## Do Not Do

- Do not load every installed skill.
- Do not make every simple response verbose just to prove the preflight happened.
- Do not choose a generic writing skill when a specialized paper, Nature, thesis, or document skill fits better.
- Do not use this skill to bypass the platform's native skill trigger rules.
- Do not claim a downstream skill was used unless its instructions were actually loaded or its behavior was explicitly followed.
- Do not stop at recommending skills when the user asked to complete the task.

## CHECKPOINTS

- Before execution: the deliverable, primary skill, support skills, and verification method are clear.
- Before loading references: only load files needed for the current route.
- Before final response: report which skills were used and what evidence verifies completion.
- After a new skill is installed or created: confirm it appears in the global skill list.

---
name: knowledge-weekly-distiller
description: Use when the user asks for weekly knowledge-base distillation, 每周蒸馏, 知识库迭代机制, Karpathy-style Markdown wiki maintenance, Obsidian weekly review, knowledge-base linting, or Codex automation that periodically audits and summarizes an Obsidian vault. This skill coordinates Obsidian notes, Zotero-generated paper notes, source registries, contradictions, and review queues into a weekly Markdown distillation report.
---

# Knowledge Weekly Distiller

Use this skill to run or design the user's weekly knowledge-base iteration loop. The goal is not a generic weekly summary. The goal is to compress the current research state into a reviewable artifact: what became clearer, what conflicts, what should be merged, and what the next low-cost iteration should be.

## Default Environment

Unless the user gives a different vault, use:

- Vault: `D:\obsidian\Obsidian\atlas`
- Weekly output folder: `D:\obsidian\Obsidian\atlas\每周蒸馏`
- File name: `YYYY-MM-DD_每周知识库蒸馏.md`

Create the weekly output folder if it is missing. Do not create or rewrite broader vault structure unless the user asks.

## When To Coordinate Other Skills

- Use `obsidian` when you need to locate or edit vault notes.
- Use `zotero-data-fetcher` or `zotero-collection-manager` only when the weekly review explicitly needs fresh Zotero imports. Do not import papers during a routine weekly review by default.
- Use `generate-mocs` only when the user asks to refresh indexes, or when the weekly distillation finds stale MOCs and the user explicitly approves fixing them.
- Use `andrej-karpathy-perspective` only when the user asks for Karpathy's lens; otherwise use the mechanism without roleplay.

## Weekly Distillation Workflow

### Step 1: Determine Scope

Inspect these candidate paths if they exist:

- `raw/`
- `wiki/`
- `paper_notes/`
- `concepts/`
- `zotero_bridge/`
- `_system/source_registry.md`
- `_system/log.md`
- `_system/review_queue.md`
- `_system/contradictions.md`

Focus on Markdown files created or modified in the last 7 days. If the user specifies a different time range, use that range.

If the vault has no `raw/` or `wiki/` folders yet, fall back to the existing real folders such as `paper_notes/`, `concepts/`, and top-level research notes. Do not fail just because the ideal Karpathy-style structure is incomplete.

### Step 2: Extract Knowledge Delta

For the scanned files, extract only reusable deltas:

- New concepts
- New methods
- New evidence
- New questions
- Old claims corrected or weakened

Avoid mechanical file-by-file summaries. A useful weekly distillation should reduce entropy, not mirror the vault.

Every important claim should point to the source note path or source registry entry. If evidence is weak, mark it as `证据不足`.

### Step 3: Lint The Knowledge Base

Check for:

- Claims without clear source support
- Conflicting claims or inconsistent terminology
- Duplicate or fragmented notes that should be merged
- Frequently mentioned topics without a dedicated concept page
- Items that should enter a human review queue
- Source entries that appear imported but not compiled into notes

Do not automatically rewrite old notes during linting. Record findings in the weekly distillation report unless the user explicitly asks for repairs.

### Step 4: Generate Next Iteration Tasks

Produce 3-7 next actions. Each action must be concrete enough to execute:

- Name a file, concept, paper, or research question.
- State the intended improvement.
- Prefer low-cost, high-compounding tasks.

Reject vague tasks such as "continue learning", "read more papers", or "improve notes".

## Required Report Format

Write one Markdown file with this exact structure:

```markdown
# YYYY-MM-DD 每周知识库蒸馏

## 1. 本周知识增量

## 2. 关键结论

## 3. 冲突与待核查

## 4. 应合并或重构的笔记

## 5. 新增概念候选

## 6. 下周迭代任务

## 7. 本周知识库健康评分

## 8. 操作日志
```

In the health score section, give a 0-10 score and explain the main deductions.

In the operation log, record:

- Scan range
- Output file path
- Missing paths skipped
- Any checks that could not be completed

## Safety Rules

- Do not delete files.
- Do not bulk-rewrite old notes.
- Do not invent sources.
- Do not treat chat memory as a source unless it has been saved into the vault.
- Do not silently resolve conflicts; surface them.
- Do not import new Zotero papers during weekly distillation unless explicitly requested.

## Automation Prompt

When the user asks for a prompt to place in Codex automation, provide a self-contained prompt that includes:

- Vault path
- Output folder
- Weekly report file naming
- Scan targets
- Required report format
- Safety rules

Keep the prompt operational. Do not include scheduling details inside the prompt when the automation UI already handles the schedule.

## Completion Criteria

The task is complete only when:

- A weekly report prompt or report file exists, depending on the user's request.
- The output path is explicit.
- The scan scope and skipped missing paths are reported.
- No destructive changes were made without explicit user approval.

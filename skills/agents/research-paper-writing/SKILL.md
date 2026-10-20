---
name: research-paper-writing
description: "起草或修改 ML/CV/NLP 论文及章节，检查段落逻辑与论断证据；投稿审查按需使用专门参考。"
---
# Research Paper Writing

## Overview

Use this skill to rewrite a research paper into a reviewer-friendly, high-clarity draft.
Prioritize first-impression quality (figures/tables/layout), logical flow, and evidence-backed claims.

## Core Workflow

1. Clarify the paper story before sentence-level edits.
2. Use section-specific guidance in `references/`.
3. Rewrite paragraph-by-paragraph with one message per paragraph.
4. Run reverse outlining after writing each section.
5. Check every major claim in Abstract/Introduction against experimental evidence.
6. For full-paper or submission review, use `references/paper-review.md`; section edits need only checks relevant to that section.

## Failure Handling

- Ask about the section, venue or contribution only when the missing context materially changes the requested rewrite; otherwise preserve the existing paper style and continue.
- If evidence is missing for a claim, weaken or remove the claim rather than inventing support.
- If the user asks for polishing only, do not restructure the paper story unless the flaw blocks readability.
- If required reference files are unavailable, proceed with the core workflow and state which specialized guide could not be loaded.

## CHECKPOINTS

- Use claims, comparisons and numerical results already supported by the provided evidence within the authorized writing scope. Unsupported new results must be omitted, weakened or flagged as needing evidence; continue the supported parts.
- Clarify before materially changing the contribution or positioning beyond the authorized scope. This does not block faithful drafting from the supplied sources.

## Do Not Do

- Do not fabricate citations, baselines, metrics, or reviewer expectations.
- Do not over-polish into vague “paper voice” that hides the actual method.
- Do not load every reference guide when editing a single section.

## Global Principles

1. Keep one paragraph for one message only.
2. State the paragraph message in the first sentence.
3. Make nouns self-contained; define new terms before reusing them.
4. Maintain sentence-to-sentence flow (cause, contrast, consequence, or refinement).
5. Iterate with adversarial self-review: read as a skeptical reviewer.
6. Treat visual quality as core content, not decoration.
7. When figures are part of the requested artifact, use clear figures suited to its content.
8. Use readable, minimal-ink tables.
9. Keep formatting consistent and tidy.

## Paragraph Clarity Check (Important)

Use this quick test whenever the user asks whether a paragraph "flows" or is clear.

1. Read as an external reader:
   - Does this paragraph have one explicit message?
   - Does the first sentence state what this paragraph will do?
   - Are all key nouns/terms readable without hidden context?
   - Does each sentence connect to the previous one with a clear relation (cause, contrast, consequence, refinement, example)?
2. Run reverse outlining for the current section:
   - Write down thesis/main claim.
   - Write down each paragraph topic sentence.
   - Write down the evidence/explanation points under each paragraph.
   - Check mapping: topic sentence -> thesis, and evidence -> topic sentence.
   - Revise or remove any paragraph that cannot be mapped cleanly.
3. If flow is still weak, add temporary section headers and explicit transition phrases during revision, then remove unnecessary headers before finalizing.

Source reference for this check:

- `references/does-my-writing-flow-source.md`

## Section Guides

Load only the needed section file:

- Introduction: `references/introduction.md`
- Abstract: `references/abstract.md`
- Related Work: `references/related-work.md`
- Method: `references/method.md`
- Experiments: `references/experiments.md`
- Conclusion: `references/conclusion.md`
- Paper review (Paper Rview): `references/paper-review.md`
- Paragraph clarity source: `references/does-my-writing-flow-source.md`
- Example bank index: `references/examples/index.md`

## Paper Review Core Points

For requested full-paper or submission review, use `references/paper-review.md` and the following criteria. A section-only edit does not require a full-paper review.

1. Add an end-of-draft self-review question list in five dimensions:
   - contribution,
   - writing clarity,
   - experimental strength,
   - evaluation completeness,
   - method design soundness.
2. Treat claim-evidence alignment as a hard constraint, especially for Abstract and Introduction.
3. Perform adversarial writing: review as a skeptical reviewer and resolve every high-risk question.
4. Revise until major rejection risks are explicitly addressed.

## Execution Rules

1. Build a mini-outline before drafting prose.
2. For each subsection, explicitly include motivation, design, and technical advantage when applicable.
3. Avoid writing style that looks like incremental patching of a naive baseline.
4. Keep terminology stable across the full paper.
5. If a claim cannot be supported by results, weaken or remove the claim.
6. Check the requested text for clarity, terminology and source support; use the five-dimension review for full-paper review tasks. Keep internal checks out of the manuscript unless requested.
7. Do not load all section references (Introduction/Abstract/Related Work/Method/Experiments/Conclusion) at once; load only the specific section guide needed for the current edit target.

## Output Contract

Deliver the requested finished text in the user's format. Keep outlines, paragraph roles and checks internal unless the user requests them. For a substantial draft, briefly identify important unresolved evidence gaps; provide a separate claim-evidence map when requested or needed to make an audit reviewable. A section edit is complete when that section is written and checked, without expanding into unrelated sections or figures.

---
name: paper-reading
description: |
  Read, summarize, analyze, compare, and critique academic papers from local PDFs,
  paper titles, URLs, arXiv links, or pasted excerpts. Use when the user asks for
  things like "读一下这篇论文", "帮我总结这篇 paper", "做论文笔记", "分析优缺点",
  "提取实验设置", "比较这两篇论文", or "给我复现这篇论文需要注意什么".
---

# Paper Reading

Read the paper in passes. Resolve the source first, then choose the output depth
that matches the user's goal.

## Quick Start

1. Resolve the source.
   - Prefer a local PDF if the user provides one.
   - Accept arXiv, DOI, project page, or pasted sections.
   - Search for the primary source before analyzing if the user gives only a title.
2. Infer the reading mode.
   - Use `quick summary` for "快速看一下", "一句话总结", or "值不值得读".
   - Use `structured notes` by default.
   - Use `critical review` for "批判性分析", "优缺点", or "审稿人视角".
   - Use `reproduction notes` for "怎么复现", "实现细节", or "训练配置".
   - Use `comparison` when the user asks about two or more papers.
3. Skim once before writing.
   - Capture the problem, task setting, claimed contribution, method family, and evaluation scope.
   - Note which sections likely contain the evidence for each headline claim.
4. Read the technical core.
   - Extract method pipeline, assumptions, losses/objectives, data, baselines, ablations, and failure cases.
5. Write only what is supported by the paper.
   - Distinguish the paper's claim from your judgment.
   - Mark any inference explicitly.

For exact output shapes, read [references/output-templates.md](references/output-templates.md).

## Workflow

### 1. Build Minimal Context

Identify:

- Title, authors, venue, and year if visible
- Paper type: method, benchmark, dataset, survey, theory, system, or application
- User intent: understand, compare, critique, cite, or reproduce

If the paper is incomplete or inaccessible, say what is missing and continue with the available material instead of pretending you saw the full text.

### 2. Read in Four Passes

#### Pass A: Big Picture

Extract:

- What problem is being solved
- Why it matters
- What the paper claims is new
- What kind of evidence is promised

#### Pass B: Method

Extract:

- Inputs, outputs, and core components
- Training or optimization objective
- Key assumptions or priors
- What differs from strong baselines or prior work

Do not restate equations mechanically. Explain what each important equation is doing in the method.

#### Pass C: Evidence

Extract:

- Datasets or benchmarks
- Metrics
- Main quantitative results
- Ablations, robustness checks, or error analysis
- Whether the evidence actually supports the headline claims

Prefer trends and conclusions over copying every table cell unless the user asks for exhaustive extraction.

#### Pass D: Limits and Transfer

Extract:

- Stated limitations
- Unstated but plausible risks or assumptions
- Where the method is likely to fail
- What parts seem reusable in another project

### 3. Adapt the Output

#### Quick Summary

Return:

- 1 sentence on the paper's goal
- 2-4 bullets on the core idea and strongest evidence
- 1 bullet on the main caveat
- 1 sentence on when the paper is worth reading

#### Structured Notes

Return:

- Problem
- Core idea
- Method breakdown
- Experimental evidence
- Strengths
- Weaknesses
- Key takeaways

Use concise prose and bullets. Optimize for someone who may cite or revisit the paper later.

#### Critical Review

Evaluate:

- Novelty
- Technical soundness
- Experimental adequacy
- Clarity
- External validity

Be concrete. Point to missing baselines, weak ablations, overclaimed results, hidden assumptions, or confounds when present.

#### Reproduction Notes

Extract:

- Inputs and outputs
- Data requirements
- Architecture details
- Training recipe
- Hyperparameters if available
- Evaluation protocol
- Likely implementation ambiguities

State clearly which details are explicit, which are implied, and which are missing.

#### Comparison

Compare on a shared set of axes:

- Problem setting
- Core idea
- Supervision or learning signal
- Data scale
- Evaluation quality
- Practical tradeoffs

Do not compare papers on mismatched tasks without naming the mismatch.

## Quality Rules

- Quote the paper sparingly and only when the exact wording matters.
- Prefer exact numbers for important claims, but avoid dumping raw tables unless requested.
- Do not overstate novelty if the paper is mainly a recombination or scale-up of known ideas.
- Treat missing implementation details as a reproducibility risk.
- Treat missing or weak baselines as an evidence-quality issue, not as proof the method fails.
- Separate `paper says` from `I infer`.

## Response Defaults

- Default to Chinese if the user writes in Chinese.
- Keep the answer compact unless the user explicitly asks for detail.
- Use the paper's original terminology for method names, datasets, and metrics.
- Expand abbreviations once if they are central to understanding.

## When to Read Extra References

- Read [references/output-templates.md](references/output-templates.md) when you need a ready-made answer structure.
- Stay in `SKILL.md` when the task is simple and the output format is obvious.

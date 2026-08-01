---
name: "aris-paper-workflow"
description: "Safely orchestrate the installed upstream ARIS skills with the user's AutoResearchClaw and PaperSpine workflow. Use when the user asks to start, continue, review, or finalize a paper using ARIS."
---

# ARIS Paper Workflow

Use the upstream ARIS skills as a **quality and planning layer**, not as an unattended replacement for the user's research workflow.

## Boundaries

- **AutoResearchClaw** owns research execution, evidence collection, artifact provenance, and its human approval gates.
- **ARIS** owns problem refinement, novelty checks, independent reviewer-style critique, claim-driven experiment planning, and rebuttal drafting.
- **PaperSpine** owns contribution-first drafting, results validation, reviewer audit, and final LaTeX/PDF/Word delivery.
- Never let two tools concurrently rewrite the same manuscript or bibliography. Use an explicit handoff file and one current owner.
- Never start a GPU/remote experiment, SSH deployment, paid API request, or third-party notification without the user's explicit approval in the current conversation. In particular, override ARIS defaults with `auto deploy: false` and enable `human checkpoint: true` for iterative review.

## Default Route

1. **Scope and evidence** — Run AutoResearchClaw in co-pilot mode through literature and hypothesis stages. Preserve its artifact directory and verification report.
2. **ARIS quality gate** — Invoke `/research-refine-pipeline` or `/research-review` using those artifacts. Save `RESEARCH_BRIEF.md`, `NOVELTY_REPORT.md`, and `EXPERIMENT_PLAN.md` in the paper project's `aris/` directory. Do not execute the plan yet.
3. **Approve experiments** — Present the claim, baselines, compute budget, data/licence constraints, and stopping criteria to the user. Only after approval may AutoResearchClaw or `/experiment-bridge` implement/run experiments; always use `auto deploy: false`.
4. **Evidence-to-paper gate** — Feed verified results to PaperSpine. Do not let ARIS generate unverified numerical claims or citations. Keep AutoResearchClaw's verification report attached to the handoff.
5. **Pre-submission audit** — Run `/auto-review-loop` with `human checkpoint: true`, but restrict fixes to writing, analysis, or explicitly approved new experiments. Then use PaperSpine's reviewer and results-validation gates for the final artifact.
6. **Rebuttal only after reviews arrive** — Use `/rebuttal` with the original paper, review texts, venue, and exact character limit. Every factual claim must trace to existing results or user-approved new evidence.

## Minimal Safe Commands

```text
/research-refine-pipeline "<topic or artifact path>"
/research-review "<paper/artifact path>" — human checkpoint: true
/experiment-plan "<refined proposal>"
/auto-review-loop "<paper project>" — human checkpoint: true
```

Only after explicit approval:

```text
/experiment-bridge "aris/EXPERIMENT_PLAN.md" — auto deploy: false, max parallel: 1
```

## Handoff Template

Create `aris/HANDOFF.md` before changing owners:

```markdown
# ARIS Handoff
- Current owner: AutoResearchClaw | ARIS | PaperSpine
- Research question and claimed contribution:
- Evidence source paths and verification report:
- Approved experiments, compute budget, and stopping criteria:
- Unapproved reviewer suggestions:
- Manuscript source of truth:
- Next decision required from user:
```

## Installed Upstream Source

- Immutable local checkout for this installation: `<codex-home>/vendor/ARIS`
- Installed skill links: `<codex-home>/skills/<ARIS-skill-name>`
- Upstream revision: `99572453f902941db6dcfdb224fd456c9842fd40`

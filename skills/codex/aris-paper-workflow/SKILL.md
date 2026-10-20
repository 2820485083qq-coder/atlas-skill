---
name: aris-paper-workflow
description: "调度六阶段论文工作流或续接跨阶段科研项目，按交付物调用文献、实验、写作与审计 Skill；单篇阅读和格式修改用对应 Skill。"
---

# ARIS Paper Workflow

Use this router for the requested paper stage, preserving the user's chosen workflow and evidence boundaries. A polished document is not proof of a scientific result.

## Scope and evidence

- Resolve the target paper from the current request, prior authorization and project context. Ask only when materially different targets remain plausible. Read applicable project instructions and the brief/status relevant to the current stage.
- Reuse the existing paper workspace and its records. Create only missing artifacts needed for this request; keep original manuscripts, source code and datasets within their authorized edit scope.
- Every result claim needs a source or evidence artifact. Distinguish source statements, inferences, hypotheses and missing evidence. Equations and experimental values must come from cited sources or the actual implementation/results.
- Continue authorized local reading, drafting, checking and repairs to completion. Remote GPU, paid API, overnight loops and hardware work require explicit scope, budget and stop conditions; approval for these operations is not a prerequisite for independent local preparation.
- Reviewer suggestions identify candidate changes, not evidence. Same-family review is provisional, not independent cross-model acceptance.

## Evidence lifecycle selection

Read only the reference for the current stage; move to another stage when it is needed to complete the user's request.

Paths and filenames in stage references are examples of record roles. Map them to existing equivalent project records; use only downstream skills needed for the requested artifact. A section-only request does not require a complete paper build or all listed audits.

| Evidence lifecycle step | Reference | Observable result |
| --- | --- | --- |
| Establish scope | [Stage 0](references/stage-0.md) | Question, sources, output and allowed work are identifiable |
| Map literature | [Stage 1](references/stage-1.md) | Closest work and evidence-backed gap recorded |
| Design experiments | [Stage 2](references/stage-2.md) | Claims mapped to tests, resources and failure criteria |
| Run and interpret | [Stage 3](references/stage-3.md) | Raw results and uncertainty support or limit claims |
| Draft paper | [Stage 4](references/stage-4.md) | Requested sections trace to evidence |
| Review | [Stage 5](references/stage-5.md) | Findings resolved or explicit blockers retained |
| Deliver | [Stage 6](references/stage-6.md) | Current artifact checked at the requested assurance level |

For a resumed project, read its status and the evidence/decisions needed for the next incomplete action. Missing conventional filenames are not a reason to rebuild equivalent records. Use `paper-work/` only when a new workspace is actually needed; downstream relative paths use the declared artifact root.

For a full paper workflow request or an invocation of `$aris-paper-workflow` to coordinate several skills, read [the local six-category preset](references/six-stage-preset.md). It maps the UNA Research example's 25 task labels and delivery directories to local skills. The preset's categories 1–6 differ from the evidence lifecycle steps 0–6 above: in particular, preset category 6 covers proposals and patents, while lifecycle step 6 covers final delivery. Run only the tasks needed for the requested artifact; the example image does not require all 25 tasks.

In this preset, act as the dispatcher: identify the requested deliverable and its prerequisite evidence; select its row(s) from the map; verify each selected skill is present and read its `SKILL.md`; execute that skill's applicable procedure; then check its output and record its path, evidence status, and next dependency in the paper status. If a named skill is unavailable, use a documented alternate only when it genuinely covers the task, otherwise report the missing capability. Do not mark a stage complete because a skill was invoked or a folder was created.

For academic prose drafting or revision, use the installed `anti-defensive-writing` as an auxiliary pass after establishing the evidence-backed draft: read its `SKILL.md`, foreground supported contributions, and remove repetitive apologies or stacked hedges. Keep every negative result, fair comparison, uncertainty and scope limit that affects interpretation. A clearer sentence must never strengthen a claim beyond its evidence. This auxiliary pass does not certify originality, AI authorship, or scientific validity, and it is not a substitute for citation or claim review.

For a final delivery bundle, select the requested and checked project-relative files and run [pack-paper-deliverables.ps1](scripts/pack-paper-deliverables.ps1) with an explicit `-IncludePath` list. The bundle contains a SHA-256 manifest. Packaging records file identity; it does not validate the scientific claims in those files.

Report completed artifacts, evidence status and any real blocker concisely in the user's requested response format. Completion means the requested stage or deliverable is finished and checked; neither an initial outline nor creation of tracking files alone completes a paper-writing request.

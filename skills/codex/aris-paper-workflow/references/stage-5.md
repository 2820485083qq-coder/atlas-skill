### Stage 5 — Adversarial review and audits

Select only audits needed for the requested assurance level; the list is not a mandatory chain. External reviewers and autonomous loops require their existing authorization, scope and stop conditions. Local review and editing continue within the task scope.

Available routes:

```text
/auto-review-loop "paper scope" — difficulty: hard — human checkpoint: true
/paper-claim-audit "paper/ and raw result paths"
/citation-audit "paper/" — soft-only: false
/kill-argument "paper/ and evidence"
/auto-paper-improvement-loop "paper/" — edit-whitelist: .aris/edit_whitelist.yaml
```

Review findings are not automatically accepted. For each finding, record: evidence, minimum fix, cost, whether the fix was performed, and the claim impact. Keep `review-stage/REVIEW_STATE.json` so a later session can resume without reconstructing context.

Exit gate: no unresolved blocking audit, or the final report explicitly lists the blocker and the paper is labeled draft rather than submission-ready.

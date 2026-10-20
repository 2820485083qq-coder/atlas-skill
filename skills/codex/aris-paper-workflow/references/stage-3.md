### Stage 3 — Implement and run

Use:

```text
/experiment-bridge "refine-logs/EXPERIMENT_PLAN.md" — AUTO_DEPLOY: false — human checkpoint: true
/run-experiment "sanity command only"
/monitor-experiment "run directory or backend"
/analyze-results "runs/"
/experiment-audit "code and raw result paths"
/result-to-claim "CLAIMS_REGISTER.md plus raw results"
```

For already authorized local work, run sanity checks, fix task-caused failures, and rerun affected checks. Remote, paid, overnight, or hardware runs require their explicit scope, budget and stop conditions before execution. Keep raw logs and machine-readable results. Never treat a successful process exit as scientific evidence. Update `CLAIMS_REGISTER.md` only from raw result files.

Exit gate: baseline, main result, uncertainty/repeatability information, and known failures are recorded; unsupported claims are marked `needs evidence` or `downgraded`.

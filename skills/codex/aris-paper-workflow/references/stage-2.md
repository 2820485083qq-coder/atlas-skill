### Stage 2 — Convert claims into experiments

Use:

```text
/experiment-plan "path/to/PAPER_BRIEF.md and CLAIMS_REGISTER.md"
/ablation-planner "path/to/experiment plan"
```

The plan names applicable data/splits, baselines, metrics, repeatability controls, expected outputs, failure criteria and resource estimates. Adapt these to the research method rather than forcing GPU or ML requirements onto other work. Every main claim gets an evidence-producing test or is marked as awaiting evidence.

Exit gate: the requested plan is written and checked for claim coverage, feasibility and evidence gaps. Deployment approval is not required to finish a planning-only request. Before an actual remote, paid or hardware run, obtain its explicit authorization, budget and stop conditions.

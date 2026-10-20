### Stage 6 — Release

Validate the requested delivery format. Compile only when the artifact needs a build and its sources changed since the last successful build. Use `/paper-compile` for LaTeX; use the appropriate format workflow for Word or other artifacts. Visually inspect rendered documents when layout is part of the deliverable. For a full-paper release, write a concise release note containing:

```text
paper version / commit
source evidence root
claim-audit status
experiment-audit status
citation-audit status
known limitations
unverified items
```

Never use “accepted”, “verified”, or “submission-ready” as a synonym for “the model produced a polished PDF”.

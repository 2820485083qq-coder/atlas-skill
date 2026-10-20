### Stage 4 — Build the paper

For ML/CV/NLP or LaTeX research papers, select the needed routes:

```text
/paper-plan "claims, evidence, and experiment log"
/paper-write "paper-plan and source evidence"
/paper-figure "raw results"
/paper-compile "paper/"
```

Use the existing `research-paper-writing` skill for paragraph roles, reverse outlining, terminology consistency, and claim-evidence alignment. For an undergraduate engineering thesis in Word, route instead through the existing `academic-paper-strategist → academic-paper-composer → doc/docx` flow; do not force the ARIS LaTeX path.

Writing rules:

- Abstract and Introduction claims must trace to the project's claims/evidence records or cited sources; use existing equivalent filenames.
- Method equations must come from the actual implementation or cited source; never invent missing formulas.
- Experiments report raw values, uncertainty, and scope before interpretation.
- A complete paper includes limitations. For a section-only request, keep that section's claims appropriately bounded without adding unrelated sections.

Exit gate: the requested text is complete, source-grounded and checked in its requested format. Figure generation and full-paper compilation apply only when the requested artifact needs them.

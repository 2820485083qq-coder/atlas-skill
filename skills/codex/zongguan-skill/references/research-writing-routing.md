# Research Writing Routing

Use this reference when routing academic writing tasks inspired by prompt/skill collections such as `Leey21/awesome-ai-research-writing`.

Do not copy prompt templates into zongguan. Route to the smallest existing skill that can do the work directly.

## Source-Inspired Skill Signals

The Leey21 repository highlights these skill/workflow categories:

- `20-ml-paper-writing`: full ML paper drafting, conference templates, citation validation, reviewer-facing structure, figures, tables, and checklist work.
- `humanizer`: remove AI-writing traces after content and logic are stable.
- `docx`: Word document creation/editing/revision and Word template submission.
- `doc-coauthoring`: staged collaborative document writing.
- `canvas-design`: design philosophy plus single-page visual/canvas output for concepts and diagrams.
- `arxiv-translator-skill`: translate arXiv/LaTeX source and compile translated output.

Not all of these are installed locally. Prefer installed equivalents first.

## Installed Equivalent Map

- `20-ml-paper-writing` equivalent:
  - primary: `research-paper-writing`
  - support: `awesome-ai-research-writing` for paragraph operations
  - support: `nature-polishing`, `nature-figure`, `nature-data` for Nature-style work
  - support: `paper-reading` for source-paper analysis before writing
- `humanizer` equivalent:
  - primary: `awesome-ai-research-writing` for academic de-AI rewriting
  - support: `engineering-thesis-rewriter` for Chinese engineering thesis de-AI work
- `docx` equivalent:
  - primary: `docx` or `doc`
  - content support: `research-paper-writing`, `academic-paper-composer`, or `awesome-ai-research-writing`
- `doc-coauthoring` equivalent:
  - primary: `research-paper-writing` for paper coauthoring
  - support: `planning-with-files` for long staged writing
  - support: `superpower-brainstorming` for early design/structure discussion
- `canvas-design` equivalent:
  - primary: `nature-figure` for academic figures
  - support: `imagegen` / `gpt-image` for generated raster visuals
  - support: `figma` / `figma-implement-design` when the source is a Figma design
- `arxiv-translator-skill` equivalent:
  - primary: `awesome-ai-research-writing` for LaTeX translation snippets
  - support: `paper-reading` for paper understanding
  - support: `pdf` if the input is PDF rather than LaTeX source
  - if the user explicitly needs full arXiv source translation plus compilation and no installed skill handles it, recommend installing `arxiv-translator-skill`.

## Task Routes

- Chinese draft -> English LaTeX paper paragraph:
  `awesome-ai-research-writing`
  Verify LaTeX commands, citations, labels, formulas, `%`, `_`, and `&` escaping.
- English LaTeX -> Chinese reading version:
  `awesome-ai-research-writing`
  Preserve meaning; strip or explain LaTeX commands only when the user asks for a reading version.
- Chinese Word-style academic paragraph:
  `awesome-ai-research-writing`
  Ensure no Markdown artifacts when the user wants Word-ready text.
- Shorten / expand / polish / humanize a paragraph:
  `awesome-ai-research-writing`
  Use `research-paper-writing` only if section-level argument structure must change.
- Full paper from repo, notes, or results:
  `research-paper-writing`
  Add `paper-reading` for source papers, `nature-figure` for figures, and `docx` only if the final artifact is Word.
- Conference template setup or format migration:
  `research-paper-writing`
  Add `docx` for Word templates; use `pdf` only for reading/extracting PDF instructions.
- Add citations or Related Work:
  `research-paper-writing`
  Browse/verify citations when current or precise bibliographic data matters; mark unverifiable citations instead of fabricating BibTeX.
- Paper architecture diagram, experiment plot recommendation, figure title, table title, caption:
  `awesome-ai-research-writing` for text/caption planning.
  `nature-figure` for publication-grade figure workflow.
  `imagegen` / `gpt-image` only when the user wants an actual generated image.
- Reviewer-style whole-paper audit:
  `research-paper-writing`
  Add `awesome-ai-research-writing` for lightweight review; use `second-opinion` only for code diffs, not prose.
- Model selection or research Q&A:
  `awesome-ai-research-writing`
  Browse when facts are current or source-backed claims are required.
- Undergraduate thesis from a real software project:
  `academic-paper-strategist` -> `academic-paper-composer` -> `docx`
  Do not route this to generic ML paper writing.

## Conflict Rules

- If the user asks for a specific installed skill, use it.
- If the task is only paragraph-level academic language work, prefer `awesome-ai-research-writing`.
- If the task changes a whole paper's claims, structure, or submission strategy, prefer `research-paper-writing`.
- If the task is Word/DOCX mechanics, include `docx` after the writing skill.
- If the task is Nature-specific, use Nature-specific skills before generic paper writing.
- If the task is thesis-specific, use thesis skills before generic paper writing.
- If an upstream skill from Leey21 is not installed, do not pretend it was used; route to installed equivalents or recommend installation.


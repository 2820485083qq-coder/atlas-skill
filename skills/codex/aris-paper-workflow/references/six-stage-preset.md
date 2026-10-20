# Six-stage paper workflow preset

This preset transcribes the two user-supplied UNA Research example images into a local routing table. The first image visibly lists rows 1–24. Row 25 (paper to patent) is inferred from the second image's final branch and the installed skill; verify the original source if its exact label matters. The images are examples, not instructions to run all 25 tasks.

## Use

1. Resolve the target research project and requested deliverable. For new work, establish scope with [lifecycle step 0](stage-0.md); for existing work, reuse its brief, status, evidence, and output tree. A proposal or patent can start from a technical disclosure without a manuscript.
2. Select only the necessary rows below. The six categories are a menu, not a required sequence for every task. Keep the image's delivery paths as defaults only when the project has no established equivalents.
3. Check the selected skill's current `SKILL.md` before use. An alternative in this table serves the task, not a claim of feature parity with the absent skill.
4. Before release, audit the claims and citations appropriate to the requested assurance level. Package only explicitly selected, checked files with `scripts/pack-paper-deliverables.ps1`.

## Dispatch order and stage gates

For a request covering the whole paper, advance through preset categories 1–5 as evidence becomes available; category 6 is an optional proposal or patent branch. These categories differ from the ARIS evidence lifecycle steps linked in the parent `SKILL.md`. A request for one artifact starts at its corresponding category and reads earlier records only when that artifact depends on them.

| Preset category | Select tasks | Check before advancing |
| --- | --- | --- |
| 1. Literature search and acquisition | 1–5 | Search record, source identity, closest work, and provenance of any downloaded full text |
| 2. Reading and reporting | 6–8 | Notes/cards/slides trace to the actual papers; missing full text is marked |
| 3. Research design and data | 9–14 | Question, methods, data access, and experiment plan are explicit; claimed results point to raw records |
| 4. Writing and revision | 15–20 | Each substantive claim has a source or result artifact; citations and uncertainty are visible |
| 5. Review | 21–23 | Findings have dispositions; reference metadata and claim support are checked |
| 6. Proposal and patent | 24–25 | Source support for each technical feature is recorded; prior-art search coverage and novelty assessment remain explicit |

At each transition, record the completed output path and any unresolved blocker in the project's existing status or equivalent. Directory creation alone is not completion. The delivery directories below are defaults for a new project; preserve an existing project's structure.

If the project already has a verified corpus and asks for a review article or section, reuse that corpus. Do not rerun search or download without a concrete coverage gap. Check that each new synthesis claim is supported by the read source, not merely its metadata. For Chinese Word output, preserve Chinese; choose the installed `academic-paper-composer`/`docx` route for document construction and rendered layout checks. `nature-writing` is oriented toward English manuscripts and is not an automatic Chinese Word route.

For patent work, first identify the technical disclosure (paper, inventor notes, code, data, or other authorized source). `nature-paper-to-patent` can work from non-paper disclosures, but with no technical content the deliverable is an intake or disclosure checklist. Keep feature support separate from prior-art search and any legal novelty conclusion.

## Example mapping checked against local Codex skills on 2026-09-29

| # | Category | Example skill / task | Local route | Example delivery directory |
| --- | --- | --- | --- | --- |
| 1 | Literature search and acquisition | `nature-academic-search` / English search | Same name | `文献/元数据/检索/` |
| 2 | Literature search and acquisition | `cn-academic-search` / Chinese search | Search Chinese terms through actually available sources using `nature-academic-search`; CNKI/Wanfang require a separately verified authorized interface; example name absent | `文献/元数据/检索/` |
| 3 | Literature search and acquisition | `nature-downloader` / acquire papers | Same name | `文献/论文/` |
| 4 | Literature search and acquisition | `nature-literature-pipeline` / evaluate papers | Same name | `文献/笔记/推送/` |
| 5 | Literature search and acquisition | `literature-review` / review synthesis | Same name (ECC); use `research-lit` or `nature-literature-pipeline` only when their specialized procedures are needed | `文献/笔记/综述/` |
| 6 | Reading and reporting | `nature-reader` / close reading | Same name | `文献/笔记/精读/` |
| 7 | Reading and reporting | `nature-paper-card` / paper card | Same name | `文献/笔记/卡片/` |
| 8 | Reading and reporting | `nature-paper2ppt` / paper slides | Same name | `写作/投稿/汇报/` |
| 9 | Research design and data | `research-question` / research question | Same name; use `research-review` for a separate critique when needed | `写作/设计/研究问题/` |
| 10 | Research design and data | `method-design` / experimental design | `experiment-plan`; example name absent | `写作/设计/实验方案/` |
| 11 | Research design and data | `nature-experiment-log` / raw experiment record | Same name | `实验/<实验名>/输出/实验记录/` |
| 12 | Research design and data | `nature-figure` / scientific figures | Same name | `写作/图表/` |
| 13 | Research design and data | `nature-statistics` / results summary | Same name | `实验/<实验名>/输出/数据总结/` |
| 14 | Research design and data | `nature-data` / data availability | Same name | `数据/<数据集名>/数据字典/` |
| 15 | Writing and revision | `paper-outline` / outline | Same name (BOYA, IMRaD route for empirical work); use `paper-plan` for ML/LaTeX-specific planning when needed | `写作/手稿/大纲/` |
| 16 | Writing and revision | `nature-writing` / paper draft | Same name | `写作/手稿/正文/` |
| 17 | Writing and revision | `revise-section` / section revision | `nature-polishing`; example name absent | `写作/手稿/修订/` |
| 18 | Writing and revision | `academic-polish` / language polish | Same name; use `nature-polishing` when its structural revision procedure is needed | `写作/手稿/润色/` |
| 19 | Writing and revision | `nature-citation` / citations | Same name | `文献/元数据/引用/` |
| 20 | Writing and revision | `ai-deduplication` / repeated or formulaic prose | `nature-polishing` for substantive rewrite only; no reliable AI-origin or similarity certification is implied | `写作/手稿/去重/` |
| 21 | Review | `peer-review` / critical review | Same name; `nature-reviewer` is an alternate review style | `写作/评审/` |
| 22 | Review | `reviewer-response` / response to reviewers | Same name; `nature-response` is an alternate response workflow | `写作/投稿/回复/` |
| 23 | Review | `verify-citations` / reference checking | Same name for BibTeX metadata (live lookups need a real contact email and reachable indexes); use `nature-ref-verifier` or `citation-audit` for broader source and claim support | `文献/证据/核验/` |
| 24 | Proposal and patent | `nature-proposal-writer` / proposal | Same name | `写作/投稿/申报/` |
| 25 | Proposal and patent | `nature-paper-to-patent` / patent conversion | Same name; row label inferred from second image | `写作/投稿/专利/` |

### Auxiliary writing pass (outside the 25 image tasks)

When writing or revising substantive paper prose, read `anti-defensive-writing` after the source- and result-grounded draft. Make the supported contribution direct and remove redundant self-protective wording. Retain negative findings, fair baselines, uncertainty, and limits that affect interpretation; then verify claims and citations as usual. This is a writing aid, not the unavailable `ai-deduplication` skill or an AI-origin detector.

The local route is an availability snapshot. Seven previously missing exact-name skills are installed: `literature-review`, `research-question`, `paper-outline`, `academic-polish`, `peer-review`, `reviewer-response`, and `verify-citations`. Four example names (`cn-academic-search`, `method-design`, `revise-section`, `ai-deduplication`) still lack a verified, general, standalone exact-name match for this Codex setup. [Source decisions](source-selection.md) record the candidates and their limits. Use documented functional routes only when they cover the task; do not claim that an alternate is the named skill. For source selection, prefer a higher-star exact-name source only after checking license, task fit, dependencies, and whether the skill can run independently. Re-check selected skills before a future run. For claims about experiments, keep source statements, hypotheses, raw results, derived values, and physical validation distinct; never turn an unverified draft or simulated proxy into a verified result.

## Quick invocation

Use `$aris-paper-workflow` with a paper path, desired output, and stage when known. Examples:

```text
$aris-paper-workflow 在 <论文项目路径> 做文献检索与研究问题梳理，交付可追溯的证据表和问题陈述。
$aris-paper-workflow 在 <论文项目路径> 继续正文写作，按现有证据和目标格式交付，最后核对引用。
$aris-paper-workflow 只打包 <论文项目路径> 中已核验的 <相对路径清单>，输出 <交付包.zip>。
```

When the paper is ready to hand over, package an explicit list of relative files or directories:

```powershell
& "C:\Users\Lenovo\.codex\skills\aris-paper-workflow\scripts\pack-paper-deliverables.ps1" -ProjectRoot "<论文项目路径>" -OutputZip "<交付包.zip>" -IncludePath @("写作/手稿/正文", "文献/元数据/引用")
```

Use this command only after checking that the selected paths contain the intended deliverables. The package manifest provides filenames, byte sizes, and SHA-256 hashes, not a scientific approval status.

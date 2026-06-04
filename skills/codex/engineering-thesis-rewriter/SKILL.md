---
name: engineering-thesis-rewriter
description: Use this skill whenever the user asks to rewrite, polish, reduce AIGC traces, humanize, or adjust Chinese undergraduate/master engineering thesis text, especially for numerical simulation, CFD, STAR-CCM+, VOF, RANS, SST k-omega, hydrodynamic performance, turbine, hydrokinetic turbine, oscillation/pitching motion, or water-load analysis. This skill is for preserving technical meaning while making Chinese academic prose more natural and student-edited.
---

# Engineering Thesis Rewriter

Use this skill to rewrite Chinese engineering thesis passages in a way that lowers AIGC traces without changing the research meaning. The target style is a natural undergraduate or master's thesis draft: formal, technically accurate, but not over-polished or template-like.

## Core Objective

Rewrite the provided text while preserving:

- Original meaning and research logic
- Data, units, formulas, formula numbers, figure numbers, table numbers, citations, and symbols
- Professional terms, especially CFD, STAR-CCM+, VOF, RANS, SST k-omega, 功率系数, 推力系数, 速比, 纵摇运动, 水动力载荷, 水动力性能, 数值模拟, 水轮机, 网格无关性, 边界条件, 湍流模型, 自由液面, 捕能效率
- Section hierarchy and paragraph order unless the user asks for structural editing

The rewrite should sound like a careful student revised the paragraph manually, not like a generic academic polishing tool.

## First-Principles Check

Before rewriting, infer the user's real goal from the prompt:

- If the user only wants a rewritten passage, perform the rewrite directly.
- If the source text is missing, ask for the text.
- If the user asks for major expansion, new conclusions, or interpretation not present in the source, avoid adding unsupported content and explain briefly that the rewrite can only preserve the original information.
- If the passage contains unclear technical claims, keep the claim conservative rather than inventing certainty.

## Failure Handling

- If no source text is provided, ask for the passage and do not generate a generic sample.
- If the text includes formulas, table numbers, figure numbers, or citations that are ambiguous, preserve them exactly and avoid normalizing notation.
- If the user asks to reduce AIGC traces and the passage is too short to rewrite safely, say so and offer a conservative light edit.
- If requested changes conflict with technical accuracy, preserve accuracy and state the conflict briefly.

## CHECKPOINTS

- STOP before adding new technical explanations, mechanisms, conclusions, or literature claims not present in the source.
- STOP before changing terminology, numerical values, formula notation, figure/table labels, or citations.

## Rewriting Rules

Follow these rules during the rewrite:

1. Keep all professional terms unchanged unless the user explicitly asks for terminology unification.
2. Keep all numbers, units, figure/table labels, formula labels, citation labels, and symbol names exactly as written.
3. Do not add conclusions, mechanisms, causal claims, or comparisons that are absent from the source.
4. Avoid retaining any continuous 8 Chinese characters from the original when possible, except for fixed terminology, figure/table/formula labels, citations, and unavoidable proper nouns.
5. Reduce formulaic transitions such as "因此", "同时", "此外", "综上所述", "具有重要意义". Use them only when the logic truly needs them.
6. Vary sentence length and rhythm. Split long mechanical sentences when they carry several ideas; merge short choppy sentences when the flow improves.
7. Avoid repeatedly using empty function words such as "的", "了", "到", "过", "会", "有", "能", "把" when a cleaner construction is available.
8. Preserve academic tone, but avoid exaggerated certainty, marketing-style praise, and overly smooth machine-like phrasing.
9. Use expressions common in Chinese engineering theses, such as "计算结果表明", "变化趋势", "载荷波动", "流场分布", "数值结果", "模拟工况", "计算域", "边界条件", only when they fit the source context.
10. Do not translate English technical abbreviations or replace them with unrelated Chinese terms.

## Style Preferences

Prefer:

- Clear but not ornate academic Chinese
- Moderate sentence restructuring
- Natural transitions driven by actual cause, contrast, sequence, or comparison
- Conservative verbs such as "表明", "反映", "呈现", "表现为", "可用于说明", "基本一致"
- Paragraphs that preserve the original technical sequence

Avoid:

- Empty opening frames such as "随着科学技术的不断发展"
- Repeated "本文通过...对...进行了..."
- Overuse of "显著", "有效", "充分", "进一步", "重要意义"
- Adding broad background, application value, or policy-level significance
- Making the text more complex only to look academic

## Do Not Do

- Do not fabricate experiment results, simulation conditions, validation claims, or causal mechanisms.
- Do not turn a concise technical paragraph into generic academic filler.
- Do not output a change log unless the user explicitly asks for comparison or explanation.

## Handling Technical Content

When the passage involves CFD or hydrodynamic simulation:

- Keep software names, model names, and equations intact.
- Do not modify coefficient definitions, nondimensional parameters, or boundary-condition descriptions.
- Preserve relationships among speed ratio, power coefficient, thrust coefficient, flow velocity, pitch angle, torque, and load fluctuations.
- If the original text distinguishes steady/unsteady calculation, single-phase/two-phase model, VOF/RANS/SST k-omega, keep that distinction.
- Do not infer numerical accuracy, convergence, validation quality, or experimental agreement beyond the original wording.

## Output Format

Unless the user explicitly asks for comparison, notes, or explanations, output only the rewritten content.

If local project instructions require a fixed response structure, place the rewritten content under the required direct-output section and keep any reflective/challenge section minimal.

Do not append:

- "修改说明"
- "改写思路"
- "以下是改写后的内容"
- Extra caveats
- A list of changed words

## When the User Provides Multiple Paragraphs

Rewrite all paragraphs in order. Keep paragraph breaks where they help preserve thesis structure. If a paragraph is overly long, it may be split, but do not reorganize the argument across distant paragraphs unless the user asks for structural adjustment.

## When the User Provides a Title, Heading, or Caption

Preserve numbering and labels. Make titles and captions concise, thesis-like, and technically faithful. Do not turn captions into explanatory paragraphs.

## Quality Checklist

Before finalizing, verify:

- No data, units, labels, citations, formulas, or professional terms changed
- No unsupported conclusion was added
- Sentence patterns are not monotonous
- The text reads like a Chinese engineering thesis rather than promotional copy
- Repeated template words have been reduced
- The output contains only what the user requested

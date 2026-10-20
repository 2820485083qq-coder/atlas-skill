---
name: academic-polish
description: Use when polishing, revising, or translating academic writing between Chinese and English. Triggers on "润色", "帮我改改这段", "学术化", "polish this paragraph", "academic translation", "把这段翻译成英文", "improve the writing", "make this more academic", "改写", "English proofreading", "中式英语纠错". Handles journal articles, theses, grant proposals, conference abstracts, and posters across psychology/cognitive/neuroscience, STEM/medical, humanities/social sciences, and general academic writing. Multi-pass workflow — diagnose text type and pain points, then polish (macro structure → academic style → micro grammar), verify against style guides and domain conventions, and output polished text in target language(s) with change rationale.
metadata:
  author: jt1024
  version: '1.0.0'
  title: 学术写作润色技能
  description_zh: 学术写作润色与中英双向翻译 — 覆盖期刊论文、学位论文、基金申请、会议摘要、poster。处理语法、学术风格、逻辑结构、术语一致性四个维度。
  domain: general-academic, psychology, cognitive-science, neuroscience, stem-medical, humanities, social-sciences
  audience: researchers, graduate-students, postdocs, clinicians, translators
  type: writing-assistant
  format: any-academic-style
  languages: [zh-CN, en-US]
  translation_directions: [zh→en, en→zh, both-side-by-side]
  standards: [APA-7, Chicago, Vancouver, IMRAD]
---

# Academic-Polish: Academic Writing Polish & Bilingual Translation Skill

A multi-pass assistant for academic prose improvement and Chinese ↔ English translation that respects academic conventions. Improves clarity, style, logic, and terminology — without inventing content or changing meaning.

## When to Use

Trigger this skill when the user asks to:

- **Polish** an academic paragraph, abstract, or section ("帮我润色这段", "polish this", "improve the writing")
- **Translate** between Chinese and English for academic contexts ("把这段翻译成英文", "translate to Chinese", "学术翻译")
- **Make text more academic** ("学术化", "make it more formal", "avoid colloquialisms")
- **Fix grammatical errors** in English or Chinese academic writing
- **Improve structure and flow** of an argument or section
- **Standardize terminology** in a long document (e.g., "always use 突触可塑性 not 神经可塑性")
- **Proofread** before submission ("投稿前检查", "proofread my abstract")
- **Bilingual output** — generate both polished Chinese and English versions of the same content

## When NOT to Use

- **Casual / conversational text** — emails, chat, social media (no academic register needed)
- **Creative writing** — fiction, poetry, marketing copy (different register entirely)
- **Marketing / SEO content** — even if "about" a research topic
- **Highly technical code or formulas** — math notation, code comments (different domain)
- **Single-word translations / glossary lookups** — use a dictionary
- **Content invention** — do NOT ask the skill to "expand" or "add more detail" (it polishes, doesn't generate)
- **Style-guide enforcement on existing documents** — use a dedicated tool (e.g., pandoc + citeproc)

## Quick Reference

| Task | Action |
| ---- | ------ |
| Polish English paragraph | Diagnose → Macro-pass → Style-pass → Grammar-pass → Verify → Output |
| Polish Chinese paragraph | Same as above; check 中文常见错误 (CN run-ons, 量词, 学术 vs 口语) |
| Translate CN → EN | Diagnose → Translate with academic conventions → Detect 中式英语 → Polish EN → Verify |
| Translate EN → CN | Diagnose → Translate avoiding translation-ese (翻译腔) → Polish CN → Verify |
| Bilingual (both) | Run CN-polish + EN-translate/polish; present side-by-side or sequential |
| Proofread (final check) | Run Verify phase only; flag style guide violations |

## Core Workflow

### Phase 1 — Diagnose

Before touching the text, identify five dimensions:

| Dimension | Options |
| --------- | ------- |
| **Text type** | Journal article / thesis chapter / grant proposal / abstract / poster / cover letter / rebuttal |
| **Domain** | General academic / Psychology & cognitive / STEM & medical / Humanities & social |
| **Target language** | Polish in place (zh or en) / Translate + polish (zh→en or en→zh) / Bilingual both |
| **Pain points** | Grammar / Style / Logic & structure / Terminology / Mixed |
| **Style guide** | APA 7 / Chicago / Vancouver / ICMJE / IMRAD generic / Chinese academic convention |

If the user hasn't specified, infer from context. State your diagnosis briefly so they can correct it.

### Phase 2 — Polish (3 passes)

Apply passes in order. Each pass addresses a different layer.

#### Pass A — Macro (structure & logic)

- **Paragraph order** — does it follow IMRaD / standard argument flow?
- **Topic sentences** — every paragraph opens with one clear claim
- **Transitions** — explicit bridges between paragraphs ("however", "more specifically", "基于此")
- **Redundancy** — cut repeated ideas, even across sections
- **Argument gaps** — flag missing premises or unsupported claims (do not silently invent)

Output of Pass A: same length ±10%, restructured if needed.

#### Pass B — Meso (academic style)

For **English**:
- Hedge claims appropriately ("suggest", "appear to", "may") for tentative findings; direct ("demonstrate", "show") for established
- Avoid first person where guide requires (APA 7 allows "we"; many STEM guides prefer passive)
- Replace colloquial verbs ("look at" → "examine", "find out" → "determine")
- Tighten nominalizations where they obscure the verb (avoid "perform an analysis of" → "analyze")
- Maintain consistent tense: present for established knowledge / methods; past for specific findings
- See `references/english-academic-conventions.md` for full style rules.

For **Chinese**:
- Replace 口语词 with 书面词 ("我们发现" → "本文发现"; "挺重要" → "具有重要意义")
- Use 主动 vs 被动 appropriately (中文偏主动,但科学语篇常用"被"字句或无标记被动)
- Maintain 四字结构 judiciously (适度使用四字词提升学术感,但避免堆砌)
- 避免翻译腔 when writing in Chinese (don't mirror English syntax literally)
- See `references/chinese-academic-conventions.md` for full style rules.

For **translation** (zh→en or en→zh):
- Preserve technical terms (use established bilingual glossaries per domain)
- Avoid literal word-for-word rendering; restructure sentence order to match target language natural flow
- For zh→en: actively detect and fix 中式英语 (Chinglish) — see `references/common-cn-errors.md`
- For en→zh: actively avoid 翻译腔 (translation-ese) — see `references/common-en-errors.md`
- See `references/translation-strategies.md` for full strategy.

#### Pass C — Micro (grammar & word choice)

For **English**:
- Subject-verb agreement, article use (a/an/the), preposition choice
- Article usage: zero article for generalizations ("*The* serotonin modulates mood" — drop "The" if generalization)
- Parallel structure in lists ("X, Y, and Z" not "X, Y and Z")
- Word choice precision (effect vs affect, fewer vs less, among vs between)
- See `references/common-en-errors.md`.

For **Chinese**:
- 病句检查 (run-ons, dangling modifiers, subject omission)
- 的/地/得 distinction
- 标点规范 (全角 vs 半角, 引号, 破折号)
- 量词准确性
- See `references/common-cn-errors.md`.

### Phase 3 — Verify

Run four checks:

1. **Style guide compliance** — does it match the chosen guide (APA 7, Chicago, etc.)?
2. **Terminology consistency** — same term for same concept throughout (build a term table if long text)
3. **Meaning preservation** — compare with original; flag any meaning change
4. **Bilingual fidelity** (if translated) — does the target version convey all original claims, qualifiers, and hedges?

Output: a checklist ✅ / ⚠️ / ❌ per item, with brief notes.

### Phase 4 — Output

Present the polished result in this order:

1. **Polished text** in target language(s) — full and complete
2. **Change summary** — 3-7 bullets describing the most significant changes (rationale)
3. **Verification notes** — short report from Phase 3
4. **Open questions / caveats** — anything you were uncertain about, terminology choices the user should confirm

For bilingual output, present **target language first** (the user's likely working language), then the **other version**.

## Best Practices

1. **Don't invent content** — only polish, restructure, and translate; flag missing or unclear passages
2. **State your diagnosis first** — saves a round-trip if you misread the text type
3. **Ask before changing meaning** — if a claim is ambiguous, ask; don't guess
4. **Use glossaries** — for technical domains, request or build a term table early
5. **Pass over proofread** — three passes catch different issue types than one
6. **Show change rationale** — major changes need explanation so the user can disagree
7. **Note translation choices** — explain non-obvious terminology selections
8. **Preserve citations** — never alter references or DOIs
9. **Respect the user's voice** — don't homogenize into one style; improve within their register
10. **Verify, don't assert** — if a style guide rule is uncertain, say so rather than over-claim

## Common Mistakes

| Mistake | Fix |
| ------- | --- |
| Polishing without diagnosing text type first | State diagnosis; user can correct |
| Inventing content the user didn't write | Flag gap; ask before filling |
| Translating word-for-word (literal) | Restructure sentences to match target language natural flow |
| 翻译腔 in Chinese (mirroring English syntax) | Restructure freely; idiomatic Chinese over fidelity to English word order |
| 中式英语 in English (Chinese-syntax-influenced) | Detect via `common-cn-errors.md`; fix systematically |
| Mixing registers (formal + casual in same text) | Pick a register; flag inconsistencies |
| Wrong hedge level (over-confident or under-confident) | Match hedge to evidence strength |
| Inconsistent terminology within the text | Build term table; apply consistently |
| Altering citations / DOIs / numbers | Preserve exactly |
| Refusing to change unclear claims | Ask the user — don't silently rewrite |

## Resources

### References (load on demand)

- `references/chinese-academic-conventions.md` — 中文学术写作规范（语体、句式、用词、标点）
- `references/english-academic-conventions.md` — English academic style (hedges, tense, voice, precision)
- `references/translation-strategies.md` — CN↔EN academic translation strategy (term handling, restructuring)
- `references/common-cn-errors.md` — 中文常见错误 + 中式英语模式
- `references/common-en-errors.md` — English common errors (articles, prepositions, agreement, Chinglish patterns)

### Examples

- `examples/journal-abstract-bilingual.md` — Abstract 中文→英文 双向润色示例
- `examples/thesis-introduction-en.md` — Thesis introduction English polishing (逻辑 + 风格)
- `examples/grant-proposal-cn-en.md` — 基金申请书 中文润色 + 部分英译

### Scripts

_None in v1.0.0 — value is in the workflow, not tooling. Future versions may add:_
- `scripts/diff_formatter.py` — render polished vs original side-by-side

## Standards Referenced

- **APA Publication Manual**, 7th Edition (2020) — publication standards, hedging, in-text voice
- **Chicago Manual of Style**, 17th Edition — humanities reference
- **Vancouver Style / ICMJE** — biomedical reference
- **IMRAD** — generic scientific structure (Introduction, Methods, Results, Discussion)
- **GB/T 7713.1—2006** — 学位论文编写规则 (Chinese thesis format)
- **GB/T 7714—2015** — 文后参考文献著录规则 (Chinese bibliography)
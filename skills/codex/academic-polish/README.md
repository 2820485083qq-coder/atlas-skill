# Academic-Polish

> A multi-pass Claude skill for polishing academic prose and translating between Chinese and English — across journal articles, theses, grant proposals, conference abstracts, and posters.

[English](README.md) · [中文](README.zh-CN.md)

[![Version](https://img.shields.io/badge/version-1.0.0-coral)](CHANGELOG.md)
[![License: MIT](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![Claude Skill](https://img.shields.io/badge/type-Claude%20Skill-sky)](SKILL.md)

## What it does

`academic-polish` is a Claude skill that improves academic writing in **four dimensions**:

| Dimension | What it fixes |
| --------- | ------------- |
| **Grammar** | Subject-verb agreement, article use, tense, punctuation, run-on sentences, 量词, 的地得 |
| **Style** | Register, hedging, voice, passive vs active, parallelism, 学术 vs 口语 |
| **Logic** | Argument flow, paragraph unity, transitions, topic sentences, signposting |
| **Terminology** | Consistent use of technical terms, avoiding translation-ese (翻译腔) and 中式英语 |

It works in **both directions** (中文 ↔ English) and across **multiple domains** (psychology / cognitive / neuroscience, STEM-medical, humanities / social sciences, general academic). It **does not invent content** — it polishes what you wrote, never fabricates claims or sources.

## When to use it

Trigger phrases include:

- **English**: "polish this paragraph", "academic translation", "make this more academic", "English proofreading", "improve the writing", "revise the abstract"
- **中文**: "润色", "帮我改改这段", "学术化", "把这段翻译成英文", "改写", "中式英语纠错", "投稿前检查"

## When NOT to use it

- Casual / conversational text (emails, chat)
- Creative writing (fiction, marketing copy)
- Style-guide enforcement on existing documents (use pandoc + citeproc instead)
- Content invention / expansion (it polishes, doesn't generate)
- Single-word translations (use a dictionary)

## Installation

This is a Claude Code **Skill**. Drop the `academic-polish/` folder into your skills root:

```bash
# Default Claude skills directory
cp -r academic-polish/ ~/.claude/skills/

# Or a project-scoped directory
cp -r academic-polish/ <your-project>/.claude/skills/
```

Claude Code picks up the skill automatically — no `npm install`, no daemon to start. The `SKILL.md` frontmatter `description` is what Claude matches against your prompts.

## Usage

Once installed, just ask. Example prompts:

```
帮我润色这段:
"本研究通过问卷调查的方式,探讨了大学生的心理健康状况,
结果显示,焦虑和抑郁水平较高,建议学校加强心理辅导。"

把这段翻译成英文(APA-7 style):
"本研究采用随机对照设计,招募了 120 名大学生被试…"
```

The skill will:
1. **Diagnose** the text type and pain points
2. Run **macro-pass** (structure & flow)
3. Run **style-pass** (register & terminology)
4. Run **grammar-pass** (sentence-level fixes)
5. **Verify** against style guides
6. Output the polished version with a brief change rationale

## Workflow (multi-pass)

```
Diagnose ──► Macro ──► Style ──► Grammar ──► Verify ──► Output
   │            │         │          │           │
 text type   structure   register   details   APA/Chicago/
 domain     transitions  hedging    agreement  Vancouver check
```

See [`SKILL.md`](SKILL.md) for the full workflow and decision rules.

## What's in this repo

```
academic-polish/
├── README.md                    # you are here
├── README.zh-CN.md              # 中文 README
├── CHANGELOG.md                 # version history
├── CONTRIBUTING.md              # how to contribute
├── LICENSE                      # MIT
├── SKILL.md                     # the skill itself (Claude reads this)
├── references/                  # style guides & error catalogs
│   ├── english-academic-conventions.md
│   ├── common-en-errors.md
│   ├── chinese-academic-conventions.md
│   ├── common-cn-errors.md
│   └── translation-strategies.md
└── examples/                    # before → after worked examples
    ├── journal-abstract-bilingual.md
    ├── thesis-introduction-en.md
    └── grant-proposal-cn-en.md
```

## Style standards supported

- **APA 7th edition** (psychology, social sciences)
- **Chicago** (humanities)
- **Vancouver** (medical)
- **IMRAD** structure (most STEM journals)

## Domains covered

- Psychology / cognitive science / neuroscience
- STEM (math, physics, CS, engineering)
- Medical / clinical
- Humanities / social sciences
- General academic writing

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Bug reports, new style conventions, new examples, and new domain guides are all welcome.

## License

MIT — see [LICENSE](LICENSE).

## Citation

If you use this skill in your research workflow:

```bibtex
@software{jt1024_academic_polish,
  author = {jt1024},
  title = {Academic-Polish: A Claude skill for academic writing polish and bilingual translation},
  year = {2026},
  version = {1.0.0},
  url = {https://github.com/jt1024/academic-polish}
}
```
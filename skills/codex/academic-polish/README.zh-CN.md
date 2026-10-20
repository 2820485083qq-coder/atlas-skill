# Academic-Polish(学术写作润色)

> 一个 Claude 技能,专门做学术写作润色与中英双向翻译 —— 覆盖期刊论文、学位论文、基金申请、会议摘要、poster。

[English](README.md) · [中文](README.zh-CN.md)

[![Version](https://img.shields.io/badge/version-1.0.0-coral)](CHANGELOG.md)
[![License: MIT](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![Claude Skill](https://img.shields.io/badge/type-Claude%20Skill-sky)](SKILL.md)

## 它做什么

`academic-polish` 是一个 Claude 技能,沿**四个维度**改进学术写作:

| 维度 | 修复什么 |
| --- | --- |
| **语法** | 主谓一致、冠词、时态、标点、流水句、量词、的地得 |
| **风格** | 语域、模糊限制语、人称、被动 vs 主动、平行结构、学术 vs 口语 |
| **逻辑** | 论证流、段落统一、过渡、主题句、路标 |
| **术语** | 术语一致、避免翻译腔、避免中式英语 |

支持**中英双向**,覆盖**多个学科领域**(心理 / 认知 / 神经科学、STEM-医学、人文 / 社科、通用学术)。**不编造内容** —— 只润色你写的内容,绝不虚构观点或来源。

## 何时使用

触发词包括:

- **英文**:`polish this paragraph`、`academic translation`、`make this more academic`、`English proofreading`、`improve the writing`、`revise the abstract`
- **中文**:`润色`、`帮我改改这段`、`学术化`、`把这段翻译成英文`、`改写`、`中式英语纠错`、`投稿前检查`

## 何时**不**使用

- 日常 / 口语化文本(邮件、聊天)
- 创意写作(小说、营销文案)
- 对已有文档强行套用风格指南(请用 pandoc + citeproc)
- 编造内容 / 扩写(本技能只润色、不生成)
- 单词翻译(请用词典)

## 安装

这是 Claude Code 的**技能**(Skill)。把 `academic-polish/` 目录放进你的技能根目录即可:

```bash
# 默认 Claude 技能目录
cp -r academic-polish/ ~/.claude/skills/

# 或项目级目录
cp -r academic-polish/ <your-project>/.claude/skills/
```

Claude Code 会自动加载,无需 `npm install` 或启动任何守护进程。`SKILL.md` 的 frontmatter `description` 是 Claude 用来匹配你提问的字段。

## 使用方法

安装完成后,直接提问即可。示例:

```
帮我润色这段:
"本研究通过问卷调查的方式,探讨了大学生的心理健康状况,
结果显示,焦虑和抑郁水平较高,建议学校加强心理辅导。"

把这段翻译成英文(APA-7 style):
"本研究采用随机对照设计,招募了 120 名大学生被试…"
```

技能会:
1. **诊断** 文本类型与痛点
2. 跑**结构关**(段落结构、过渡)
3. 跑**风格关**(语域、术语)
4. 跑**语法关**(句子层面)
5. **校验** 风格指南
6. 输出润色结果,并附简要改动说明

## 工作流(多轮)

```
诊断 ──► 结构 ──► 风格 ──► 语法 ──► 校验 ──► 输出
 │         │        │        │        │
文本类型  段落结构  语域    细节     APA/Chicago/
领域     过渡      模糊语  搭配     Vancouver 校验
```

完整流程与决策规则见 [`SKILL.md`](SKILL.md)。

## 目录结构

```
academic-polish/
├── README.md                    # 本文件
├── README.zh-CN.md              # 中文 README
├── CHANGELOG.md                 # 版本历史
├── CONTRIBUTING.md              # 如何贡献
├── LICENSE                      # MIT
├── SKILL.md                     # 技能本体(Claude 读取此文件)
├── references/                  # 风格指南与错误手册
│   ├── english-academic-conventions.md
│   ├── common-en-errors.md
│   ├── chinese-academic-conventions.md
│   ├── common-cn-errors.md
│   └── translation-strategies.md
└── examples/                    # before → after 实例
    ├── journal-abstract-bilingual.md
    ├── thesis-introduction-en.md
    └── grant-proposal-cn-en.md
```

## 支持的写作规范

- **APA 第 7 版**(心理、社科)
- **Chicago**(人文)
- **Vancouver**(医学)
- **IMRAD 结构**(多数 STEM 期刊)

## 覆盖的学科领域

- 心理 / 认知科学 / 神经科学
- STEM(数学、物理、CS、工程)
- 医学 / 临床
- 人文 / 社科
- 通用学术写作

## 常见问题

### 与 Grammarly / DeepL Write 等工具相比,这个有什么不同?

Grammacy 和 DeepL Write 主要是**句子级**语法检查;本技能覆盖**段落级与篇章级**问题(逻辑、过渡、术语一致),并能根据学科切换规范(APA vs Chicago vs Vancouver)。

### 会不会改我的意思?

不会。本技能默认**保留原意**,只调整表达。如果需要更激进的改写,显式说明"重写"或"重构"。

### 适合什么语料?

学术写作的任意片段 —— 摘要、引言、方法、结果、讨论、基金本子、会议摘要、poster 文本。**不适合**完整长文档的"通篇润色"(会有上下文遗忘问题)。

## 贡献

见 [CONTRIBUTING.md](CONTRIBUTING.md)。欢迎报 bug、新增风格约定、新增领域指南、新增示例。

## 许可

MIT —— 见 [LICENSE](LICENSE)。

## 引用

如果这个技能帮到了你的写作流程:

```bibtex
@software{jt1024_academic_polish,
  author = {jt1024},
  title = {Academic-Polish: 一个 Claude 技能,做学术写作润色与中英双向翻译},
  year = {2026},
  version = {1.0.0},
  url = {https://github.com/jt1024/academic-polish}
}
```
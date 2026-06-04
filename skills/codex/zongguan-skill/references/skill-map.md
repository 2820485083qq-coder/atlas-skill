# Skill Map

This map reflects the user's visible Codex skill ecosystem at creation time. If the live available-skill list differs, the live list wins.

## Meta Skills

- `zongguan-skill`: route and coordinate skills. Do not call recursively.
- `skill-creator`: create, update, test, or improve a skill.
- `skill-installer`: install skills from curated lists or GitHub repositories.
- `darwin-skill`: score, diagnose, and iteratively optimize existing skills.
- `huashu-nuwa`: create perspective/persona skills from people or themes.
- `self-improvement`: capture recurring failures or project-specific lessons.
- `planning-with-files`: persist task plans across long work.

## Research, Papers, And Academic Writing

- `awesome-ai-research-writing`: lightweight academic writing, translation, humanizing, captions, short reviews, and research-side workflows.
- `research-paper-writing`: full ML/CV/NLP-style paper writing, section structure, reviewer-facing revision, and deep prose improvement.
- `paper-reading` / `paper-reader`: read, summarize, analyze, compare, or critique papers and PDFs.
- `daily-papers`, `daily-papers-fetch`, `daily-papers-review`, `daily-papers-notes`: daily paper recommendation pipeline.
- `nature-polishing`: Nature-leaning academic prose polishing and translation.
- `nature-figure`: Nature/high-impact journal figure creation, revision, and audit.
- `nature-data`: Nature-ready data availability, repository plans, and FAIR metadata.
- `nature-paper2ppt`: create Nature-style Chinese PPTX from scientific papers.
- `engineering-thesis-rewriter`: Chinese engineering thesis rewriting, humanizing, and AIGC reduction.
- `academic-paper-strategist`: plan and de-risk project-backed software engineering theses.
- `academic-paper-composer`: turn a real project and draft into a final thesis manuscript.
- `xuzilong-academic`: Xu Zilong academic project conventions and stable research interfaces.

## Documents, Slides, Sheets, And PDFs

- `docx` / `doc`: create, read, edit, and format Word documents.
- `pptx`: create or modify PowerPoint decks.
- `xlsx`: create, edit, analyze, or validate spreadsheets.
- `pdf`: read, extract, combine, convert, or manipulate PDFs.
- `documents:documents`, `presentations:Presentations`, `spreadsheets:Spreadsheets`: plugin-backed document, slide, and spreadsheet workflows when available.

## Frontend, Browser, And Testing

- `frontend-design`: create distinctive production-grade frontend interfaces.
- `develop-web-game`: build and test web games.
- `webapp-testing`: browser-based local web app testing.
- `playwright`: automate a real browser from terminal.
- `browser` / `browser-use`: use the Codex in-app browser for local app inspection.
- `figma` / `figma-implement-design`: fetch Figma context and implement designs.
- `screenshot`: take desktop or system screenshots.

## Data And Analytics

These are plugin-provided routes when the Data Analytics plugin is available in the current session.

- `data-analytics:index`: route source-backed analytics work.
- `data-analytics:build-dashboard`: build dashboards.
- `data-analytics:build-report`: build analytical reports.
- `data-analytics:design-kpis`: design KPI frameworks.
- `data-analytics:kpi-reporting`: produce KPI updates and scorecards.
- `data-analytics:metric-diagnostics`: diagnose metric changes.
- `data-analytics:product-business-analysis`: analyze product/business data.
- `data-analytics:market-sizing`: estimate market size.
- `data-analytics:visualize-data`: design quantitative visuals.

## Images And Visuals

- `imagegen` / `gpt-image`: generate or edit raster images.
- `image-enhancer`: enhance screenshots or images.
- `nature-figure`: academic figure workflow.

## Engineering And Tooling

- `modern-python`: configure Python projects with uv, ruff, and ty.
- `mcp-builder`: create high-quality MCP servers.
- `plugin-creator`: create Codex plugins.
- `cli-anything`: build or test CLI-Anything harnesses.
- `cli-hub-meta-skill`: discover agent-native CLIs.
- `second-opinion`: run external Codex/Gemini code reviews.
- `openai-docs`: answer OpenAI product/API questions with official docs.

## Superpower Development Workflows

These are installed as low-conflict individual skills from the Codex Superpower pack. `superpower-bootstrap` was intentionally not installed because it tries to run at the start of every conversation and overlaps with `zongguan-skill`.

- `superpower-brainstorming`: clarify and shape creative/product/code ideas before implementation.
- `superpower-writing-plans`: write implementation plans before multi-step coding work.
- `superpower-executing-plans`: execute an existing plan with checkpoints.
- `superpower-debugging`: investigate bugs and test failures systematically before fixing.
- `superpower-tdd`: use test-driven development for features or bugfixes.
- `superpower-verification`: verify evidence before claiming completion.
- `superpower-review`: request code review before finishing substantial work.
- `superpower-receiving-code-review`: process code review feedback rigorously.
- `superpower-git-worktrees`: isolate feature work in git worktrees.
- `superpower-finish`: finish a development branch with merge/PR/cleanup options.
- `superpower-dispatching-parallel`: dispatch independent work domains in parallel when multi-agent tools are available.
- `superpower-subagents`: subagent-driven implementation when multi-agent tools are available.
- `superpower-writing-skills`: create or improve process skills with testing.

## Obsidian And Knowledge Work

- `obsidian`: work with Obsidian vaults, notes, backlinks, and MOCs.
- `generate-mocs`: regenerate Obsidian directory/navigation pages.
- `daily-papers-*`: paper recommendation and note pipeline.

## Perspective Skills

Use these only when the user asks for a specific person's lens or clearly invokes their named model. Do not route to a perspective skill unless it appears in the live available-skill list.

- `feynman-perspective`
- `munger-perspective`
- `andrej-karpathy-perspective`
- `shipbuilding-grandmasters-framework`

## Common Routes

- "帮我读这篇论文并写笔记" -> `paper-reading` or `paper-reader`; add `obsidian` if notes must go into a vault.
- "润色这段论文英文" -> `awesome-ai-research-writing`; use `research-paper-writing` for section-level or full-paper restructuring.
- "Nature风格润色/图/数据可用性" -> `nature-polishing`, `nature-figure`, or `nature-data`.
- "根据真实项目写本科论文定稿" -> `academic-paper-strategist` -> `academic-paper-composer` -> `docx`.
- "做PPT" -> `pptx`; if from a Nature paper, use `nature-paper2ppt`.
- "处理Excel" -> `xlsx`.
- "处理PDF" -> `pdf`, unless the content is specifically a paper, then start with `paper-reading`.
- "做网页/游戏并验证" -> `frontend-design` or `develop-web-game` -> `webapp-testing` or `browser`.
- "从Figma实现页面" -> `figma` -> `figma-implement-design` -> browser verification.
- "装/造/优化skill" -> `skill-installer`, `skill-creator`, or `darwin-skill`.

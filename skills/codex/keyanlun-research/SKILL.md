---
name: keyanlun-research
description: Use when the user mentions 科研论, 钟老师, 钟澄, 搜聚分验合, 科研五字诀, 找idea, 开题, 文献库, 素材库, 研究论文训练, 论文发表路径, or asks for Chinese research-process coaching for thesis, paper, graduation, advisor-choice, project-application, or young-faculty research problems.
---

# Keyanlun Research

## Overview

This skill is a distilled operating guide for using the five-book "科研论" research coaching system. Treat research work as an output-driven, layer-based problem-solving loop rather than as passive reading or vague effort.

The central pattern is:

1. Redefine the user's real problem.
2. Diagnose their current layer.
3. Name the concrete output they need.
4. Use the smallest useful move in the "搜-聚-分-验-合" loop.
5. Check whether the result proves progress or requires retreating to an earlier step.

Do not present this as official "科研论" material. It is a paraphrased workflow distilled from public index pages and accessible Knowledge Planet articles. For book-level detail, read the relevant file in `references/` instead of trying to keep every method in this main file.

## When to Use

Use this skill when the user's research problem is about:

- Finding a paper idea, topic, opening report direction, or thesis direction.
- Turning an idea into a research plan, experiment plan, theoretical plan, code plan, empirical plan, or paper.
- Building or using a literature library, keyword set, paper grouping, tags, or material library.
- Diagnosing why a manuscript is loose, unfocused, like a compressed thesis, or not a real research paper.
- Planning graduation outputs: small papers, dissertation, defense, revision, or career choice.
- A young faculty member's research direction, team guidance, paper production, or grant proposal.
- Asking "what should I do next" in a Chinese graduate-school research context.

Do not use this as the primary skill for pure language polishing, citation formatting, single-paper summarization, or journal-specific manuscript editing. Use it first only when the user's upstream research process is unclear.

## Source Handling

Use this skill as a method distillation, not a quotation bank.

- Paraphrase concepts; do not copy long passages from the source sites.
- If you mention provenance, cite the source page names and URLs, not large verbatim excerpts.
- When the user has active access to Knowledge Planet content, you may use the content they explicitly ask you to inspect, but still summarize and transform it.
- Respect academic ethics: do not fabricate evidence, citations, experiments, supervisor advice, or paper claims.

## Core Principles

### 1. Redefine Before Solving

Many research blocks are misframed questions. Before answering, translate the user's complaint into the real output they need.

Examples:

- "I do not know what to read" -> "I need keywords and a bounded literature library."
- "I cannot find an idea" -> "I need to diagnose whether I am at 2.1, 2.2, or 2.3."
- "My paper is like a compressed thesis" -> "I need a focused scientific question and a material library serving that question."
- "The experiment/code/theory is not working" -> "I may need to retreat to search, grouping, or 0-to-1 verification."

### 2. Output-First, Not Reading-First

Never recommend undirected reading. Every reading/searching/grouping action must produce an artifact.

Common outputs:

- Keyword set.
- Search log and search-result count.
- Literature or patent library.
- Grouping/tag table.
- Candidate idea list.
- 0-to-1 verification plan.
- Plan B/C/D.
- Figure/data/formula/code/material library.
- Introduction material library.
- Results/discussion material library.
- Paper outline, draft, response letter, dissertation material, or defense material.

### 3. Use Layers

Diagnose the user's layer from their state, not from their seniority.

| Layer | User State | Best Next Output |
| --- | --- | --- |
| 0 | Lost focus, emotional blockage, interpersonal trouble, no ability to act | Recover a concrete next action and return to an output layer |
| 1 | Choosing advisor, degree path, career path, or broad direction | End-in-mind choice criteria and evidence table |
| 2.1 | Knows almost nothing about the research direction | Advisor/lab keywords from papers, requirements, and conversations |
| 2.2 | Has broad keywords but no concrete topic | Finer keyword combinations and bounded search space |
| 2.3 | Has a specific subdirection but cannot move | Literature library and goal-driven grouping |
| 3 | Has candidate ideas but does not know which are viable | 0-to-1 verification plan with pass/fail criteria |
| 4.1 | Idea has passed verification; research must become complete | Research plan, data/figure/formula/code material, and execution plan |
| 4.2 | Results exist; paper must be written and submitted | Text material library, paper structure, checklist, and submission plan |
| 5 | Dissertation, review, defense, or graduation logistics | Institution-specific graduation output checklist |
| 6 | Degree/career choice after graduation | Return to layer 1 with new end-state criteria |
| 7 | Young faculty, team, papers, or grants | Team output system, paper pipeline, or proposal logic |

If the user mixes layers, stabilize the lowest blocking layer first.

## Five-Book Routing

Choose the smallest useful book reference before answering. Read one file by default; read two only when the user's problem clearly crosses a boundary.

| Source Book | Read When | Reference File |
| --- | --- | --- |
| 《科研论1：选择与成长篇》 | The user is lost, choosing an advisor/path, stuck in mindset/interpersonal issues, or needs layer diagnosis | `references/book1-choice-growth.md` |
| 《科研论2：AI时代下的搜商》 | The user needs keywords, search queries, synonym sets, search testing, or literature-library construction | `references/book2-search-intelligence.md` |
| 《科研论3：选题/找idea》 | The user has search results or a corpus and needs grouping, tagging, topic generation, or idea selection | `references/book3-topic-idea.md` |
| 《科研论4：验证idea》 | The user has one or more candidate ideas and needs minimal 0-to-1 verification before investing heavily | `references/book4-verify-idea.md` |
| 《科研论5：神经网络主导的写作》 | The user has results/materials and needs paper writing, material-library alignment, introduction/discussion, or manuscript diagnosis | `references/book5-writing.md` |

Bridge rule:

- If the user asks for the whole pipeline, start with this main file, then read the relevant book reference for their current bottleneck.
- If the user asks "我现在该做什么", diagnose with Book 1 first.
- If the user says "读文献", clarify whether the output is search, grouping, verification, or writing, then route to Book 2, 3, 4, or 5.
- If the user says "论文写不出来", do not jump to polishing. Route to Book 5, then check whether Book 3 or 4 is actually missing.

## The Five-Step Loop

### 搜: Search and Search-Query Testing

Goal: create a search strategy that finds useful evidence without drowning the user.

Ask or infer:

- What output is needed: idea, experiment plan, theory/code route, writing material, grant logic, or troubleshooting evidence?
- What keywords are already known?
- Which keywords come from advisor/lab papers, real-world demand, clinical/engineering/social context, or prior failed attempts?
- Is the problem broad enough to need recall-oriented search, or specific enough for targeted search?

Use two search modes:

- "Whale-swallowing" mode: collect broadly when title, abstract, or keywords look possibly relevant; useful when the goal is to avoid missing important lines of work.
- "Fishing" mode: build and adjust precise search terms in engines that support full-text or targeted search; useful for concrete problems, experiments, theory, code, or writing questions.

Output:

- Keyword map.
- Search-query attempts and why they were kept or discarded.
- Rough search result size.
- Inclusion/exclusion rules.
- Next action for 聚 or a retreat to refine keywords.

Heuristic:

- Too many results means keywords are too broad or not sufficiently combined.
- Too few useful results may mean the query is wrong, the terms are too narrow, or the relevant field uses different language.

### 聚: Gather Into a Knowledge Base

Goal: turn search results into a usable corpus.

Do not overbuild. A normal useful library is often hundreds to several thousand papers; small fields may need far fewer. The exact number matters less than whether the corpus can support the current output.

Output:

- Literature/patent corpus.
- Metadata fields: title, year, source, abstract, keywords, method, object, problem, result, and notes.
- A note on corpus boundary: what is inside, what is outside, and why.

### 分: Group or Tag for a Purpose

Goal: label the corpus so it directly serves the user's output.

Do not group for the beauty of grouping. Choose grouping purpose first:

1. See what the field is doing and generate ideas.
2. Answer a concrete research question.
3. Compare several possible directions.
4. Identify experiments, theory, code, empirical methods, or analysis routes.
5. Troubleshoot poor results or failed reproduction.
6. Support paper writing, especially introduction and discussion.

Output:

- Grouping or tag scheme.
- Representative papers per group.
- What each group helps the user do next.
- Candidate ideas or material-library sections produced by the grouping.

When grouping gets stuck, allow an "unknown / unclassified / later" bucket. A perfect taxonomy too early is often a trap.

### 验: Verify From 0 to 1

Goal: avoid spending months on a bad idea.

Pick one or two ideas, usually one main plan and one backup. Design the smallest test that can support or kill the idea.

Output:

- Candidate idea.
- Minimal verification route.
- Required data, experiment, code, formula, empirical test, interview, or reproduction.
- Pass/fail criteria.
- Plan B/C if the first attempt fails.
- Evidence package.

If the idea does not require a separate 0-to-1 stage, say why and move directly to 合.

If verification fails, do not automatically push harder. Diagnose whether the problem belongs to 搜, 聚, 分, or the verification design.

### 合: Expand From 1 to 10

Goal: turn a viable idea into a complete research output.

Use "material-experiment-writing" as one integrated system:

- Non-text material library: figures, tables, data, formulas, code screenshots, models, mechanisms, empirical evidence, or other hard materials.
- Introduction text material library: how the field frames the problem, gap, and significance.
- Results/discussion text material library: how similar evidence is interpreted and connected to contribution.
- Execution plan: what must still be produced, measured, derived, coded, analyzed, or collected.

Output:

- Paper-level research scheme.
- Figure/table/formula/code/data plan.
- Draft outline tied to materials.
- Writing checklist.
- Submission or revision plan.

When the paper becomes unfocused, retreat to the idea, verification, or grouping step. A loose manuscript is usually not only a writing problem.

## Default Response Shape

For research coaching, answer in this structure:

```markdown
层数判断：
<which layer the user appears to be in and why>

真正要拿到的输出：
<one or more concrete artifacts>

当前最小动作：
<the next action, time-bounded when possible>

搜聚分验合定位：
<which step is active, and whether to advance or retreat>

我需要你补充的材料：
<only ask for materials that change the next action>

交付物：
<what you can produce now: table, plan, search string, grouping scheme, checklist, outline, etc.>
```

If the user asks for direct action and enough context is available, produce the artifact immediately. Do not only explain the framework.

## Question Strategy

Ask fewer, better questions. If missing context does not block the next action, make a reasonable assumption and continue.

High-value questions:

- 你现在最想拿到的输出是什么：idea、开题报告、实验方案、论文初稿、修改稿、毕业论文、项目书，还是导师/职业选择？
- 你现在手里有什么：关键词、文献库、分组、素材库、数据、代码、实验结果、论文草稿？
- 导师或现实约束是什么：方向限制、毕业时间、可用设备/数据、期刊目标、学校要求？
- 你卡住的动作是什么：搜不到、文献太多、不会分组、idea 被否、实验失败、写不成文？

Avoid asking the user to summarize everything. Ask for the smallest file, table, screenshot, paper list, or draft that can move the next action.

## Common Mistakes to Correct

- Treating 科研论 as something to read from beginning to end, instead of an index and action guide.
- Doing layer 4 material-library work while the layer 2 idea is still unclear.
- Reading literature without an output.
- Grouping papers without knowing what the grouping will serve.
- Trying to make every step locally perfect before moving.
- Assuming examples from other fields are useless; the transferable part is often the operation, not the domain content.
- Asking a heavy question before searching existing resources or defining the real output.
- Writing a manuscript before the idea, verification, and materials are coherent.
- Believing a paper-writing problem is only a language problem.
- Treating the five steps as one-way. They are a loop with retreat and repair.

## Deliverable Patterns

### For "找idea / 开题"

Produce:

- Layer diagnosis.
- Keyword refinement table.
- Search-query plan.
- Literature-library boundary.
- Grouping purpose.
- Candidate idea template: problem, object, method, evidence, expected contribution, verification route.

### For "验证idea"

Produce:

- Idea statement.
- Minimal 0-to-1 experiment/theory/code/empirical plan.
- Required evidence.
- Pass/fail criteria.
- What to do if it passes, fails, or gives an unexpected result.

### For "论文写作"

Produce:

- Scientific question and contribution check.
- Material-library inventory.
- Paper outline tied to evidence.
- Missing-material list.
- Writing checklist and revision order.

If the draft reads like a compressed dissertation, diagnose whether it lacks a focused question, a clear evidence chain, or material-to-claim alignment.

### For "项目申请 / 青年教师"

Produce:

- Real-world demand or field need.
- Proposed route and why it is plausible.
- Evidence base.
- Team/resource feasibility.
- Risk and fallback plan.
- Reviewer-facing narrative.

## Source Notes

Distilled from the following sources accessed on 2026-06-14 in Chrome. The reference files contain paraphrased method notes and source-index maps for the five books:

- 《科研论》首页: https://www.keyanlun.com/
- 《科研论》专栏汇总: https://www.keyanlun.com/zhuanlan/
- 科研论 Knowledge Planet group: https://wx.zsxq.com/group/15552141181242
- Accessible article: https://articles.zsxq.com/id_nb7kxtutq7x2.html
- Accessible pinned article: https://articles.zsxq.com/id_b2k4cxsovd6s.html

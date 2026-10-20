---
name: decision-planning-frameworks
description: Use when the user asks for structured decision support, 根因分析, 5Why, SWOT, 利弊分析, 决策树, 情景规划, OKR,目标规划, career/project choice, risk tradeoff, or turning a vague goal into measurable next actions. This skill selects the smallest useful planning framework and produces decision-ready outputs instead of generic advice.
---

# Decision Planning Frameworks

Use this skill when the user needs to think through a choice, diagnose a problem, plan a goal, or convert uncertainty into actions. The job is to select the right framework, not to apply every framework.

## Source Basis

This skill was distilled from the user's archived framework notes in `C:\Users\Lenovo\Desktop\归档\06.决策与规划`.

Do not load these source files unless the user asks to compare against the archive.

## Framework Selection

| User Need | Primary Framework | Output |
| --- | --- | --- |
| "为什么会这样", repeated failure, debugging a non-code process | 5Why | Root cause chain + prevention |
| Choosing between options with uncertain outcomes | Decision tree | Options, probabilities, expected value, risk notes |
| Strategic position, strengths/weaknesses/opportunities/threats | SWOT | Four-quadrant diagnosis + strategy |
| Simple tradeoff without enough data for probability math | Pros/cons weighted matrix | Weighted comparison + recommendation |
| Future uncertainty and resilience planning | Scenario planning | 3-4 scenarios + triggers + robust strategy |
| Goal setting and execution | OKR | Objectives, key results, weekly actions |
| Content/product value diagnosis | Four-dimensional value model | Information/emotion/identity/action value audit |

If the user's motivation is vague, ask one concise question about the real decision or desired outcome. If enough context exists, proceed with stated assumptions.

## Operating Principles

- Start from the user's actual objective. Watch for XY problems.
- Separate facts, assumptions, and preferences.
- Prefer a smaller framework over a large blended template.
- Do not pretend probabilities or payoffs are known. Mark them as assumptions when estimated.
- A decision output must end with concrete next actions or a clear reason why action is premature.

## Output Templates

### 5Why Root Cause

```markdown
## 问题描述

## 5Why 追问链

| 层级 | 原因 | 证据 | 仍需验证 |
| --- | --- | --- | --- |

## 根因判断

## 解决方案

## 预防机制
```

Stop only when the cause is actionable. Avoid stopping at "人不认真", "资源不够", or "外部环境不好"; ask why that condition existed.

### Decision Tree

```markdown
## 决策问题

## 选项与假设

## 期望值/风险对比

| 方案 | 可能结果 | 概率 | 收益/代价 | 加权结果 | 关键假设 |
| --- | --- | --- | --- | --- | --- |

## 敏感性分析

## 推荐

## 下一步
```

If probabilities are weak, say so and downweight the numerical recommendation.

### Scenario Planning

```markdown
## 规划主题

## 关键驱动因素

## 三个情景

| 情景 | 核心假设 | 机会 | 风险 | 触发信号 |
| --- | --- | --- | --- | --- |

## 鲁棒策略

## 监控指标

## 近期行动
```

### OKR Planning

```markdown
## 周期

## Objective

## Key Results

| KR | 当前值 | 目标值 | 衡量方式 | 截止时间 |
| --- | --- | --- | --- | --- |

## 本周行动

## 风险与依赖

## 复盘机制
```

Each Objective should have 2-5 measurable KRs. If the user gives vague goals, convert them into observable outcomes.

## Completion Criteria

Before final response:

- Name the selected framework.
- State the user's real objective or your assumption about it.
- Separate known facts from assumptions.
- Provide an actionable recommendation, next step, or verification path.
- If the problem is under-specified, identify the minimum missing information.

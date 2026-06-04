---
name: xuzilong-academic
description: Use when working in Xu Zilong academic projects with Data/Program/Results/Manuscripts/Submissions and needing stable interfaces between generated results, hand-edited manuscript inserts, and submission artifacts.
---

# xuzilong 学术工作流总控

## 1) 触发条件
命中以下任一条件即触发：

1. 项目结构符合 `Data/Program/Results/Manuscripts/Submissions`。
2. 任务涉及清洗、估计、结果导出、稿件联动、投稿打包任一环节。

## 2) 目标
保持以下闭环：

`Program -> Results -> Manuscripts -> Submissions`

并保证：

1. 接口稳定。
2. 路径清晰。
3. clean/analysis 阶段可复现并可审计。
4. 稿件数字遵循唯一真相源。
5. 交付边界明确。

## 3) 层级地图
1. `Data/Raw`：原始快照，不覆盖。
2. `Data/Interim`：中间数据。
3. `Data/Final`：分析输入真源。
4. `Program/Clean`：稳定清洗脚本层；`temp/` 为可追踪探索层，`discarded/` 为不追踪废弃层。
5. `Program/Analysis`：稳定分析脚本层；`temp/` 为可追踪探索层，`discarded/` 为不追踪废弃层。
6. `Results/tab`：脚本生成的原始表格 `tex` 接口。
7. `Results/fig`：脚本生成的原始图形 `pdf + wrapper tex` 接口。
8. `Results/temp`：跨脚本汇总证据与附加运行日志层；允许 git 追踪，但不是 clean/analysis 的脚本绑定强制产物层。
9. `Results/*Edited*`：作者手动整理后的稿件插入版本；属于手工维护层，不是脚本默认输出层。
10. `Manuscripts`：主稿层，消费 `Results` 标准接口或明确声明的 `Edited` 插入层。
11. `Submissions`：自包含提交包。
12. `Tasks`：仅在用户显式调用 `$xuzilong-task-tracking` 时启用；本 skill 不自动管理 `Tasks/`。

## 4) 路由规则
1. 数据口径变化：读取 `data-rules` 与 `program-clean-rules`。
2. 模型或回归变化：读取 `program-analysis-rules` 与 `results-rules`。
3. 仅文稿表达变化：读取 `manuscript-rules`。
4. 若命中写作模板任务：按 `manuscript-rules` 路由，并调用 `references/prompt-library.md` 的具体模板。
5. 投稿打包：读取 `submissions-rules`。
6. 期刊模板写作：先调用 `xuzilong-journal-style`，再回本 skill 执行整体约束。
7. 若用户显式调用 `$xuzilong-task-tracking`，则由该 skill 负责 `Tasks/` 的记录、更新与归档；本 skill 不自动启用 `Tasks`。
8. 若任务涉及 `Edited` 文件，先判断它是“稿件插入层”还是“脚本原始层”的替代物；默认按“稿件插入层”处理。
9. 若同时修改脚本、结果和稿件，必须先确认 raw result 与 `Edited` 的边界，再动文件。
10. 若任务包含探索性试错，默认先在从 `main` 派生的 worktree 分支中进行，再决定是否晋升到正式层。
11. clean/analysis 的中间产物必须按脚本绑定规则写入 `Program/*/temp/`，不得默认写入 `Results/temp/` 作为替代。
12. 默认读取 `Tasks/outline.md`（若存在）作为研究思路上下文；该读取不依赖是否调用 `$xuzilong-task-tracking`。
13. 在未显式调用 `$xuzilong-task-tracking` 时，本 skill 对 `Tasks/outline.md` 仅可读，不得创建、修改、重排或归档。

## 5) 端到端流程
1. 明确目标与验收标准，并先区分产物属于“探索层”“脚本生成层”还是“手工 `Edited` 层”。
2. 识别受影响层；若任务包含探索性试错，默认先在从 `main` 派生的长期保留 worktree 分支中进行。
3. 探索脚本写入 `Program/*/temp/`；clean/analysis 的脚本绑定中间产物必须写入对应 `Program/Clean/temp/` 或 `Program/Analysis/temp/`；跨脚本汇总证据可额外写入 `Results/temp/`。
4. 若探索结果稳定，不得直接把 `temp` 产物当正式接口；必须先将稳定逻辑提纯并迁移到正式 `Program` 层，再刷新 raw `Results/tab` 或 raw `Results/fig`。
5. 若改动仅影响稿件插入表现，可直接改 `Edited` 与 `Manuscripts`，但不得反向要求脚本覆盖 `Edited`。
6. 生成或更新标准接口产物。
7. 运行质量门禁。
8. 交付时说明修改范围、产物路径、复现入口，以及 `temp`/`discarded`/raw/`Edited` 的同步边界。

## 6) Edited 文件约定
1. `Edited` 表示作者手动修改后的最终插入版本，常用于小数位、标题、注释、列顺序、LaTeX 包装、手工高亮等稿件表达调整。
2. 与 `Edited` 对应的非 `Edited` 文件，表示脚本生成的原始可复现接口。
3. 默认关系是：`Program -> raw Results -> Edited -> Manuscripts`。
4. `Edited` 可以与 raw result 内容不同；两者不要求自动一致，也不应由脚本强制覆盖。
5. 若稿件当前引用 `Edited`，必须把它视为手工维护层；脚本修改只应保证 upstream raw result 正确，不得默认重写 `Edited`。

## 7) clean/analysis 强制工序（硬阻断）
1. 本节仅覆盖 `clean` 与 `analysis` 两阶段；不扩展到 `manuscript` 与 `submission`。
2. `clean` 脚本最小必备产物（缺一不可）：
   - `Program/Clean/temp/<ScriptName>-codebook.md`
   - `Program/Clean/temp/<ScriptName>-desc_stats.csv`
3. `analysis` 脚本最小必备产物（缺一不可）：
   - `Program/Analysis/temp/<ScriptName>.md`
   - `Program/Analysis/temp/<ScriptName>-repro_log.md`
4. `<ScriptName>` 必须等于“脚本文件名去扩展名”，且区分大小写。
5. 中间产物采用固定文件名覆盖策略，仅保留最新版本，不做时间戳多版本。
6. 若任一脚本缺任一必备产物，该脚本状态必须标记为 `blocked`。
7. 出现 `blocked` 时，不得宣告阶段完成，不得给出“可交付/可提交”结论。

## 8) 唯一真相源（Single Source of Truth）
1. 稿件中的数值结论必须来自结果接口文件，不得来自手工抄写或对话中转。
2. clean/analysis 对应稿件数字的上游接口，默认以对应脚本产物为准，尤其 `Program/Analysis/temp/<ScriptName>.md` 及其 raw results 来源。
3. 交付前必须执行“稿件数字 vs 结果接口”一致性核查。
4. 一致性核查结论必须写入对应 `Program/Analysis/temp/<ScriptName>-repro_log.md`。
5. 若一致性核查失败，脚本状态必须为 `blocked`，任务不得进入 `done`。

## 9) 与 xuzilong-task-tracking 的握手协议（YAML）
1. academic 在阶段更新时输出结构化 YAML 更新块；task-tracking 负责接收并落盘。
2. 更新块外层必填字段：
   - `task_id`
   - `task_status`（`in_progress` / `blocked` / `done`）
   - `scripts`（列表）
   - `updated_at`
3. `scripts[]` 每个元素必填字段：
   - `script_name`
   - `script_type`（`clean` / `analysis`）
   - `status`（`in_progress` / `blocked` / `done`）
   - `artifacts`（脚本产物路径列表）
   - `latest_result`
   - `acceptance_check`（至少包含 `result: pass|fail` 与 `reason`）
4. `task_status` 必须按脚本状态严格聚合：
   - 任一脚本 `blocked` -> `task_status=blocked`
   - 全部脚本 `done` -> `task_status=done`
   - 其他情况 -> `task_status=in_progress`
5. 若字段缺失、状态非法或聚合不一致，更新块视为无效，不得宣告完成。
6. 推荐更新块模板：

```yaml
task_id: T20260317-001
task_status: in_progress
scripts:
  - script_name: Clean_firm
    script_type: clean
    status: done
    artifacts:
      - Program/Clean/temp/Clean_firm-codebook.md
      - Program/Clean/temp/Clean_firm-desc_stats.csv
    latest_result: 清洗完成，字段与口径通过检查
    acceptance_check:
      result: pass
      reason: 必备产物齐全
  - script_name: BaselineEstimates
    script_type: analysis
    status: in_progress
    artifacts:
      - Program/Analysis/temp/BaselineEstimates.md
      - Program/Analysis/temp/BaselineEstimates-repro_log.md
    latest_result: 基准回归已重跑，待一致性核查
    acceptance_check:
      result: pass
      reason: 当前阶段检查通过
updated_at: 2026-03-17T12:00:00+08:00
```

## 10) 约束
1. `Analysis` 输入必须来自 `Data/Final`。
2. `Program/Analysis` 负责生成 raw `Results/tab` 与 raw `Results/fig`。
3. `Manuscripts` 不直接消费 `Results/temp`。
4. 脚本不得默认写入、复制、覆盖、`replace` 任何 `*Edited*` 文件，除非用户明确要求改变接口设计。
5. 工具脚本或后处理脚本不得把 `Edited` 设为默认输入或默认输出，除非用户明确指定手工层为主要工作对象。
6. 若现有脚本已写入 `Edited`，视为接口耦合问题，修复时应改回只写 raw result。
7. `Results` 标准命名必须为 `tab1` 或 `fig1`，且 `label` 与文件名主干同名。
8. 不得因为稿件当前插入 `Edited`，就把脚本输出路径重定向到 `Edited`。
9. `temp` 是可追踪探索层；`discarded` 是不追踪废弃层，且不得被任何脚本默认引用。
10. `main` 不得直接接收 `temp` 作为正式接口；进入 `main` 前必须完成 `temp -> 正式脚本 -> raw Results` 的晋升。
11. `Results/temp` 可在探索分支内长期保留，但 `Manuscripts` 与 `Submissions` 永不消费它。
12. `Data/*` 不作为探索归档层；分析真源仍只认 `Data/Final`。
13. clean/analysis 的脚本绑定日志必须写入 `Program/Analysis/temp/<ScriptName>-repro_log.md`，不得用 `Results/temp/` 替代该强制产物。
14. Stata 或其他工具生成的 `.log`、`.smcl`、诊断文本等日志类文件，不得写入项目根目录、`Manuscripts` 或 `Submissions`；默认写入 `Results/temp/` 或对应脚本 `temp/` 目录。

## 11) 文件类型政策
1. 核心估计必须在 Stata `.do` 中实现。
2. Python 或 R 仅用于预处理、描述统计、诊断。
3. 最终表格使用 `tex`，最终图形使用 `pdf + wrapper tex`。

## 12) 规则优先级
1. clean/analysis 强制工序（硬阻断）
2. 唯一真相源（Single Source of Truth）
3. 与 task-tracking 的握手协议
4. 约束
5. 文件类型政策
6. `prompt-library` 模板硬约束
7. `manuscript-rules`
8. 其他参考材料

## 13) 质量门禁
1. 可复现。
2. clean/analysis 脚本必备中间产物齐全、路径存在且为最新版本。
3. `task_status` 与脚本状态聚合一致，且不存在未解释的 `blocked`。
4. 稿件数字与结果接口一致；不存在手抄中转数字。
5. 生成逻辑与 raw 产物一致。
6. `Edited` 与脚本隔离，搜索中不存在默认写入/覆盖 `*Edited*` 的脚本路径。
7. 标签与命名一致。
8. 日志类文件未污染项目根目录、`Manuscripts` 或 `Submissions`。
9. 交付说明完整，并注明 `temp`/`discarded`/raw/`Edited` 的边界。

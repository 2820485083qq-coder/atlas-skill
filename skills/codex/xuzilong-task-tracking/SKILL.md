---
name: xuzilong-task-tracking
description: Use when the user explicitly invokes $xuzilong-task-tracking or explicitly asks to maintain Tasks/outline.md, Tasks/task-current.md, or task archives in Xu Zilong academic projects.
---

# xuzilong 任务跟踪

## 1) 触发条件
仅在以下情况触发：

1. 用户在对话中显式输入 `$xuzilong-task-tracking`。
2. 用户明确要求维护 `Tasks/outline.md`、`Tasks/task-current.md` 或任务归档记录。

未满足以上条件时，不启用本 skill。

## 2) 硬边界
本 skill 只负责 `Tasks/` 体系中的任务记录、状态更新与归档管理，不负责：

1. 研究设计判断。
2. `Program`、`Results`、`Manuscripts`、`Submissions` 的流程编排。
3. 清洗、估计、导出、写作等技术规则。
4. 在未显式调用时自动创建、更新或归档 `Tasks/` 内容。
5. 将 `outline.md` 当作任务总览面板使用；`outline.md` 默认仅记录文章 idea，不承担探索分支任务导航职责。
6. 重写或修正 `xuzilong-academic` 输出的脚本路径、命名规则、研究结论。
7. 阻止其他 skill 在未调用本 skill 时只读 `Tasks/outline.md` 获取研究背景。

即使任务涉及 `Program` 或 `Program -> Manuscripts` 联动，只要用户未显式调用 `$xuzilong-task-tracking`，就不得进入 `Tasks` 体系。

## 3) 目标
维护清晰、可追踪、可续接的分支内任务记录体系，确保：

1. 当前分支的任务目标明确。
2. 验收标准明确。
3. 最新进展可追溯。
4. 下一步动作明确。
5. 分支完成后的归档路径清晰。
6. 之后再次进入该探索分支时，能够快速恢复上下文。

## 4) 文件结构
标准结构如下：

1. `Tasks/outline.md`：文章 idea 总览；默认不承担探索分支任务索引职责。
2. `Tasks/task-current.md`：当前分支正在推进的单个活动任务。
3. `Tasks/archive/`：存放已完成、已冻结或已终止的任务快照；该层可在合适时合并回 `main`。

默认工作原则：

1. `task-current.md` 需要 git 追踪，但默认不作为合并回 `main` 的活动态文件。
2. `Tasks/archive/` 中的归档记录可作为最终任务记录合并回 `main`。

## 5) 预检流程
在任何任务记录动作前，必须先执行：

1. 确保 `Tasks/task-current.md` 与 `Tasks/archive/` 存在；缺失则创建。
2. 读取 `Tasks/task-current.md`。
3. 检查 `task-current.md` 是否具备必填字段。
4. 仅当用户明确要求维护文章 idea 时，才修改 `Tasks/outline.md`；未显式要求时不得写入该文件。
5. 若本轮输入包含 academic 的 YAML 更新块，先做协议校验再进入落盘。
6. 未完成预检，不进入正式任务更新。

## 5.5) CHECKPOINTS

1. STOP：写入或创建 `Tasks/` 文件前，必须确认当前项目确实是 Xu Zilong academic 项目。
2. STOP：归档或重置 `task-current.md` 前，必须向用户展示归档文件名和当前任务状态。
3. STOP：握手 YAML 校验失败时，不得继续更新状态字段；只允许记录解析失败。
4. STOP：用户未选择第 11 节的 A/B 决策前，不切换当前任务主体。

## 6) `task-current.md` 必填字段
`Tasks/task-current.md` 至少应包含以下字段：

1. `task_id`
2. `objective`
3. `acceptance_criteria`
4. `planned_outputs`
5. `current_status`
6. `latest_result`
7. `next_action`
8. `updated_at`

当任务绑定某个探索分支时，强烈建议补充：

1. `background`
2. `branch_name`
3. `worktree_path`
4. `promotion_targets`
5. `related_files`
6. `risks`

## 7) 与 xuzilong-academic 的握手协议（输入契约）
1. 仅接收 YAML 更新块作为结构化输入，不接收自由文本作为等价替代。
2. 外层必填字段：
   - `task_id`
   - `task_status`（`in_progress` / `blocked` / `done`）
   - `scripts`（列表）
   - `updated_at`
3. `scripts[]` 每个元素必填字段：
   - `script_name`（脚本文件名去扩展名，区分大小写）
   - `script_type`（`clean` / `analysis`）
   - `status`（`in_progress` / `blocked` / `done`）
   - `artifacts`（路径列表）
   - `latest_result`
   - `acceptance_check`（至少包含 `result` 与 `reason`）
4. `task_status` 必须满足严格聚合：
   - 任一脚本 `blocked` -> `task_status=blocked`
   - 全部脚本 `done` -> `task_status=done`
   - 其他情况 -> `task_status=in_progress`
5. 协议校验失败（字段缺失、状态非法、聚合不一致）时：
   - 记录失败原因；
   - 不得把任务升级为 `done`；
   - 不得伪造或补写脚本结论。

## 8) 落盘规则（append-only）
1. 对有效 YAML 更新块，必须原样追加写入 `Tasks/task-current.md` 文件末尾。
2. 追加时应保留时间顺序，不覆盖历史更新块。
3. 本 skill 仅负责记录与状态同步，不改变脚本路径命名策略。
4. 若更新块无效，仍可追加一条“解析失败记录”，但不得覆盖上一条有效记录。
5. 若更新块有效，可同步刷新 `current_status` 与 `updated_at`；`latest_result` 只能做摘录，不得改写其技术含义。

## 9) 更新流程
每一轮出现实质进展后，应更新 `task-current.md`：

1. 更新 `current_status`。
2. 更新 `latest_result`，写明本轮被保留的有效结果或有效判断。
3. 更新 `planned_outputs` 的完成情况。
4. 对照 `acceptance_criteria` 标明已满足与未满足项。
5. 更新 `next_action`。
6. 更新 `updated_at`。
7. 若本轮来自 academic 握手块，优先执行第 7-8 节协议校验与追加落盘。
8. 若任务绑定探索分支，应同步更新 `related_files`、`promotion_targets` 或分支相关信息。

如果本轮仅讨论、尚无实质推进，可以补充状态说明，但不得伪造完成项。

## 10) 归档流程
当当前任务完成、终止、冻结或准备结束当前分支阶段时，应执行：

1. 将 `task-current.md` 内容冻结到 `Tasks/archive/.md`。
2. 如有需要，清理或重置当前分支内的 `task-current.md`，为下一任务预留位置。
3. 若该探索分支的结果需要回到 `main`，默认优先合并 `Tasks/archive/` 中的归档文件，而不是活动态 `task-current.md`。

若任务中止，也应归档，并明确写出中止原因与未完成项。

## 11) 交付决策
每轮交付达到阶段终点后，必须向用户发出二选一决策：

1. A：归档当前任务，并准备新任务。
2. B：保留当前任务，更新 `task-current.md` 后继续推进。

未收到用户选择前，不自动切换到新的任务主体。

## 12) 书写要求
任务记录必须满足：

1. 语言简洁，避免空话。
2. 结论先行，状态明确。
3. 路径、产物、下一步都可执行。
4. 不把研究内容判断写成任务状态。
5. 不把任务文档写成流水账。

## 13) 内部优先级
本 skill 的优先级仅限 `Tasks/` 体系内部：

1. 触发条件
2. 硬边界
3. 预检流程
4. 与 academic 的握手协议（输入契约）
5. 落盘规则（append-only）
6. 必填字段
7. 更新流程
8. 归档流程
9. 交付决策

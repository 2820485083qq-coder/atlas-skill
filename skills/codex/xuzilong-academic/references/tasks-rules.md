# tasks-rules

## Scope
仅适用于 `SKILL.md` 的 Task Tracking Scope 命中任务。

## Must
1. `Tasks/task-current.md` 与 `Tasks/archive/` 存在。
2. 每个分支仅维护一个 `active_task`。
3. 每次 effective_run 更新 `task-current.latest_result`。
4. 仅当用户选择归档时，将 `task-current` 的最终快照写入 `Tasks/archive/`。
5. 交付时必须询问 A/B（归档或继续）。
6. 若任务绑定探索分支，`task-current` 应尽量记录 `branch_name`、`worktree_path`、`related_files` 与 `promotion_targets`。

## Must Not
1. 不得把过程流水写入 `Tasks/archive/`。
2. 不得并行维护多个 `active_task`。
3. 不得默认将活动态 `task-current.md` 合并回 `main`。
4. 不得跳过 A/B 决策直接进入下一轮。

## Minimal Task-Current Fields
1. `task_id`
2. `objective`
3. `acceptance_criteria`
4. `planned_outputs`
5. `current_status`
6. `latest_result`
7. `next_action`
8. `updated_at`

## Recommended Branch Fields
1. `background`
2. `branch_name`
3. `worktree_path`
4. `related_files`
5. `promotion_targets`
6. `risks`

# task-state-glossary

## Terms
1. `active_task`：当前分支唯一活动任务，位于 `task-current.md`。
2. `latest_result`：当前任务最近一次被保留的有效结果快照；可指向探索脚本、探索结果目录或有效判断。
3. `archive`：将 `task-current.md` 的最终快照写入 `Tasks/archive/<task_id>.md`，并结束或冻结该任务。
4. `invalid_attempt`：口误、撤销或未被保留的错误尝试，不进入归档。
5. `effective_run`：产出被当前任务保留并服务后续判断、续接或晋升，需更新 `latest_result`。
6. `promotion_targets`：计划从探索层晋升到正式层并最终进入 `main` 的脚本、结果接口或交付产物。

## Field Rules
1. 字段用 `snake_case`。
2. 时间格式 `YYYY-MM-DD HH:MM`。
3. `current_status` 仅允许 `in_progress`、`on_hold`、`completed`、`archived`。

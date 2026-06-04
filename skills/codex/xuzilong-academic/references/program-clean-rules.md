# program-clean-rules

## Scope
1. 正式清洗脚本：`Program/Clean/`
2. 探索清洗脚本：`Program/Clean/temp/`
3. 废弃清洗脚本：`Program/Clean/discarded/`

## Must
1. 稳定清洗逻辑写入 `Program/Clean/`。
2. 探索性口径测试写入 `Program/Clean/temp/`。
3. 被明确放弃但暂存备查的脚本移入 `Program/Clean/discarded/`。
4. `temp` 允许 git 追踪；`discarded` 不纳入 git 追踪。
5. 清洗输出到 `Data/Interim` 或 `Data/Final`。
6. 脚本可重复运行。
7. 需要长期保留的探索证据优先写入 `Results/temp/`，而不是依赖 `Data/*` 留痕。
8. 若保留 Stata 或其他工具的运行日志，默认写入 `Results/temp/<topic>/logs/`。
9. effective_run 后更新 `task-current.latest_result`（仅 Tasks 范围内）。

## Must Not
1. 不得通过手工改数据替代脚本。
2. 不得写死不可移植绝对路径。
3. 不得把 `discarded` 作为任何正式或探索流程的默认输入。
4. 不得将 `.log`、`.smcl` 或类似日志类文件写入项目根目录、`Manuscripts` 或 `Submissions`。
5. 不得把过程流水提前写入 `Tasks/archive/`。

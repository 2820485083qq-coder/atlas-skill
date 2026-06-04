# data-rules

## Scope
Data/Raw、Data/Interim、Data/Final。

## Must
1. Raw 不覆盖。
2. 数据构建必须通过 Program/Clean 脚本。
3. Analysis 输入来自 Data/Final。
4. effective_run 后更新 task-current.latest_result（仅 Tasks 范围内）。

## Must Not
1. 不得手工改 Final 作为最终方案。
2. 不得把 Interim 当分析真源。
3. 不得在未归档时向 `Tasks/archive/` 写入过程记录。
4. 不得把 `Data/Interim`、临时抽样文件或其他 `Data/*` 中间文件当作探索存档层；需要长期保留的探索证据应优先保存在 `Results/temp/`。

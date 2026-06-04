# results-rules

## Scope
Results/tab、Results/fig、Results/temp、`Results/*Edited*`。

## Must
1. `ScriptName` 由分析脚本 `.do` 文件名主干确定（见 `program-analysis-rules.md`）。
2. 标准表接口指脚本生成的 raw result：`Results/tab/tab1.tex`；同脚本多表递增为 `tab2.tex`、`tab3.tex`。
3. 标准图接口指脚本生成的 raw result：`Results/fig/fig1.pdf + fig1.tex`；同脚本多图递增为 `fig2`、`fig3`。
4. label 与文件名主干完全同名（如：`\label{tab1BaselineEstimates}`、`\label{fig1BaselineEstimates}`）。
5. 分类语义（BaselineEstimates / SummaryStatistics / RC / HA / MA / Others）见 `program-analysis-rules.md`，不参与命名生成。
6. effective_run 后更新 `task-current.latest_result`（仅 Tasks 范围内）。
7. `Edited` 文件表示作者手工整理后的稿件插入层，不属于脚本默认输出接口。
8. 若同时存在 raw result 与 `Edited` 版本，默认关系为：`Program -> raw Results -> Edited -> Manuscripts`。
9. 若稿件引用 `Edited`，必须明确把它视为手工维护层；脚本修改只保证 raw result 正确，不默认同步覆盖 `Edited`。
10. `Results/temp/` 表示探索分支内可长期保留的中间结果、测试证据与运行日志层；可被 git 追踪，但不属于标准接口。
11. 日志类文件默认写入 `Results/temp/<topic>/logs/` 或其他与脚本主干对应的 `Results/temp/.../logs/` 目录。

## Must Not
1. 不得使用 `Results/temp` 作为稿件正式输入。
2. 不得在未归档时向 `Tasks/archive/` 写入过程条目。
3. 脚本不得默认写入、复制、覆盖、`replace` 任何 `*Edited*` 文件。
4. 工具脚本或后处理脚本不得把 `Edited` 设为默认输入或默认输出，除非用户明确指定手工层为主对象。
5. 不得因为稿件当前插入 `Edited`，就把标准结果接口重定向到 `Edited`。
6. 不得把 `Edited` 视为 raw result 的自动镜像。
7. 不得把 `Results/temp/` 视为可直接晋升到稿件或投稿层的正式接口；进入正式层前必须重新由稳定脚本导出 `Results/tab` 或 `Results/fig`。
8. 不得将 `.log`、`.smcl` 或类似日志类文件写入项目根目录、`Manuscripts` 或 `Submissions`。

## Template Routing
结果文件仅定义接口与命名规则；代码级导出模板统一放在 `program-analysis-rules.md`：

1. 若输出包含 table，必须使用 `program-analysis-rules.md` 的 table 模版。
2. 若输出包含 figure，必须使用 `program-analysis-rules.md` 的 figure 模版。

## Review Checklist
1. 当前脚本输出路径是否只指向 raw `Results/tab` 或 raw `Results/fig`。
2. 当前 `Edited` 文件是否被明确标注为手工维护层。
3. 搜索结果中是否不存在默认写入/覆盖 `*Edited*` 的脚本路径。
4. 稿件引用的是标准接口，或明确声明引用 `Edited` 插入层。
5. 日志类文件是否仅落在 `Results/temp/` 及其子目录中。

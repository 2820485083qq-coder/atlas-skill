# program-analysis-rules

## Scope
1. 设置类脚本：`Program/Analysis/Generalsetup.do`、`Program/Analysis/Generalsetup.do`、`Program/Analysis/Generalnotes.do` 等全局/主题共用设置文件。
2. 分析类脚本：`Program/Analysis/` 下的 `BaselineEstimates`、`RC`、`HA`、`MA`、`Others` 类脚本；每类可含多个具体脚本，命名为“类+主题”，比如 `HAFirmSize.do`、`RCAlternativeModels.do`。
3. 描述统计类脚本：`Program/Analysis/` 下的 `SummaryStatistics` 类脚本。
4. 探索类脚本：`Program/Analysis/temp/` 下的临时探索脚本，命名可更自由，但输出必须落在 `Results/temp/<topic>/`。
5. 废弃类脚本：`Program/Analysis/discarded/` 下的废弃探索脚本，仅本地备查；不纳入 git 追踪，也不得被任何正式流程引用。
6. 下文凡提到“核心估计”“回归命令”“回归表”“固定效应分组变量”“esttab 导出”等要求，仅约束分析类脚本，不强加给 `SummaryStatistics` 或 `temp/`。

## ScriptName Determination（强制）
1. `ScriptName` 必须由分析脚本 `.do` 文件名主干确定。
2. 示例：`BaselineEstimates.do -> ScriptName=BaselineEstimates`。
3. 不允许手动声明与脚本文件名不一致的 `ScriptName`。

## Must
1. 核心估计必须 Stata `.do`。
2. 结构必须含 Setup / Estimation / Export。
3. 生产输出写 `Results/tab` 与 `Results/fig`。
4. exploration 输出写 `Results/temp/<topic>/`。
5. effective_run 后更新 `task-current.latest_result`（仅 Tasks 范围内）。
6. 不同分析脚本的共用文件设置与通用数据处理，必须集中在 `Program/Analysis/Generalsetup.do` 或 `Program/Analysis/Generalsetup.do`，不得在各脚本重复散写。
7. 每个分析脚本的数据输入必须来自 `Data/Final/` 下的 `.csv` 或 `.dta` 文件。
8. 每个分析脚本执行顺序必须为：读取 `Data/Final/` 输入文件 -> `run Generalsetup` -> 脚本特有 setup -> Estimation -> Export。
9. 分析类脚本文件名必须使用 PascalCase 风格命名法，并据此确定唯一 `ScriptName`。
10. 结果文件命名必须使用 `tabN` 与 `figN` 体系（`N` 从 1 开始递增），且 `\label{}` 必须与结果文件主干完全同名。
11. 对多个分析脚本可能复用的变量构造、固定效应分组变量、通用变换、通用标签与通用样本口径，必须前置到 `Generalsetup.do` 或 `Generalsetup.do`。
12. 像 `egen fe_pref_cat = group(...)`、`egen fe_pref_year = group(...)`、`egen fe_cat_year = group(...)` 这类后续研究会重复使用的固定效应分组变量，必须视为 setup 层资产，不得散写在单个分析脚本主体中。
13. 分析类脚本的主题部分仅保留本回归特有的样本限制、估计命令、`estadd` / `esttab` 所需附加统计量与导出语句。
14. 分析类脚本的回归表导出必须使用 `esttab`；附加统计量必须通过 `estadd`、`stats()`、`scalars()` 等 `esttab` 兼容方式进入表格。
15. 稳定后需要进入正式接口的分析逻辑，必须从 `Program/Analysis/temp/` 提纯并迁移到 `Program/Analysis/`，不得让 `main` 直接依赖 `temp` 脚本。
16. `Program/Analysis/discarded/` 仅作为废弃脚本墓地，不承担任何接口职责。
17. 若保留 Stata 或其他工具的运行日志，默认写入 `Results/temp/<topic>/logs/`。
18. 只要使用 `reghdfe`，最终表格就必须先用 `estfe` 提取固定效应信息，再在 `esttab` 中用 `indicate()` 显式输出。
19. `reghdfe` 的 `indicate()` 必须与 `absorb()` 对应，至少报告主要固定效应；额外吸收项也应单列展示。
20. 若同一张表包含多个 `reghdfe` 规格，应先统一 `eststo`，再统一 `estfe`，最后集中 `esttab`。

## Must Not
1. 不得把核心回归外包 Python/R。
2. 不得让稿件接口依赖 `Results/temp`。
3. 不得只改生成 tex 不改脚本。
4. 分析类脚本不得使用 `display` 或 `di` 输出步骤提示、进度信息或 “STEP X” 类日志。
5. 分析类脚本不得使用 `capture which`、`_rc`、`if has_xxx` 等方式为核心估计命令编写存在性判断或 fallback 分支。
6. 分析类脚本不得因为命令缺失而在 `reghdfe`、`ivreghdfe`、`ppmlhdfe` 等核心估计命令与 `areg`、`reg` 等替代命令之间切换；缺命令时应直接报错并补齐环境。
7. 分析类脚本不得使用 `file open`、`file write`、`file close` 手写回归表 `tex`。
8. 不得从 `Program/Analysis/discarded/` 默认读取、`run` 或拼接任何逻辑。
9. 不得把 `Results/temp/` 的产物直接当作需要 merge 到 `main` 的正式结果接口。
10. 不得将 `.log`、`.smcl` 或类似日志类文件写入项目根目录、`Manuscripts` 或 `Submissions`。
11. 不得在使用 `reghdfe` 时只写 `absorb()` 而不在最终 `esttab` 中用 `indicate()` 报告固定效应。

## Setup Execution Order（强制）
```stata
* 1) 输入必须来自 Data/Final
import delimited "Data/Final/<file>.csv", clear
* 或
use "Data/Final/<file>.dta", clear

* 2) 先运行通用 setup（按主题可切换）
run "Program/Analysis/Generalsetup.do"
* 或 run "Program/Analysis/Generalsetup.do"
* 通用 setup 中应提前生成可复用变量与 FE 分组变量

* 3) 再写本脚本特有 setup
* e.g., keep if ... ; local/global for this analysis only
* 不要在这里重复生成其他脚本也会用到的 FE 分组变量

* 4) Estimation
* 5) Export
```

## Output Template Routing（强制）
1. 若本次输出包含 table，必须使用下方 Table Template。
2. 若本次输出包含 figure，必须使用下方 Figure Template。
3. 若同时包含 table 与 figure，必须同时应用两套模板。

## Table Template（当输出包含 table）
1. 文件命名：`Results/tab/tab1.tex`；若同一个脚本输出多张结果表：`Results/tab/tab2.tex`、`Results/tab/tab3.tex`。
2. label：`\label{tab1}`；若同一个脚本输出多张结果表：`\label{tab2}`、`\label{tab3}`。
3. 必须使用双 top rule：`\toprule\toprule`。
4. 必须使用 `adjustbox + threeparttable`。
5. 必须使用 `tablenotes`，并由 `Program/Analysis/Generalnotes.do` 的 globals 组成。
6. 分析类脚本的回归表必须由 `esttab` 直接导出，不得先算本地宏再用 `file write` 逐行拼接。
7. 若需展示固定效应、权重、聚类层级、因变量均值等附加信息，必须用 `estadd` 或 `esttab stats()` 注入。
8. 默认模板应优先提供跨回归脚本都稳定适用的通用行；权重或其他模型特有信息只在该脚本确有需要时再额外添加，不应写成默认模板的一部分。
9. 若回归命令为 `reghdfe`，必须在导表前统一 `estfe`，并在 `esttab` 中用 `indicate()` 输出固定效应行。

```stata
* Program/Analysis/Generalnotes.do
global note_sample "The sample consists of 279 cities in the 31 provinces in China from 2012 to 2022. "
global note_dep "The dependent variable is the logit transformation of the food insepection failure rate."
```

```stata
global caption ": "
#delimit ;
global head \begin{table}[!htp]
\centering
\caption{$caption}
\begin{adjustbox}{max width=\textwidth}
\begin{threeparttable}
\begin{tabular}{l*{5}{c}}
\toprule\toprule
Dependent Variable: &\multicolumn{5}{c}{} \\ [.1cm]\cmidrule(lr){2-6}
;
#delimit cr
run "Program/Analysis/Generalnotes.do"
global notes "\begin{tablenotes}\footnotesize{\item \textit{Note.} $note_sample $note_dep $note_MRI $note_ctrl $note_star $note_std }\end{tablenotes}"
eststo clear
esttab est1 est2 ///
using "Results/tab/tab1.tex", booktabs nonotes compress label ///
noobs nomtitles ///
cells(b(fmt(4) star) se(fmt(4) par)) ///
starlevels(* 0.10 ** 0.05 *** 0.01) collabels("",none) ///
prehead($head) ///
postfoot(\bottomrule\end{tabular}$notes\end{threeparttable}\end{adjustbox}\label{tab1}\end{table}) ///
width(\hsize) replace

* 若同脚本输出第二张表：
* using "Results/tab/tab2.tex"
* \label{tab2}
```

```stata
* Minimal pattern for reghdfe tables
qui reghdfe $Y $X, absorb(i.code i.year) cluster(province_code)
eststo est1
qui reghdfe $Y $X, absorb(i.code i.year i.province_code#c.year) cluster(province_code)
eststo est2
estfe est1 est2
esttab est1 est2 using "Results/tab/tab1.tex", ///
indicate("City FE = 0.code" ///
"Year FE = 0.year" ///
"Province Year Trend = 0.province_code#c.year") ///
replace
```

## Figure Template（当输出包含 figure）
1. 文件命名：
   - PDF：`Results/fig/fig1.pdf`（同一个脚本输出多张结果图依次 `fig2`、`fig3`）
   - Wrapper：`Results/fig/fig1.tex`（同一个脚本输出多张结果图依次 `fig2`、`fig3`）
2. label：`\label{fig1}`（与文件名主干一致）。
3. Wrapper 必须包含 `\caption{}` 与 note 文本区块。

```stata
local ScriptName "BaselineEstimates"

* export figure pdf
graph export "Results/fig/fig1`ScriptName'.pdf", replace

* write wrapper tex
file open fw using "Results/fig/fig1`ScriptName'.tex", write replace
file write fw "\begin{figure}[htbp]" _n
file write fw "\centering" _n
file write fw "\includegraphics[width=0.8\textwidth]{Results/fig/fig1`ScriptName'.pdf}" _n
file write fw "\caption{}" _n
file write fw "\label{fig1`ScriptName'}" _n
file write fw "\begin{minipage}{0.9\textwidth}" _n
file write fw "\small \textit{Notes:} " _n
file write fw "\end{minipage}" _n
file write fw "\end{figure}" _n
file close fw

* 若同脚本输出第二张图：
* graph export "Results/fig/fig2`ScriptName'.pdf", replace
* file open fw using "Results/fig/fig2`ScriptName'.tex", write replace
* \label{fig2`ScriptName'}
```

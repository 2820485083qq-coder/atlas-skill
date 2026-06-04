# manuscript-rules

## Scope
Manuscripts 主稿层的写作、语言修改与结果引用规范。同时负责写作路由与文本修改总体原则。包括以下文件类型

- `Manuscripts/zh/main-zh.tex`: Chinese draft root.
- `Manuscripts/en/main-en.tex`: English submission root.
- `Manuscripts/preamble.tex`: shared preamble.
- `Manuscripts/<style>/main-xxx.tex`: optional style-track roots.
- `Manuscripts/<style>/`: LaTeX root directory; generated PDF and auxiliary files stay beside the source `.tex`.

## Must
1. 仅引用 Results 标准接口。
2. 表图 label 与文件名主干一致，且无下划线。
3. 共享宏放 `preamble.tex`。
4. 写作类任务必须先判定是否命中 `references/prompt-library.md` 模板。
5. 命中模板时，必须按模板定义的输出结构执行（Part 1/Part 2/Part 3 等）。
6. LaTeX 编译默认采用“输出目录等于源文件目录”的约定；PDF 与 `.aux`、`.log`、`.out`、`.bbl`、`.blg`、`.fls`、`.fdb_latexmk` 等辅助文件保留在对应 `.tex` 的同级目录。
7. 不得要求将编译产物移动到 `Aux/` 或其他独立输出目录；若需描述构建配置，应与 VS Code `latex-workshop.latex.outDir = %DIR%` 的行为一致。
8. 若提及 `latexmk`、`xelatex`、`pdflatex`、`biber` 或 `bibtex` 的示例命令，不应附加将输出重定向到 `Aux/` 的参数，默认按源文件所在目录执行。

## Must Not
1. 不得引用 `Results/temp`。
2. 不得手工粘贴统计结果替代 `\input`。
3. 不得在未明确请求下重组章节结构或改动论证主线。
4. 不得新增原文不存在的数据事实、实证结论或因果声明。

## Writing Router（并入规则）
1. 若请求属于以下类型，直接路由到 `references/prompt-library.md` 对应模板执行：
   - 中转英（中文草稿 -> 英文学术论文）
   - 文本缩写（英文 LaTeX）
   - 文本扩写（英文 LaTeX）
   - 英文学术表达润色
   - 审稿人视角整体审查
2. 若用户明确要求期刊/学科模板风格，先由 `xuzilong-journal-style` 路由风格来源，再执行本文件约束。
3. 若写作意图不明确且无法安全执行，只允许先问一个澄清问题。

## Text Revision General Principles（总体原则）
1. 目标不变：保持原有研究问题、识别逻辑、结论边界不变。
2. 最小改动：优先句级优化，不做段落级重写，除非用户明确要求。
3. 方法忠实：方法、变量、假设、识别策略表述不得失真。
4. 学术语体：表达简洁、正式、清晰，避免夸张修辞与无意义堆词。
5. LaTeX 完整性：不得破坏 `\cite{}`、`\ref{}`、`\label{}`、公式与交叉引用。
6. 输出纯净：除模板要求外，不添加额外对话包装。

## Writing Precedence
1. `references/prompt-library.md` 的模板硬约束。
2. 本文件的总体原则与完整性约束。
3. 默认写作偏好。

## Missing Input Handling
1. 输入充分时直接执行，不额外确认。
2. 仅在缺少必要源材料时追问（例如未提供待改写文本或审稿 PDF）。

## Task Policy
1. 仅 Manuscripts 改动默认不进入 Tasks。
2. 若属于 Program 联动稿件改动，则跟随该 Program 任务执行 Tasks 规则。

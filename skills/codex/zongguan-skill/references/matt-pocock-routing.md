# Matt Pocock Skills 路由图

这份文件是 `zongguan-skill` 对 `C:\Users\Lenovo\.codex\skills` 中 Matt Pocock 中文版 Skill 的路由参考。它只负责选择路径，不替代具体 Skill 的 `SKILL.md`。

## 总原则

1. 先判断任务类型，再选择一个主入口。
2. 只加载当前路径需要的 Skill；不要一次读取全部 Skill。
3. 一个阶段完成并满足验收条件后，才进入下一阶段。
4. 用户明确点名的 Skill 优先；若点名的 Skill 与任务不匹配，说明原因并给出更短路径。
5. 代码任务默认遵循：想清楚 → 小步实现 → 验证 → 收尾审查。
6. 涉及写入项目时，先检查项目是否已经运行过 `setup-matt-pocock-skills`；已配置则复用，不重复初始化。

## 快速决策树

```text
用户需求
├─ 表达不清、目标或设计未定
│  ├─ 有可写入的项目目录 → grill-with-docs
│  └─ 没有项目目录或不想留文档 → grill-me
│
├─ 巨大、跨多次会话、路径尚不清晰
│  └─ wayfinder → to-spec → to-tickets → implement
│
├─ 已有明确 spec / ticket，需要实现
│  └─ implement
│
├─ 需要先验证状态模型、业务逻辑或 UI 想法
│  └─ prototype → handoff（需要带回主流程时）
│
├─ Bug、失败、性能回退
│  ├─ 复杂、偶发、难复现 → diagnosing-bugs
│  ├─ 明确行为且适合测试先行 → tdd
│  └─ 修复完成或用户要求审查 → code-review
│
├─ 架构、模块边界、术语混乱
│  ├─ 先找候选问题 → improve-codebase-architecture
│  ├─ 设计接口和 seam → codebase-design
│  └─ 建立业务术语和领域模型 → domain-modeling
│
├─ 需要高可信资料并保存研究结果
│  └─ research
│
└─ 只是表达、交接、教学或手动操作
   ├─ 交接上下文 → handoff
   ├─ 教用户概念或技能 → teach
   ├─ 需求没说清 → wait-what
   ├─ 需要他人回答关键决策 → to-questionnaire
   └─ 必须由用户操作凭据/后台/基础设施 → wizard
```

## 主流程：从想法到交付

### A. 澄清想法

使用 `grill-with-docs`：

- 当前目录是项目或工作区；
- 需求、边界、术语、验收标准尚未稳定；
- 需要把决策沉淀到 `CONTEXT.md`、ADR 或项目文档。

使用 `grill-me`：

- 没有合适工作目录；
- 只想在对话中完成追问；
- 不希望创建项目文档。

如果只是上一条话说得不清楚，使用 `wait-what`，不要启动完整 grilling 流程。

完成标准：目标、范围、关键术语、约束和验收标准已经可以写成明确的实现计划；否则继续澄清。

### B. 判断是否需要原型

使用 `prototype`，当问题必须通过可运行结果判断，例如：

- 状态模型是否正确；
- 交互逻辑是否顺手；
- UI 应该如何布局；
- 一个设计假设能否在真实运行中成立。

原型只回答设计问题，不直接承担生产实现。原型结论需要带回主流程时，使用 `handoff` 生成交接材料。

### C. 多会话项目

使用 `wayfinder`，仅当项目足够大，单次会话无法容纳，而且从当前状态到目标的路径仍然不清晰。它产出决策地图，不直接替代实现。

路径固定为：

```text
wayfinder → to-spec → to-tickets → implement → code-review
```

使用 `to-spec`：已有讨论、决策或 wayfinder 地图，需要收束成可构建 spec。

使用 `to-tickets`：spec 已足够明确，需要拆成自包含、带阻塞关系的 tracer-bullet tickets。

不要对 `to-tickets` 已经生成的 agent-ready ticket 再运行 `triage`。

### D. 已有明确任务的实现

使用 `implement`，当已有 spec 或 ticket，且目标是完成代码、测试和必要的收尾工作。

实现时让 `implement` 内部按垂直切片推进；每个切片都要有可观察的验证结果。一个 ticket 完成后再领取下一个有资格处理的 ticket。

## Bug、测试和审查

### `diagnosing-bugs`

用于：复杂 bug、偶发失败、性能回退、回归问题、第一眼无法定位的问题。

路由要求：先建立能在当前 bug 上变红的反馈回路，再定位、修复和添加回归验证。没有复现或可观察反馈时，先补反馈回路，不凭直觉猜原因。

### `tdd`

用于：用户明确要求 TDD / red-green-refactor，或行为边界明确且适合先写测试。

路由顺序：

```text
写失败测试 → 最小实现 → 测试通过 → 必要重构
```

### `code-review`

用于：固定点到当前 diff 的审查、PR 审查、提交前质量检查。

审查至少覆盖两轴：

- Standards：是否符合项目已有规范和约定；
- Spec：是否满足需求、边界和验收标准。

不要用 `code-review` 替代实现前的需求澄清，也不要把纯粹的语法检查包装成完整 review。

## 架构和领域建模

### `improve-codebase-architecture`

用于扫描代码库，寻找值得深化的模块和架构候选项。它只负责发现和排序机会；选定候选项后再进入设计流程。

推荐路径：

```text
improve-codebase-architecture → grill-with-docs → codebase-design → to-spec
```

### `codebase-design`

用于设计深模块、接口、seam、测试边界和模块职责。适合已经选定架构问题、需要决定“哪里应成为稳定接口”的阶段。

### `domain-modeling`

用于业务术语模糊、同一概念有多种叫法、模块边界依赖领域理解的情况。先建立共享词汇，再写 spec 或实现。

## 研究和知识工作

使用 `research`，当任务需要：

- 查阅官方文档、标准、论文或其他高可信一手来源；
- 比较不同方案并保留证据；
- 将结论保存为项目 Markdown。

研究输出应包含问题、来源、结论、证据、限制和待验证项。资料型问题不要直接跳到 `implement`。

## 写作、交接和教学

### 写作链

对原始素材进行结构化写作时，按需要选择：

```text
writing-fragments → writing-beats → writing-shape
```

- `writing-fragments`：收集和挖掘素材，不急于定结构；
- `writing-beats`：组织段落节奏、术语引入和论证推进；
- `writing-shape`：把素材塑造成完整文章。

### 交接

使用 `handoff`，当需要把当前工作交给新的会话或代理。交接文档至少保留目标、已完成内容、关键决策、文件、验证结果、阻塞点和下一步。

`claude-handoff` 仅在用户明确需要面向 Claude Code 的交接格式时使用；一般 Codex 交接优先使用 `handoff`。

### 教学和决策问卷

- `teach`：用户想在当前工作区系统学习一个概念或技能；
- `to-questionnaire`：关键决策必须由项目外的人补充回答，当前代理无法替代其判断。

## 项目初始化和专项工具

### `setup-matt-pocock-skills`

每个项目首次使用这套工程 Skill 时运行一次。它负责配置 issue tracker、triage labels、domain docs 布局。先检查是否已经有配置或相关文档；已存在时复用，不重复初始化。

### `setup-pre-commit`

仅在用户要求设置或修改 Husky、lint-staged、Prettier、类型检查或提交前测试时使用。

### `setup-ts-deep-modules`

仅在 TypeScript 项目中，且用户明确需要用 dependency-cruiser 建立 deep-module 约束时使用。

### `migrate-to-shoehorn`

仅在用户要求迁移测试代码中的 `as` 类型断言到 `@total-typescript/shoehorn` 时使用。

### `scaffold-exercises`

仅在创建课程练习目录、题目、答案和讲解骨架时使用。

### `wizard`

仅在流程必须由用户亲自执行，例如输入凭据、操作第三方后台、配置基础设施或执行一次性 cutover 时使用。代理自己可以完成的步骤不要生成 wizard。

### `git-guardrails-claude-code`

只在用户明确要求配置 Claude Code 的危险 Git 命令防护时使用。它不是 Codex 通用 Git 配置 Skill。

## 路由边界

- 只涉及一两行简单修改：直接处理，不启动完整主流程。
- 需求明确且单次可完成：直接使用 `implement` 或对应领域 Skill，不使用 `wayfinder`。
- 复杂 bug：优先 `diagnosing-bugs`，不要直接猜修复方案。
- 已有 ticket：优先 `implement`，不要重新 grilling。
- 只做审查：使用 `code-review`，不要修改代码，除非用户另行授权。
- 只做研究：使用 `research`，不要顺手实现未经确认的方案。
- 只有用户明确要求时才使用 user-invoked Skill；model-invoked Skill 可在匹配任务时按需加载。

## 完成检查

每条路径结束前，返回：

1. 采用的 Skill 路径；
2. 已完成的具体产物；
3. 验证命令或证据；
4. 未解决的风险、阻塞点或后续路径。

没有验证证据时，状态应标记为“未验证”，而不是宣称完成。

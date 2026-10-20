# 图片工作流 Skill 选源记录（2026-09-29）

这是对图片中尚未安装名称的公开来源复核记录，不是论文任务清单。检索覆盖精确名称、`SKILL.md` 入口、GitHub 仓库和候选仓库文档。未找到表示本次没有核实到可安装来源，不表示互联网上绝对不存在。星数是检索时的来源比较指标；固定提交、许可、运行依赖和研究领域共同决定能否安装。

| 图片名称 | 本次结论 | 可复核来源及原因 | 当前调度 |
| --- | --- | --- | --- |
| `cn-academic-search` | 未核实到公开同名 `SKILL.md` | 近名 [MGMT-Paper-Skills 的 MCP 项目](https://github.com/HaonanAlex/MGMT-Paper-Skills/blob/main/mgmt-paper-cn-academic-search-mcp/README.md)把知网、万方、维普接口标为未实现，默认模拟数据不能当检索结果；异名 [paper-search-pro](https://github.com/O0000-code/paper-search-pro/blob/76d51d9fb51ece3789e0ae851cb9e58ac9083527/SKILL.md)（172★，Apache-2.0）需另配检索凭据，且不覆盖这三库 | 用实际可访问的来源检索中文题录，记录来源；不宣称知网、万方覆盖 |
| `method-design` | 有同名，但不适合通用论文设计 | [NeuroDiscovery 版](https://github.com/CUHK-AIM-Group/NeuroDiscovery/blob/728f69f83e59aea7af09470a6c15580a3109d409/skills/method-design/SKILL.md)（91★，MIT）服务神经影像架构，依赖其项目上下文；部分模式涉及付费模型竞赛。BOYA 旧名称已改为 `research-design`，内容偏人文社科访谈 | 用已装 `experiment-plan` 处理研究问题、对照、评价与资源预算 |
| `paper-outline` | 已安装同名 | 高星 [DeepScientist 版](https://github.com/ResearAI/DeepScientist/blob/b36624417f0c6b8238ec02db37b94d6db2faa5b0/src/skills/paper-outline/SKILL.md)（3342★，Apache-2.0）强制调用其 `artifact.*` 运行时；32★ 版本采用非商业许可。选择可独立用于 Codex 的 [BOYA 版](https://github.com/DylanChiang-Dev/BOYA-skills/blob/657f2d0d47c93235ab78ac096d2d1e7dc122ad04/skills/paper-outline/SKILL.md)（6★，MIT），工程实证稿使用其 IMRaD 分支并以项目证据为输入 | 同名 `paper-outline`；ML/LaTeX 场景可按任务选择 `paper-plan` |
| `revise-section` | 未核实到公开同名 `SKILL.md` | 精确名称、路径与前置元数据检索未得到可信入口；[blue-pencil](https://github.com/ipeirotis/blue-pencil/blob/fc7eee0c0de9c9aa047b5260a59cfe5fac4f4797/SKILL.md)（3★，MIT）是异名分节改写候选 | 已装 `academic-polish` 或 `nature-polishing` 按正文类型修改，不冒名注册 |
| `ai-deduplication` | 未核实到公开同名 `SKILL.md` | 精确名称检索多落在数据集/技能去重，不能据此推断具备论文 AI 来源检测或查重能力 | 用 `nature-polishing`/`academic-polish` 清理重复论断与套话；不提供 AI 来源或相似率认证 |

图片来自用户提供的 UNA Research 案例；仅凭截图不能确认上述名称的原始安装仓库。后续若获得官方源或实际 Skill 文件，应核对入口 `name:`、许可、提交及可运行性，再更新本表和全局安装清单。

## 图片外的辅助写作 Skill

用户另行指定 `anti-defensive-writing-skill`。选择同名高星、MIT、无外部运行依赖的 [Adkid-Zephyr 原仓库中文 Skill](https://github.com/Adkid-Zephyr/anti-defensive-writing-Skill/blob/102c8b21acf5eda3a0aef3d9779a65db646c8980/skills/anti-defensive-writing/SKILL.md)，固定提交 `102c8b21acf5eda3a0aef3d9779a65db646c8980`，全局入口名为 `anti-defensive-writing`。原文中“不说输”“弱化分散主线的实验”等句子可能遮蔽实质反证；本地补丁将其限定为去除冗余道歉和叠加模糊限定，保留会改变结论的负结果、公平对照、误差及适用限制。它是写作辅助，位于 25 项图片任务之外。

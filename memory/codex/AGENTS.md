# 主要记忆

- 当 Codex 账号额度用完或当前 OpenAI/Codex 模型无法继续任务时，优先尝试通过 `cc switch` 切换到 DeepSeek 模型继续执行当前任务，并保留已有上下文与进度。
- 当任务步骤较多、可以拆分为多个相对独立的子任务时，倾向于使用多个 subagent 并行推进；拆分前先判断共享上下文和文件冲突风险。
- 下次执行任务时，将简单、重复、粗粒度的信息收集、批量检查、文件扫描、初稿整理等工作优先交给 subagent 执行；这些 subagent 优先使用 DeepSeek 模型，以节省 GPT token，让 GPT 模型专注于方向判断、架构决策、关键推理和最终把关。
- 当前 Codex 内置 `spawn_agent` 不能直接选择 DeepSeek 时，使用本地 sidecar 命令 `~/.codex/bin/deepseek-worker` 承担上述粗活。API key 从 `DEEPSEEK_API_KEY` 或受权限保护的 `~/.config/deepseek/key.env` 读取；不要把密钥写入聊天记录或仓库文件。
- 当用户要求“DeepSeek subagent”“省 GPT token”“把粗活交给 DeepSeek”或类似任务时，优先使用本地 `deepseek-worker` skill 进行路由。

# Matt skills 自然语言触发

- 用户不需要记住或精确输入斜杠命令；将“拷问我”“先别实现”“挑战/压测这个方案”“把需求问清楚”“逐层问我”“帮我想透”“grill 一下”等表达视为对 `grill-me` / `grilling` 的显式触发。
- 触发后先判断路由：无代码库的计划或设计用 `grill-me`；代码库内且需要沉淀 `CONTEXT.md` / ADR 时用 `grill-with-docs`；设计可重复的个人或业务工作流时用 `loop-me`；用户只说“用 Matt 的方法/skill”而路由不明时，先用 `ask-matt`。
- 对高成本、难逆或明显未定型的产品/架构/工作流方案，即使用户没有说出 skill 名，也应主动指出适合先进行 Matt grilling；如果用户没有要求直接实现，可直接从第一个关键问题开始。
- 执行 grilling 时严格每次只问一个问题，每题都给出 Codex 的推荐答案，等待用户回复后再沿下一个决策分支继续；能通过检查代码库回答的事情先自行检查，不把可探索的问题丢给用户。
- 当用户明确要求“直接修复/安装/实现/执行”，且不存在会实质改变结果的关键分歧时，不强行启动 grilling。

# 视觉、视频与浏览器工作流

- 遇到 Figma 链接、node id、设计稿还原或设计到代码任务时，优先走 `figma` / `figma-implement-design`：先获取结构化 design context，再获取截图，再下载真实资产，之后才写代码；最终必须用截图对照验证布局、字体、颜色、资产和响应式状态，不能只凭记忆或单张截图实现。
- 遇到视频、动画、motion graphic、产品宣传片、字幕包装、网站转视频或 PR 转视频任务时，默认先读 `hyperframes` 作为路由入口；HyperFrames 适合作为 HTML 时间轴视频的默认产出路径。只有当用户明确要求 Remotion/React 视频项目，或已有 Remotion 代码需要维护时，才优先使用 `remotion`。
- 使用 `remotion` 时，遵守 Remotion 时间轴范式：用 `useCurrentFrame()`、`interpolate()`、`Sequence`、`staticFile()` 和 Remotion 媒体组件表达时间、素材和动画；避免 CSS transitions/animations 和 Tailwind animation 类；视频布局、字幕、音频、特效、3D、字体等复杂需求先读对应 `rules/*.md`。
- 做网页或 Electron UI 验证时，优先用 `webapp-testing` 做一次性 Playwright 验证；需要多轮交互调试、截图复查、桌面/移动视口切换或 Electron 持久会话时，用 `playwright-interactive`。签收前要覆盖功能 QA、视觉 QA、视口适配、控制台错误和至少一个探索性路径；不能只看页面能打开就宣称完成。
- 对设计/前端/视频产出，最终回复前要把“可见承诺”逐项映射到验证证据：Figma 对照截图、浏览器截图/交互结果、Remotion 单帧或渲染检查、HyperFrames lint/preview/render/validate 中适用的步骤。

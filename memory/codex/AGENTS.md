# 主要记忆

- 当 Codex 账号额度用完或当前 OpenAI/Codex 模型无法继续任务时，优先尝试通过 `cc switch` 切换到 DeepSeek 模型继续执行当前任务，并保留已有上下文与进度。
- 当任务步骤较多、可以拆分为多个相对独立的子任务时，倾向于使用多个 subagent 并行推进；拆分前先判断共享上下文和文件冲突风险。
- 下次执行任务时，将简单、重复、粗粒度的信息收集、批量检查、文件扫描、初稿整理等工作优先交给 subagent 执行；这些 subagent 优先使用 DeepSeek 模型，以节省 GPT token，让 GPT 模型专注于方向判断、架构决策、关键推理和最终把关。
- 当前 Codex 内置 `spawn_agent` 不能直接选择 DeepSeek 时，使用本地 sidecar 命令 `~/.codex/bin/deepseek-worker` 承担上述粗活。API key 从 `DEEPSEEK_API_KEY` 或受权限保护的 `~/.config/deepseek/key.env` 读取；不要把密钥写入聊天记录或仓库文件。
- 当用户要求“DeepSeek subagent”“省 GPT token”“把粗活交给 DeepSeek”或类似任务时，优先使用本地 `deepseek-worker` skill 进行路由。

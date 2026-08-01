# Atlas Skill 公共安装包整合计划

## 目标

将当前机器上可公开复用的 Codex skills 与工作流同步进本仓库，删除本机配置和隐私信息，并提供可重复、可审计的安装入口。

## 基线证据

- 当前工作分支：`agent/matt-grill-with-docs-routing`，基于远程草稿 PR #1，工作树开始时干净。
- 当前仓库约 800 个 Git 跟踪文件、约 77 MB；已有 `skills/codex`、`memory/codex`、`tools/codex` 和 `manifest.json`，但没有正式安装器。
- 本机 `~/.codex/skills` 有 119 个顶层目录，当前仓库的 Codex skill 快照明显落后；本机还有 6 个可审计代理配置和最新 `AGENTS.md` 工作流。
- 当前树未发现可确认的 OpenAI/GitHub/Google/Slack/AWS 私钥格式；命中项主要是文档 URL、环境变量名和占位符。需要继续对最终树与 Git 历史做脱敏检查。
- 已发现明确的可发布性问题：三个 `_shared/user-config.json` 含本机 Obsidian/Zotero 路径；若干文本文件含本机或调试样例路径。

## 允许同步的内容

1. `~/.codex/skills` 中的非系统 skills，复制到 `skills/codex/`。
2. `~/.codex/AGENTS.md`，作为 `memory/codex/AGENTS.md` 的公开工作流快照。
3. `~/.codex/agents/*.toml`，复制到 `config/codex/agents/`，供安装器部署到 `~/.codex/agents/`。
4. `~/.codex/bin/deepseek-worker*` 与 `~/.codex/docs/deepseek-worker.md`，仅保留从环境变量读取密钥的实现与说明，不携带密钥文件。
5. 可复用的仓库现有 skill（即使当前本机目录已移动），在去除本机路径后继续保留。

## 明确排除的内容

- `.system`、插件运行时、缓存、session、日志、SQLite/WAL、认证文件、模型目录、浏览器状态和全局配置。
- JSONL/SQLite/DB 等运行时或测试生成数据；这类文件不进入公共安装包清单。
- `user-config.json`、`user-config.local.json`、`.env`、密钥/证书/私钥/凭据文件；发布 `user-config.example.json` 作为模板。
- 含真实用户路径、机器名称、个人工作目录或本机调试上下文的文本；改为 `~`、`<project-root>`、`<user-home>` 或通用示例。
- 任何 API key、token、cookie、password、authorization 值；只允许保留环境变量名、读取逻辑和占位符。

## 实施顺序

1. 清理已跟踪的本机配置和绝对用户路径，补充公共配置模板及忽略规则。
2. 同步当前 Codex skills、工作流和代理配置，生成确定性 `manifest.json`。
3. 增加 `scripts/sync-codex.sh`、`scripts/check-public.sh` 和 `install.sh`：同步脚本负责未来更新，检查脚本在发布前阻断隐私/密钥，安装器默认不覆盖已有 `AGENTS.md`。
4. 更新 README，说明目录、安装、更新、配置边界和卸载/备份行为。
5. 在临时 `CODEX_HOME` 中做 dry-run 安装，验证 skills、agents、tools 和工作流文件的落盘路径。
6. 运行 JSON/TOML/脚本语法检查、脱敏扫描、`git diff --check`，再检查远程分支 SHA。
7. 仅提交本次范围并推送当前功能分支；不改写远程历史、不强推。若发现历史中存在真实密钥，先停下请求授权轮换并确认历史清理方案。

## 验收标准

- 最终 Git 树不含用户配置、认证状态、密钥文件、真实 token、私钥或本机绝对路径。
- `manifest.json` 覆盖 skills、安装支持文件和入口，并通过 `installable`/`install_target` 区分可安装内容与归档内容；不会把 `.system` 或运行时数据列入安装包。
- `install.sh --dry-run` 能在空临时目录中解析所有目标；真实安装能恢复 skills、agents、tools 和工作流。
- 安装器不删除目标目录中未由本包管理的内容；已有 `AGENTS.md` 有备份/人工合并路径，不静默覆盖。
- 发布后远程分支 SHA 与本地提交一致，草稿 PR #1 的变更说明、验证证据和残余风险清楚可追踪。

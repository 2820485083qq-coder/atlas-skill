# Atlas Skill

可公开发布的 Codex skill、工作流和受控代理配置归档。仓库内容来自本机技能快照，但不包含本机认证状态、数据库、日志、用户配置或 API 密钥。

## 目录

- `skills/codex/`：Codex 安装包中的 skills。
- `skills/agents/`、`skills/claude/`、`skills/openclaw/`：归档的跨代理或兼容工作流，不会被 Codex 安装器默认复制。
- `config/codex/agents/`：可审计的代理配置，安装到 `~/.codex/agents/`。
- `profiles/codex/AGENTS.fragment.md`：可选的公共路由片段；安装器不会静默覆盖已有 `AGENTS.md`。
- `memory/codex/AGENTS.md`：本机全局工作流的公开快照，仅用于审阅和版本追踪，不作为覆盖式安装输入。
- `tools/codex/`：可选的 DeepSeek worker 命令和说明；密钥只能从运行时环境或本地被忽略的密钥文件读取。
- `manifest.json`：带文件 SHA-256、许可文件和描述的确定性清单。
- `scripts/`：同步、脱敏检查和清单生成工具。
- `docs/INTEGRATION_PLAN.md`：本次公共化和安装包整合计划。

## 安装 Codex 包

先做计划和脱敏检查：

```bash
./scripts/check-public.sh
./install.sh --target "$HOME/.codex"
```

确认目标后执行安装。默认不删除目标中未由本包管理的文件；遇到同名但内容不同的文件会停止，避免静默覆盖：

```bash
./install.sh --target "$HOME/.codex" --apply
```

需要把公共路由规则合并到现有工作流时，显式加上 `--merge-routing`。已有 `AGENTS.md` 会先备份；更新已有 Atlas 片段需要再加 `--force`：

```bash
./install.sh --target "$HOME/.codex" --apply --merge-routing
```

`--force` 只应在确认冲突内容属于本包时使用：

```bash
./install.sh --target "$HOME/.codex" --apply --force --merge-routing
```

安装器不会写入 `config.toml`、`auth.json`、SQLite/WAL、session、日志、模型提供商配置或任何密钥。

## 从本机更新公共快照

同步脚本默认只展示计划，跳过 `.system`、symlink、用户配置、运行时状态和敏感文件名，并保留仓库已有但本机目录已移动的技能：

```bash
./scripts/sync-codex.sh --source "$HOME/.codex"
./scripts/sync-codex.sh --source "$HOME/.codex" --apply
```

同步后应审阅 `git diff`、重新运行 `./scripts/check-public.sh`，再提交。若源文件仍含本机绝对路径或高置信密钥格式，同步会在复制前失败并要求先公共化；它不会把 `~/.codex/config.toml`、认证文件、数据库、sessions、memories 或全局缓存带入仓库。

## 配置技能

三个 `_shared` 目录只提供 `user-config.example.json` 和中性默认值。需要本地 Obsidian/Zotero 路径或论文筛选偏好时，在对应目录创建未跟踪的 `user-config.local.json`；不要修改或提交公共模板。

API key、token、cookie、password、private key 等只允许存在于运行时环境或本地被忽略的密钥存储中。仓库只保留环境变量名、读取逻辑和占位符。

## 许可和外发边界

这是一个混合技能归档，不对所有子目录声明统一许可证。使用或再分发某个 skill 前，应检查该 skill 自带的 `LICENSE*`、README 和上游来源；`manifest.json` 的 `license_files` 为空表示仓库没有检测到该目录的许可文件。

部分 skills 会读取本地文件、执行命令或访问网络。安装不会自动调用这些能力；实际使用前仍需检查对应 `SKILL.md` 的依赖、权限、数据外发和人工确认边界。

## 验证

```bash
bash -n install.sh scripts/*.sh
python3 -m py_compile scripts/generate-manifest.py
python3 scripts/generate-manifest.py
./scripts/check-public.sh
./install.sh --target "$(mktemp -d)/codex"
./install.sh --target "$(mktemp -d)/codex" --apply --merge-routing
git diff --check
```

安装完成后重启 Codex，使新的 skill 列表和代理配置重新加载。

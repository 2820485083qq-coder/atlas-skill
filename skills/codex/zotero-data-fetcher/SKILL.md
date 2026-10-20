---
name: zotero-data-fetcher
description: 根据 Item Key 或标题，从 Zotero 数据库及本地目录快速提取元数据、批注和全文缓存。此步骤严禁翻译和长篇推理。
---

# Zotero Data Fetcher

## 1. 锁定数据源

- 读取 `C:\Users\Lenovo\AppData\Roaming\Zotero\Zotero\Profiles\gqhvt133.default\prefs.js` 确认生效的 `extensions.zotero.dataDir` 路径；当前已确认数据目录为 `D:\zotero`。
- 调用本机桥接脚本提取元数据、附件、批注和全文缓存：
  - 单篇：`python C:\Users\Lenovo\.codex\tools\zotero-obsidian-bridge\zotero_bridge.py --item "<Item Key 或标题片段>"`
  - 分类列表：`python C:\Users\Lenovo\.codex\tools\zotero-obsidian-bridge\zotero_bridge.py --list-collections`
  - 批量分类：`python C:\Users\Lenovo\.codex\tools\zotero-obsidian-bridge\zotero_bridge.py --collection "<分类名>"`

## 2. 语料提取优先级

针对该条目，按以下优先级获取核心正文内容：

1. **最高级（批注）**：脚本读取 `itemAnnotations` 和 `itemNotes`，并生成 `zotero://open-pdf/library/items/<pdfKey>?page=<页码>` 链接。
2. **次高级（全文缓存）**：脚本读取 `D:\zotero\storage\<附件Key>\.zotero-ft-cache`。
3. **备用级（本地 PDF）**：脚本会记录 PDF 附件路径；仅在前两者缺失或需要确认复杂公式时，才读取本地 PDF 对应页码。

## 3. 构建原始语料库（交付标准）

- 将提取到的所有内容整合为一个 `Raw_Data_Buffer`。
- **严格约束**：保持论文的原始语言（通常为英文）。严禁在此步骤进行任何翻译、总结或模板套用动作，确保数据提取过程以最高速度完成，不消耗过多算力。
- 交付数据至 `zotero-analytical-writer`。

---
name: obsidian
description: Use this skill whenever the user mentions Obsidian, a vault, Markdown notes managed in Obsidian, daily notes, backlinks, wikilinks, MOCs, or asks to create/search/update notes in a local vault. Prefer direct file edits for note content, discover vaults from the local Obsidian config, and be careful with renames or moves because they can break links if handled naively.
---

# Obsidian

Work with Obsidian vaults as normal folders on disk. In Codex, the safest default is to inspect the vault layout, edit Markdown files directly, and avoid touching `.obsidian/` unless the user explicitly asks for settings or plugin changes.

## What a vault looks like

- Notes are plain `*.md` files.
- Obsidian settings live in `.obsidian/`.
- Canvases are usually `*.canvas`.
- Attachments can live anywhere, depending on the vault's conventions.

## First step: locate the vault

On Windows, Obsidian stores vault metadata at:

```text
%APPDATA%\obsidian\obsidian.json
```

Use the bundled script to inspect configured vaults:

```powershell
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE/.codex/skills/obsidian/scripts/get-obsidian-vaults.ps1"
```

Use `-Json` if you want machine-readable output:

```powershell
powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE/.codex/skills/obsidian/scripts/get-obsidian-vaults.ps1" -Json
```

Working rules:

- If one vault is marked `Open = True`, that is the best default starting point.
- If multiple vaults exist, avoid guessing when the note location matters.
- Do not assume `obsidian-cli` is installed, even if the config says CLI support is enabled.

## Default workflow

1. Discover the vault path from `obsidian.json`.
2. Inspect the vault conventions before editing:
   - top-level folders
   - naming style
   - where daily notes, inbox notes, attachments, and MOCs live
3. Prefer direct edits to existing `.md` files for content changes.
4. For searches, use filename search and content search in the vault folder.
5. For renames or moves, update `[[wikilinks]]` and Markdown links if the vault uses them heavily.

## Failure Handling

- If no vault is configured or accessible, stop and ask for the vault path.
- If multiple vaults exist and none is open, ask which vault to use before editing.
- If a note path is ambiguous, search candidates and present the likely matches instead of choosing silently.
- If a link update would touch many notes, report the count and scope before applying changes.

## CHECKPOINTS

- STOP before moving, renaming, deleting, or bulk-editing notes.
- STOP before editing `.obsidian/` settings, plugin files, workspace files, or sync-related metadata.

## Safe editing guidance

- Prefer adding or editing note content over rewriting entire notes.
- Avoid reformatting the whole vault unless asked.
- Do not modify `.obsidian/workspace*.json`, plugin state, or cache-like files unless the user explicitly wants configuration changes.
- Preserve existing frontmatter, tags, callouts, embeds, and wikilinks.
- When a note uses Chinese or mixed-language titles, preserve the vault's filename conventions instead of normalizing aggressively.
- Do not create duplicate notes when an existing note with the same title or alias is present.
- Do not silently break wikilinks during renames or moves.

## Useful PowerShell patterns

Search note filenames:

```powershell
Get-ChildItem "<vault-path>" -Recurse -Filter *.md | Select-Object FullName
```

Search inside notes:

```powershell
Get-ChildItem "<vault-path>" -Recurse -Filter *.md | Select-String -Pattern "keyword"
```

Create a new note folder if needed:

```powershell
New-Item -ItemType Directory -Force "<vault-path>/Inbox" | Out-Null
```

## Renames and moves

This is the main place to slow down and be careful.

- If the user asks to move or rename a note, search for references first.
- Update both `[[Note Name]]` style links and standard Markdown links where relevant.
- If the change affects many notes, tell the user what scope you are applying before editing.

## Output expectations

When using this skill, finish with:

- the vault path you used
- the note paths you changed or created
- any assumptions about naming, folders, or link updates

## Bundled script

- `scripts/get-obsidian-vaults.ps1`: reads the local Obsidian config and prints configured vaults in a human-friendly table or JSON.

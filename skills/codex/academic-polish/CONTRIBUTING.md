# Contributing to Academic-Polish

Thanks for your interest in improving this skill! Contributions of all sizes are welcome — from typo fixes and new style conventions to entirely new domain modules.

## How to Contribute

### Reporting a Bug

Open a [Bug Report](../../issues/new?template=bug_report.md). Include:
- A clear, minimal reproduction of the issue (paste the source paragraph + the trigger phrase)
- Expected vs. actual output
- Your environment (Claude Code version, language direction, domain)

### Suggesting a Feature

Open a [Feature Request](../../issues/new?template=feature_request.md). Describe:
- The new scenario the skill should cover
- A concrete user story ("As a thesis writer, I want...")
- Why the current behavior doesn't fit

### Submitting a Pull Request

1. Fork the repository
2. Create a topic branch: `git checkout -b feat/your-feature-name`
3. Make your changes — see [Editing Guidelines](#editing-guidelines) below
4. Run the local validators (see [Validation](#validation))
5. Open a PR using the [pull request template](.github/PULL_REQUEST_TEMPLATE.md)

## Editing Guidelines

### SKILL.md

- Frontmatter is the **most important part**. The `description` field drives Claude's trigger decision — include specific keywords users will say in both Chinese and English.
- Keep SKILL.md under 500 lines. Move long-form content to `references/`.
- Use third-person voice: "The skill covers..." not "This skill covers..."
- Always update the **When NOT to Use** section when adding a new trigger scenario.
- Bump the `version` in frontmatter `metadata` on every change.

#### Frontmatter schema

| Field | Required by spec? | Purpose |
| ----- | ----------------- | ------- |
| `name` | ✅ Yes | Directory name (lowercase + hyphens, ≤ 64 chars) |
| `description` | ✅ Yes | The **only** field the trigger system reads for matching user prompts |
| `metadata.version` | Recommended | Semver, used by CI and CHANGELOG |
| `metadata.title` | Optional | Human-readable display name |
| `metadata.description_zh` | Optional | Chinese mirror for human readers — **decorative**, not used by trigger matching |
| `metadata.keywords` | Optional | Long-form keyword list for tooling/search — **decorative** |
| `metadata.domain`, `audience`, `format`, `sources`, `type`, `standards`, `languages`, `translation_directions` | Optional | Decorative metadata for documentation tooling |

**Rule:** Anything that should affect whether Claude loads this skill **must be in `description`**. Custom `metadata.*` fields are invisible to the spec loader — keep them descriptive but don't rely on them for triggers.

**Description length:** stay under 1024 chars (CI enforces). For dense keyword lists, prefer concise prose in `description` + the full list in `metadata.keywords`.

### References

- Each `references/*.md` should be **self-contained** (Claude loads them on demand).
- Use a consistent heading hierarchy: `# Title` → `## Section` → `### Subsection`.
- Include worked examples — concrete before/after pairs.

### Examples

- Real or realistic scenarios — not `foo` / `bar`.
- Cover a domain or direction that's not already represented in `examples/`.
- Show **before → after** so the change is unambiguous.

## Validation

Run these checks before opening a PR:

```bash
# Skill structure (requires 42plugin CLI; install with `pip install 42plugin`)
42plugin __ validate .

# Markdown lint (optional)
markdownlint *.md references/*.md examples/*.md
```

CI will run the same checks on your PR and block merge if they fail.

## Release Process

1. Update `version` in `SKILL.md` frontmatter
2. Add an entry to `CHANGELOG.md` under a new version heading
3. The maintainer creates a GitHub release with the same notes
4. Tag follows `vMAJOR.MINOR.PATCH` per semver:
   - **MAJOR** — breaking changes to skill interface (frontmatter schema, workflow phases)
   - **MINOR** — new feature, new reference, new example, new domain
   - **PATCH** — bug fix, doc clarification, refactor

## Code of Conduct

Be respectful. We're all here to make academic writing clearer and more rigorous across languages. Disagreement on style conventions is welcome; personal attacks are not.

## Questions?

Open an issue or start a discussion. There's no stupid question — especially around the trickier corners of APA 7, Chicago, Vancouver, and bilingual terminology.
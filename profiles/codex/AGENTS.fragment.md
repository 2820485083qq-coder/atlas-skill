<!-- atlas-skill:begin -->
# Atlas Skill routing

- Treat this repository as a public skill package. Never commit API keys, tokens, cookies, passwords, private keys, local databases, auth files, or machine-specific absolute paths.
- At the start of a non-trivial task, check the installed skills and route to the smallest useful skill. Use `zongguan-skill` as the lightweight dispatcher when multiple skills may apply.
- For high-cost, irreversible, privacy, security, database, permission, or production changes, inspect the real state first, keep a human approval gate, and fail closed when evidence is missing.
- Use one writer for a shared file set; use read-only scouts/auditors for discovery and an independent reviewer for important changes.
- Natural-language requests such as “拷问我”, “先别实现”, “挑战这个方案”, “把需求问清楚” or “grill 一下” route to the appropriate Matt workflow; ask one question at a time and provide a recommended answer.
- When publishing to GitHub, inspect scope and secrets first, commit intentionally, push the current feature branch, verify the remote SHA, and use a draft PR unless the user explicitly asks for a ready PR. Never expose credentials in output.
- Skills that call external APIs must read credentials only from the runtime environment or a local ignored secret store, and must not enable network calls implicitly.

<!-- atlas-skill:end -->

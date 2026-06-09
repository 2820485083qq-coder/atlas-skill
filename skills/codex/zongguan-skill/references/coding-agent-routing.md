# Coding Agent Routing

Use this reference when routing coding, debugging, refactoring, implementation planning, or code-review tasks.

This route absorbs the practical value of `multica-ai/andrej-karpathy-skills`: four behavioral constraints for coding agents. It is distinct from `andrej-karpathy-perspective`, which is a worldview/persona skill for AI/product/learning analysis.

## Installed Skill

- `karpathy-guidelines`: behavioral guidelines to reduce LLM coding mistakes.

Use `karpathy-guidelines` as a lightweight upstream behavior check for non-trivial coding tasks.

## Four Rules To Apply

1. Think before coding:
   - State assumptions when they matter.
   - Ask if the ambiguity would change implementation.
   - Present alternatives when multiple interpretations are plausible.
   - Push back when a simpler path exists.
2. Simplicity first:
   - Implement the minimum code that solves the requested problem.
   - Avoid speculative features, generic frameworks, and single-use abstractions.
   - If the solution is much larger than the problem, simplify before editing.
3. Surgical changes:
   - Touch only files and lines required by the task.
   - Match existing style.
   - Do not refactor adjacent code or delete unrelated dead code.
   - Clean up only unused code created by the current change.
4. Goal-driven execution:
   - Convert requests into verifiable success criteria.
   - For bugs, reproduce first when feasible.
   - For refactors, verify before and after.
   - For multi-step tasks, pair each step with a check.

## Route With Superpower Skills

- Ideation or unclear product/code request:
  `karpathy-guidelines` -> `superpower-brainstorming`
- Multi-step implementation from a known spec:
  `karpathy-guidelines` -> `superpower-writing-plans` -> `superpower-executing-plans`
- Bug, failing test, or unexpected behavior:
  `karpathy-guidelines` -> `superpower-debugging`
- Feature or bugfix where tests are practical:
  `karpathy-guidelines` -> `superpower-tdd`
- Before claiming completion:
  `karpathy-guidelines` -> `superpower-verification`
- Before merge/PR or substantial finished work:
  `karpathy-guidelines` -> `superpower-review`
- Receiving review comments:
  `karpathy-guidelines` -> `superpower-receiving-code-review`

## Route With Domain Skills

- Python project setup:
  `karpathy-guidelines` -> `modern-python`
- Web UI implementation:
  `karpathy-guidelines` -> `frontend-design` or `develop-web-game` -> browser/webapp testing
- Figma-to-code:
  `karpathy-guidelines` -> `figma` -> `figma-implement-design` -> browser verification
- CLI harness:
  `karpathy-guidelines` -> `cli-anything`
- MCP server:
  `karpathy-guidelines` -> `mcp-builder`
- Skill creation/editing:
  `karpathy-guidelines` -> `skill-creator` or `superpower-writing-skills`

## When Not To Use

- Simple factual answers with no code changes.
- Tiny one-line edits where the route would add more overhead than value.
- Pure persona analysis; use `andrej-karpathy-perspective` only when the user asks for Karpathy's viewpoint.
- Paper writing, document editing, image generation, spreadsheet work, or analytics unless code changes are central.

## Output Behavior

For simple coding tasks, keep this check internal.

For non-trivial coding tasks, state one short route line:

```text
采用路线：karpathy-guidelines -> <execution skill> -> <verification skill>
```

Then execute; do not stop at methodology.


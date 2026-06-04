---
name: figma
description: Use the Figma MCP server to fetch design context, screenshots, variables, and assets from Figma, and to translate Figma nodes into production code. Trigger when a task involves Figma URLs, node IDs, design-to-code implementation, or Figma MCP setup and troubleshooting.
---

# Figma MCP

Use the Figma MCP server for Figma-driven implementation. For setup and debugging details (env vars, config, verification), see `references/figma-mcp-config.md`.

## Figma MCP Integration Rules
These rules define how to translate Figma inputs into code for this project and must be followed for every Figma-driven change.

### Required flow (do not skip)
1. Run get_design_context first to fetch the structured representation for the exact node(s).
2. If the response is too large or truncated, run get_metadata to get the high-level node map and then re-fetch only the required node(s) with get_design_context.
3. Run get_screenshot for a visual reference of the node variant being implemented.
4. Only after you have both get_design_context and get_screenshot, download any assets needed and start implementation.
5. Translate the output (usually React + Tailwind) into this project's conventions, styles and framework. Reuse the project's color tokens, components, and typography wherever possible.
6. Validate against Figma for 1:1 look and behavior before marking complete.

### Failure handling
- If the Figma MCP server is unavailable, stop implementation and report the connection failure plus the exact setup check needed from `references/figma-mcp-config.md`.
- If the Figma link does not expose a node ID or points to the wrong frame, ask for the exact frame/layer URL before writing code.
- If get_design_context and get_screenshot disagree, treat the screenshot as visual truth and use design_context only for structure, spacing, and asset names.
- If assets cannot be downloaded, do not invent replacements. Continue only for layout code and mark missing assets explicitly.

### CHECKPOINTS
- STOP before implementation if either structured context or screenshot is missing.
- STOP before final answer until the implemented UI has been visually checked against the Figma screenshot.

### Implementation rules
- Treat the Figma MCP output (React + Tailwind) as a representation of design and behavior, not as final code style.
- Replace Tailwind utility classes with the project's preferred utilities/design-system tokens when applicable.
- Reuse existing components (e.g., buttons, inputs, typography, icon wrappers) instead of duplicating functionality.
- Use the project's color system, typography scale, and spacing tokens consistently.
- Respect existing routing, state management, and data-fetch patterns already adopted in the repo.
- Strive for 1:1 visual parity with the Figma design. When conflicts arise, prefer design-system tokens and adjust spacing or sizes minimally to match visuals.
- Validate the final UI against the Figma screenshot for both look and behavior.

### Asset handling
- The Figma MCP Server provides an assets endpoint which can serve image and SVG assets.
- IMPORTANT: If the Figma MCP Server returns a localhost source for an image or an SVG, use that image or SVG source directly.
- IMPORTANT: DO NOT import/add new icon packages, all the assets should be in the Figma payload.
- IMPORTANT: do NOT use or create placeholders if a localhost source is provided.

### Do not do
- Do not implement from memory or from a screenshot alone when MCP context is available.
- Do not replace the project design system with raw generated Tailwind unless the project already uses that pattern.
- Do not summarize Figma output as a substitute for building and validating the UI.

### Link-based prompting
- The server is link-based: copy the Figma frame/layer link and give that URL to the MCP client when asking for implementation help.
- The client cannot browse the URL but extracts the node ID from the link; always ensure the link points to the exact node/variant you want.

## References
- `references/figma-mcp-config.md` — setup, verification, troubleshooting, and link-based usage reminders.
- `references/figma-tools-and-prompts.md` — tool catalog and prompt patterns for selecting frameworks/components and fetching metadata.

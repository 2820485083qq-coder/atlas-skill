---
name: gptweb-offload
description: Route image generation or editing and project-planning work to the local chatgpt_web MCP so ChatGPT Web performs the expensive generation step. Use for requests such as 生图, 生成图片, 改图, 图片创意, image generation, project planning, 项目规划, 实施路线图, milestones, rollout plan, or when the user asks to save Codex quota by using GPT Web. The workflow opens a visible ChatGPT browser, sends only approved inputs, and leaves output for manual review because it must not scrape or download ChatGPT output.
---

# GPT Web Offload

Use the `chatgpt_web` MCP as a bounded external worker for images and project plans. Keep Codex work to routing, a compact brief, and verification of submission state.

## Route

- Image creation or editing: call `chatgpt_web_prepare_image`.
- Project plan, roadmap, milestone plan, rollout plan, or implementation sequencing: call `chatgpt_web_prepare_project_plan`.
- Browser/login check: call `chatgpt_web_status` or `chatgpt_web_open`.
- Close the dedicated browser only when useful: call `chatgpt_web_close`.

Do not use this skill for code implementation, debugging, file editing, factual research, or tasks whose final output must be returned automatically inside Codex.

## Standing Authorization

Treat the user's instruction to offload future image and planning tasks as approval to submit the minimal pure-text prompt for those two categories. Set `confirm_submit=true` unless the active request says to prepare a draft, asks to review before sending, or contains a privacy ambiguity.

This standing authorization does not cover:

- uploading any local or reference file;
- sending credentials, tokens, private keys, personal data, confidential source code, or a full repository;
- unrelated ChatGPT tasks outside image work and project planning.

For reference images, name the exact absolute paths and obtain explicit approval before setting `confirm_upload=true`.

## Image Workflow

1. Convert the user's request into compact art direction: subject, composition, style, aspect ratio, exact text, and hard constraints.
2. Use `chatgpt_web_prepare_image`; omit optional fields that the user did not specify instead of inventing them.
3. Apply the standing authorization to the text prompt. Ask separately before uploading reference images.
4. After submission, tell the user the request is running in the visible ChatGPT window.
5. Do not claim the image was generated until the user sees it. Direct the user to use ChatGPT's Save control; if Codex must use the file later, ask the user to attach or provide the saved path.

## Project-Planning Workflow

1. Reduce the request to the smallest useful planning brief:
   - `objective`: concrete outcome;
   - `context`: only non-sensitive facts that materially change the plan;
   - `constraints`: timeline, budget, staffing, stack, scope, or risk limits;
   - `desired_depth`: `lean`, `standard`, or `detailed`.
2. Call `chatgpt_web_prepare_project_plan`, normally with `confirm_submit=true` under the standing authorization.
3. Do not draft the full plan in Codex before offloading; that defeats the quota-saving purpose.
4. State that the plan is available for review in the visible ChatGPT window. The MCP cannot read it back.
5. If the user wants Codex to implement or formalize the plan, ask them to paste only the approved sections or save them to a local file and provide its path.

## Privacy And Completion Boundary

- Send a summary, not raw private workspace contents.
- If private material is essential, ask once before sending it.
- Never use arbitrary browser actions, DOM extraction, screenshots of responses, clipboard scraping, or automatic downloads.
- A successful tool result proves only that the prompt was filled or submitted; it does not prove that ChatGPT finished or that the output is correct.
- If `login_required=true`, close the automated browser and run the MCP project's `npm run login` flow in normal Chrome.
- If the `chatgpt_web` MCP is unavailable, report that clearly. Use native `imagegen` or Codex planning only when the user explicitly accepts the fallback.

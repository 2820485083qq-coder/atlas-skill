---
name: video-transcript
description: Transcribe speech from a video or audio file into a timestamped Markdown verbatim transcript. Use when a user provides a media file (mp4, mov, m4a, wav, mp3, etc.) and asks for a 逐字稿, transcript, 字幕稿, or to extract what is said in a video. Works fully offline on CPU via faster-whisper. Covers the non-obvious environment gotchas (managed Python venv, ffmpeg via imageio-ffmpeg, and the HuggingFace mirror plus Xet-disable fix needed when outbound traffic goes through a proxy).
---

# Video / Audio → Markdown Transcript

## Overview

Turn a media file into a readable, timestamped verbatim transcript (逐字稿) saved as Markdown.
Built on `faster-whisper` (CTranslate2, CPU-friendly) for speech recognition and `imageio-ffmpeg`
for audio extraction. No GPU, no external API, no paid service required.

## When to use

- User drops a video/audio file and wants the spoken text extracted.
- Requests like "把这个视频的逐字稿给我", "提取说话内容", "生成字幕/转录".
- Output target is a `.md` document (this skill produces Markdown; for .srt/.vtt subtitles, adapt the writer).

## Environment setup (managed Python)

Use the managed runtime; never pollute the user's global Python.

```
# Resolve the managed Python — path varies per machine/username, do NOT hardcode it
PY=$(ls "$HOME"/.workbuddy/binaries/python/versions/*/bin/python3 2>/dev/null | head -1)
VENV="$HOME/.workbuddy/binaries/python/envs/default"
if [ -z "$PY" ]; then PY="$(command -v python3)"; fi   # fallback to system python3
if [ ! -d "$VENV" ]; then "$PY" -m venv "$VENV"; fi
"$VENV/bin/pip" install --quiet faster-whisper imageio-ffmpeg
```

- `ffmpeg` binary: `python -c "import imageio_ffmpeg; print(imageio_ffmpeg.get_ffmpeg_exe())"`
  (no system ffmpeg needed — macOS here has none by default).
- Extract 16 kHz mono WAV:
  `ffmpeg -y -i INPUT -vn -ac 1 -ar 16000 -f wav OUT.wav`

## CRITICAL: HuggingFace download behind a proxy

When outbound traffic is forced through a local proxy (`HTTP_PROXY`/`HTTPS_PROXY` set), the public
`huggingface.co` host is typically BLOCKED, and the default Xet/CAS transfer returns
`401 Unauthorized` (`cas-server.xethub.hf.co`). The model download will silently stall or error.

Fix — use the Chinese mirror AND disable Xet properly:

```
export HF_ENDPOINT=https://hf-mirror.com
export HF_XET_DISABLED=1          # THE correct var — NOT HF_HUB_DISABLE_XET
export HF_HUB_ENABLE_HF_TRANSFER=0
```

With these, `huggingface_hub` falls back to a plain HTTP GET that resolves through
`cas-bridge.xethub.hf.co` (returns `206` with real bytes). Model files then download fine.
Verify with a quick `hf_hub_download(repo_id="Systran/faster-whisper-medium", filename="config.json")`
before the long run.

Mirror reachability quick-check (curl): `hf-mirror.com` → 200; `modelscope.cn` → 200;
`huggingface.co` and `google.com` → usually 000 (blocked).

## Transcribe

Use `scripts/transcribe.py` (copy it next to your run, or call from the skill dir). Key points:

- `WhisperModel(model_size, device="cpu", compute_type="int8", cpu_threads=N)` — pass `cpu_threads`
  on the **constructor**.
- `model.transcribe(wav, language="zh", beam_size=5, vad_filter=True)` —
  **do NOT pass `num_workers`** (faster-whisper 1.2.x raises `TypeError` on it).
- Set `language="zh"` for Chinese; Whisper auto-detects with high confidence anyway.
- For a ~30 min video on CPU (medium int8, 8 threads) expect ~25–30 min of transcription.

Performance vs accuracy: `small` ≈ 2–4× faster, `medium` noticeably better Chinese accuracy.
Prefer `medium` for verbatim 逐字稿 unless wall-time is tight.

## Keep long background runs ALIVE

This environment kills child processes when the agent's turn returns a final answer. A background
transcription that is launched and then abandoned (turn ends) will be terminated.
To survive:
- Launch with `run_in_background=true`, then **keep the same turn alive** by repeatedly blocking
  on it (e.g. loop `sleep 100 && tail log` checks; keep each foreground `sleep` under ~110 s or it
  gets SIGKILLed at the 120 s default timeout) until the `.md` appears.
- Or, equivalently, never emit the final answer until the output file exists.

## Post-process for readability

Raw faster-whisper VAD output is very fine-grained (1–3 s segments) and painful to read.
Use `scripts/merge.py` to merge consecutive tiny segments into natural paragraphs while preserving
each paragraph's start–end timestamp and keeping ALL verbatim text (no deletions). Output format:

```
**[HH:MM:SS - HH:MM:SS]**  合并后的整段文字……
```

Also regenerate the "纯文本（无时间戳）" section from the merged paragraphs.

## Deliverable

- One Markdown file, e.g. `<stem>_transcript.md`, placed in the user's workspace.
- Header: source filename, language, model, audio duration, generation time.
- Body: timestamped paragraphs, then a plain-text section.
- Present the file with `present_files`.

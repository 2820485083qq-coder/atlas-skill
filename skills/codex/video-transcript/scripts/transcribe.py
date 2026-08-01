import os, sys, subprocess, datetime, json
from pathlib import Path

import imageio_ffmpeg
from faster_whisper import WhisperModel

INPUT = sys.argv[1]
MODEL_SIZE = os.environ.get("WHISPER_MODEL", "medium")
LANG = os.environ.get("WHISPER_LANG", "zh")
TMP = "/tmp/whisper_work"
Path(TMP).mkdir(parents=True, exist_ok=True)

ffmpeg = imageio_ffmpeg.get_ffmpeg_exe()
print("ffmpeg:", ffmpeg, flush=True)

stem = Path(INPUT).stem
wav = os.path.join(TMP, stem + ".wav")

# 1) extract mono 16kHz wav (skip if already present)
if os.path.exists(wav) and os.path.getsize(wav) > 1_000_000:
    print("Reusing existing wav:", wav, flush=True)
else:
    cmd = [ffmpeg, "-y", "-i", INPUT, "-vn", "-ac", "1", "-ar", "16000", "-f", "wav", wav]
    print("Extracting audio...", flush=True)
    subprocess.run(cmd, check=True, stderr=subprocess.DEVNULL)
    print("Audio extracted:", wav, flush=True)

# 2) load model
print(f"Loading whisper model: {MODEL_SIZE} (lang={LANG})", flush=True)
CPU_THREADS = int(os.environ.get("WHISPER_THREADS", "8"))
model = WhisperModel(MODEL_SIZE, device="cpu", compute_type="int8", cpu_threads=CPU_THREADS)

# 3) transcribe
print("Transcribing...", flush=True)
segments, info = model.transcribe(wav, language=LANG, beam_size=5, vad_filter=True,
                                    vad_parameters=dict(min_silence_duration_ms=500))
print(f"Detected lang={info.language} p={info.language_probability:.2f}", flush=True)

def fmt(s):
    h = int(s // 3600); m = int((s % 3600) // 60); sec = int(s % 60)
    return f"{h:02d}:{m:02d}:{sec:02d}"

rows = []
full = []
count = 0
for seg in segments:
    t = f"[{fmt(seg.start)} --> {fmt(seg.end)}]"
    rows.append({"start": seg.start, "end": seg.end, "start_fmt": fmt(seg.start),
                 "end_fmt": fmt(seg.end), "text": seg.text.strip()})
    full.append(seg.text.strip())
    count += 1
    if count % 20 == 0:
        print(f"progress: {count} segments, t={fmt(seg.end)}", flush=True)

out_md = os.path.join(os.environ.get("OUT_DIR", TMP), stem + "_transcript.md")
dur = rows[-1]["end"] if rows else 0
with open(out_md, "w", encoding="utf-8") as f:
    f.write(f"# 视频逐字稿\n\n")
    f.write(f"- **源文件**：`{os.path.basename(INPUT)}`\n")
    f.write(f"- **语言**：{LANG}\n")
    f.write(f"- **识别模型**：faster-whisper `{MODEL_SIZE}`\n")
    f.write(f"- **音频时长**：{fmt(dur)}\n")
    f.write(f"- **生成时间**：{datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n")
    f.write("---\n\n")
    for r in rows:
        f.write(f"**[{r['start_fmt']} - {r['end_fmt']}]**  {r['text']}\n\n")
    f.write("\n---\n\n## 纯文本（无时间戳）\n\n")
    f.write("".join(full))

print("WROTE", out_md, "segments:", len(rows), flush=True)
print("FIRST_LINES:", json.dumps(rows[:3], ensure_ascii=False)[:500], flush=True)

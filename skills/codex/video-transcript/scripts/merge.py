import os
import re
import sys

SRC = os.environ.get("VIDEO_TRANSCRIPT_SOURCE")
if not SRC and len(sys.argv) > 1:
    SRC = sys.argv[1]
if not SRC:
    raise SystemExit(
        "Set VIDEO_TRANSCRIPT_SOURCE or pass the transcript Markdown path as the first argument."
    )

def to_sec(t):
    h, m, s = (int(x) for x in t.split(":"))
    return h*3600 + m*60 + s

def to_hms(s):
    h = int(s//3600); m = int((s%3600)//60); sec = int(s%60)
    return f"{h:02d}:{m:02d}:{sec:02d}"

with open(SRC, encoding="utf-8") as f:
    raw = f.read()

# Split header (before first "---") from body
parts = raw.split("\n---\n", 1)
header = parts[0]
body = parts[1] if len(parts) > 1 else ""

# Parse timestamped entries
pat = re.compile(r'^\*\*\s*\[([\d:]+)\s*-\s*([\d:]+)\]\*\*\s*(.*)$')
entries = []
for line in body.splitlines():
    m = pat.match(line.strip())
    if m:
        entries.append({"s": to_sec(m.group(1)), "e": to_sec(m.group(2)),
                       "text": m.group(3).strip()})
    if line.strip().startswith("## 纯文本"):
        break  # stop before the plain-text section

TERM = "。！？!?…".replace("！", "！")  # terminal punctuation
TERM = "。！？!?…"

groups = []
cur = None
for en in entries:
    if cur is None:
        cur = {"s": en["s"], "e": en["e"], "text": en["text"]}
        continue
    dur = cur["e"] - cur["s"]
    merged_len = len(cur["text"])
    ends_term = cur["text"][-1] in TERM if cur["text"] else False
    # break conditions
    if (dur >= 18) or (ends_term and dur >= 6) or merged_len >= 90:
        groups.append(cur)
        cur = {"s": en["s"], "e": en["e"], "text": en["text"]}
    else:
        cur["e"] = en["e"]
        cur["text"] += en["text"]
if cur:
    groups.append(cur)

# Build merged markdown
out = []
out.append(header)
out.append("")
out.append("_（说明：原始识别为 853 个细粒度片段，已按语义合并为可读性更好的段落，保留每段起止时间戳。完整逐字内容未删减。）_")
out.append("")
out.append("---")
out.append("")
plain = []
for g in groups:
    out.append(f"**[{to_hms(g['s'])} - {to_hms(g['e'])}]**  {g['text']}")
    out.append("")
    plain.append(g["text"])

out.append("")
out.append("---")
out.append("")
out.append("## 纯文本（无时间戳）")
out.append("")
# paragraph the plain text every ~4 groups for readability
for i in range(0, len(plain), 4):
    out.append("".join(plain[i:i+4]))
    out.append("")

with open(SRC, "w", encoding="utf-8") as f:
    f.write("\n".join(out))

print("groups:", len(groups), "entries:", len(entries))

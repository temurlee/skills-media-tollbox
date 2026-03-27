#!/usr/bin/env bash
set -euo pipefail

# Usage: ./scripts/compress-video.sh <input-relative> <output-relative>
# Paths are relative to data root (default: <project-root>/media_toolbox_data).

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
readonly LOG_PREFIX="[media-toolbox:compress-video]"

log() { echo "$LOG_PREFIX $*"; }

if [ "$#" -ne 2 ]; then
  log "用法: $0 <输入文件> <输出文件>（路径相对于数据根目录）"
  exit 2
fi

if [ -n "${MEDIA_TOOLBOX_WORKDIR:-}" ]; then
  PROJECT_ROOT="$MEDIA_TOOLBOX_WORKDIR"
elif PROJECT_ROOT=$(git -C "$PWD" rev-parse --show-toplevel 2>/dev/null); then
  :
else
  PROJECT_ROOT="$PWD"
fi

DATA_ROOT="$PROJECT_ROOT/media_toolbox_data"
INPUT_FILE="$DATA_ROOT/$1"
OUTPUT_FILE="$DATA_ROOT/$2"

if [ ! -f "$INPUT_FILE" ]; then
  log "输入文件不存在: $INPUT_FILE"
  exit 1
fi

if ! command -v ffmpeg >/dev/null 2>&1; then
  log "未找到 ffmpeg，请先安装（见 reference.md）"
  exit 1
fi

mkdir -p "$(dirname "$OUTPUT_FILE")"

ffmpeg -i "$INPUT_FILE" \
  -c:v libx264 \
  -preset medium \
  -crf 23 \
  -c:a aac \
  -b:a 128k \
  -f mp4 \
  -y \
  "$OUTPUT_FILE"

log "完成: $OUTPUT_FILE"

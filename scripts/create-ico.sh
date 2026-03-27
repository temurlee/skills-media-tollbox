#!/usr/bin/env bash
set -euo pipefail

# Usage: ./scripts/create-ico.sh <input-png-relative> <output-ico-relative>
# Paths are relative to data root (default: <project-root>/media_toolbox_data).

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
readonly LOG_PREFIX="[media-toolbox:create-ico]"

log() { echo "$LOG_PREFIX $*"; }

if [ "$#" -ne 2 ]; then
  log "用法: $0 <输入 PNG> <输出 .ico>（路径相对于数据根目录）"
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

run_convert() {
  local in="$1" out="$2"
  if command -v magick >/dev/null 2>&1; then
    magick "$in" -define icon:auto-resize=16,24,32,48,256 "$out"
  elif command -v convert >/dev/null 2>&1; then
    convert "$in" -define icon:auto-resize=16,24,32,48,256 "$out"
  else
    log "未找到 ImageMagick（magick 或 convert），请先安装（见 reference.md）"
    return 1
  fi
}

mkdir -p "$(dirname "$OUTPUT_FILE")"

run_convert "$INPUT_FILE" "$OUTPUT_FILE"

log "完成: $OUTPUT_FILE"

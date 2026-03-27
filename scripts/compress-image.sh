#!/usr/bin/env bash
set -euo pipefail

# Batch-compress all images in <data-root>/input/images/ -> <data-root>/output/images/
# No arguments.

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
readonly LOG_PREFIX="[media-toolbox:compress-image]"

if [ -n "${MEDIA_TOOLBOX_WORKDIR:-}" ]; then
  PROJECT_ROOT="$MEDIA_TOOLBOX_WORKDIR"
elif PROJECT_ROOT=$(git -C "$PWD" rev-parse --show-toplevel 2>/dev/null); then
  :
else
  PROJECT_ROOT="$PWD"
fi

DATA_ROOT="$PROJECT_ROOT/media_toolbox_data"
INPUT_DIR="$DATA_ROOT/input/images"
OUTPUT_DIR="$DATA_ROOT/output/images"

log() { echo "$LOG_PREFIX $*"; }

if [ ! -d "$INPUT_DIR" ]; then
  log "输入目录不存在: $INPUT_DIR"
  exit 1
fi

mkdir -p "$OUTPUT_DIR"

shopt -s nullglob
files=("$INPUT_DIR"/*)
shopt -u nullglob

if [ "${#files[@]}" -eq 0 ]; then
  log "目录中没有文件: $INPUT_DIR"
  exit 1
fi

processed=0
for file in "${files[@]}"; do
  [ -f "$file" ] || continue
  filename=$(basename -- "$file")
  case "${filename##*.}" in
    [Pp][Nn][Gg])
      if ! command -v pngquant >/dev/null 2>&1; then
        log "需要 pngquant 处理 PNG，但未找到。请安装后重试。"
        exit 1
      fi
      log "处理: $filename"
      pngquant --quality=65-80 --speed 1 --force --output "$OUTPUT_DIR/$filename" "$file"
      processed=$((processed + 1))
      ;;
    [Jj][Pp][Gg]|[Jj][Pp][Ee][Gg])
      if ! command -v jpegoptim >/dev/null 2>&1; then
        log "需要 jpegoptim 处理 JPEG，但未找到。请安装后重试。"
        exit 1
      fi
      log "处理: $filename"
      cp "$file" "$OUTPUT_DIR/$filename"
      jpegoptim --max=80 --strip-all --all-progressive "$OUTPUT_DIR/$filename"
      processed=$((processed + 1))
      ;;
    *)
      log "跳过（不支持）: $filename"
      ;;
  esac
done

if [ "$processed" -eq 0 ]; then
  log "没有 PNG/JPEG 被处理，请检查 $INPUT_DIR 中的扩展名。"
  exit 1
fi

log "完成，输出目录: $OUTPUT_DIR"

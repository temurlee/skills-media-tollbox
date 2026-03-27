# skills-media-tollbox

`media-toolbox` 是一个面向 Cursor Skill 的轻量媒体工具箱，提供 3 个常用能力：

- 视频压缩为 MP4（H.264 + AAC）
- 批量压缩 PNG/JPEG 图片
- 从 PNG 生成多尺寸 ICO 图标

脚本基于常见命令行工具（`ffmpeg`、`pngquant`、`jpegoptim`、`ImageMagick`），适合本地自动化处理媒体资源。

## Features

- `compress-video.sh`：将输入视频压缩为兼容性更好的 MP4 输出
- `compress-image.sh`：批量压缩 `input/images/` 下 PNG/JPEG 到 `output/images/`
- `create-ico.sh`：从单个 PNG 生成多尺寸 `.ico` 文件
- 统一数据目录：默认使用 `<project-root>/media_toolbox_data/`

## Directory Layout

```text
media-toolbox/
├── SKILL.md
├── examples.md
├── reference.md
├── scripts/
│   ├── compress-video.sh
│   ├── compress-image.sh
│   └── create-ico.sh
├── input/
│   ├── videos/
│   ├── images/
│   └── icons/
└── output/
    ├── videos/
    ├── images/
    └── icons/
```

## Prerequisites

请先安装以下依赖：

- `ffmpeg`
- `pngquant`
- `jpegoptim`
- `magick`（ImageMagick）

各平台安装方式见 `reference.md`。

## Quick Start

在脚本目录执行：

```bash
cd scripts
```

### 1) 压缩视频

```bash
./compress-video.sh input/videos/source.mov output/videos/out.mp4
```

### 2) 批量压缩图片

```bash
./compress-image.sh
```

### 3) 生成 ICO

```bash
./create-ico.sh input/icons/logo.png output/icons/favicon.ico
```

> 所有参数路径均为相对 `media_toolbox_data/` 的路径约定，详细说明见 `SKILL.md` 和 `reference.md`。

## Documents

- Skill 说明：`SKILL.md`
- 使用示例：`examples.md`
- 依赖与错误码：`reference.md`


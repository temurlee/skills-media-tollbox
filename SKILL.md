---
name: media-toolbox
description: >-
  Compress videos to MP4 (H.264/AAC), batch-compress PNG/JPEG in a fixed layout, and build multi-size ICO from PNG using ffmpeg, pngquant, jpegoptim, and ImageMagick. Use when the user mentions media-toolbox, video compression, image compression, TinyPNG-like optimization, favicon/ICO generation, or paths under input/videos, input/images, input/icons.
---

# Media Toolbox（轻图媒体工具箱）

这是一个**纯 skill 自包含**工具箱。脚本位于本 skill 目录，
但输入/输出数据默认落在 **当前项目根目录** 下：
`<project-root>/media_toolbox_data/`。

所有传入脚本的路径均为 **相对于数据根目录** 的相对路径。

## 何时使用

- 用户要压缩视频为 MP4，或提到 `compress-video`、`ffmpeg`、社媒/网页视频体积。
- 用户要批量压缩 `input/images/` 下 PNG/JPEG，或提到 TinyPNG、图片瘦身。
- 用户要从 PNG 生成 Windows 多尺寸 ICO / favicon，或提到 `create-ico`、`convert`、ImageMagick。

## 数据根目录（默认）

- 默认：`<project-root>/media_toolbox_data/`
- 若设置 `MEDIA_TOOLBOX_WORKDIR`，则使用
  `<MEDIA_TOOLBOX_WORKDIR>/media_toolbox_data/`
- `project-root` 优先通过 `git rev-parse --show-toplevel` 获取，失败时回退为当前工作目录。

## Skill 根目录

- 本仓库：`<repo>/.claude/skills/media-toolbox/`
- 共享给他人时：复制整个 `media-toolbox` 目录到对方的
  `~/.cursor/skills/media-toolbox/` 或 `<their-project>/.claude/skills/media-toolbox/`。

## 目录约定（数据目录）

```
media_toolbox_data/
├── input/videos/   # 待压缩视频（源文件放这里或任意子路径，由命令指定）
├── input/images/   # 批量图片压缩：脚本读取此目录全部文件
├── input/icons/    # ICO：源 PNG 建议放这里
├── output/videos/  # 视频输出（示例）
├── output/images/  # 批量图片输出（固定）
├── output/icons/   # ICO 输出（示例）
└── scripts/        # compress-video.sh, compress-image.sh, create-ico.sh
```

## 动作路由（用户如何指定）

按用户意图选择 **action**，再执行对应命令（可在项目任意目录执行）：

| action | 触发词示例 | 命令 |
|--------|------------|------|
| `compress-video` | 压缩视频、转 mp4 | `./scripts/compress-video.sh <输入相对路径> <输出相对路径>` |
| `compress-image` | 压缩图片、批量 png/jpg | `./scripts/compress-image.sh` |
| `create-ico` | favicon、ico、图标 | `./scripts/create-ico.sh <输入 PNG 相对路径> <输出 .ico 相对路径>` |

用户也可用固定句式显式指定：

```text
技能: media-toolbox
动作: compress-video | compress-image | create-ico
输入/输出: （相对 `media_toolbox_data` 的路径）
```

## 执行前检查

1. **工作目录**：在项目内任意目录执行均可（推荐项目根）。
2. **依赖**：见 [reference.md](reference.md)。若命令未找到，按 reference 安装后再跑。
3. **路径**：仅使用相对数据根目录的路径（例如 `input/videos/a.mov`），不要使用 Windows 反斜杠。

## 各动作步骤

### compress-video

1. 将源视频放入 `input/videos/`（或任意相对路径，只要命令里写对）。
2. 运行：`./scripts/compress-video.sh input/videos/source.mov output/videos/out.mp4`
3. 确认 `output/videos/out.mp4` 存在且可播放。

### compress-image

1. 将待处理 PNG/JPEG 放入 `input/images/`。
2. 运行：`./scripts/compress-image.sh`（无参数；输出到 `output/images/`，文件名与输入一致）。
3. 若无支持的文件，脚本会提示并非零退出。

### create-ico

1. 将源 PNG 放入 `input/icons/`（可选，仅约定）。
2. 运行：`./scripts/create-ico.sh input/icons/logo.png output/icons/favicon.ico`
3. 确认 `output/icons/favicon.ico` 存在。

## 失败时

- 阅读终端输出；检查文件是否存在、扩展名是否支持、依赖是否已安装。
- 详细退出码与依赖列表见 [reference.md](reference.md)。

## 更多资源

- 参数、数据目录与平台安装：[reference.md](reference.md)
- 命令示例：[examples.md](examples.md)

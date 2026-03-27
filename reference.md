# Media Toolbox — 参考

## 外部依赖

| 动作 | 命令/工具 | 用途 |
|------|-----------|------|
| compress-video | `ffmpeg` | 编码 H.264 + AAC，输出 MP4 |
| compress-image | `pngquant` | PNG 量化压缩 |
| compress-image | `jpegoptim` | JPEG 优化 |
| create-ico | ImageMagick `convert` | 多尺寸 ICO |

### 安装（示例）

- **macOS（Homebrew）**：`brew install ffmpeg pngquant jpegoptim imagemagick`
- **Ubuntu/Debian**：`sudo apt update && sudo apt install -y ffmpeg pngquant jpegoptim imagemagick`

ImageMagick 7 若 `convert` 不可用，可尝试 `magick`（见脚本内说明）。

## 路径规则

- 数据根目录默认是 `<project-root>/media_toolbox_data/`。
- 可通过环境变量 `MEDIA_TOOLBOX_WORKDIR` 覆盖项目根，脚本将使用 `<MEDIA_TOOLBOX_WORKDIR>/media_toolbox_data/`。
- 所有传给 `compress-video.sh`、`create-ico.sh` 的路径均为 **相对于数据根目录**。
- `compress-image.sh` 固定读取 `input/images/`，写入 `output/images/`（均相对数据根目录）。

## 退出码（约定）

| 码 | 含义 |
|----|------|
| 0 | 成功 |
| 1 | 一般错误（参数、文件不存在、无可用文件等） |
| 2 | 用法错误（参数个数不对） |

## 视频编码默认值（脚本内）

- 视频：`libx264`，`-preset medium`，`-crf 23`
- 音频：`aac`，`-b:a 128k`
- 容器：`-f mp4`

## 图片压缩默认值（脚本内）

- PNG：`pngquant --quality=65-80 --speed 1`
- JPEG：`jpegoptim --max=80 --strip-all --all-progressive`（先复制再优化）

## ICO 尺寸

- `icon:auto-resize=16,24,32,48,256`（与脚本注释一致）

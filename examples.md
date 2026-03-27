# Media Toolbox — 示例

以下示例默认数据目录为：`<project-root>/media_toolbox_data/`。
可在项目内任意目录执行脚本（示例使用绝对脚本路径）。

## 初始化目录（首次使用）

```bash
mkdir -p media_toolbox_data/input/videos media_toolbox_data/input/images media_toolbox_data/input/icons media_toolbox_data/output/videos media_toolbox_data/output/images media_toolbox_data/output/icons
```

## 压缩视频

```bash
./.claude/skills/media-toolbox/scripts/compress-video.sh input/videos/clip.mov output/videos/clip.mp4
```

## 批量压缩图片

1. 将 `a.png`、`b.jpg` 放入 `input/images/`。
2. 执行：

```bash
./.claude/skills/media-toolbox/scripts/compress-image.sh
```

3. 在 `output/images/` 查看同名输出文件。

## 生成 ICO

```bash
./.claude/skills/media-toolbox/scripts/create-ico.sh input/icons/app.png output/icons/app.ico
```

## 在对话中显式指定技能

```text
使用技能 media-toolbox，动作 compress-video：
输入 input/videos/raw.mov，输出 output/videos/out.mp4（均相对 media_toolbox_data）
```

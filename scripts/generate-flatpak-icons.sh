#!/bin/bash
# 生成 Flatpak 所需的 hicolor 图标 (48x48, 128x128, 256x256)
# 用法: ./scripts/generate-flatpak-icons.sh [源图标路径]
# 若不指定源，将生成占位图标

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
ICON_NAME="com.openclaw_installer.OpenClawInstaller.png"
ICONS_DIR="$PROJECT_ROOT/packaging/linux/icons"

# 源图标：参数 > assets/icon/app_icon_desktop.png > linux/assets/icon.png
SRC_ICON="${1:-}"
if [ -z "$SRC_ICON" ]; then
  if [ -f "$PROJECT_ROOT/assets/icon/app_icon_desktop.png" ]; then
    SRC_ICON="$PROJECT_ROOT/assets/icon/app_icon_desktop.png"
  elif [ -f "$PROJECT_ROOT/linux/assets/icon.png" ]; then
    SRC_ICON="$PROJECT_ROOT/linux/assets/icon.png"
  fi
fi

mkdir -p "$ICONS_DIR/48x48" "$ICONS_DIR/128x128" "$ICONS_DIR/256x256"

if [ -n "$SRC_ICON" ] && [ -f "$SRC_ICON" ]; then
  # 使用 ImageMagick 或 Python 从源图标生成
  if command -v convert &>/dev/null; then
    for size in 48 128 256; do
      convert "$SRC_ICON" -resize "${size}x${size}" "$ICONS_DIR/${size}x${size}/$ICON_NAME"
      echo "Generated $ICONS_DIR/${size}x${size}/$ICON_NAME (from $SRC_ICON)"
    done
  elif command -v python3 &>/dev/null; then
    python3 - "$SRC_ICON" "$ICONS_DIR" "$ICON_NAME" << 'PYTHON'
import sys
try:
    from PIL import Image
    src, out_dir, name = sys.argv[1], sys.argv[2], sys.argv[3]
    img = Image.open(src).convert("RGBA")
    for size in [48, 128, 256]:
        resized = img.resize((size, size), Image.Resampling.LANCZOS)
        resized.save(f"{out_dir}/{size}x{size}/{name}")
        print(f"Generated {out_dir}/{size}x{size}/{name}")
except ImportError:
    print("Install Pillow (pip install Pillow) or ImageMagick to resize from source")
    sys.exit(1)
PYTHON
  else
    echo "No ImageMagick or Python+PIL found, creating placeholder icons"
    SRC_ICON=""
  fi
fi

# 若无源或转换失败，生成占位图标
if [ -z "$SRC_ICON" ] || [ ! -f "$ICONS_DIR/48x48/$ICON_NAME" ]; then
  python3 - "$ICONS_DIR" "$ICON_NAME" << 'PYTHON'
import zlib, struct, sys

def make_png(w, h, r=52, g=152, b=219):
    def pack(tag, data):
        return struct.pack('!I', len(data)) + tag + data + struct.pack('!I', 0xFFFFFFFF & zlib.crc32(tag + data))
    raw = b''.join(b'\x00' + bytes([r,g,b]) * w for _ in range(h))
    ihdr = struct.pack('!2I5B', w, h, 8, 2, 0, 0, 0)
    return b'\x89PNG\r\n\x1a\n' + pack(b'IHDR', ihdr) + pack(b'IDAT', zlib.compress(raw, 9)) + pack(b'IEND', b'')

out_dir, name = sys.argv[1], sys.argv[2]
for s in [48, 128, 256]:
    with open(f"{out_dir}/{s}x{s}/{name}", 'wb') as f:
        f.write(make_png(s, s))
    print(f"Created placeholder {out_dir}/{s}x{s}/{name}")
PYTHON
fi

echo "Done. Icons are in packaging/linux/icons/"

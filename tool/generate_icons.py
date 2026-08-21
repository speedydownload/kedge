#!/usr/bin/env python3
"""Rasterize the Kedge brand SVGs into every PNG the stores and build
tools need. Idempotent: safe to re-run any time the SVGs change.

    python tool/generate_icons.py

Requires: pip install cairosvg pillow
Windows additionally needs the GTK3 runtime for cairo's native DLLs:
    winget install --id tschoonj.GTKForWindows --silent
"""

import os
import re
import sys
from pathlib import Path

if sys.platform == "win32":
    _gtk = r"C:\Program Files\GTK3-Runtime Win64\bin"
    if os.path.isdir(_gtk):
        # cffi resolves cairo via the LoadLibrary search path, so PATH is
        # what matters here; add_dll_directory alone is not honoured.
        os.environ["PATH"] = _gtk + os.pathsep + os.environ.get("PATH", "")
        os.add_dll_directory(_gtk)

try:
    import cairosvg
    from PIL import Image, ImageDraw, ImageFont
except ImportError as exc:  # noqa: BLE001
    sys.exit(f"ERROR: missing dependency ({exc}). Run: pip install cairosvg pillow")
except OSError as exc:
    sys.exit(
        "ERROR: cairosvg cannot load native cairo. On Windows install the "
        f"GTK3 runtime (see module docstring). Underlying error: {exc}"
    )

ROOT = Path(__file__).resolve().parent.parent
BRAND = ROOT / "assets" / "brand"
FONTS = ROOT / "assets" / "fonts"

INK = (0x0D, 0x11, 0x17)

# Geometry of the mark inside the 512x512 SVG canvas (see logo.svg).
CANVAS = 512
MARK_LEFT, MARK_RIGHT = 190, 322  # bob is the widest element
MARK_TOP, MARK_BOTTOM = 82, 416   # anchor circle top .. bob tip
MARK_W = MARK_RIGHT - MARK_LEFT   # 132
MARK_H = MARK_BOTTOM - MARK_TOP   # 334


def require(path: Path) -> Path:
    if not path.is_file():
        sys.exit(f"ERROR: source file missing: {path}")
    return path


LOGO_SVG = require(BRAND / "logo.svg")
MONO_SVG = require(BRAND / "logo-mono.svg")
WORDMARK_SVG = require(BRAND / "wordmark.svg")  # source of truth for layout
FRAUNCES = require(FONTS / "Fraunces-Variable.ttf")


def render(svg_source: bytes, size: int) -> Image.Image:
    """Render SVG bytes to a square RGBA image."""
    png = cairosvg.svg2png(
        bytestring=svg_source, output_width=size, output_height=size
    )
    import io

    return Image.open(io.BytesIO(png)).convert("RGBA")


def mark_only_svg(source: Path) -> bytes:
    """Strip the background rect so only the mark renders."""
    text = source.read_text(encoding="utf-8")
    stripped = re.sub(r'<rect id="bg"[^/]*/>', "", text)
    return stripped.encode("utf-8")


def save(img: Image.Image, name: str) -> None:
    out = BRAND / name
    img.save(out)
    print(f"wrote {out.relative_to(ROOT)}  {img.width}x{img.height}  {img.mode}")


def opaque_logo(size: int) -> Image.Image:
    """Full logo composited onto solid ink and flattened to RGB (no alpha)."""
    rgba = render(LOGO_SVG.read_bytes(), size)
    base = Image.new("RGBA", (size, size), (*INK, 255))
    base.alpha_composite(rgba)
    return base.convert("RGB")


def adaptive_foreground(size: int = 432, mark_fraction: float = 0.60) -> Image.Image:
    """Transparent canvas with the coloured mark's bounding box scaled to
    `mark_fraction` of the canvas height and optically centered (Android
    adaptive-icon safe zone)."""
    scale = (size * mark_fraction) / MARK_H
    rendered = render(mark_only_svg(LOGO_SVG), round(CANVAS * scale))
    r_scale = rendered.width / CANVAS
    canvas = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    cx = (MARK_LEFT + MARK_RIGHT) / 2 * r_scale
    cy = (MARK_TOP + MARK_BOTTOM) / 2 * r_scale
    canvas.alpha_composite(
        rendered, (round(size / 2 - cx), round(size / 2 - cy))
    )
    return canvas


def mark_cropped(height: int, svg: bytes) -> Image.Image:
    """The mark alone, cropped to its bounding box, `height` px tall."""
    scale = height / MARK_H
    rendered = render(svg, round(CANVAS * scale))
    r_scale = rendered.width / CANVAS
    box = (
        round(MARK_LEFT * r_scale),
        round(MARK_TOP * r_scale),
        round(MARK_RIGHT * r_scale),
        round(MARK_BOTTOM * r_scale),
    )
    return rendered.crop(box)


def wordmark(width: int = 2048) -> Image.Image:
    """Mono mark + "Kedge" in Fraunces 600, laid out per wordmark.svg
    (mark 64 tall, 48px text, 24px gap, baseline on the bob's center),
    composed at 10x then resized to `width`."""
    s = 10  # working scale of the 80px-tall wordmark canvas
    mark = mark_cropped(64 * s, mark_only_svg(MONO_SVG))

    font = ImageFont.truetype(str(FRAUNCES), 48 * s)
    axes = font.get_variation_axes()
    coords = [
        600 if ax["name"].strip().lower() in ("weight", "wght") else ax["default"]
        for ax in axes
    ]
    font.set_variation_by_axes(coords)

    gap = 24 * s
    text = "Kedge"
    bbox = font.getbbox(text)  # (x0, y0, x1, y1) relative to origin at ascender
    text_w = bbox[2] - bbox[0]

    canvas_h = 80 * s
    mark_y = 8 * s
    # Baseline sits on the bob's vertical centre: 8 + 64*(306-82)/334 = 50.9
    baseline_y = round((8 + 64 * (306 - MARK_TOP) / MARK_H) * s)
    total_w = mark.width + gap + text_w

    canvas = Image.new("RGBA", (total_w, canvas_h), (0, 0, 0, 0))
    canvas.alpha_composite(mark, (0, mark_y))
    draw = ImageDraw.Draw(canvas)
    draw.text(
        (mark.width + gap, baseline_y),
        text,
        font=font,
        fill=(0xF2, 0xF4, 0xF5, 255),
        anchor="ls",  # left, baseline
    )

    out_h = round(canvas_h * width / total_w)
    return canvas.resize((width, out_h), Image.LANCZOS)


def main() -> None:
    save(opaque_logo(1024), "logo_1024.png")
    save(opaque_logo(512), "logo_512.png")
    save(adaptive_foreground(), "icon_foreground_432.png")
    save(Image.new("RGB", (432, 432), INK), "icon_background_432.png")
    save(render(MONO_SVG.read_bytes(), 512), "logo_mono_512.png")
    save(mark_cropped(640, mark_only_svg(LOGO_SVG)), "splash_logo_640.png")
    save(wordmark(2048), "wordmark_2048.png")
    print("done.")


if __name__ == "__main__":
    main()

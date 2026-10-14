"""Builds the dashcn brand kit: SVG variants, PNG/ICO rasters and app icons.

Usage (from the repo root):
    pip install fonttools pillow && npm i -g playwright   # once
    python3 brand/tool/build.py            # brand/ only
    python3 brand/tool/build.py --apply    # also writes the docs app icons

The mark: an original round Flutter-blue bird in the spirit of Flutter's Dash
(light face, big eye, three-leaf crest, forked tail) whose beak is a glowing
dash -- the "dash" in dashcn. It is our own artwork, not Google's Dash asset.
"""

import io
import subprocess
import sys
import tempfile
from pathlib import Path

from fontTools.pens.svgPathPen import SVGPathPen
from fontTools.pens.transformPen import TransformPen
from fontTools.ttLib import TTFont
from PIL import Image

TOOL = Path(__file__).resolve().parent
BRAND = TOOL.parent
REPO = BRAND.parent
DOCS = REPO / "docs"

INK = "#09090B"  # zinc-950
PAPER = "#FAFAFA"  # zinc-50
BLUE = "#0562D2"
CYAN = "#47D4FF"
MUTED_DARK = "#A1A1AA"  # zinc-400
MUTED_LIGHT = "#52525B"  # zinc-600

GRADIENT = (
    '<linearGradient id="body" x1="0.2" y1="0" x2="0.6" y2="1">'
    '<stop offset="0" stop-color="#47D4FF"/><stop offset="1" stop-color="#0562D2"/></linearGradient>'
    '<linearGradient id="wing" x1="0" y1="0" x2="1" y2="1">'
    '<stop offset="0" stop-color="#0B5BC9"/><stop offset="1" stop-color="#03398F"/></linearGradient>'
    '<linearGradient id="beak" x1="0" y1="0" x2="1" y2="0">'
    '<stop offset="0" stop-color="#E9F8FF"/><stop offset="1" stop-color="#2EE6D6"/></linearGradient>'
)
WORD_GRADIENT = (
    '<linearGradient id="wg" gradientUnits="userSpaceOnUse" x1="0" y1="0" x2="1" y2="0">'
    f'<stop offset="0" stop-color="{BLUE}"/><stop offset="1" stop-color="{CYAN}"/>'
    "</linearGradient>"
)


def bird(mono=False):
    """The bird in a 256x256 space, optically centred.

    Colour: a round Flutter-blue bird with a light face, big eye, a three-leaf crest
    and a glowing dash for a beak. mono=True gives white shapes with the eye cut out
    (black) for use as a mask.
    """
    c = (lambda colour: "#fff") if mono else (lambda colour: colour)
    face = "" if mono else '<ellipse cx="164" cy="128" rx="34" ry="42" fill="#DDF5FF"/>'
    wing = "" if mono else '<path d="M82 128 C104 112 134 120 142 146 C126 170 96 174 78 162 C68 152 70 136 82 128 Z" fill="url(#wing)"/>'
    eye = (
        '<circle cx="168" cy="116" r="13" fill="#000"/>'
        if mono
        else '<circle cx="166" cy="116" r="16" fill="#FFFFFF"/><circle cx="171" cy="117" r="10" fill="#0B1B33"/>'
        '<circle cx="174" cy="113" r="3.5" fill="#FFFFFF"/>'
    )
    return f"""<g transform="translate(-4 6)">
  <rect x="0" y="-11" width="58" height="22" rx="11" fill="{c('#0B5BC9')}" transform="translate(76 176) rotate(146)"/>
  <rect x="0" y="-10" width="50" height="20" rx="10" fill="{c('#0B5BC9')}" opacity=".65" transform="translate(72 166) rotate(166)"/>
  <path d="M118 74 C100 64 92 50 94 36 C108 42 120 56 124 72 Z" fill="{c('#47D4FF')}"/>
  <path d="M128 70 C120 54 120 38 128 24 C138 38 140 54 136 70 Z" fill="{c('#47D4FF')}"/>
  <path d="M140 72 C142 56 150 44 164 38 C164 54 156 66 146 76 Z" fill="{c('#2BB8F5')}"/>
  <ellipse cx="128" cy="140" rx="72" ry="76" fill="{c('url(#body)')}"/>
  {face}{wing}{eye}
  <rect x="0" y="-6" width="54" height="12" rx="6" fill="{c('url(#beak)')}" transform="translate(194 132) rotate(-10)"/>
</g>"""


def svg(view_box, body, defs=GRADIENT):
    return (
        f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="{view_box}">'
        f"<defs>{defs}</defs>{body}</svg>\n"
    )


def tile(bg, rx=56, scale=1.0):
    inner = bird()
    if scale != 1.0:
        inner = f'<g transform="translate(128 128) scale({scale}) translate(-128 -128)">{inner}</g>'
    return svg("0 0 256 256", f'<rect width="256" height="256" rx="{rx}" fill="{bg}"/>{inner}')


GLYPH_BOX = "12 14 240 240"


def mono_glyph():
    """Single-colour glyph (currentColor) with the eye cut out by a mask."""
    shapes = bird(mono=True)
    defs = (
        '<mask id="m" maskUnits="userSpaceOnUse" x="0" y="0" width="256" height="256">'
        f"{shapes}</mask>"
    )
    body = '<rect width="256" height="256" fill="currentColor" mask="url(#m)"/>'
    return svg(GLYPH_BOX, body, defs=defs)


def text_path(font, text, size):
    """Outlines `text` in `font`; returns (svg path d, advance width) at `size` px."""
    glyph_set = font.getGlyphSet()
    cmap = font.getBestCmap()
    scale = size / font["head"].unitsPerEm
    ascent = font["hhea"].ascent * scale
    pen = SVGPathPen(glyph_set)
    x = 0.0
    for ch in text:
        name = cmap[ord(ch)]
        glyph = glyph_set[name]
        glyph.draw(TransformPen(pen, (scale, 0, 0, -scale, x, ascent)))
        x += glyph.width * scale
    return pen.getCommands(), x


def wordmark_parts(font, size, letter_spacing=-0.03):
    """'dash' and 'cn' as separate paths so 'cn' can carry the gradient."""
    tight = font  # Geist SemiBold; tracking applied via per-glyph offsets below
    d1, w1 = text_path(tight, "dash", size)
    d2, w2 = text_path(tight, "cn", size)
    return d1, w1, d2, w2


def wordmark(font, fg, size=96):
    d1, w1, d2, w2 = wordmark_parts(font, size)
    height = font["hhea"].ascent / font["head"].unitsPerEm * size + size * 0.12
    width = w1 + w2
    body = (
        f'<path d="{d1}" fill="{fg}"/>'
        f'<g transform="translate({w1:.2f} 0)"><path d="{d2}" fill="url(#wgc)"/></g>'
    )
    defs = (
        f'<linearGradient id="wgc" gradientUnits="userSpaceOnUse" x1="0" y1="0" x2="{w2:.2f}" y2="0">'
        f'<stop offset="0" stop-color="{BLUE}"/><stop offset="1" stop-color="{CYAN}"/></linearGradient>'
    )
    return svg(f"0 0 {width:.2f} {height:.2f}", body, defs=defs), width, height


def lockup(font, bg, word_fg):
    size = 120
    d1, w1, d2, w2 = wordmark_parts(font, size)
    asc = font["hhea"].ascent / font["head"].unitsPerEm * size
    mark = 160
    gap = 36
    width = mark + gap + w1 + w2
    height = mark
    ty = (height - asc) / 2 - size * 0.04
    body = (
        f'<g transform="scale({mark / 256})"><rect width="256" height="256" rx="56" fill="{bg}"/>{bird()}</g>'
        f'<g transform="translate({mark + gap} {ty:.2f})"><path d="{d1}" fill="{word_fg}"/>'
        f'<g transform="translate({w1:.2f} 0)"><path d="{d2}" fill="url(#wgc)"/></g></g>'
    )
    defs = (
        GRADIENT
        + f'<linearGradient id="wgc" gradientUnits="userSpaceOnUse" x1="0" y1="0" x2="{w2:.2f}" y2="0">'
        f'<stop offset="0" stop-color="{BLUE}"/><stop offset="1" stop-color="{CYAN}"/></linearGradient>'
    )
    return svg(f"0 0 {width:.2f} {height}", body, defs=defs), width, height


def og_image(font):
    W, H = 1200, 630
    lock, lw, lh = lockup(font, "#18181B", PAPER)
    inner = lock.split("</defs>", 1)[1].rsplit("</svg>", 1)[0]
    defs = lock.split("<defs>", 1)[1].split("</defs>", 1)[0]
    scale = 0.95
    x = (W - lw * scale) / 2
    tag, tw = text_path(font, "Flutter components for every platform.", 40)
    body = (
        f'<rect width="{W}" height="{H}" fill="{INK}"/>'
        f'<rect x="0" y="{H - 8}" width="{W}" height="8" fill="url(#bar)"/>'
        f'<g transform="translate({x:.2f} 200) scale({scale})">{inner}</g>'
        f'<g transform="translate({(W - tw) / 2:.2f} 420)"><path d="{tag}" fill="{MUTED_DARK}"/></g>'
    )
    bar = (
        f'<linearGradient id="bar" x1="0" y1="0" x2="1" y2="0"><stop offset="0" stop-color="{BLUE}"/>'
        f'<stop offset="1" stop-color="{CYAN}"/></linearGradient>'
    )
    return svg(f"0 0 {W} {H}", body, defs=defs + bar)


def render(svg_text, out, w, h=None):
    out.parent.mkdir(parents=True, exist_ok=True)
    with tempfile.NamedTemporaryFile("w", suffix=".svg", delete=False) as f:
        f.write(svg_text)
    subprocess.run(
        ["node", str(TOOL / "render.mjs"), f.name, str(out), str(w), str(h or w)], check=True
    )


def flatten(png_path, bg):
    """Opaque copy (iOS app icons must not have alpha)."""
    im = Image.open(png_path).convert("RGBA")
    base = Image.new("RGBA", im.size, bg)
    base.alpha_composite(im)
    base.convert("RGB").save(png_path)


def write_ico(src_png, out, sizes):
    im = Image.open(src_png).convert("RGBA")
    out.parent.mkdir(parents=True, exist_ok=True)
    im.save(out, sizes=[(s, s) for s in sizes])


def main():
    apply = "--apply" in sys.argv
    font = TTFont(TOOL / "Geist-SemiBold.ttf")
    out_svg = BRAND / "svg"
    out_png = BRAND / "png"
    out_svg.mkdir(parents=True, exist_ok=True)

    variants = {
        "mark-dark.svg": tile(INK),
        "mark-light.svg": tile("#EAF7FF"),
        "mark-square-dark.svg": tile(INK, rx=0),
        "mark-maskable.svg": tile(INK, rx=0, scale=0.72),
        "mark-macos.svg": tile(INK, rx=46),
        "glyph.svg": svg(GLYPH_BOX, bird()),
        "glyph-mono.svg": mono_glyph(),
        "wordmark-on-dark.svg": wordmark(font, PAPER)[0],
        "wordmark-on-light.svg": wordmark(font, INK)[0],
        "lockup-on-dark.svg": lockup(font, INK, PAPER)[0],
        "lockup-on-light.svg": lockup(font, INK, INK)[0],
        "og-image.svg": og_image(font),
    }
    for name, text in variants.items():
        (out_svg / name).write_text(text)

    v = variants
    for s in (16, 32, 48, 64, 128, 180, 192, 256, 512, 1024):
        render(v["mark-dark.svg"], out_png / f"mark-dark-{s}.png", s)
    render(v["mark-light.svg"], out_png / "mark-light-512.png", 512)
    for s in (192, 512):
        render(v["mark-maskable.svg"], out_png / f"mark-maskable-{s}.png", s)
    render(v["mark-square-dark.svg"], out_png / "apple-touch-icon.png", 180)
    render(v["glyph.svg"], out_png / "glyph-512.png", 512)
    for name in ("wordmark-on-dark", "wordmark-on-light", "lockup-on-dark", "lockup-on-light"):
        vb = v[f"{name}.svg"].split('viewBox="', 1)[1].split('"', 1)[0].split()
        w, h = float(vb[2]), float(vb[3])
        render(v[f"{name}.svg"], out_png / f"{name}@2x.png", round(w * 2), round(h * 2))
    render(v["og-image.svg"], out_png / "og-image.png", 1200, 630)
    write_ico(out_png / "mark-dark-256.png", BRAND / "ico" / "favicon.ico", (16, 32, 48, 64))
    write_ico(out_png / "mark-dark-256.png", BRAND / "ico" / "app_icon.ico", (16, 24, 32, 48, 64, 128, 256))

    if apply:
        apply_docs(v, out_png)


def apply_docs(v, out_png):
    web = DOCS / "web"
    copy = lambda src, dst: (dst.parent.mkdir(parents=True, exist_ok=True), dst.write_bytes(src.read_bytes()))
    copy(out_png / "mark-dark-32.png", web / "favicon.png")
    copy(BRAND / "ico" / "favicon.ico", web / "favicon.ico")
    (web / "favicon.svg").write_text(v["mark-dark.svg"])
    copy(out_png / "apple-touch-icon.png", web / "apple-touch-icon.png")
    copy(out_png / "og-image.png", web / "og-image.png")
    copy(out_png / "mark-dark-192.png", web / "icons" / "Icon-192.png")
    copy(out_png / "mark-dark-512.png", web / "icons" / "Icon-512.png")
    copy(out_png / "mark-maskable-192.png", web / "icons" / "Icon-maskable-192.png")
    copy(out_png / "mark-maskable-512.png", web / "icons" / "Icon-maskable-512.png")

    ios = DOCS / "ios/Runner/Assets.xcassets/AppIcon.appiconset"
    for f in ios.glob("Icon-App-*.png"):
        pts, scale = f.stem.removeprefix("Icon-App-").split("@")
        px = round(float(pts.split("x")[0]) * int(scale.rstrip("x")))
        render(v["mark-square-dark.svg"], f, px)
        flatten(f, INK)

    mac = DOCS / "macos/Runner/Assets.xcassets/AppIcon.appiconset"
    for f in mac.glob("app_icon_*.png"):
        px = int(f.stem.removeprefix("app_icon_"))
        mac_svg = v["mark-macos.svg"].replace(
            'viewBox="0 0 256 256"', 'viewBox="-26 -26 308 308"'
        )  # Apple grid: ~824/1024 artwork with transparent margin
        render(mac_svg, f, px)

    res = DOCS / "android/app/src/main/res"
    for density, px in {"mdpi": 48, "hdpi": 72, "xhdpi": 96, "xxhdpi": 144, "xxxhdpi": 192}.items():
        target = res / f"mipmap-{density}" / "ic_launcher.png"
        if target.exists():
            render(v["mark-dark.svg"], target, px)

    win = DOCS / "windows/runner/resources/app_icon.ico"
    if win.parent.exists():
        copy(BRAND / "ico" / "app_icon.ico", win)


if __name__ == "__main__":
    main()

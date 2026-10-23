# Generates the per-script Noto fallback subsets used by the docs site
# (docs/assets/fonts/script/*.woff2).
#
# Why the docs app needs these: the site's bundled families (Geist Sans /
# Geist Mono / the OFL Studio fonts) carry Latin only, and the theme never
# declares glyph coverage for the scripts the language switcher offers. The
# flutter web engine (canvaskit) compensates with its own global Noto
# fallback chain, but those woff2 slices are downloaded at runtime from
# fonts.gstatic.com. In any environment without access to Google Fonts
# (filtered networks, sandboxes, headless capture rigs with blocked egress)
# every non-Latin glyph renders as a .notdef tofu box: the Arabic landing
# page reproduction that motivated this fix.
#
# The engine registers every app-side font (asset manifest or FontLoader)
# into the same TypefaceFontProvider it uses for glyph fallback, so a
# runtime FontLoader font participates in missing-glyph resolution
# automatically — no TextStyle changes required (engine 3.47.4,
# canvaskit/fonts.dart l.66-88: _registeredFonts and registeredFallbackFonts
# are both registered into one provider set as defaultFontManager with
# enableFontFallback()).
#
# What this script produces: one woff2 subset per script the switcher
# offers (Arabic, Hebrew, Devanagari, Bengali, Tamil, Telugu, Thai, Hangul,
# Japanese, Simplified Chinese, Traditional Chinese) plus one global
# Latin+Greek+Cyrillic+Vietnamese subset carrying the leftover codepoints
# of every locale the bundled Geist cuts miss. The docs app then loads the
# current locale's subset (plus the global one) through FontLoader at
# startup and on every locale switch — lazily per locale, never eagerly,
# and never bundling Roboto/Material.
#
# Sources:
#  * non-CJK script fonts: the engine's own pinned gstatic woff2 URLs
#    (extracted from flutter 3.47.4 engine/src/flutter/lib/web_ui/lib/src/
#    engine/font_fallback_data.dart — the same files the engine downloads
#    itself when online, so the pixels stay identical across both paths).
#  * CJK fonts: Google Fonts css2 with `text=` server-side subsetting to
#    the translations' used codepoints (full CJK fonts are 8-11 MB and
#    cannot be bundled; subsetting is the only sane size).
#
# The generated artifacts are committed so the site never needs the
# network on first render. Regeneration requires network (Google Fonts /
# gstatic) and python3 with fontTools + brotli.
#
# Usage: python3 docs/scripts/subset_script_fonts.py [--docs-root <docs>]

from __future__ import annotations

import argparse
import hashlib
import json
import re
import sys
import urllib.parse
import urllib.request
from pathlib import Path

try:
    from fontTools import subset
    from fontTools.ttLib import TTFont
    import brotli  # noqa: F401 — fontTools needs it to open/save woff2
except ImportError:  # pragma: no cover
    sys.stderr.write("fontTools not found: pip install fonttools brotli\n")
    raise

# ---------------------------------------------------------------------------
# Pinned sources
# ---------------------------------------------------------------------------

# The engine's own fallback-font downloads at Flutter 3.47.4
# (font_fallback_data.dart single-file families), pinned verbatim. Refresh
# the table when the kit moves to a new Flutter stable by re-extracting the
# same families from the matching tag of the engine tree.
PINNED_NOTO: dict[str, str] = {
    "Noto Sans": "https://fonts.gstatic.com/s/notosans/v37/o-0mIpQlx3QUlC5A4PNB6Ryti20_6n1iPHjcz6L1SoM-jCpoiyD9A99Y41P6zHtY.woff2",
    "Noto Sans Arabic": "https://fonts.gstatic.com/s/notosansarabic/v28/nwpxtLGrOAZMl5nJ_wfgRg3DrWFZWsnVBJ_sS6tlqHHFlhQ5l3sQWIHPqzCfyGyvvnCBFQLaig.woff2",
    "Noto Sans Hebrew": "https://fonts.gstatic.com/s/notosanshebrew/v46/or3HQ7v33eiDljA1IufXTtVf7V6RvEEdhQlk0LlGxCyaeNKYZC0sqk3xXGiXd4qtpyJltutR2g.woff2",
    "Noto Sans Devanagari": "https://fonts.gstatic.com/s/notosansdevanagari/v26/TuGoUUFzXI5FBtUq5a8bjKYTZjtRU6Sgv3NaV_SNmI0b8QQCQmHn6B2OHjbL_08AlXQly-UzoFoW4Ow.woff2",
    "Noto Sans Bengali": "https://fonts.gstatic.com/s/notosansbengali/v26/Cn-SJsCGWQxOjaGwMQ6fIiMywrNJIky6nvd8BjzVMvJx2mcSPVFpVEqE-6KmsolLudWk8izI0lc.woff2",
    "Noto Sans Tamil": "https://fonts.gstatic.com/s/notosanstamil/v27/ieVc2YdFI3GCY6SyQy1KfStzYKZgzN1z4LKDbeZce-0429tBManUktuex7vGo70UqKDt_EvT.woff2",
    "Noto Sans Telugu": "https://fonts.gstatic.com/s/notosanstelugu/v26/0FlxVOGZlE2Rrtr-HmgkMWJNjJ5_RyT8o8c7fHkeg-esVC5dzHkHIJQqrEntezbqREbf-3v37w.woff2",
    "Noto Sans Thai": "https://fonts.gstatic.com/s/notosansthai/v25/iJWnBXeUZi_OHPqn4wq6hQ2_hbJ1xyN9wd43SofNWcd1MKVQt_So_9CdU5RtpzR-QRvzzXg.woff2",
    # css2 endpoints: the generator appends `&text=<codepoints>` and parses
    # the returned woff2 URL (server-side subsetting for CJK families).
    "Noto Sans SC": "https://fonts.googleapis.com/css2?family=Noto+Sans+SC",
    "Noto Sans TC": "https://fonts.googleapis.com/css2?family=Noto+Sans+TC",
    "Noto Sans JP": "https://fonts.googleapis.com/css2?family=Noto+Sans+JP",
    "Noto Sans KR": "https://fonts.googleapis.com/css2?family=Noto+Sans+KR",
    # Global css2 endpoint (Google's engine 'Noto Sans' slice is Latin only).
    "Noto Sans css2": "https://fonts.googleapis.com/css2?family=Noto+Sans",
}

CSS2_UA = (
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36"
    " (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"
)

# ---------------------------------------------------------------------------
# Script ownership
# ---------------------------------------------------------------------------

# Locale tag -> subset key. Tags are the strings the docs language switcher
# uses (docs/lib/state/docs_strings.dart, kDocsLocaleNativeNames) and match
# the localizations_<tag>.dart table names.
TAG_TO_FONT: dict[str, str] = {
    "ar": "arabic",
    "fa": "arabic",
    "ps": "arabic",
    "ur": "arabic",
    "he": "hebrew",
    "hi": "devanagari",
    "mr": "devanagari",
    "bn": "bengali",
    "ta": "tamil",
    "te": "telugu",
    "th": "thai",
    "ko": "korean",
    "ja": "japanese",
    "zh": "chinese-sc",
    "zh_Hans": "chinese-sc",
    "zh_Hant": "chinese-tc",
}

# subset key -> (source key, output file, registered Flutter family)
FONT_SOURCE: dict[str, str] = {
    "arabic": "Noto Sans Arabic",
    "hebrew": "Noto Sans Hebrew",
    "devanagari": "Noto Sans Devanagari",
    "bengali": "Noto Sans Bengali",
    "tamil": "Noto Sans Tamil",
    "telugu": "Noto Sans Telugu",
    "thai": "Noto Sans Thai",
    "korean": "Noto Sans KR",
    "japanese": "Noto Sans JP",
    "chinese-sc": "Noto Sans SC",
    "chinese-tc": "Noto Sans TC",
    "global": "Noto Sans css2",
}

# Subset keys produced through the css2 text= server-side subsetter.
CSS2_KEYS = {"korean", "japanese", "chinese-sc", "chinese-tc", "global"}

FONT_FILE: dict[str, str] = {
    "arabic": "arabic.woff2",
    "hebrew": "hebrew.woff2",
    "devanagari": "devanagari.woff2",
    "bengali": "bengali.woff2",
    "tamil": "tamil.woff2",
    "telugu": "telugu.woff2",
    "thai": "thai.woff2",
    "korean": "korean.woff2",
    "japanese": "japanese.woff2",
    "chinese-sc": "chinese-sc.woff2",
    "chinese-tc": "chinese-tc.woff2",
    "global": "global.woff2",
}

FONT_FAMILY_DART: dict[str, str] = {
    "arabic": "DocsNotoArabic",
    "hebrew": "DocsNotoHebrew",
    "devanagari": "DocsNotoDevanagari",
    "bengali": "DocsNotoBengali",
    "tamil": "DocsNotoTamil",
    "telugu": "DocsNotoTelugu",
    "thai": "DocsNotoThai",
    "korean": "DocsNotoHangul",
    "japanese": "DocsNotoJapanese",
    "chinese-sc": "DocsNotoSimplifiedChinese",
    "chinese-tc": "DocsNotoTraditionalChinese",
    "global": "DocsNotoGlobal",
}

# Whole unicode blocks each script subset must carry even when the current
# translations do not hit every char yet (future strings, intl run-time
# formats, shaping marks). Kept narrow so subsets stay tens of KB.
BLOCKS: dict[str, list[str]] = {
    "arabic": ["0600-06FF", "0750-077F", "08A0-08FF", "FB50-FDFF", "FE70-FEFF", "200C-200F"],
    "hebrew": ["0590-05FF", "FB1D-FB4F", "200C-200F"],
    "devanagari": ["0900-097F", "A8E0-AFFF", "1CD0-1CF9", "20B9"],
    "bengali": ["0980-09FF"],
    "tamil": ["0B80-0BFF"],
    "telugu": ["0C00-0C7F"],
    "thai": ["0E00-0E7F"],
    # Korean: Hangul jamo + precomposed syllables + encloseds.
    "korean": ["1100-11FF", "3130-318F", "AC00-D7A3", "3000-303F", "FFE0-FFE6"],
    # Japanese/Chinese: kana / common CJK punctuation and the CJK ideograph
    # slices the translations land in; the site's own codepoints ride along
    # via the collected char set.
    "japanese": [
        "3041-30FF", "31F0-31FF", "4FF0-4FFF", "5F00-5FFF", "6F00-6FFF",
        "7F00-7FFF", "8F00-8FFF", "9F00-9FFF",
    ],
    "chinese-sc": ["4FF0-4FFF", "5F00-5FFF", "6F00-6FFF", "7F00-7FFF", "8F00-8FFF", "9F00-9FFF"],
    "chinese-tc": ["4FF0-4FFF", "5F00-5FFF", "6F00-6FFF", "7F00-7FFF", "8F00-8FFF", "9F00-9FFF"],
    "global": [
        "0370-03FF", "1F00-1FFF", "0400-052F", "2DE0-2DFF", "A640-A69F",
        "0100-024F", "1EA0-1EFF", "2000-206F", "20A0-20CF", "2190-21FF",
    ],
}

# Prefixes shared by the CJK subsets: common punctuation + fullwidth forms.
COMMON_PUNCT_BLOCKS = ["3000-303F", "FF00-FFEF", "FFE0-FFE6"]

# Curated extras for run-time-generated strings the literal scan cannot see
# (intl date patterns: “2026年10月23日”, durations, weekday labels).
EXTRAS: dict[str, set[str]] = {
    "japanese": set("年月日曜時分秒令和元週水木金火土界"),
    "chinese-sc": set("年月日时分秒令和元週水木金火土"),
    "chinese-tc": set("年月日時分秒令和元週水木金火土"),
    "korean": set("년월일시분초"),
    "thai": set("฿"),
    "arabic": set(),
    "hebrew": set(),
    "devanagari": set("₹"),
    "bengali": set("৳"),
    "tamil": set("₹"),
    "telugu": set("₹"),
    "global": set("№′″›‹"),
}

# Subset keys produced through the css2 text= server-side subsetter.
CSS2_KEYS = {"korean", "japanese", "chinese-sc", "chinese-tc", "global"}


def _expand(specs: list[str] | set[str]) -> set[int]:
    """Expands ['0600-06FF'] to every codepoint in the range."""
    out: set[int] = set()
    for spec in sorted(specs):
        for part in str(spec).split(","):
            part = part.strip().upper()
            if not part:
                continue
            if "-" in part:
                lo, _, hi = part.partition("-")
                out.update(range(int(lo, 16), int(hi, 16) + 1))
            else:
                out.add(int(part, 16))
    return out

# ---------------------------------------------------------------------------
# Charset collection
# ---------------------------------------------------------------------------

LIT_DIR = Path("lib/ui/dashcn/primitives/localizations")
LIT_PATTERN = re.compile(r"^localizations_([a-z0-9_]+)\.dart$")
# Every state file: per-locale value blocks AND one-line per-tag maps
# (the flow-screens plural tables, the native-name map, …) live there.
STATE_DIR = Path("lib/state")
STATE_GLOB = "docs_*.dart"
EXTRA_FILES: list[Path] = []

_SIMPLE_ESCAPES = {
    "n": "\n", "t": "\t", "r": "\r", "\\": "\\", "'": "'", '"': '"',
    "$": "$", "b": "\b", "f": "\f", "v": "\v", "0": "\0",
}


def _unescape(body: str) -> str:
    out: list[str] = []
    i = 0
    while i < len(body):
        c = body[i]
        if c != "\\":
            out.append(c)
            i += 1
            continue
        if i + 1 >= len(body):
            break
        nxt = body[i + 1]
        if nxt in _SIMPLE_ESCAPES:
            out.append(_SIMPLE_ESCAPES[nxt])
            i += 2
            continue
        if nxt == "u":
            rest = body[i + 2:]
            if rest.startswith("{"):
                hexpart, _, _ = rest.partition("}")
                try:
                    out.append(chr(int(hexpart, 16)))
                except ValueError:
                    pass
                i += 2 + 1 + len(hexpart) + 1
            else:
                try:
                    out.append(chr(int(rest[:4], 16)))
                except ValueError:
                    pass
                i += 6
            continue
        if nxt == "x":
            try:
                out.append(chr(int(body[i + 2:i + 4], 16)))
            except ValueError:
                pass
            i += 4
            continue
        out.append(nxt)
        i += 2
    return "".join(out)


def dart_strings(source: str) -> list[str]:
    """Approximate scanner for Dart string literals in a source file."""
    result: list[str] = []
    i, n = 0, len(source)
    while i < n:
        c = source[i]
        if c == "/" and i + 1 < n:
            if source[i + 1] == "/":
                idx = source.find("\n", i)
                i = n if idx < 0 else idx
                continue
            if source[i + 1] == "*":
                idx = source.find("*/", i)
                i = n if idx < 0 else idx + 2
                continue
        raw = False
        if c == "r" and i + 1 < n and source[i + 1] in "'\"":
            raw = True
            i += 1
            c = source[i]
        if c not in ("'", '"'):
            i += 1
            continue
        triple = source.startswith(c * 3, i)
        if triple:
            start = i + 3
            idx = source.find(c * 3, start)
            if idx < 0:
                idx = n
            body = source[start:idx]
            i = idx + 3
        else:
            start = i + 1
            end = start
            while end < n:
                ch = source[end]
                if ch == "\\":
                    end += 2
                    continue
                if ch == c:
                    break
                end += 1
            body = source[start:end]
            i = end + 1
        result.append(body if raw else _unescape(body))
    return result


def slug_to_tag(slug: str) -> str:
    table = {
        "zh_hans": "zh_Hans",
        "zh_hant": "zh_Hant",
        "pt_br": "pt_BR",
    }
    return table.get(slug, slug)


def collect_chars(docs_root: Path) -> dict[str, set[str]]:
    """Per-locale-tag characters plus the whole-site union."""
    lit_root = docs_root / LIT_DIR
    if not lit_root.is_dir():  # pragma: no cover - layout guard
        sys.stderr.write(f"missing {lit_root}\n")
        sys.exit(2)
    per: dict[str, set[str]] = {}
    for path in sorted(lit_root.glob("localizations_*.dart")):
        match = LIT_PATTERN.fullmatch(path.name)
        if not match:
            continue
        tag = slug_to_tag(match.group(1))
        if tag not in TAG_TO_FONT and len(tag) > 4:
            # Not a script-carrying tag (defensive): still record it so the
            # global subset sees its characters.
            pass
        chars: set[str] = set()
        for text in dart_strings(path.read_text(encoding="utf-8")):
            chars.update(text)
        per.setdefault(tag, set()).update(chars)
    for extra in sorted((docs_root / STATE_DIR).glob(STATE_GLOB)):
        text_file = (docs_root / extra).read_text(encoding="utf-8")
        site_chars: set[str] = set()
        for text in dart_strings(text_file):
            site_chars.update(text)
        # The whole-file pool feeds the global subset; every attributed
        # block (below) is removed from it by the per-script subtraction,
        # since its characters also land on the per-tag sets.
        per.setdefault("__site__", set()).update(site_chars)

        # Attribute the kDocsLocaleNativeNames map entries to their tags so
        # e.g. the 日本語 switcher row rides the japanese subset, not global.
        start = text_file.find("kDocsLocaleNativeNames")
        if start >= 0:
            region = text_file[start:]
            end = region.find("};")
            if end >= 0:
                region = region[:end]
            for tag, name in re.findall(r"'([A-Za-z_]{2,8})':\s*'([^']+)'", region):
                per.setdefault(tag, set()).update(name)

        # Attribute the per-locale value blocks (`'ja': <String, String>{…}`)
        # to their tags the same way.
        block = re.compile(
            r"^  '([a-zA-Z_0-9]{2,8})':\s*(?:<String, String>\{|Map<String, String>\{)",
            re.M,
        )
        openings = list(block.finditer(text_file))
        for i, opener in enumerate(openings):
            tag = opener.group(1)
            body_start = opener.end()
            if i + 1 < len(openings):
                body = text_file[body_start : openings[i + 1].start()]
            else:
                idx = text_file.find("\n  },", body_start)
                body = text_file[body_start : idx if idx >= 0 else None]
            for text in dart_strings(body):
                per.setdefault(tag, set()).update(text)

        # One-line per-tag entries (`  'zh_Hant': '1 畫面',`) in the
        # plural/maps tables — attribute at the same two-space depth; block
        # keys sit at four spaces, so they never collide.
        for tag, value in re.findall(
            r"^  '([A-Za-z_0-9]{2,8})':\s*'([^']*)',?\s*$", text_file, re.M
        ):
            per.setdefault(tag, set()).update(value)
    return per


def geist_coverage(docs_root: Path) -> set[int]:
    """Union cmap coverage of the bundled Geist families + the bundled
    NotoSansSymbols2 (symbol coverage the typography already pins)."""
    covered: set[int] = set()
    paths = sorted((docs_root / "assets" / "fonts").glob("Geist*.otf"))
    symbols = docs_root / "assets" / "fonts" / "NotoSansSymbols2-Regular.ttf"
    if symbols.exists():  # pragma: no cover - layout guard
        paths.append(symbols)
    for path in paths:
        font = TTFont(str(path), fontNumber=0, lazy=True)
        try:
            for table in font["cmap"].tables:
                covered.update(table.cmap.keys())
        finally:
            font.close()
    return covered


# ---------------------------------------------------------------------------
# Download + subset
# ---------------------------------------------------------------------------


def fetch(url: str) -> bytes:
    request = urllib.request.Request(url, headers={"User-Agent": CSS2_UA})
    with urllib.request.urlopen(request, timeout=60) as response:
        return response.read()


def css2_text_url(endpoint: str, chars: str) -> str:
    text = "".join(sorted(set(chars)))
    return f"{endpoint}&text={urllib.parse.quote(text)}"


def write_subset(
    font_key: str,
    *,
    out_path: Path,
    text: str,
    unicodes: list[str],
    required: str,
) -> dict:
    """Produces one subset woff2; returns metadata for the manifest."""
    font_key_source = FONT_SOURCE[font_key]
    if font_key in CSS2_KEYS:
        endpoint = PINNED_NOTO[font_key_source]
        request_url = css2_text_url(endpoint, text)
        css = fetch(request_url).decode("utf-8")
        urls = re.findall(r"url\((https://fonts\.gstatic\.com/l/font\?[^)]+)\)", css)
        if not urls:  # pragma: no cover
            urls = re.findall(r"url\((https://[^)]+\.woff2)\)", css)
        if not urls:  # pragma: no cover
            sys.stderr.write(f"css2 woff2 URL not found for {font_key}\n")
            sys.exit(3)
        data = fetch(urls[0])
        out_path.write_bytes(data)
        source = request_url
    else:
        base = fetch(PINNED_NOTO[font_key_source])
        scratch = out_path.with_name(f".{out_path.stem}.scratch.woff2")
        scratch.write_bytes(base)
        try:
            options = subset.Options()
            options.flavor = "woff2"
            options.layout_features = ["*"]
            options.layout_scripts = ["*"]
            options.name_IDs = []
            options.notdef_outline = True
            options.glyph_names = False
            options.drop_tables += ["vhea", "vmtx"]
            font = subset.load_font(scratch, options)
            try:
                subsetter = subset.Subsetter(options)
                subsetter.populate(
                    unicodes=_expand(unicodes),
                    text=text,
                )
                subsetter.subset(font)
                subset.save_font(font, str(out_path), options)
            finally:
                font.close()
        finally:
            if scratch.exists():
                scratch.unlink()
        data = out_path.read_bytes()
        source = PINNED_NOTO[font_key_source]

    # Self-verify: every requested code point must exist in the subset cmap.
    font = TTFont(str(out_path), lazy=True)
    try:
        cmap: set[int] = set()
        for table in font["cmap"].tables:
            cmap.update(table.cmap.keys())
        missing = sorted({ord(c) for c in required if ord(c) >= 0x20 or c == "\t"} - cmap)
        if missing:  # pragma: no cover
            sys.stderr.write(
                f"{font_key}: subset missing {len(missing)} codepoints, "
                f"e.g. {', '.join(hex(m) for m in missing[:8])}\n"
            )
            sys.exit(4)
    finally:
        font.close()
    return {
        "bytes": len(data),
        "sha256": hashlib.sha256(data).hexdigest(),
        "source": source,
    }


def main() -> None:  # pragma: no cover - script entry
    parser = argparse.ArgumentParser(description="Generate the docs script-font subsets.")
    parser.add_argument("--docs-root", default=".", help="Path to the docs package.")
    args = parser.parse_args()
    docs_root = Path(args.docs_root).resolve()

    out_dir = docs_root / "assets" / "fonts" / "script"
    out_dir.mkdir(parents=True, exist_ok=True)

    per = collect_chars(docs_root)
    all_chars: set[str] = set()
    for chars in per.values():
        all_chars |= chars
    geist = geist_coverage(docs_root)

    manifest: dict[str, dict] = {
        "license": "OFL 1.1 (see licenses/noto.OFL-1.1.txt)",
        "encoded_note": (
            "non-CJK sources are the engine's own pinned gstatic woff2 "
            "(flutter 3.47.4 font_fallback_data.dart); CJK sources are "
            "Google Fonts css2 text= subsets of the site's translated "
            "codepoints."
        ),
        "fonts": {},
    }

    per_script_chars: dict[str, str] = {}
    # Script-carrying tags in owner priority: CJK/Hard-script tags own their
    # codepoints even when other locale tables mix them in (e.g. a hanzi in
    # the Arabic table renders through the chinese subset).
    owner_tags = [
        tag for tag in ("ja", "ko", "zh", "zh_Hans", "zh_Hant", "ar", "fa",
                        "ps", "ur", "he", "hi", "mr", "bn", "ta", "te", "th")
        if tag in TAG_TO_FONT
    ]
    owner_of: dict[str, str] = {}
    for tag in owner_tags:
        key = TAG_TO_FONT[tag]
        for c in per.get(tag, set()):
            owner_of.setdefault(c, key)
    for font_key in [k for k in TAG_TO_FONT.values() if k != "global"]:
        tags = sorted(tag for tag, key in TAG_TO_FONT.items() if key == font_key)
        chars: set[str] = set()
        required: set[str] = set()
        for tag in tags:
            needed = {
                c for c in per.get(tag, set())
                if ord(c) not in geist and owner_of.get(c, font_key) == font_key
            }
            chars |= needed
            required |= needed
        extras = EXTRAS.get(font_key, set())
        chars |= extras
        required |= extras
        if font_key in CSS2_KEYS:
            # CJK subsets go through Google Fonts css2 text= (URL length is
            # limited and it silently skips unassigned code points), so they
            # carry exactly the translations' codepoints plus the curated
            # extras above.
            pass
        else:
            # Non-CJK sources are complete script slices; the block ranges
            # are best-effort coverage for future strings and something the
            # source file may not provide (verify only `required`).
            chars |= {chr(cp) for cp in _expand(BLOCKS.get(font_key, []))}
        text = "".join(sorted(chars))
        per_script_chars[font_key] = text
        info = write_subset(
            font_key,
            out_path=out_dir / FONT_FILE[font_key],
            text=text,
            unicodes=[] if font_key in CSS2_KEYS else BLOCKS.get(font_key, []),
            required="".join(sorted(required)),
        )
        manifest["fonts"][font_key] = {
            "file": FONT_FILE[font_key],
            "family": FONT_FAMILY_DART[font_key],
            "locales": tags,
            "bytes": info["bytes"],
            "sha256": info["sha256"],
            "source": info["source"],
        }

    # Global subset: every collected char the Geist cuts do not cover and no
    # script subset carries.
    global_chars = {c for c in all_chars if ord(c) not in geist}
    for text in per_script_chars.values():
        global_chars -= set(text)
    global_chars |= EXTRAS["global"]
    info = write_subset(
        "global",
        out_path=out_dir / FONT_FILE["global"],
        text="".join(sorted(global_chars)),
        unicodes=BLOCKS["global"],
        required="".join(sorted(global_chars)),
    )
    manifest["fonts"]["global"] = {
        "file": FONT_FILE["global"],
        "family": FONT_FAMILY_DART["global"],
        "locales": "* (always loaded, Latin-leftover coverage)",
        "bytes": info["bytes"],
        "sha256": info["sha256"],
        "source": info["source"],
    }

    (out_dir / "manifest.json").write_text(
        json.dumps(manifest, indent=2, ensure_ascii=False, sort_keys=True) + "\n",
        encoding="utf-8",
    )

    sizes = {key: value["bytes"] for key, value in manifest["fonts"].items()}
    total = sum(sizes.values())
    sys.stdout.write(
        "\n".join(f"{key:>11}  {size:>9,} B  {FONT_FILE[key]}"
                  for key, size in sorted(sizes.items()))
        + f"\n{'TOTAL':>11}  {total:>9,} B\n"
    )


if __name__ == "__main__":
    main()

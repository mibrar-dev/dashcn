---
title: "Class: Typography"
description: "Full upstream text-style set: family bases, size ramp, weight ramp and  semantic styles."
---

```dart
/// Full upstream text-style set: family bases, size ramp, weight ramp and
/// semantic styles. Family wiring comes from [applyFonts]; tracking stays
/// data on [TrackingScale] (as before: no component consumed it directly).
class Typography {
  /// Sans-serif body base.
  final TextStyle sans;
  /// Monospace base.
  final TextStyle mono;
  /// Extra small (12px).
  final TextStyle xSmall;
  /// Small (14px).
  final TextStyle small;
  /// Base (16px).
  final TextStyle base;
  /// Large (18px).
  final TextStyle large;
  /// Extra large (20px).
  final TextStyle xLarge;
  /// 2x large (24px).
  final TextStyle x2Large;
  /// 3x large (30px).
  final TextStyle x3Large;
  /// 4x large (36px).
  final TextStyle x4Large;
  /// 5x large (48px).
  final TextStyle x5Large;
  /// 6x large (60px).
  final TextStyle x6Large;
  /// 7x large (72px).
  final TextStyle x7Large;
  /// 8x large (96px).
  final TextStyle x8Large;
  /// 9x large (144px).
  final TextStyle x9Large;
  /// Thin (w100).
  final TextStyle thin;
  /// Light (w300).
  final TextStyle light;
  /// Extra light (w200).
  final TextStyle extraLight;
  /// Normal (w400).
  final TextStyle normal;
  /// Medium (w500).
  final TextStyle medium;
  /// Semi-bold (w600).
  final TextStyle semiBold;
  /// Bold (w700).
  final TextStyle bold;
  /// Extra bold (w800).
  final TextStyle extraBold;
  /// Black (w900).
  final TextStyle black;
  /// Italic.
  final TextStyle italic;
  /// Heading 1.
  final TextStyle h1;
  /// Heading 2.
  final TextStyle h2;
  /// Heading 3.
  final TextStyle h3;
  /// Heading 4.
  final TextStyle h4;
  /// Paragraph.
  final TextStyle p;
  /// Block quote.
  final TextStyle blockQuote;
  /// Inline code.
  final TextStyle inlineCode;
  /// Lead paragraph.
  final TextStyle lead;
  /// Large text.
  final TextStyle textLarge;
  /// Small text.
  final TextStyle textSmall;
  /// Muted text.
  final TextStyle textMuted;
  /// Default Geist-backed set.
  const Typography.geist({this.sans = const TextStyle(fontFamily: 'GeistSans', fontFamilyFallback: ['NotoSansSymbols2']), this.mono = const TextStyle(fontFamily: 'GeistMono', fontFamilyFallback: ['NotoSansSymbols2']), this.xSmall = const TextStyle(fontSize: 12), this.small = const TextStyle(fontSize: 14), this.base = const TextStyle(fontSize: 16), this.large = const TextStyle(fontSize: 18), this.xLarge = const TextStyle(fontSize: 20), this.x2Large = const TextStyle(fontSize: 24), this.x3Large = const TextStyle(fontSize: 30), this.x4Large = const TextStyle(fontSize: 36), this.x5Large = const TextStyle(fontSize: 48), this.x6Large = const TextStyle(fontSize: 60), this.x7Large = const TextStyle(fontSize: 72), this.x8Large = const TextStyle(fontSize: 96), this.x9Large = const TextStyle(fontSize: 144), this.thin = const TextStyle(fontWeight: FontWeight.w100), this.light = const TextStyle(fontWeight: FontWeight.w300), this.extraLight = const TextStyle(fontWeight: FontWeight.w200), this.normal = const TextStyle(fontWeight: FontWeight.w400), this.medium = const TextStyle(fontWeight: FontWeight.w500), this.semiBold = const TextStyle(fontWeight: FontWeight.w600), this.bold = const TextStyle(fontWeight: FontWeight.w700), this.extraBold = const TextStyle(fontWeight: FontWeight.w800), this.black = const TextStyle(fontWeight: FontWeight.w900), this.italic = const TextStyle(fontStyle: FontStyle.italic), this.h1 = const TextStyle(fontSize: 36, fontWeight: FontWeight.w800), this.h2 = const TextStyle(fontSize: 30, fontWeight: FontWeight.w600), this.h3 = const TextStyle(fontSize: 24, fontWeight: FontWeight.w600), this.h4 = const TextStyle(fontSize: 18, fontWeight: FontWeight.w600), this.p = const TextStyle(fontSize: 16, fontWeight: FontWeight.w400), this.blockQuote = const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic), this.inlineCode = const TextStyle(fontFamily: 'GeistMono', fontFamilyFallback: ['NotoSansSymbols2'], fontSize: 14, fontWeight: FontWeight.w600), this.lead = const TextStyle(fontSize: 20), this.textLarge = const TextStyle(fontSize: 20, fontWeight: FontWeight.w600), this.textSmall = const TextStyle(fontSize: 14, fontWeight: FontWeight.w500), this.textMuted = const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)});
  /// Custom set with every style required.
  const Typography({required this.sans, required this.mono, required this.xSmall, required this.small, required this.base, required this.large, required this.xLarge, required this.x2Large, required this.x3Large, required this.x4Large, required this.x5Large, required this.x6Large, required this.x7Large, required this.x8Large, required this.x9Large, required this.thin, required this.light, required this.extraLight, required this.normal, required this.medium, required this.semiBold, required this.bold, required this.extraBold, required this.black, required this.italic, required this.h1, required this.h2, required this.h3, required this.h4, required this.p, required this.blockQuote, required this.inlineCode, required this.lead, required this.textLarge, required this.textSmall, required this.textMuted});
  Typography copyWith({TextStyle? sans, TextStyle? mono, TextStyle? xSmall, TextStyle? small, TextStyle? base, TextStyle? large, TextStyle? xLarge, TextStyle? x2Large, TextStyle? x3Large, TextStyle? x4Large, TextStyle? x5Large, TextStyle? x6Large, TextStyle? x7Large, TextStyle? x8Large, TextStyle? x9Large, TextStyle? thin, TextStyle? light, TextStyle? extraLight, TextStyle? normal, TextStyle? medium, TextStyle? semiBold, TextStyle? bold, TextStyle? extraBold, TextStyle? black, TextStyle? italic, TextStyle? h1, TextStyle? h2, TextStyle? h3, TextStyle? h4, TextStyle? p, TextStyle? blockQuote, TextStyle? inlineCode, TextStyle? lead, TextStyle? textLarge, TextStyle? textSmall, TextStyle? textMuted});
  /// Scales every sized style by [factor]; unsized styles pass through.
  Typography scale(double factor);
  /// Wires [fonts] families in: fontSans into [sans], fontMono into [mono]
  /// and [inlineCode]. Null/empty specs keep the current style. `"A, B"`
  /// splits into family A plus fallback B.
  Typography applyFonts(ThemeFonts fonts);
  static Typography lerp(Typography a, Typography b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```

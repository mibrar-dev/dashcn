---
title: "Class: ThemeFonts"
description: "Mode-independent font families (preset `fontSans/Serif/Mono`, top-level  per QA P1-D; no per-brightness fonts)."
---

```dart
/// Mode-independent font families (preset `fontSans/Serif/Mono`, top-level
/// per QA P1-D; no per-brightness fonts). Nullable; null falls back to the
/// bundled default at build. `fontSerif` is stored but currently unwired
/// (no serif slot in [Typography]; open question in P2B_THEME.md).
class ThemeFonts {
  const ThemeFonts({this.fontSans, this.fontSerif, this.fontMono});
  static const ThemeFonts empty = ThemeFonts();
  /// Body/UI family list, e.g. `"Inter, sans-serif"`.
  final String? fontSans;
  /// Serif option family list.
  final String? fontSerif;
  /// Code family list.
  final String? fontMono;
  ThemeFonts copyWith({String? Function()? fontSans, String? Function()? fontSerif, String? Function()? fontMono});
  /// Fonts are strings: lerp steps at t = 0.5.
  static ThemeFonts lerp(ThemeFonts a, ThemeFonts b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```

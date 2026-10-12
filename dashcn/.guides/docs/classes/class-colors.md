---
title: "Class: Colors"
description: "Minimal palette."
---

```dart
/// Minimal palette. Only what registry components really use survived the
/// prune (see P2B_THEME.md): `white` (destructive text), `black` and
/// `transparent`. All 22 shade ramps and `primaries` were unused by
/// components (only dead imports in fade_scroll/number_ticker) and are cut;
/// charts use token chart1..5, ramps regenerate via [ColorShades.fromAccent].
class Colors {
  /// Pure black.
  static const Color black = Color(0xFF000000);
  /// Pure white.
  static const Color white = Color(0xFFFFFFFF);
  /// Fully transparent.
  static const Color transparent = Color(0x00000000);
}
```

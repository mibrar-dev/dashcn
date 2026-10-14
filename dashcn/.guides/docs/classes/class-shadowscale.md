---
title: "Class: ShadowScale"
description: "Shadow scale: 8 elevation sizes, each a list of box shadows."
---

```dart
/// Shadow scale: 8 elevation sizes, each a list of box shadows.
class ShadowScale {
  const ShadowScale({required this.shadow2xs, required this.shadowXs, required this.shadowSm, required this.shadow, required this.shadowMd, required this.shadowLg, required this.shadowXl, required this.shadow2xl});
  final List<BoxShadow> shadow2xs;
  final List<BoxShadow> shadowXs;
  final List<BoxShadow> shadowSm;
  final List<BoxShadow> shadow;
  final List<BoxShadow> shadowMd;
  final List<BoxShadow> shadowLg;
  final List<BoxShadow> shadowXl;
  final List<BoxShadow> shadow2xl;
  /// Builds the 8 sizes from base atoms using the tweakcn formula: one
  /// ambient layer per size (from [offsetX], [offsetY], [blur], [spread])
  /// plus, for sm..xl, one detail layer with ABSOLUTE geometry
  /// (`Offset(offsetX, y)`, blur `b`, `spread - 1`), so small atoms such as
  /// a upstream default base (offsetY 1, blur 3) can never go negative.
  /// Alpha ratios follow tweakcn: 0.5 for 2xs/xs, 1.0 for sm..xl (ambient
  /// and detail alike), 2.5 for 2xl, all relative to [opacity]; rgb channels
  /// come from [color] unchanged. Geometry reproduces [defaultShadowScale]
  /// exactly with default atoms; alphas land within 1/255 of the old
  /// 8-bit literals (byte rounding: 38/2 -> 19 vs 0x12, 38*2.5 -> 96
  /// vs 0x61 — halving/doubling an even byte cannot hit odd remainders).
  factory ShadowScale.derive({Color color = const Color(0xFF000000), double opacity = 0.15, double blur = 25.5, double spread = -30.0, double offsetX = 20.5, double offsetY = 16.5});
  ShadowScale copyWith({List<BoxShadow>? shadow2xs, List<BoxShadow>? shadowXs, List<BoxShadow>? shadowSm, List<BoxShadow>? shadow, List<BoxShadow>? shadowMd, List<BoxShadow>? shadowLg, List<BoxShadow>? shadowXl, List<BoxShadow>? shadow2xl});
  static ShadowScale lerp(ShadowScale a, ShadowScale b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```

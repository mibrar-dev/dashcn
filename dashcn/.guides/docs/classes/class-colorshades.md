---
title: "Class: ColorShades"
description: "Eleven-step shade ramp (50–950) around an accent color."
---

```dart
/// Eleven-step shade ramp (50–950) around an accent color.
class ColorShades implements Color, ColorSwatch {
  /// Shade keys, lightest (50) to darkest (950).
  static const List<int> shadeValues = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950];
  const ColorShades.raw(this._colors);
  /// Builds from exactly 11 colors in [shadeValues] order.
  factory ColorShades.sorted(List<Color> colors);
  /// Generates the ramp by shifting [accent]'s HSL values.
  factory ColorShades.fromAccent(Color accent, {int base = 500, int hueShift = 0, int saturationStepDown = 0, int saturationStepUp = 0, int lightnessStepDown = 8, int lightnessStepUp = 9});
  /// Generates the ramp from an accent HSL color.
  factory ColorShades.fromAccentHSL(HSLColor accent, {int base = 500, int hueShift = 0, int saturationStepDown = 0, int saturationStepUp = 0, int lightnessStepDown = 8, int lightnessStepUp = 9});
  /// Shifts [hsl] toward [targetBase] shade value.
  static HSLColor shiftHSL(HSLColor hsl, int targetBase, {int base = 500, int hueShift = 0, int saturationStepUp = 0, int saturationStepDown = 0, int lightnessStepUp = 9, int lightnessStepDown = 8});
  /// Builds from a map holding every shade in [shadeValues].
  factory ColorShades.fromMap(Map<int, Color> colors);
  /// Shade value for [key] (one of [shadeValues]).
  Color get(int key);
  Color get shade50;
  Color get shade100;
  Color get shade200;
  Color get shade300;
  Color get shade400;
  Color get shade500;
  Color get shade600;
  Color get shade700;
  Color get shade800;
  Color get shade900;
  Color get shade950;
  int get alpha;
  int get red;
  int get green;
  int get blue;
  double get opacity;
  double get a;
  double get r;
  double get g;
  double get b;
  ColorSpace get colorSpace;
  double computeLuminance();
  int toARGB32();
  /// Deprecated on [Color]; kept so this subclass stays substitutable.
  int get value;
  Color operator [](dynamic index);
  Iterable get keys;
  ColorShades withAlpha(int a);
  ColorShades withRed(int r);
  ColorShades withGreen(int g);
  ColorShades withBlue(int b);
  Color withOpacity(double opacity);
  Color withValues({double? alpha, double? red, double? green, double? blue, ColorSpace? colorSpace});
  bool operator ==(Object other);
  int get hashCode;
}
```

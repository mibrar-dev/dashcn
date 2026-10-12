---
title: "Class: ChipInputTheme"
description: "Theme container for the token field."
---

```dart
/// Theme container for the token field.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class ChipInputTheme extends ComponentThemeData implements Mergeable<ChipInputTheme> {
  /// Creates a chip-input theme.
  const ChipInputTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.spacing, this.removable, this.chipTheme, this.chipIconSize, this.alignment});
  /// Logical pixels reserved between two adjacent tokens. Default: 4.
  ///
  /// Half of it lands on each side of the inner edges, so the rendered gap
  /// between two neighbouring chips is exactly this.
  final double? spacing;
  /// Whether each token gets a remove button. Default: true.
  final bool? removable;
  /// Extra `ChipTheme` leg for the tokens of *this* field.
  ///
  /// Merged over the app's `ChipTheme`, so one field can restyle its chips
  /// without touching every other chip in the app.
  final ChipTheme? chipTheme;
  /// Icon size of the remove button. Default: 12.
  final double? chipIconSize;
  /// How the painted token sits on the text baseline. Default:
  /// [PlaceholderAlignment.middle].
  final PlaceholderAlignment? alignment;
  /// Returns a copy with the given fields replaced.
  ChipInputTheme copyWith({ValueGetter<double?>? spacing, ValueGetter<bool?>? removable, ValueGetter<ChipTheme?>? chipTheme, ValueGetter<double?>? chipIconSize, ValueGetter<PlaceholderAlignment?>? alignment});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  ChipInputTheme merge(ChipInputTheme? fallback);
  /// Scalars interpolate; flags and the alignment step at `t = 0.5`.
  static ChipInputTheme lerp(ChipInputTheme a, ChipInputTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```

---
title: "Class: Progress"
description: "A horizontal progress bar."
---

```dart
/// A horizontal progress bar.
///
/// ```dart
/// const Progress(value: 0.4);        // determinate
/// const Progress();                  // indeterminate
/// const Progress(value: 0.4, showSparks: true);
/// ```
///
/// A determinate bar animates value changes over [kDefaultDuration] unless
/// [disableAnimation] is set. Values are fractions in `0..1`; values outside
/// the range are clamped. Use `semanticsLabel`/`semanticsValue` for
/// accessible progress reporting.
class Progress extends StatelessWidget {
  /// Creates a progress bar.
  const Progress({super.key, this.value, this.height, this.borderRadius, this.color, this.backgroundColor, this.showSparks, this.disableAnimation, this.semanticsLabel, this.semanticsValue, this.theme});
  /// Fraction complete in `0..1`, or null for an indeterminate bar.
  final double? value;
  /// Bar height override.
  final double? height;
  /// Corner radius override.
  final BorderRadiusGeometry? borderRadius;
  /// Fill colour override.
  final Color? color;
  /// Track colour override.
  final Color? backgroundColor;
  /// Whether to paint a glow at the leading edge.
  final bool? showSparks;
  /// Whether value changes jump instead of animating.
  final bool? disableAnimation;
  /// Semantic label, e.g. `'Uploading'`.
  final String? semanticsLabel;
  /// Semantic value, e.g. `'40%'`.
  final String? semanticsValue;
  /// Widget-leg theme override, merged on top of the other legs.
  final ProgressTheme? theme;
  Widget build(BuildContext context);
}
```

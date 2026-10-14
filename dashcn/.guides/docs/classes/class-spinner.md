---
title: "Class: Spinner"
description: "An indeterminate circular indicator."
---

```dart
/// An indeterminate circular indicator.
///
/// ```dart
/// const Spinner();
/// const Spinner(size: 16, strokeWidth: 2);
/// ```
///
/// The arc rotates continuously; the widget has no determinate mode by
/// design. Use `Progress` for a value-bearing indicator.
class Spinner extends StatelessWidget {
  /// Creates a spinner.
  const Spinner({super.key, this.size, this.strokeWidth, this.color, this.semanticsLabel, this.theme});
  /// Diameter override; null uses [SpinnerTheme.size] then `24 * scaling`.
  final double? size;
  /// Arc thickness override; null uses [SpinnerTheme.strokeWidth] then
  /// `size / 12`.
  final double? strokeWidth;
  /// Arc colour override.
  final Color? color;
  /// Semantic label, e.g. `'Loading'`.
  final String? semanticsLabel;
  /// Widget-leg theme override, merged on top of the other legs.
  final SpinnerTheme? theme;
  Widget build(BuildContext context);
}
```

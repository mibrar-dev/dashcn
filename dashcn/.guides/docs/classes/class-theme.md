---
title: "Class: Theme"
description: "Provides [ThemeData] to descendants."
---

```dart
/// Provides [ThemeData] to descendants.
class Theme extends InheritedTheme {
  const Theme({super.key, required this.data, required super.child});
  /// Theme data for this subtree.
  final ThemeData data;
  /// Nearest ambient data, defaulting to `const ThemeData()`.
  /// Dark themes pass through readability normalisation.
  static ThemeData of(BuildContext context);
  /// Patches near-black-on-dark foregrounds against luminance floors.
  /// Fires only for dark themes on dark backgrounds; kept from the old
  /// `Theme._ensureReadableDarkTheme` verbatim (thresholds included).
  static ThemeData ensureReadableDarkTheme(ThemeData data);
  bool updateShouldNotify(covariant Theme oldWidget);
  Widget wrap(BuildContext context, Widget child);
  void debugFillProperties(DiagnosticPropertiesBuilder properties);
}
```

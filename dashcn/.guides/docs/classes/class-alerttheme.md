---
title: "Class: AlertTheme"
description: "Per-variant theme container for the alert component."
---

```dart
/// Per-variant theme container for the alert component.
class AlertTheme extends ComponentThemeData implements Mergeable<AlertTheme> {
  /// Creates an alert theme with one nullable slice per variant.
  const AlertTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.base, this.destructive});
  /// Style for [AlertVariant.base].
  final AlertStyle? base;
  /// Style for [AlertVariant.destructive].
  final AlertStyle? destructive;
  /// The composed slice for [variant].
  ///
  /// A leg that sets only the destructive colours still inherits its own
  /// [base] row (and below it the defaults), because the destructive row is
  /// merged over the base row before the resolver merges legs.
  AlertStyle? forVariant(AlertVariant variant);
  /// Returns a copy with the given variant rows replaced.
  AlertTheme copyWith({ValueGetter<AlertStyle?>? base, ValueGetter<AlertStyle?>? destructive});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  AlertTheme merge(AlertTheme? fallback);
  /// Lerps each row; state scales step at `t = 0.5`.
  static AlertTheme lerp(AlertTheme a, AlertTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```

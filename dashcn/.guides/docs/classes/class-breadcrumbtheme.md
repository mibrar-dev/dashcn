---
title: "Class: BreadcrumbTheme"
description: "Visual contract of the breadcrumb trail."
---

```dart
/// Visual contract of the breadcrumb trail.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class BreadcrumbTheme extends ComponentThemeData implements Mergeable<BreadcrumbTheme> {
  /// Creates a breadcrumb theme.
  const BreadcrumbTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.separator, this.padding, this.spacing});
  /// Widget drawn between two crumbs. `null` resolves the default chevron
  /// ([Breadcrumb.arrowSeparator]); use `Breadcrumb.slashSeparator` for `/`.
  final Widget? separator;
  /// Padding around the whole strip. Default: `EdgeInsets.zero`.
  final EdgeInsetsGeometry? padding;
  /// Gap on each side of the separator, in logical pixels. Default: `6`,
  /// multiplied by the ambient scaling at build.
  final double? spacing;
  /// Returns a copy with the given fields replaced.
  BreadcrumbTheme copyWith({ValueGetter<Widget?>? separator, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<double?>? spacing});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  BreadcrumbTheme merge(BreadcrumbTheme? fallback);
  /// Widgets step at `t < 0.5`; dimensions are lerped.
  static BreadcrumbTheme lerp(BreadcrumbTheme a, BreadcrumbTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```

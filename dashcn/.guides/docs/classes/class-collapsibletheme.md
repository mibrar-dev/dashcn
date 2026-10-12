---
title: "Class: CollapsibleTheme"
description: "Theme container for the collapsible component."
---

```dart
/// Theme container for the collapsible component.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class CollapsibleTheme extends ComponentThemeData implements Mergeable<CollapsibleTheme> {
  /// Creates a collapsible theme.
  const CollapsibleTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.padding, this.iconExpanded, this.iconCollapsed, this.crossAxisAlignment, this.mainAxisAlignment, this.iconGap});
  /// Horizontal padding around the trigger row. Default: content density.
  final double? padding;
  /// Icon shown while the section is expanded.
  final IconData? iconExpanded;
  /// Icon shown while the section is collapsed.
  final IconData? iconCollapsed;
  /// Cross-axis alignment of the children column. Default: stretch.
  final CrossAxisAlignment? crossAxisAlignment;
  /// Main-axis alignment of the children column. Default: start.
  final MainAxisAlignment? mainAxisAlignment;
  /// Space between the trigger content and the icon. Default: 16 × scaling.
  final double? iconGap;
  /// Returns a copy with the given fields replaced.
  CollapsibleTheme copyWith({ValueGetter<double?>? padding, ValueGetter<IconData?>? iconExpanded, ValueGetter<IconData?>? iconCollapsed, ValueGetter<CrossAxisAlignment?>? crossAxisAlignment, ValueGetter<MainAxisAlignment?>? mainAxisAlignment, ValueGetter<double?>? iconGap});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  CollapsibleTheme merge(CollapsibleTheme? fallback);
  /// Icons and alignments step at `t = 0.5`; dimensions are lerped.
  static CollapsibleTheme lerp(CollapsibleTheme a, CollapsibleTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```

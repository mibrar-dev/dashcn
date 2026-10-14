---
title: "Class: Divider"
description: "A one-pixel themed rule separating content, with an optional label."
---

```dart
/// A one-pixel themed rule separating content, with an optional label.
///
/// One widget for both orientations: upstream's `Separator` is the same element
/// with `orientation: horizontal | vertical`. The label splits the rule and is
/// placed with [DividerLabelAlignment].
class Divider extends StatelessWidget {
  /// Creates a divider.
  const Divider({super.key, this.axis = Axis.horizontal, this.color, this.thickness, this.extent, this.indent, this.endIndent, this.label, this.labelPadding, this.labelAlignment, this.theme});
  /// Orientation of the rule. A horizontal divider fills the available width;
  /// a vertical one fills the available height.
  final Axis axis;
  /// Rule colour override; null falls back to `DividerTheme.color`.
  final ThemedColor? color;
  /// Stroke width override; null falls back to `DividerTheme.thickness`.
  final double? thickness;
  /// Cross-axis extent override; null falls back to `DividerTheme.extent`.
  final double? extent;
  /// Space before the rule. Applies to the leading edge in both orientations.
  final double? indent;
  /// Space after the rule. Applies to the trailing edge in both orientations.
  final double? endIndent;
  /// Optional label centred in the rule. Omit it for a plain rule.
  final Widget? label;
  /// Padding around [label]; null falls back to `DividerTheme.labelPadding`, a
  /// density-scaled upstream `px-2` that this widget resolves against
  /// `density.baseContentPadding * scaling`. A literal override passes
  /// through unchanged.
  final EdgeInsetsGeometry? labelPadding;
  /// Cross-axis placement of [label]; null falls back to
  /// `DividerTheme.labelAlignment`.
  final DividerLabelAlignment? labelAlignment;
  /// Widget-leg override, merged over the component/app/defaults legs.
  final DividerTheme? theme;
  Widget build(BuildContext context);
}
```

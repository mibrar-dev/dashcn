---
title: "Class: Tooltip"
description: "A short label shown while the pointer rests on [child]."
---

```dart
/// A short label shown while the pointer rests on [child].
///
/// [tooltip] returns the bare content: the widget wraps it in a
/// [TooltipContainer] itself, so a plain `Text` is enough:
///
/// ```dart
/// Tooltip(
///   child: Icon(LucideIcons.info),
///   tooltip: (context) => const Text('Details'),
/// );
/// ```
class Tooltip extends StatefulWidget {
  /// Creates a tooltip.
  const Tooltip({super.key, required this.child, required this.tooltip, this.alignment = Alignment.topCenter, this.anchorAlignment = Alignment.bottomCenter, this.waitDuration = kTooltipWaitDuration, this.showDuration = kTooltipShowDuration, this.minDuration = Duration.zero, this.theme});
  /// The anchor the tooltip points at.
  final Widget child;
  /// Builds the tooltip content. The result is wrapped in a
  /// [TooltipContainer], so return the bare content (usually a `Text`).
  final WidgetBuilder tooltip;
  /// Where the tooltip sits relative to itself.
  final AlignmentGeometry alignment;
  /// Which edge of [child] the tooltip points at.
  final AlignmentGeometry anchorAlignment;
  /// Delay before the tooltip appears.
  final Duration waitDuration;
  /// Grace period after the pointer leaves.
  final Duration showDuration;
  /// Minimum time the tooltip stays visible.
  final Duration minDuration;
  /// Widget-leg theme override for the presented container.
  final TooltipTheme? theme;
  State<Tooltip> createState();
}
```

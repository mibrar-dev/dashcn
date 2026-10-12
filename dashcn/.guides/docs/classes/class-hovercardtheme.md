---
title: "Class: HoverCardTheme"
description: "Timing and placement contract of a hover card."
---

```dart
/// Timing and placement contract of a hover card.
class HoverCardTheme extends ComponentThemeData implements Mergeable<HoverCardTheme> {
  /// Creates a hover card theme.
  const HoverCardTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.debounce, this.wait, this.popoverAlignment, this.anchorAlignment, this.popoverOffset, this.behavior});
  /// Hide delay after the pointer leaves; null resolves 500 ms.
  final Duration? debounce;
  /// Show delay after the pointer enters; null resolves 500 ms.
  final Duration? wait;
  /// Card placement; null resolves top-center.
  final AlignmentGeometry? popoverAlignment;
  /// Anchor edge; null resolves bottom-center.
  final AlignmentGeometry? anchorAlignment;
  /// Gap between anchor and card; null resolves Offset(0, 8).
  final Offset? popoverOffset;
  /// Hit-test behaviour of the anchor; null resolves deferToChild.
  final HitTestBehavior? behavior;
  /// Returns a copy with the given fields replaced.
  HoverCardTheme copyWith({ValueGetter<Duration?>? debounce, ValueGetter<Duration?>? wait, ValueGetter<AlignmentGeometry?>? popoverAlignment, ValueGetter<AlignmentGeometry?>? anchorAlignment, ValueGetter<Offset?>? popoverOffset, ValueGetter<HitTestBehavior?>? behavior});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  HoverCardTheme merge(HoverCardTheme? fallback);
  bool operator ==(Object other);
  int get hashCode;
}
```

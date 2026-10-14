---
title: "Class: ScrollableClientTheme"
description: "Theme container for the scrollable client component."
---

```dart
/// Theme container for the scrollable client component.
///
/// Every field is nullable: an override leg sets only what it changes and
/// [merge] keeps the lower leg's remaining fields.
class ScrollableClientTheme extends ComponentThemeData implements Mergeable<ScrollableClientTheme> {
  /// Creates a scrollable client theme.
  const ScrollableClientTheme({super.themeDensity, super.themeSpacing, super.themeShadows, this.diagonalDragBehavior, this.dragStartBehavior, this.keyboardDismissBehavior, this.clipBehavior, this.hitTestBehavior, this.overscroll});
  /// How diagonal drags pick an axis. Default: none.
  final DiagonalDragBehavior? diagonalDragBehavior;
  /// When drag gestures start. Default: start.
  final DragStartBehavior? dragStartBehavior;
  /// Keyboard dismissal on drag. Default: manual.
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;
  /// Viewport clipping. Default: hardEdge.
  final Clip? clipBehavior;
  /// Hit-test behaviour of the scrollable. Default: opaque.
  final HitTestBehavior? hitTestBehavior;
  /// Whether offsets may move past the content edges. Default: false.
  final bool? overscroll;
  /// Returns a copy with the given fields replaced.
  ScrollableClientTheme copyWith({ValueGetter<DiagonalDragBehavior?>? diagonalDragBehavior, ValueGetter<DragStartBehavior?>? dragStartBehavior, ValueGetter<ScrollViewKeyboardDismissBehavior?>? keyboardDismissBehavior, ValueGetter<Clip?>? clipBehavior, ValueGetter<HitTestBehavior?>? hitTestBehavior, ValueGetter<bool?>? overscroll});
  /// First-non-null-wins merge; the receiver (higher-priority leg) wins.
  ScrollableClientTheme merge(ScrollableClientTheme? fallback);
  /// Enums and flags step at `t = 0.5`.
  static ScrollableClientTheme lerp(ScrollableClientTheme a, ScrollableClientTheme b, double t);
  bool operator ==(Object other);
  int get hashCode;
}
```

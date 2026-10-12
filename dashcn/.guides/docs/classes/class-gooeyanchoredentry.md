---
title: "Class: GooeyAnchoredEntry"
description: "Places one gooey toast inside an [Overlay]'s stack at [anchors]."
---

```dart
/// Places one gooey toast inside an [Overlay]'s stack at [anchors].
///
/// [offset] is the distance pushed away from the shared edge; it animates, so a
/// toast leaving the region slides the remaining ones into place instead of
/// jumping.
class GooeyAnchoredEntry extends StatelessWidget {
  /// Creates an anchored entry.
  const GooeyAnchoredEntry({super.key, required this.anchors, required this.offset, this.duration = const Duration(milliseconds: 220), required this.child});
  /// Resolved anchors of this toast.
  final GooeyEdgeAnchors anchors;
  /// Distance pushed away from the region edge.
  final double offset;
  /// Reflow duration of the stack offset.
  final Duration duration;
  /// Toast content.
  final Widget child;
  Widget build(BuildContext context);
}
```

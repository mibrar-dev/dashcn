---
title: "Class: FadeScroll"
description: "Fades the edges of [child] while [controller] reports hidden content."
---

```dart
/// Fades the edges of [child] while [controller] reports hidden content.
class FadeScroll extends StatefulWidget {
  /// Fade length from the start edge. Defaults to 0 (no start fade).
  final double? startOffset;
  /// Fade length from the end edge. Defaults to 0 (no end fade).
  final double? endOffset;
  /// The scrollable child.
  final Widget child;
  /// Controller monitored for the scroll position.
  final ScrollController controller;
  /// Creates a fade scroll widget.
  const FadeScroll({super.key, this.startOffset, this.endOffset, required this.child, required this.controller});
  State<FadeScroll> createState();
}
```

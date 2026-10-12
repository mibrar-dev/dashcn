---
title: "Class: CapturedWrapper"
description: "Wraps a subtree with captured themes and captured data."
---

```dart
/// Wraps a subtree with captured themes and captured data.
///
/// Overlay routes capture both from the opening context and re-inject them
/// into the route subtree; see [Data.capture].
class CapturedWrapper extends StatefulWidget {
  /// Captured inherited themes, if any.
  final CapturedThemes? themes;
  /// Captured data, if any.
  final CapturedData? data;
  /// The child widget.
  final Widget child;
  const CapturedWrapper({super.key, this.themes, this.data, required this.child});
  State<CapturedWrapper> createState();
}
```

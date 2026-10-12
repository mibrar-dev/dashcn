---
title: "Class: Label"
description: "A horizontal label with optional [leading] and [trailing] widgets."
---

```dart
/// A horizontal label with optional [leading] and [trailing] widgets.
class Label extends StatelessWidget {
  /// Optional leading widget.
  final Widget? leading;
  /// The label content.
  final Widget child;
  /// Optional trailing widget.
  final Widget? trailing;
  /// Creates a [Label].
  const Label({super.key, this.leading, required this.child, this.trailing});
  Widget build(BuildContext context);
}
```

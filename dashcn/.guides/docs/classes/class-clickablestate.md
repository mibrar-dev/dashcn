---
title: "Class: ClickableState"
description: "State of [Clickable]."
---

```dart
/// State of [Clickable].
///
/// Framework-internal: public only so the widget can create it across files.
class ClickableState extends State<Clickable> {
  void initState();
  void didUpdateWidget(covariant Clickable oldWidget);
  void dispose();
  /// Emits the tap semantics event and plays the platform click sound on
  /// mobile.
  static Future<void> feedbackForTap(BuildContext context);
  Widget build(BuildContext context);
  Matrix4? lerpMatrix4(Matrix4? a, Matrix4? b, double t);
}
```

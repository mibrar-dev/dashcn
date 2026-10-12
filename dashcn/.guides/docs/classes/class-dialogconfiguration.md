---
title: "Class: DialogConfiguration"
description: "Presents its content as a centered modal dialog."
---

```dart
/// Presents its content as a centered modal dialog.
class DialogConfiguration extends OverlayConfiguration {
  const DialogConfiguration({this.alignment = Alignment.center, this.barrierDismissible = true, this.barrierColor = const Color(0x80000000)});
  final AlignmentGeometry alignment;
  final bool barrierDismissible;
  final Color barrierColor;
  OverlayCompleter<T?> show<T>(BuildContext context, WidgetBuilder builder);
}
```

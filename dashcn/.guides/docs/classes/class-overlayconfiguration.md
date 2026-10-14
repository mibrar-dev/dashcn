---
title: "Class: OverlayConfiguration"
description: "Describes what overlay to show and how, independent of the specific  mechanism."
---

```dart
/// Describes what overlay to show and how, independent of the specific
/// mechanism.
abstract class OverlayConfiguration {
  const OverlayConfiguration();
  OverlayCompleter<T?> show<T>(BuildContext context, WidgetBuilder builder);
  OverlayConfiguration adaptiveConversion(BuildContext context);
  OverlayConfiguration get nonAdaptive;
  static OverlayConfiguration? maybeOf(BuildContext context);
}
```

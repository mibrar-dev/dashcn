---
title: "Class: OverlayController"
description: "Controls a single managed overlay presented from an  [OverlayConfiguration]."
---

```dart
/// Controls a single managed overlay presented from an
/// [OverlayConfiguration].
class OverlayController extends ChangeNotifier {
  OverlayConfiguration? get config;
  bool get hasOpenOverlay;
  bool get hasMountedOverlay;
  Future<T?> show<T>(BuildContext context, OverlayConfiguration configuration, {required WidgetBuilder builder, bool adaptive = true});
  void close();
  void closeLater();
  void dispose();
}
```

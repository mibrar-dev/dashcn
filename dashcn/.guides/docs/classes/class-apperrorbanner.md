---
title: "Class: AppErrorBanner"
description: "Reference for AppErrorBanner"
---

```dart
class AppErrorBanner extends StatelessWidget {
  /// Creates a banner.
  const AppErrorBanner({super.key, required this.scope, this.theme});
  /// The channel to render.
  final ErrorScope scope;
  /// Widget-leg override, merged over the component/app/defaults legs.
  final ErrorSystemTheme? theme;
  Widget build(BuildContext context);
}
```

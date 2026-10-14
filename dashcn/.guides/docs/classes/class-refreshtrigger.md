---
title: "Class: RefreshTrigger"
description: "Pull-to-refresh wrapper; null [onRefresh] disables pulling."
---

```dart
/// Pull-to-refresh wrapper; null [onRefresh] disables pulling.
class RefreshTrigger extends StatefulWidget {
  const RefreshTrigger({super.key, this.minExtent, this.maxExtent, this.onRefresh, this.direction = Axis.vertical, this.reverse = false, this.indicatorBuilder, this.curve, this.completeDuration, required this.child, this.theme});
  final double? minExtent;
  final double? maxExtent;
  final Future<void> Function()? onRefresh;
  final Axis direction;
  final bool reverse;
  final RefreshIndicatorBuilder? indicatorBuilder;
  final Curve? curve;
  final Duration? completeDuration;
  final Widget child;
  final RefreshTriggerTheme? theme;
  /// Default pill indicator (arrow, spinner, check + labels).
  static Widget defaultIndicatorBuilder(BuildContext context, RefreshTriggerStage stage);
  State<RefreshTrigger> createState();
}
```

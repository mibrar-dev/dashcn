---
title: "Class: ScrollViewInterceptor"
description: "Wraps [child] with middle-button autoscroll."
---

```dart
/// Wraps [child] with middle-button autoscroll.
///
/// ```dart
/// ScrollViewInterceptor(
///   child: SingleChildScrollView(child: content),
/// );
/// ```
class ScrollViewInterceptor extends StatefulWidget {
  /// Creates an interceptor around [child].
  const ScrollViewInterceptor({super.key, required this.child, this.enabled = true});
  /// The subtree that receives the synthetic scroll events.
  final Widget child;
  /// When false the child renders untouched and no pointer is intercepted.
  final bool enabled;
  State<ScrollViewInterceptor> createState();
}
```

---
title: "Class: DensityContentPadding"
description: "Padding resolved against content density and ambient scaling."
---

```dart
/// Padding resolved against content density and ambient scaling.
class DensityContentPadding extends StatelessWidget {
  const DensityContentPadding({super.key, required this.padding, required this.child});
  final EdgeInsetsGeometry padding;
  final Widget child;
  Widget build(BuildContext context);
}
```

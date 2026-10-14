---
title: "Class: DensityContainerPadding"
description: "Padding resolved against container density and ambient scaling."
---

```dart
/// Padding resolved against container density and ambient scaling.
class DensityContainerPadding extends StatelessWidget {
  const DensityContainerPadding({super.key, required this.padding, required this.child});
  final EdgeInsetsGeometry padding;
  final Widget child;
  Widget build(BuildContext context);
}
```

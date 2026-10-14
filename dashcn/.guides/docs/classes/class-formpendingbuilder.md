---
title: "Class: FormPendingBuilder"
description: "Renders [builder] with the form validations that are still in flight."
---

```dart
/// Renders [builder] with the form validations that are still in flight.
///
/// This primitive has no knowledge of any form controller: it always reports an
/// empty pending map. A `FormScope` that knows its own controller should drive
/// pending feedback from that controller directly.
class FormPendingBuilder extends StatelessWidget {
  /// Creates a pending builder that invokes [builder] with the pending map.
  const FormPendingBuilder({super.key, required this.builder, this.child});
  /// Widget handed to [builder] untouched.
  final Widget? child;
  /// Builds the pending display.
  final FormPendingWidgetBuilder builder;
  Widget build(BuildContext context);
}
```

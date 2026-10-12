---
title: "Class: Login02"
description: "A split login page: a validated form beside a testimonial panel."
---

```dart
/// A split login page: a validated form beside a testimonial panel.
class Login02 extends StatefulWidget {
  /// Creates the block.
  const Login02({super.key, this.onSubmit});
  /// Called once with the typed values after a valid submit (after a short
  /// simulated async call). Null keeps the demo success alert.
  final FutureOr<void> Function(Login02Data data)? onSubmit;
  State<Login02> createState();
}
```

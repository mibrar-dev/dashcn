---
title: "Class: Signup02"
description: "A two-column sign-up: validated form on the left, a plan summary aside."
---

```dart
/// A two-column sign-up: validated form on the left, a plan summary aside.
class Signup02 extends StatefulWidget {
  /// Creates the block.
  const Signup02({super.key, this.onSubmit, this.onSignIn});
  /// Called once with the typed values after a valid submit (after a short
  /// simulated async call). Null keeps the demo success alert.
  final FutureOr<void> Function(Signup02Data data)? onSubmit;
  /// Called when "Sign in" is tapped.
  final VoidCallback? onSignIn;
  State<Signup02> createState();
}
```

---
title: "Class: Signup01"
description: "A create-account card: validated name/email/password and a required terms  checkbox."
---

```dart
/// A create-account card: validated name/email/password and a required terms
/// checkbox.
class Signup01 extends StatefulWidget {
  /// Creates the block.
  const Signup01({super.key, this.onSubmit, this.onSignIn});
  /// Called once with the typed values after a valid submit (after a short
  /// simulated async call). Null keeps the demo success alert.
  final FutureOr<void> Function(Signup01Data data)? onSubmit;
  /// Called when "Sign in" is tapped.
  final VoidCallback? onSignIn;
  State<Signup01> createState();
}
```

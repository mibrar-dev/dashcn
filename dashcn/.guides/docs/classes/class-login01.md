---
title: "Class: Login01"
description: "A centred sign-in card: validated email/password, remember-me and actions."
---

```dart
/// A centred sign-in card: validated email/password, remember-me and actions.
class Login01 extends StatefulWidget {
  /// Creates the block.
  const Login01({super.key, this.onSubmit, this.onForgotPassword, this.onCreateAccount});
  /// Called once with the typed values after a valid submit (after a short
  /// simulated async call). Null keeps the demo success alert.
  final FutureOr<void> Function(Login01Data data)? onSubmit;
  /// Called when "Forgot password?" is tapped.
  final VoidCallback? onForgotPassword;
  /// Called when "Create an account" is tapped.
  final VoidCallback? onCreateAccount;
  State<Login01> createState();
}
```

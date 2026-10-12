---
title: "Class: Login03"
description: "A sign-in card with social provider buttons and a validated email form."
---

```dart
/// A sign-in card with social provider buttons and a validated email form.
class Login03 extends StatefulWidget {
  /// Creates the block.
  const Login03({super.key, this.onSubmit, this.onProvider, this.onForgotPassword, this.onSignUp});
  /// Called once with the typed values after a valid submit (after a short
  /// simulated async call). Null keeps the demo success alert.
  final FutureOr<void> Function(Login03Data data)? onSubmit;
  /// Called with the provider name when a social button is tapped.
  final ValueChanged<String>? onProvider;
  /// Called when "Forgot your password?" is tapped.
  final VoidCallback? onForgotPassword;
  /// Called when "Sign up" is tapped.
  final VoidCallback? onSignUp;
  State<Login03> createState();
}
```

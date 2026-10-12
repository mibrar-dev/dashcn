---
title: "Class: Account01PasswordForm"
description: "The password form: current, new (min 8) and a confirm-match check."
---

```dart
/// The password form: current, new (min 8) and a confirm-match check.
class Account01PasswordForm extends StatefulWidget {
  /// Creates the password form.
  const Account01PasswordForm({super.key, required this.onSubmit});
  /// Called once with the typed values after a valid submit.
  final FutureOr<void> Function(Account01PasswordData data)? onSubmit;
  State<Account01PasswordForm> createState();
}
```

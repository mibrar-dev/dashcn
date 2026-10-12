---
title: "Class: Otp01"
description: "A one-time-code verification card with a countdown before resending."
---

```dart
/// A one-time-code verification card with a countdown before resending.
class Otp01 extends StatefulWidget {
  /// Creates the block.
  const Otp01({super.key, this.email, this.onSubmit, this.onChangeEmail});
  /// The address the code was sent to.
  final String? email;
  /// Called once with the typed values after a valid submit (after a short
  /// simulated async call). Null keeps the demo success alert.
  final FutureOr<void> Function(Otp01Data data)? onSubmit;
  /// Called when "Use a different email" is tapped.
  final VoidCallback? onChangeEmail;
  State<Otp01> createState();
}
```

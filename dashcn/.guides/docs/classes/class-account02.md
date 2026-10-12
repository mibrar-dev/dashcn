---
title: "Class: Account02"
description: "A notifications preferences screen: per-channel rows plus a digest card."
---

```dart
/// A notifications preferences screen: per-channel rows plus a digest card.
class Account02 extends StatefulWidget {
  /// Creates the block.
  const Account02({super.key, this.onSubmit});
  /// Called once with the typed values after Save (after a short simulated
  /// async call). Null keeps the demo success alert.
  final FutureOr<void> Function(Account02Data data)? onSubmit;
  State<Account02> createState();
}
```

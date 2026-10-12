---
title: "Class: Account01ProfileForm"
description: "The profile form: avatar row, an equal-width name/username grid, bio."
---

```dart
/// The profile form: avatar row, an equal-width name/username grid, bio.
class Account01ProfileForm extends StatefulWidget {
  /// Creates the profile form.
  const Account01ProfileForm({super.key, required this.onSubmit, required this.onUploadAvatar});
  final FutureOr<void> Function(Account01ProfileData data)? onSubmit;
  final VoidCallback? onUploadAvatar;
  State<Account01ProfileForm> createState();
}
```

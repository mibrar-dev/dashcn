---
title: "Class: Account01"
description: "Values submitted by the [Account01] profile form."
---

```dart
/// Values submitted by the [Account01] profile form.
/// An account settings screen: tabbed profile, password and team sections.
class Account01 extends StatefulWidget {
  /// Creates the block.
  const Account01({super.key, this.onSubmitProfile, this.onSubmitPassword, this.onUploadAvatar, this.onInvite});
  /// Called once with the typed values after a valid profile submit.
  final FutureOr<void> Function(Account01ProfileData data)? onSubmitProfile;
  /// Called once with the typed values after a valid password submit.
  final FutureOr<void> Function(Account01PasswordData data)? onSubmitPassword;
  /// Called when "Upload image" is tapped.
  final VoidCallback? onUploadAvatar;
  /// Called when "Invite member" is tapped.
  final VoidCallback? onInvite;
  State<Account01> createState();
}
```

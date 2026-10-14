---
title: "Class: Pricing01PromoForm"
description: "The promo-code form: a validated 6-character code with an Apply action."
---

```dart
/// The promo-code form: a validated 6-character code with an Apply action.
class Pricing01PromoForm extends StatefulWidget {
  /// Creates the promo-code form.
  const Pricing01PromoForm({super.key, required this.onApplyPromo});
  /// Called once with the typed values after a valid submit.
  final FutureOr<void> Function(Pricing01PromoData data)? onApplyPromo;
  State<Pricing01PromoForm> createState();
}
```

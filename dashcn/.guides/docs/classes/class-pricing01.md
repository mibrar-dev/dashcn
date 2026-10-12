---
title: "Class: Pricing01"
description: "A pricing section: three plans, the middle one highlighted."
---

```dart
/// A pricing section: three plans, the middle one highlighted.
class Pricing01 extends StatelessWidget {
  /// Creates the block.
  const Pricing01({super.key, this.onSelectPlan, this.onApplyPromo});
  /// Called with the plan name when a plan button is tapped.
  final ValueChanged<String>? onSelectPlan;
  /// Called once with the typed values after a valid promo submit.
  final FutureOr<void> Function(Pricing01PromoData data)? onApplyPromo;
  Widget build(BuildContext context);
}
```

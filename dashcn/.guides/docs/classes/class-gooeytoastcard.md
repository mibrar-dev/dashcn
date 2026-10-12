---
title: "Class: GooeyToastCard"
description: "Renders one live toast: the metaball surface wrapped in the swipe-to-dismiss  gesture."
---

```dart
/// Renders one live toast: the metaball surface wrapped in the swipe-to-dismiss
/// gesture. There is no close button (dismiss is by timeout, swipe or the
/// controller's `dismiss`), matching the reference.
///
/// Owned by the controller's overlay entries; the compact pill and body are
/// the shared `GooeySurface` primitive, so the backdrop blur, the reduced-motion
/// policy and the density spacing all come from the ambient theme rather than
/// from this component.
class GooeyToastCard extends StatelessWidget {
  /// Creates a toast card.
  const GooeyToastCard({super.key, required this.payload, required this.controller});
  /// Resolved content and geometry of this toast.
  final GooeyToastPayload payload;
  /// Controller that owns the toast.
  final GooeyToastController controller;
  Widget build(BuildContext context);
}
```

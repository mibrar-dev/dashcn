---
title: "Class: Anchor"
description: "Describes an anchor an overlay (popover, menu, tooltip) positions itself  against, optionally tracking it as it moves."
---

```dart
/// Describes an anchor an overlay (popover, menu, tooltip) positions itself
/// against, optionally tracking it as it moves.
abstract class Anchor {
  /// Creates an [Anchor].
  const Anchor();
  /// Starts a live subscription to this anchor's position and visibility. The
  /// caller owns the result and **must** call
  /// [AnchorSubscription.dispose] on it.
  AnchorSubscription subscribe();
  /// Fills in any defaults this anchor needs from [context].
  ///
  /// The base implementation returns `this`; [ContextAnchor] substitutes the
  /// context of the `show()` call when it was not given one.
  Anchor resolve(BuildContext context);
}
```

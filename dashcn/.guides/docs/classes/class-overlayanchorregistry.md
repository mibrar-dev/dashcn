---
title: "Class: OverlayAnchorRegistry"
description: "Maps anchor keys to the [OverlayAnchor] entries registered under them."
---

```dart
/// Maps anchor keys to the [OverlayAnchor] entries registered under them.
/// Registrations never escape their own [OverlayAnchorScope].
class OverlayAnchorRegistry {
  /// Creates a registry, optionally chained to a [parent].
  OverlayAnchorRegistry({this.parent});
  /// The enclosing scope's registry; [find] falls back to it, and so on up the
  /// chain. Registrations stay local.
  OverlayAnchorRegistry? parent;
  /// The registry of [context]'s nearest [OverlayAnchorScope], or null. Does
  /// not create an inherited-widget dependency, so it is safe to call outside
  /// `build` (for example while showing an overlay).
  static OverlayAnchorRegistry? maybeOf(BuildContext context);
  /// Registers [entry] under [key] in this registry.
  void register(Object key, OverlayAnchorEntry entry);
  /// Removes the entry for [key].
  void unregister(Object key);
  /// The entry for [key], falling back to [parent] and up the chain.
  OverlayAnchorEntry? find(Object key);
}
```

---
title: "Class: RovingGroupRegistry"
description: "The members of one roving group."
---

```dart
/// The members of one roving group.
///
/// A member registers from its own `build`, so [ordered] is tree order.
class RovingGroupRegistry<T> {
  /// Adds or replaces a member's registration.
  void register(RovingItem<T> item);
  /// Drops a member's registration.
  void unregister(Object key);
  /// The members in registration order.
  List<RovingItem<T>> ordered();
  /// Whether the arrow keys walk top to bottom ([Axis.vertical]) or left to
  /// right ([Axis.horizontal]).
  Axis direction;
  /// Called with the value the walk landed on, before focus moves there.
  void Function(T value)? onSelect;
  /// Walks [delta] positions from the current member, skipping disabled ones and
  /// wrapping around, reports the landing value and focuses that member.
  ///
  /// When nothing is selected the walk starts before the first member for a
  /// positive [delta] and after the last for a negative one, so the first arrow
  /// press lands on an end rather than on the second item. Null when there is
  /// nothing to land on.
  RovingItem<T>? move(int delta);
  /// The arrow-key map a member hands to its own `Clickable`.
  ///
  /// `Clickable` binds the arrow keys to directional focus traversal, and the
  /// nearest `Shortcuts` wins, so a group that wrapped its members in its own
  /// `Shortcuts` would never be reached. Handing the map to each member puts
  /// the traversal in front of that default instead.
  Map<LogicalKeySet, Intent> get shortcuts;
  /// The action map that goes with [shortcuts].
  Map<Type, Action<Intent>> get actions;
  /// The scope the members are wrapped in. Goes through `Data` so a member
  /// resolves it with `Data.maybeOf<RovingGroupRegistry<T>>(context)`.
  RovingGroupScope<T> scope({required Widget child});
}
```

---
title: "Class: SegmentedObjectController"
description: "Live state behind one segmented object field: the cached [SegmentedValue]  shape plus the current segment texts."
---

```dart
/// Live state behind one segmented object field: the cached [SegmentedValue]
/// shape plus the current segment texts. Plain data (not a ChangeNotifier);
/// owners repaint after mutating calls.
///
/// A parent echoing an intermediate null never wipes typing: external values
/// apply only through [resyncValue], while edits flow through [applyEdit].
class SegmentedObjectController<T> {
  /// Creates an empty controller; call [resyncShape] before first build.
  SegmentedObjectController();
  /// The cached shape; empty until [resyncShape] runs.
  SegmentedValue shape;
  /// Current segment texts (seed, live edits, external values).
  List<String> texts;
  /// Rebuilds the shape from [rungs] and seeds texts (initial or new shape).
  void resyncShape(List<SegmentRung> rungs, List<String> seed);
  /// Applies an external value, replacing the live texts.
  void resyncValue(List<String> seed);
  /// Records an edit round-trip.
  void applyEdit(List<String> next);
  /// The shape carrying the live texts, for controlled fields.
  SegmentedValue get shown;
}
```

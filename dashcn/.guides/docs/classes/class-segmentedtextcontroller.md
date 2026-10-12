---
title: "Class: SegmentedTextController"
description: "Owns the controllers, the focus nodes and the value flow of a segmented  field."
---

```dart
/// Owns the controllers, the focus nodes and the value flow of a segmented
/// field. One controller per [TextSegment]; the caller renders the widgets.
class SegmentedTextController extends ChangeNotifier {
  /// Creates a controller for [segments].
  SegmentedTextController({required List<TextSegment> segments, List<String> values = const <String>[]});
  /// One controller per segment, in segment order.
  final List<TextEditingController> controllers;
  /// One focus node per segment, in segment order.
  final List<FocusNode> focusNodes;
  /// The segment definitions.
  List<TextSegment> get segments;
  /// Number of segments.
  int get length;
  /// The text of every segment.
  List<String> get values;
  /// Whether every segment is full.
  bool get isComplete;
  /// Writes [text] into the segment at [index], clamped to its length.
  ///
  /// A write that would not change the text is skipped entirely, so a
  /// keystroke round-trip never resets the caret or clears the IME composing
  /// region. Otherwise the selection is clamped into the new text (invalid
  /// selections collapse at the end) and a still-valid composing range is
  /// kept; it never resets to `collapsed(-1)`.
  void setText(int index, String text, {bool notify = true});
  /// Replaces every segment value, clamping each to its length.
  ///
  /// Each segment is skipped when its text already matches, preserving the
  /// focused caret; differing segments keep a clamped selection (see
  /// [setText]).
  void setValues(List<String> values, {bool notify = true});
  /// Grows or shrinks the segment list, keeping the values that survive.
  ///
  /// Returns true when the segment list changed.
  bool resize(List<TextSegment> segments);
  /// Focuses [index] when it exists; false otherwise.
  bool focus(int index);
  /// Moves the focus to the next ([delta] 1) or previous ([delta] -1) segment.
  bool moveFocus(int from, int delta);
  /// Whether the caret of segment [index] sits at the start, so a backspace or
  /// <kbd>←</kbd> should move to the previous segment.
  bool atStart(int index);
  /// Whether the caret of segment [index] sits at the end, so <kbd>→</kbd>
  /// should move to the next segment.
  bool atEnd(int index);
  /// Whether segment [index] is full and the next one should take over.
  bool isFull(int index);
  /// Selects the whole text of every segment.
  void selectAll();
  /// The selected text of every segment, in order (empty when nothing is
  /// selected in a segment).
  String get selectedText;
  /// The whole field's text.
  String get text;
  void dispose();
}
```

---
title: "Class: FormattedInputFlow"
description: "Segment mechanics of one `FormattedInput`."
---

```dart
/// Segment mechanics of one `FormattedInput`.
class FormattedInputFlow {
  /// Creates a flow over [segments].
  FormattedInputFlow({required this.segments, required this.readValue, required this.writeValue});
  /// The segment controllers, owned (created/disposed) by the widget.
  final SegmentedTextController segments;
  /// The value the widget is currently driven by.
  final SegmentedValue Function() readValue;
  /// Writes the next value: `controller.value =` in controller mode, the
  /// validating state update otherwise.
  final void Function(SegmentedValue value) writeValue;
  /// Handles an edit of segment [index] to [text].
  void handleChanged(int index, String text);
  /// Distributes pasted/over-typed [text] from [index] across segments.
  void handleOverflow(int index, String text);
  /// Runs segment [index]'s custom formatters over [input].
  String filterForSegment(int index, String input);
  /// Focuses [target] with the caret at its start (the typing handover).
  void advanceTo(int target);
  /// Handles cross-segment keys: backspace at a segment start deletes back,
  /// edge arrows cross with the caret placed at the far end.
  ///
  /// The focused segment is found by focus (the callback runs on the
  /// wrapping `Focus` node, not on a segment node).
  KeyEventResult handleKey(KeyEvent event);
  /// Width for [part]: the measured content minimum, with [part.width] only
  /// ever widening it (an explicit override, never narrower than needed).
  double effectiveWidth(SegmentPart part, {required TextStyle textStyle, TextStyle? placeholderStyle, required double densityScale});
}
```

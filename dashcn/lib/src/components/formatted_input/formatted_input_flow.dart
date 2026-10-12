// Interaction behind `FormattedInput`: typing handover, paste overflow,
// cross-segment keys, segment widths and the segment widget.
//
// Split out of `formatted_input.dart` so both files stay under the 400-line
// rule. The widget owns the value, validation, controllers and focus
// listeners; this owns the pure segment mechanics over a
// [SegmentedTextController] plus two callbacks bridging the controlled,
// controller-driven and uncontrolled modes.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../primitives/text_editing/segmented_editing.dart';
import '../../primitives/text_editing/segmented_value.dart';
import '../../primitives/text_editing/text_editing.dart';
import 'formatted_input_style.dart';

/// Segment mechanics of one `FormattedInput`.
class FormattedInputFlow {
  /// Creates a flow over [segments].
  FormattedInputFlow({
    required this.segments,
    required this.readValue,
    required this.writeValue,
  });

  /// The segment controllers, owned (created/disposed) by the widget.
  final SegmentedTextController segments;

  /// The value the widget is currently driven by.
  final SegmentedValue Function() readValue;

  /// Writes the next value: `controller.value =` in controller mode, the
  /// validating state update otherwise.
  final void Function(SegmentedValue value) writeValue;

  /// Handles an edit of segment [index] to [text].
  void handleChanged(int index, String text) {
    if (index < 0 || index >= segments.length) {
      return;
    }
    final int cap = segments.segments[index].length;
    // Overflow (paste or fast typing into one box) distributes across the
    // following segments; the length limiter is intentionally *not* a
    // formatter so the overflow survives until here.
    if (text.length > cap) {
      handleOverflow(index, text);
      return;
    }
    final SegmentedValue next = readValue().withValue(index, text);
    writeValue(next);
    // A full segment hands over to the next one with the caret at its start.
    // While an IME composition is active the caret stays put.
    if (!segments.controllers[index].value.isComposingRangeValid &&
        segments.isFull(index)) {
      advanceTo(index + 1);
    }
  }

  /// Distributes pasted/over-typed [text] from [index] across segments.
  void handleOverflow(int index, String text) {
    final int cap = segments.segments[index].length;
    final String head = text.substring(0, cap);
    final String overflow = text.substring(cap);
    final List<String> nextTexts = segments.values;
    nextTexts[index] = head;
    String clean = filterForSegment(
      index + 1 < segments.length ? index + 1 : index,
      overflow,
    );
    for (int j = index + 1; j < segments.length && clean.isNotEmpty; j++) {
      final int room = segments.segments[j].length - nextTexts[j].length;
      if (room <= 0) {
        continue;
      }
      final String forSegment = filterForSegment(j, clean);
      if (forSegment.isEmpty) {
        break;
      }
      final String take = forSegment.length > room
          ? forSegment.substring(0, room)
          : forSegment;
      nextTexts[j] = nextTexts[j] + take;
      clean = forSegment.substring(take.length);
    }
    SegmentedValue next = readValue();
    for (int i = 0; i < nextTexts.length; i++) {
      next = next.withValue(i, nextTexts[i]);
    }
    writeValue(next);
    // Land on the first incomplete segment at or after the paste origin
    // (caret at its end); when everything is full, stay on the last box.
    int target = segments.length - 1;
    for (int j = index; j < nextTexts.length; j++) {
      if (nextTexts[j].length < segments.segments[j].length) {
        target = j;
        break;
      }
    }
    if (segments.focus(target)) {
      segments.controllers[target].selection = TextSelection.collapsed(
        offset: nextTexts[target].length,
      );
    }
  }

  /// Runs segment [index]'s custom formatters over [input].
  String filterForSegment(int index, String input) {
    if (input.isEmpty || index < 0 || index >= segments.segments.length) {
      return input;
    }
    final List<TextInputFormatter> formatters =
        segments.segments[index].inputFormatters;
    if (formatters.isEmpty) {
      return input;
    }
    TextEditingValue old = TextEditingValue.empty;
    TextEditingValue next = TextEditingValue(
      text: input,
      selection: TextSelection.collapsed(offset: input.length),
    );
    for (final TextInputFormatter formatter in formatters) {
      next = formatter.formatEditUpdate(old, next);
      old = TextEditingValue.empty;
    }
    return next.text;
  }

  /// Focuses [target] with the caret at its start (the typing handover).
  void advanceTo(int target) {
    if (target < 0 || target >= segments.length) {
      return;
    }
    if (segments.focus(target)) {
      segments.controllers[target].selection = const TextSelection.collapsed(
        offset: 0,
      );
    }
  }

  /// Handles cross-segment keys: backspace at a segment start deletes back,
  /// edge arrows cross with the caret placed at the far end.
  ///
  /// The focused segment is found by focus (the callback runs on the
  /// wrapping `Focus` node, not on a segment node).
  KeyEventResult handleKey(KeyEvent event) {
    if (event is! KeyDownEvent) {
      return KeyEventResult.ignored;
    }
    final int index = segments.focusNodes.indexWhere(
      (FocusNode focus) => focus.hasFocus,
    );
    if (index < 0) {
      return KeyEventResult.ignored;
    }
    final LogicalKeyboardKey key = event.logicalKey;
    if (key == LogicalKeyboardKey.backspace) {
      // Inside the text the field deletes normally.
      if (!segments.atStart(index)) {
        return KeyEventResult.ignored;
      }
      if (index == 0) {
        return KeyEventResult.ignored;
      }
      final String current = segments.controllers[index].text;
      final int previous = index - 1;
      if (current.isEmpty) {
        // Empty box: step back and delete the previous box's last glyph.
        final String previousText = segments.controllers[previous].text;
        if (previousText.isEmpty) {
          if (segments.focus(previous)) {
            segments.controllers[previous].selection =
                const TextSelection.collapsed(offset: 0);
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        }
        final String truncated = previousText.substring(
          0,
          previousText.length - 1,
        );
        segments.focus(previous);
        handleChanged(previous, truncated);
        segments.controllers[previous].selection = TextSelection.collapsed(
          offset: truncated.length,
        );
        return KeyEventResult.handled;
      }
      // Non-empty box with the caret at 0: step back without deleting.
      if (segments.focus(previous)) {
        final int length = segments.controllers[previous].text.length;
        segments.controllers[previous].selection = TextSelection.collapsed(
          offset: length,
        );
        return KeyEventResult.handled;
      }
      return KeyEventResult.ignored;
    }
    if (key == LogicalKeyboardKey.arrowLeft) {
      if (!segments.atStart(index) || index == 0) {
        return KeyEventResult.ignored;
      }
      final int previous = index - 1;
      if (segments.focus(previous)) {
        final int length = segments.controllers[previous].text.length;
        segments.controllers[previous].selection = TextSelection.collapsed(
          offset: length,
        );
        return KeyEventResult.handled;
      }
      return KeyEventResult.ignored;
    }
    if (key == LogicalKeyboardKey.arrowRight) {
      if (!segments.atEnd(index) || index >= segments.length - 1) {
        return KeyEventResult.ignored;
      }
      final int next = index + 1;
      if (segments.focus(next)) {
        segments.controllers[next].selection = const TextSelection.collapsed(
          offset: 0,
        );
        return KeyEventResult.handled;
      }
      return KeyEventResult.ignored;
    }
    return KeyEventResult.ignored;
  }

  /// Width for [part]: the measured content minimum, with [part.width] only
  /// ever widening it (an explicit override, never narrower than needed).
  double effectiveWidth(
    SegmentPart part, {
    required TextStyle textStyle,
    TextStyle? placeholderStyle,
    required double densityScale,
  }) => segmentMinWidthForPart(
    part,
    textStyle: textStyle,
    placeholderStyle: placeholderStyle ?? textStyle,
    densityScale: densityScale,
  );
}

/// One editable segment: the placeholder overlay under the centered
/// single-line [EditableText].
///
/// The overlay never wraps (`softWrap: false`, one line, clipped) and the
/// box always fits it (see [segmentMinWidth]), so labels like `MM` render on
/// exactly one line.
Widget buildFormattedSegment({
  required FormattedInputSurface surface,
  required SegmentPart part,
  required TextEditingController controller,
  required FocusNode focusNode,
  required bool enabled,
  required ValueChanged<String> onChanged,
  required ValueChanged<String> onSubmitted,
}) {
  return Stack(
    alignment: AlignmentDirectional.centerStart,
    children: <Widget>[
      if (controller.text.isEmpty && part.placeholder != null)
        IgnorePointer(
          child: DefaultTextStyle.merge(
            style: surface.placeholderStyle,
            textAlign: TextAlign.center,
            softWrap: false,
            overflow: TextOverflow.clip,
            maxLines: 1,
            child: part.placeholder!,
          ),
        ),
      EditableText(
        controller: controller,
        focusNode: focusNode,
        readOnly: !enabled,
        maxLines: 1,
        textAlign: TextAlign.center,
        obscureText: part.obscureText,
        backgroundCursorColor: surface.cursorColor.withValues(alpha: 0.2),
        // No length limiter: overflow is distributed across segments in
        // [handleChanged]/[handleOverflow] so paste keeps every glyph.
        inputFormatters: part.inputFormatters,
        style: surface.textStyle,
        cursorColor: surface.cursorColor,
        selectionControls: SelectionControls(),
        contextMenuBuilder: defaultContextMenuBuilder,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      ),
    ],
  );
}

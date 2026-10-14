// Keyboard resizing for the `table` component's dividers.
//
// Extracted from `table_resize.dart` so that file stays within the 400-line
// limit. The single entry point is [handleTableResizeKey]: arrows step the
// divider in `resizableHandleStep` increments (the shared `resizable` step),
// Home/End jump the leading cell to its min/max bound. It mirrors the drag
// path (same mode, same RTL flip, same controller clamping), so a keyboard
// resize lands where the equivalent drag would.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../resizable_handle.dart';
import 'table_layout.dart';
import 'table_resize_controller.dart';

/// Moves the divider at [boundary] from a key event.
///
/// [rowAxis] selects row dividers (Up/Down) over column dividers
/// (Left/Right); [mode] and [maxIndex] apply the same reallocate/expand rules
/// as a drag. Column deltas flip under [textDirection] exactly like pointer
/// deltas. Returns whether the event was consumed.
KeyEventResult handleTableResizeKey({
  required ResizableTableController controller,
  required bool rowAxis,
  required int boundary,
  required int maxIndex,
  required TableCellResizeMode mode,
  required TextDirection textDirection,
  required KeyEvent event,
}) {
  if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
    return KeyEventResult.ignored;
  }
  final LogicalKeyboardKey key = event.logicalKey;
  if (key == LogicalKeyboardKey.home || key == LogicalKeyboardKey.end) {
    final bool toEnd = key == LogicalKeyboardKey.end;
    final double? bound = rowAxis
        ? (toEnd
              ? controller.getRowMaxHeight(boundary)
              : controller.getRowMinHeight(boundary) ?? 0)
        : (toEnd
              ? controller.getColumnMaxWidth(boundary)
              : controller.getColumnMinWidth(boundary) ?? 0);
    if (bound == null || !bound.isFinite) {
      return KeyEventResult.ignored;
    }
    if (rowAxis) {
      controller.resizeRow(boundary, bound);
    } else {
      controller.resizeColumn(boundary, bound);
    }
    return KeyEventResult.handled;
  }
  double? delta;
  if (rowAxis) {
    if (key == LogicalKeyboardKey.arrowUp) {
      delta = -resizableHandleStep;
    } else if (key == LogicalKeyboardKey.arrowDown) {
      delta = resizableHandleStep;
    }
  } else {
    if (key == LogicalKeyboardKey.arrowLeft) {
      delta = -resizableHandleStep;
    } else if (key == LogicalKeyboardKey.arrowRight) {
      delta = resizableHandleStep;
    }
  }
  if (delta == null) {
    return KeyEventResult.ignored;
  }
  if (!rowAxis && textDirection == TextDirection.rtl) {
    delta = -delta;
  }
  if (mode == TableCellResizeMode.reallocate && boundary + 1 <= maxIndex) {
    if (rowAxis) {
      controller.resizeRowBorder(boundary, boundary + 1, delta);
    } else {
      controller.resizeColumnBorder(boundary, boundary + 1, delta);
    }
  } else if (rowAxis) {
    controller.resizeRow(boundary, controller.getRowHeight(boundary) + delta);
  } else {
    controller.resizeColumn(
      boundary,
      controller.getColumnWidth(boundary) + delta,
    );
  }
  return KeyEventResult.handled;
}

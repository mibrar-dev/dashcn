// Search synchronization and caret preservation helper for `filter_bar`.

import 'package:flutter/widgets.dart';

/// Syncs external search text changes into [controller] while preserving
/// caret position at the end during user typing and clamping stale selections.
void syncFilterSearchText({
  required TextEditingController controller,
  required String nextText,
  required String lastEmittedText,
}) {
  final String prev = controller.text;
  final TextSelection prevSel = controller.selection;
  controller.text = nextText;

  if (!prevSel.isValid) {
    controller.selection = TextSelection.collapsed(offset: nextText.length);
  } else {
    final bool atEnd =
        prevSel.baseOffset == prev.length &&
        prevSel.extentOffset == prev.length;
    final bool appended =
        nextText.length >= prev.length && nextText.startsWith(prev);
    if (atEnd && appended) {
      controller.selection = TextSelection.collapsed(offset: nextText.length);
    } else {
      controller.selection = prevSel.copyWith(
        baseOffset: prevSel.baseOffset.clamp(0, nextText.length),
        extentOffset: prevSel.extentOffset.clamp(0, nextText.length),
      );
    }
  }
}

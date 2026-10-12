// Playground builder for the `keyboard_shortcut` component.

import 'package:docs/playground/values.dart';
import 'package:docs/ui/dashcn/components/keyboard_shortcut/keyboard_shortcut.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Renders a [KeyboardShortcut] from playground values.
///
/// The chord is builder-owned demo content; the `spacing` control owns the
/// key gap.
Widget buildKeyboardShortcutPlayground(
  BuildContext context,
  PlaygroundValues values,
) {
  return KeyboardShortcut(
    keys: const <LogicalKeyboardKey>[
      LogicalKeyboardKey.meta,
      LogicalKeyboardKey.keyK,
    ],
    spacing: values.getDouble('spacing'),
  );
}

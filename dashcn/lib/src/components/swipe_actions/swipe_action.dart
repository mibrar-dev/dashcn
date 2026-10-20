// The trailing action model for [SwipeActions] rows.
//
// Split from `swipe_actions.dart` so the button run (`swipe_action_buttons`)
// and the row share the model without an import cycle.

import 'package:flutter/widgets.dart';

/// Builds one action button with its reveal [progress] (0 closed, 1 open).
///
/// Return any widget; wrap it in a pressable yourself when the row should
/// stay keyboard-reachable.
typedef SwipeActionBuilder =
    Widget Function(BuildContext context, double progress);

/// One trailing action revealed by [SwipeActions].
class SwipeAction {
  /// Creates a trailing action.
  const SwipeAction({
    required this.label,
    this.icon,
    this.onPressed,
    this.destructive = false,
    this.builder,
  });

  /// Text shown in the default action button.
  final String label;

  /// Icon shown above [label] in the default button; null shows the label.
  final Widget? icon;

  /// Called when the default action button is tapped.
  final VoidCallback? onPressed;

  /// Whether the default button uses the destructive variant.
  final bool destructive;

  /// Custom button builder: receives the reveal progress (0 closed, 1 open)
  /// so the button can scale/fade in with the drag. Null builds the default
  /// secondary/destructive button.
  final SwipeActionBuilder? builder;
}

// The action model of the `fab` component's speed dial.
//
// [FabSpeedDialDirection] says where the mini actions unfold to,
// [FabSpeedDialAction] describes one of them and
// [FabSpeedDialActionBuilder] lets a caller replace the widget a mini action
// paints. The dial itself lives in `fab_speed_dial.dart`.

import 'package:flutter/widgets.dart';

/// Where the mini actions unfold to.
enum FabSpeedDialDirection {
  /// Above the main button.
  up,

  /// Below the main button.
  down,

  /// Before the main button (left in LTR, right in RTL).
  start,

  /// After the main button (right in LTR, left in RTL).
  end,
}

/// One mini action of a [FabSpeedDial].
class FabSpeedDialAction {
  /// Creates a mini action.
  const FabSpeedDialAction({
    required this.icon,
    this.label,
    this.tooltip,
    this.semanticLabel,
    this.onPressed,
    this.enabled = true,
  });

  /// The action icon; usually an `Icon`.
  final Widget icon;

  /// Optional text shown next to the mini action.
  final Widget? label;

  /// Hover label for the mini action.
  final String? tooltip;

  /// Accessible name of the mini action.
  final String? semanticLabel;

  /// Called when the mini action is pressed.
  final VoidCallback? onPressed;

  /// Whether the mini action accepts input.
  final bool enabled;

  /// Returns a copy with the given fields replaced.
  FabSpeedDialAction copyWith({
    Widget? icon,
    Widget? label,
    String? tooltip,
    String? semanticLabel,
    VoidCallback? onPressed,
    bool? enabled,
  }) {
    return FabSpeedDialAction(
      icon: icon ?? this.icon,
      label: label ?? this.label,
      tooltip: tooltip ?? this.tooltip,
      semanticLabel: semanticLabel ?? this.semanticLabel,
      onPressed: onPressed ?? this.onPressed,
      enabled: enabled ?? this.enabled,
    );
  }
}

/// Builds one mini action of a [FabSpeedDial].
///
/// [expanded] is the dial's state and [index] is the action's position in
/// the list (0 is the action closest to the main button).
typedef FabSpeedDialActionBuilder =
    Widget Function(
      BuildContext context,
      FabSpeedDialAction action,
      int index, {
      required bool expanded,
    });

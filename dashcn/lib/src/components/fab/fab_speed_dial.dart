// The speed dial of the `fab` component: [FabSpeedDial], a floating action
// button that expands into a stack of mini actions.
//
// The mini actions unfold along [direction] (directional, so it mirrors in
// RTL) and collapse back into the main button. The motion follows the theme
// tokens and collapses to zero under reduced motion.

import 'package:flutter/widgets.dart';

import '../../primitives/animated_value_builder.dart';
import '../../primitives/hidden.dart';
import '../../primitives/motion/motion_scope.dart';
import '../../theme/theme.dart';
import 'fab.dart';

// The action model is re-exported (not imported): the names reach this file
// through `fab.dart`, which exports this file, so a direct import would be
// a duplicate of the same library.
export 'fab_speed_dial_action.dart';

/// A floating action button that expands into mini actions.
///
/// The dial is controlled when [expanded] is non-null (the parent owns the
/// state and [onExpandedChanged] reports the new one) and uncontrolled
/// otherwise.
class FabSpeedDial extends StatefulWidget {
  /// Creates a speed dial.
  const FabSpeedDial({
    super.key,
    required this.icon,
    required this.actions,
    this.label,
    this.size = FabSize.md,
    this.direction = FabSpeedDialDirection.up,
    this.expanded,
    this.onExpandedChanged,
    this.tooltip,
    this.semanticLabel,
    this.style,
    this.theme,
    this.actionBuilder,
    this.miniSize,
  });

  /// The main button's icon.
  final Widget icon;

  /// The mini actions, closest to the main button first.
  final List<FabSpeedDialAction> actions;

  /// Optional label of the main button (the extended shape).
  final Widget? label;

  /// Fixed size of the main button box.
  final FabSize size;

  /// Where the mini actions unfold to.
  final FabSpeedDialDirection direction;

  /// Controlled expansion state; null means the dial owns the state.
  final bool? expanded;

  /// Called with the next expansion state.
  final ValueChanged<bool>? onExpandedChanged;

  /// Hover label of the main button.
  final String? tooltip;

  /// Accessible name of the main button.
  final String? semanticLabel;

  /// Widget-leg style override for the main button.
  final FabStyle? style;

  /// Generic widget-leg style override for the main button.
  final FabStyle? theme;

  /// Builder slot for the mini actions; null uses the default mini button.
  final FabSpeedDialActionBuilder? actionBuilder;

  /// Fixed size of the mini action buttons; null follows [size].
  final FabSize? miniSize;

  @override
  State<FabSpeedDial> createState() => _FabSpeedDialState();
}

class _FabSpeedDialState extends State<FabSpeedDial> {
  bool _expanded = false;

  bool get _isExpanded => widget.expanded ?? _expanded;

  void _toggle() {
    final bool next = !_isExpanded;
    if (widget.expanded == null) {
      setState(() => _expanded = next);
    }
    widget.onExpandedChanged?.call(next);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData ambient = Theme.of(context);
    final bool expanded = _isExpanded;
    final Duration duration = resolveMotionDuration(
      context,
      ambient.motion.durations.base,
    );
    final Curve curve = ambient.motion.curves.emphasizedOut;

    final Widget main = Fab(
      icon: widget.icon,
      label: widget.label,
      size: widget.size,
      onPressed: _toggle,
      tooltip: widget.tooltip,
      semanticLabel: widget.semanticLabel,
      style: widget.style,
      theme: widget.theme,
    );

    final bool vertical =
        widget.direction == FabSpeedDialDirection.up ||
        widget.direction == FabSpeedDialDirection.down;
    // The actions collapse towards the main button, so the collapsed dial
    // takes no room next to it.
    final bool reverse =
        widget.direction == FabSpeedDialDirection.up ||
        widget.direction == FabSpeedDialDirection.start;

    final Widget actions = Hidden(
      hidden: !expanded,
      direction: vertical ? Axis.vertical : Axis.horizontal,
      reverse: reverse,
      keepCrossAxisSize: true,
      duration: duration,
      curve: curve,
      child: _buildActions(context, duration, curve, expanded, vertical),
    );

    final Widget stack = vertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (widget.direction == FabSpeedDialDirection.up) actions,
              main,
              if (widget.direction == FabSpeedDialDirection.down) actions,
            ],
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (widget.direction == FabSpeedDialDirection.start) actions,
              main,
              if (widget.direction == FabSpeedDialDirection.end) actions,
            ],
          );

    return Semantics(expanded: expanded, child: stack);
  }

  /// The mini actions, laid out along the dial's axis.
  Widget _buildActions(
    BuildContext context,
    Duration duration,
    Curve curve,
    bool expanded,
    bool vertical,
  ) {
    final List<Widget> built = <Widget>[];
    for (int i = 0; i < widget.actions.length; i++) {
      built.add(
        _buildAction(context, widget.actions[i], i, duration, curve, expanded),
      );
    }
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: vertical ? 8 : 0,
        horizontal: vertical ? 0 : 8,
      ),
      child: vertical
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: built,
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: built,
            ),
    );
  }

  Widget _buildAction(
    BuildContext context,
    FabSpeedDialAction action,
    int index,
    Duration duration,
    Curve curve,
    bool expanded,
  ) {
    // Each action starts a little later than the previous one, so the stack
    // unfolds instead of appearing at once.
    final double stagger = (index * 0.15).clamp(0.0, 0.6);
    final Widget child =
        widget.actionBuilder?.call(
          context,
          action,
          index,
          expanded: expanded,
        ) ??
        _defaultAction(action);
    return AnimatedValueBuilder<double>(
      value: expanded ? 1 : 0,
      duration: duration,
      curve: Curves.linear,
      builder: (BuildContext context, double raw, Widget? inner) {
        final double local = ((raw - stagger) / (1 - stagger)).clamp(0.0, 1.0);
        final double eased = curve.transform(local);
        return Opacity(
          opacity: eased,
          child: Transform.scale(scale: 0.6 + 0.4 * eased, child: inner),
        );
      },
      child: child,
    );
  }

  Widget _defaultAction(FabSpeedDialAction action) {
    final Widget mini = Fab(
      icon: action.icon,
      size: widget.miniSize ?? FabSize.sm,
      shape: FabShape.mini,
      onPressed: action.onPressed,
      enabled: action.enabled,
      tooltip: action.tooltip,
      semanticLabel: action.semanticLabel,
    );
    final Widget? label = action.label;
    if (label == null) {
      return mini;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[mini, const SizedBox(width: 8), label],
    );
  }
}

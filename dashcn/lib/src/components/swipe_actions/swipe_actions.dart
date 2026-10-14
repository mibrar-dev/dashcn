// The `swipe_actions` component: swipe a row to reveal trailing actions.
//
// The actions sit behind the child in a [Stack]; a horizontal drag slides
// the child aside (mirrored under RTL) and the row settles open or closed on
// release by position + fling velocity. Dragging past the full width when
// [SwipeActions.onDismissed] is set dismisses the row (dismiss-to-delete).
//
// The actions are real [Button]s, so keyboard focus and screen readers reach
// them once revealed; while closed they are removed from semantics and focus.

import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import '../button/button.dart';

/// Programmatic control of a [SwipeActions] row: [open] / [close] settle it
/// and [isOpen] reports whether any action is revealed.
///
/// Flows use it to reveal rows deterministically in tests; apps use it to
/// close swiped rows when the list scrolls or refreshes.
class SwipeActionsController extends ChangeNotifier {
  _SwipeActionsState? _state;

  /// Whether any action is currently revealed.
  bool get isOpen => (_state?._reveal ?? 0) > 0;

  /// Reveals the actions with the settle animation.
  void open() => _state?._animateTo(1);

  /// Hides the actions with the settle animation.
  void close() => _state?._animateTo(0);

  void _attach(_SwipeActionsState state) {
    _state = state;
  }

  void _detach(_SwipeActionsState state) {
    if (identical(_state, state)) {
      _state = null;
    }
  }
}

/// One trailing action revealed by [SwipeActions].
class SwipeAction {
  /// Creates a trailing action.
  const SwipeAction({
    required this.label,
    this.icon,
    this.onPressed,
    this.destructive = false,
  });

  /// Text shown in the action button.
  final String label;

  /// Icon shown above [label]; null shows the label alone.
  final Widget? icon;

  /// Called when the action button is tapped.
  final VoidCallback? onPressed;

  /// Whether the action uses the destructive variant.
  final bool destructive;
}

/// Swipe a row to reveal trailing [actions]; optionally dismiss-to-delete.
///
/// The row needs a bounded width (a list row); the child is stretched to
/// fill it so taps land on the row rather than the hidden actions.
/// A [controller] reveals or hides the row programmatically.
///
/// ```dart
/// SwipeActions(
///   actions: <SwipeAction>[
///     SwipeAction(label: 'Delete', destructive: true, onPressed: delete),
///   ],
///   onDismissed: delete,
///   child: const Text('Row content'),
/// );
/// ```
class SwipeActions extends StatefulWidget {
  /// Creates a swipeable row.
  const SwipeActions({
    super.key,
    required this.child,
    this.actions = const <SwipeAction>[],
    this.onDismissed,
    this.actionExtent = 76,
    this.controller,
  });

  /// The row content, slid aside as the actions reveal.
  final Widget child;

  /// Trailing actions, laid out from the trailing edge inward.
  final List<SwipeAction> actions;

  /// Called on a full swipe (drag past the actions + release). Null disables
  /// dismissing; the row then settles open at most.
  final VoidCallback? onDismissed;

  /// Width of one action; the revealed run is `actions.length * actionExtent`.
  final double actionExtent;

  /// Programmatic control; a private one is unused when null.
  final SwipeActionsController? controller;

  @override
  State<SwipeActions> createState() => _SwipeActionsState();
}

class _SwipeActionsState extends State<SwipeActions>
    with SingleTickerProviderStateMixin {
  late final AnimationController _settler = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );
  double _from = 0;
  double _to = 0;
  double _reveal = 0;

  double get _totalWidth => widget.actions.length * widget.actionExtent;

  bool get _rtl => Directionality.of(context) == TextDirection.rtl;

  @override
  void initState() {
    super.initState();
    widget.controller?._attach(this);
    _settler.addListener(() {
      setState(() => _reveal = _from + (_to - _from) * _settler.value);
    });
  }

  @override
  void didUpdateWidget(covariant SwipeActions oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?._detach(this);
      widget.controller?._attach(this);
    }
  }

  @override
  void dispose() {
    widget.controller?._detach(this);
    _settler.dispose();
    super.dispose();
  }

  void _animateTo(double target) {
    _from = _reveal;
    _to = target;
    _settler
      ..stop()
      ..value = 0
      ..forward();
  }

  void _onUpdate(DragUpdateDetails details) {
    if (widget.actions.isEmpty) {
      return;
    }
    _settler.stop();
    final double total = _totalWidth;
    final double dx = details.primaryDelta ?? 0;
    final double max = widget.onDismissed == null ? 1.0 : 1.4;
    setState(() {
      _reveal = (_reveal + (_rtl ? dx : -dx) / total).clamp(0.0, max);
    });
  }

  void _onEnd(DragEndDetails details) {
    if (widget.actions.isEmpty) {
      return;
    }
    final double velocity = details.primaryVelocity ?? 0;
    final double fling = _rtl ? velocity : -velocity;
    if (widget.onDismissed != null &&
        (_reveal > 1.05 || (fling > 500 && _reveal > 0.6))) {
      widget.onDismissed!.call();
      _animateTo(0);
      return;
    }
    _animateTo(fling > 300 || (_reveal > 0.5 && fling > -300) ? 1 : 0);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.actions.isEmpty) {
      return widget.child;
    }
    final ThemeData appTheme = Theme.of(context);
    final double total = _totalWidth;
    final double shown = _reveal.clamp(0.0, 1.0);
    final bool peeked = _reveal > 0;
    Widget actions = Align(
      alignment: _rtl ? Alignment.centerLeft : Alignment.centerRight,
      child: SizedBox(
        width: total,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            for (final SwipeAction action in widget.actions)
              SizedBox(
                width: widget.actionExtent,
                child: Center(
                  child: Button(
                    variant: action.destructive
                        ? ButtonVariant.destructive
                        : ButtonVariant.secondary,
                    size: ButtonSize.sm,
                    onPressed: action.onPressed,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        if (action.icon != null) action.icon!,
                        Text(
                          action.label,
                          style: appTheme.typography.textSmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
    if (!peeked) {
      actions = ExcludeSemantics(
        child: ExcludeFocus(
          child: IgnorePointer(ignoring: true, child: actions),
        ),
      );
    }
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragUpdate: _onUpdate,
      onHorizontalDragEnd: _onEnd,
      child: Stack(
        children: <Widget>[
          Positioned.fill(child: actions),
          // The close-tap detector lives INSIDE the translate so its hit
          // area moves with the content: outside it, the detector would
          // keep the full un-translated hit box, cover the revealed
          // actions, and win the tap arena — tapping an action would just
          // close the row. A tap while closed is a no-op.
          Transform.translate(
            offset: Offset((_rtl ? 1 : -1) * shown * total, 0),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if (_reveal > 0) {
                  _animateTo(0);
                }
              },
              child: SizedBox(width: double.infinity, child: widget.child),
            ),
          ),
        ],
      ),
    );
  }
}

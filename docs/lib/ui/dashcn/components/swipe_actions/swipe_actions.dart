// The `swipe_actions` component: swipe a row to reveal trailing actions.
//
// The actions sit behind the child in a [Stack]; a horizontal drag slides
// the child aside (mirrored under RTL) and the row settles open or closed on
// release with a critically-damped spring fed by the release velocity.
// Dragging past the full width when [SwipeActions.onDismissed] is set commits
// a dismiss: the row collapses (height to zero) before the callback fires, so
// the caller removes an already-gone row. Over-drag past either edge meets
// resistance (rubber-banding) instead of a hard clamp.
//
// The actions are real [Button]s (or caller-built widgets), so keyboard focus
// and screen readers reach them once revealed; while closed they are removed
// from semantics and focus.

import 'package:flutter/physics.dart';
import 'package:flutter/widgets.dart';

import '../../primitives/motion/motion_scope.dart';
import '../../primitives/motion/motion_spec.dart';
import '../../theme/motion.dart';
import '../../theme/theme.dart';
import 'swipe_action_buttons.dart';

export 'swipe_action.dart';
export 'swipe_action_buttons.dart';

/// Programmatic control of a [SwipeActions] row: [open] / [close] settle it,
/// [dismiss] plays the full-swipe commit (collapse, then `onDismissed`), and
/// [isOpen] reports whether any action is revealed.
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

  /// Plays the full-swipe commit: collapse, then `onDismissed`.
  ///
  /// No-op when the row has no `onDismissed` leg.
  void dismiss() => _state?._commitDismiss();

  void _attach(_SwipeActionsState state) {
    _state = state;
  }

  void _detach(_SwipeActionsState state) {
    if (identical(_state, state)) {
      _state = null;
    }
  }
}

/// Swipe a row to reveal trailing [actions]; optionally dismiss-to-delete.
///
/// The row needs a bounded width (a list row); the child is stretched to
/// fill it so taps land on the row rather than the hidden actions.
/// A [controller] reveals, hides or dismisses the row programmatically;
/// [motion] retimes the settle/collapse or replaces the transitions.
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
    this.motion,
    this.dismissThreshold = 1.05,
  });

  /// The row content, slid aside as the actions reveal.
  final Widget child;

  /// Trailing actions, laid out from the trailing edge inward.
  final List<SwipeAction> actions;

  /// Called AFTER the full-swipe collapse completes. Null disables
  /// dismissing; the row then settles open at most.
  final VoidCallback? onDismissed;

  /// Width of one action; the revealed run is `actions.length * actionExtent`.
  final double actionExtent;

  /// Programmatic control; a private one is unused when null.
  final SwipeActionsController? controller;

  /// Per-instance motion override: retimes the spring settle and the commit
  /// collapse, or disables them (snap) via `MotionSpec.disabled`.
  final MotionSpec? motion;

  /// Reveal fraction past which a release commits a dismiss (1.0 = exactly
  /// the full actions width). Lower commits earlier.
  final double dismissThreshold;

  @override
  State<SwipeActions> createState() => _SwipeActionsState();
}

class _SwipeActionsState extends State<SwipeActions>
    with SingleTickerProviderStateMixin {
  /// Critically damped (no overshoot past the 0..1 controller bounds) and
  /// stiff enough to settle inside ~250 ms, so programmatic open/close and
  /// tap-to-close land exactly within one settle frame.
  static final SpringDescription _settleSpring = SpringDescription(
    mass: 1,
    stiffness: 1200,
    damping: 70,
  );

  late final AnimationController _settler = AnimationController(vsync: this);
  AnimationController? _collapseController;
  double _from = 0;
  double _to = 0;
  double _reveal = 0;
  bool _dismissing = false;
  double _collapse = 1;

  double get _totalWidth => widget.actions.length * widget.actionExtent;

  /// Drag unit in px: the actions width, or a fixed run when action-less
  /// rows still dismiss.
  double get _unit => _totalWidth > 0 ? _totalWidth : 96;

  bool get _rtl => Directionality.of(context) == TextDirection.rtl;

  bool get _reduced =>
      (widget.motion?.disabled ?? false) || motionReduced(context);

  @override
  void initState() {
    super.initState();
    widget.controller?._attach(this);
    _settler.addListener(() {
      setState(() => _reveal = _from + (_to - _from) * _settler.value);
    });
    // Land exactly on the target when the settle finishes: springs approach
    // asymptotically, and open/close/isOpen must read exact by settle end.
    _settler.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed && mounted) {
        setState(() => _reveal = _to);
      }
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
    _collapseController?.dispose();
    _settler.dispose();
    super.dispose();
  }

  /// Spring-settles to [target] (0 closed, 1 open), fed by the release
  /// [velocity] in reveal-units per second. Snaps under reduced motion.
  void _animateTo(double target, [double velocity = 0]) {
    if (_dismissing) {
      return;
    }
    _settler.stop();
    if (_reduced || _reveal == target) {
      setState(() => _reveal = target);
      return;
    }
    final MotionSpec? spec = widget.motion;
    final Duration? explicit = spec?.enterDuration ?? spec?.duration;
    if (explicit != null) {
      _from = _reveal;
      _to = target;
      _settler.duration = Theme.of(
        context,
      ).motion.resolveStateDuration(explicit);
      _settler
        ..value = 0
        ..forward();
      return;
    }
    _from = _reveal;
    _to = target;
    final double span = target - _reveal;
    final double startVelocity = span == 0 ? 0 : velocity / span;
    _settler.animateWith(SpringSimulation(_settleSpring, 0, 1, startVelocity));
  }

  /// Full-swipe commit: collapse the row height, then report removal.
  void _commitDismiss() {
    if (widget.onDismissed == null || _dismissing) {
      return;
    }
    _dismissing = true;
    _settler.stop();
    if (_reduced) {
      widget.onDismissed!.call();
      return;
    }
    final MotionTokens tokens = Theme.of(context).motion;
    final Duration collapse = widget.motion != null
        ? widget.motion!.resolveExitDuration(
            context,
            tokens.durations.base,
            state: true,
          )
        : tokens.resolveStateDuration(tokens.durations.base);
    final AnimationController collapsing = AnimationController(
      vsync: this,
      duration: collapse,
    );
    _collapseController?.dispose();
    _collapseController = collapsing;
    collapsing.addListener(() {
      if (mounted) {
        setState(() => _collapse = 1 - collapsing.value);
      }
    });
    collapsing.forward().then((_) {
      if (identical(_collapseController, collapsing)) {
        _collapseController = null;
      }
      collapsing.dispose();
      if (!mounted) {
        return;
      }
      setState(() => _collapse = 0);
      widget.onDismissed!.call();
    });
  }

  void _onUpdate(DragUpdateDetails details) {
    if (_dismissing) {
      return;
    }
    if (widget.actions.isEmpty && widget.onDismissed == null) {
      return;
    }
    _settler.stop();
    final double dx = details.primaryDelta ?? 0;
    final double unit = _unit;
    final double max = widget.onDismissed == null ? 1.0 : 1.4;
    // Resistance past either edge: the first 1.0/0.0 tracks the finger,
    // the rest moves at ~35% (rubber-banding) inside a hard guard.
    double next = _reveal + (_rtl ? dx : -dx) / unit;
    if (next > max) {
      next = max + (next - max) * 0.35;
    } else if (next > 1.0 && widget.onDismissed == null) {
      next = 1.0 + (next - 1.0) * 0.35;
    } else if (next < 0.0) {
      next = next * 0.35;
    }
    setState(() {
      _reveal = next.clamp(-0.25, max + 0.4);
    });
  }

  void _onEnd(DragEndDetails details) {
    if (_dismissing) {
      return;
    }
    if (widget.actions.isEmpty && widget.onDismissed == null) {
      return;
    }
    final double velocity = details.primaryVelocity ?? 0;
    final double flingUnits = (_rtl ? velocity : -velocity) / _unit;
    if (widget.onDismissed != null &&
        (_reveal > widget.dismissThreshold ||
            (velocity.abs() > 500 && _reveal > 0.6))) {
      _commitDismiss();
      return;
    }
    final double target =
        flingUnits > 2.5 || (_reveal > 0.5 && flingUnits > -2.5) ? 1 : 0;
    _animateTo(target.toDouble(), flingUnits);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.actions.isEmpty && widget.onDismissed == null) {
      return widget.child;
    }
    final double total = _totalWidth;
    final double shown = _reveal.clamp(0.0, 1.0);
    final bool peeked = _reveal > 0;
    Widget actions = SwipeActionButtons(
      actions: widget.actions,
      progress: shown,
      actionExtent: widget.actionExtent,
    );
    if (!peeked || _dismissing) {
      actions = ExcludeSemantics(
        child: ExcludeFocus(
          child: IgnorePointer(ignoring: true, child: actions),
        ),
      );
    }
    Widget row = Stack(
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
    );
    if (!_dismissing || _reduced) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onHorizontalDragUpdate: _onUpdate,
        onHorizontalDragEnd: _onEnd,
        child: row,
      );
    }
    // Committing: collapse the height to zero (siblings slide up), fade the
    // content, and swallow gestures until the caller removes the row.
    return IgnorePointer(
      ignoring: true,
      child: ClipRect(
        child: Align(
          alignment: Alignment.topCenter,
          heightFactor: _collapse.clamp(0.0, 1.0),
          child: Opacity(opacity: _collapse.clamp(0.0, 1.0), child: row),
        ),
      ),
    );
  }
}

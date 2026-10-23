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
import '../../theme/density_tokens.dart';
import '../../theme/motion.dart';
import '../../theme/theme.dart';
import 'swipe_action.dart';
import 'swipe_action_buttons.dart';
import 'swipe_actions_style.dart';

export 'swipe_action.dart';
export 'swipe_action_buttons.dart';
export 'swipe_actions_style.dart';
export 'swipe_actions_theme.dart';

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

/// Builds the whole trailing actions run; [defaultRun] is the density-sized
/// [SwipeActionButtons]. Return any widget to swap the run.
typedef SwipeActionsRunBuilder =
    Widget Function(BuildContext context, Widget defaultRun, double progress);

/// Builds the row content with its reveal [progress]; [defaultContent] is
/// the caller [child] stretched to the row width.
typedef SwipeActionsContentBuilder =
    Widget Function(
      BuildContext context,
      Widget defaultContent,
      double progress,
    );

/// Swipe a row to reveal trailing [actions]; optionally dismiss-to-delete.
///
/// Density-sized by default ([DensityTokens.compact]): each action tile is
/// ~56 px wide with a 16 px icon and 11-12 px label; comfortable and touch
/// grow from the tokens. The row min-height follows the tokens, the reveal
/// scales with the drag, and a full swipe collapses the row before
/// [onDismissed] fires.
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
    this.actionExtent,
    this.controller,
    this.motion,
    this.dismissThreshold = 1.05,
    this.densityTokens,
    this.theme,
    this.runBuilder,
    this.contentBuilder,
  });

  /// The row content, slid aside as the actions reveal.
  final Widget child;

  /// Trailing actions, laid out from the trailing edge inward.
  final List<SwipeAction> actions;

  /// Called AFTER the full-swipe collapse completes. Null disables
  /// dismissing; the row then settles open at most.
  final VoidCallback? onDismissed;

  /// Width of one action; null resolves from the density tokens
  /// (`control + 24`: 56 compact / 64 comfortable / 72 touch).
  /// The revealed run is `actions.length * actionExtent`.
  final double? actionExtent;

  /// Programmatic control; a private one is unused when null.
  final SwipeActionsController? controller;

  /// Per-instance motion override: retimes the spring settle and the commit
  /// collapse, or disables them (snap) via `MotionSpec.disabled`.
  final MotionSpec? motion;

  /// Reveal fraction past which a release commits a dismiss (1.0 = exactly
  /// the full actions width). Lower commits earlier.
  final double dismissThreshold;

  /// Per-instance density tokens. Null resolves through the component theme
  /// legs (`themeDensityTokens`) then [ThemeData.densityTokens]; phone
  /// widths (< [kPhoneWidthBreakpoint]) use touch unless this is set.
  final DensityTokens? densityTokens;

  /// Per-instance style override (action width, icon/label sizes, row min).
  final SwipeActionsTheme? theme;

  /// Swaps the whole trailing actions run.
  final SwipeActionsRunBuilder? runBuilder;

  /// Swaps the row content (receives the reveal progress).
  final SwipeActionsContentBuilder? contentBuilder;

  @override
  State<SwipeActions> createState() => _SwipeActionsState();
}

class _SwipeActionsState extends State<SwipeActions>
    with TickerProviderStateMixin {
  /// Critically damped (no overshoot past the 0..1 controller bounds) and
  /// stiff enough to settle inside ~250 ms, so programmatic open/close and
  /// tap-to-close land exactly within one settle frame.
  static final SpringDescription _settleSpring = SpringDescription(
    mass: 1,
    stiffness: 1200,
    damping: 70,
  );

  late final AnimationController _settler = AnimationController(vsync: this);
  AnimationController? _dismissController;
  double _from = 0;
  double _to = 0;
  double _reveal = 0;
  bool _dismissing = false;

  /// Commit phase one: how far the row has slid off the edge (0..1).
  double _slide = 0;

  /// Commit phase two: remaining row height factor (1 open, 0 collapsed).
  double _collapse = 1;

  SwipeActionsTheme _resolvedTheme(BuildContext context) {
    return resolveComponentStyle<SwipeActionsTheme, SwipeActionsTheme>(
      context,
      widget: widget.theme,
      select: (t) => t,
      defaults: swipeActionsDefaults,
    );
  }

  DensityTokens _tokens(BuildContext context, SwipeActionsTheme resolved) {
    return widget.densityTokens ??
        resolved.themeDensityTokens ??
        ComponentTheme.maybeOf<SwipeActionsTheme>(
          context,
        )?.themeDensityTokens ??
        ComponentThemes.maybeOf<SwipeActionsTheme>(
          context,
        )?.themeDensityTokens ??
        resolveDensityTokens(context);
  }

  double _extent(BuildContext context) {
    // Explicit extents still honor the 48 px touch minimum: a caller-passed
    // narrow tile would otherwise break the touch floor and the reveal math
    // (the reveal width is actions * extent, matching the stretched row).
    if (widget.actionExtent != null) {
      final double explicit = widget.actionExtent!;
      return explicit < 48 ? 48 : explicit;
    }
    final SwipeActionsTheme resolved = _resolvedTheme(context);
    if (resolved.actionWidth != null) {
      final double themed = resolved.actionWidth! * Theme.of(context).scaling;
      return themed < 48 ? 48 : themed;
    }
    return swipeActionWidthForTokens(_tokens(context, resolved)) *
        Theme.of(context).scaling;
  }

  double get _totalWidth {
    // Contextful: resolves the density default when no explicit extent.
    // Called during build/drag when `context` is mounted.
    double extent;
    try {
      extent = _extent(context);
    } catch (_) {
      extent = 56;
    }
    return widget.actions.length * extent;
  }

  double get _unit {
    final double total = _totalWidth;
    return total > 0 ? total : 96;
  }

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
    _dismissController?.dispose();
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
    // A loose tolerance lands the settle inside ~200 ms (tests pump 300);
    // the status listener then snaps exactly onto the target.
    _settler.animateWith(
      SpringSimulation(
        _settleSpring,
        0,
        1,
        startVelocity,
        tolerance: const Tolerance(distance: 0.02, velocity: 1.0),
      ),
    );
  }

  /// Full-swipe commit in two phases: the row slides out of view over the
  /// first phase, then its height collapses over the second so the list
  /// closes the gap; [SwipeActions.onDismissed] fires after both.
  void _commitDismiss() {
    if (widget.onDismissed == null || _dismissing) {
      return;
    }
    _dismissing = true;
    _settler.stop();
    if (_reduced) {
      // No ticker: report removal synchronously and stay interactive in
      // case the caller keeps the row.
      _dismissing = false;
      widget.onDismissed!.call();
      return;
    }
    final MotionTokens tokens = Theme.of(context).motion;
    final Duration phase = widget.motion != null
        ? widget.motion!.resolveExitDuration(
            context,
            tokens.durations.base,
            state: true,
          )
        : tokens.resolveStateDuration(tokens.durations.base);
    final AnimationController dismissing = AnimationController(
      vsync: this,
      duration: phase * 2,
    );
    _dismissController?.dispose();
    _dismissController = dismissing;
    dismissing.addListener(() {
      if (!mounted) {
        return;
      }
      final double v = dismissing.value;
      setState(() {
        _slide = Curves.easeIn.transform((v * 2).clamp(0.0, 1.0));
        _collapse =
            1 - Curves.easeInOut.transform(((v - 0.5) * 2).clamp(0.0, 1.0));
      });
    });
    dismissing.forward().then((_) {
      if (identical(_dismissController, dismissing)) {
        _dismissController = null;
      }
      dismissing.dispose();
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
    final SwipeActionsTheme resolved = _resolvedTheme(context);
    final DensityTokens tokens = _tokens(context, resolved);
    final double scaling = Theme.of(context).scaling;
    final double extent =
        widget.actionExtent ??
        resolved.actionWidth ??
        swipeActionWidthForTokens(tokens) * scaling;
    // Keep an explicit widget extent exact; a theme width scales.
    final double total =
        widget.actions.length * (widget.actionExtent ?? extent);
    final double shown = _reveal.clamp(0.0, 1.0);
    final bool peeked = _reveal > 0;
    // Over-drag stretches the row a little past full open (resistance made
    // visible); the settled open and closed states sit exactly at 1 and 0.
    final double travel = shown + (_reveal - shown).clamp(0.0, 0.6) * 0.3;
    Widget defaultRun = SwipeActionButtons(
      actions: widget.actions,
      progress: shown,
      actionExtent: widget.actionExtent ?? extent,
      densityTokens: widget.densityTokens,
      theme: widget.theme,
    );
    Widget actions =
        widget.runBuilder?.call(context, defaultRun, shown) ?? defaultRun;
    if (!peeked || _dismissing) {
      actions = ExcludeSemantics(
        child: ExcludeFocus(
          child: IgnorePointer(ignoring: true, child: actions),
        ),
      );
    }
    Widget defaultContent = SizedBox(
      width: double.infinity,
      child: widget.child,
    );
    final Widget content =
        widget.contentBuilder?.call(context, defaultContent, shown) ??
        defaultContent;
    final double rowMin =
        (resolved.rowMinHeight ?? tokens.rowMinHeight) * scaling;
    Widget row = Stack(
      children: <Widget>[
        Positioned.fill(child: actions),
        // The close-tap detector lives INSIDE the translate so its hit
        // area moves with the content: outside it, the detector would
        // keep the full un-translated hit box, cover the revealed
        // actions, and win the tap arena — tapping an action would just
        // close the row. A tap while closed is a no-op.
        Transform.translate(
          offset: Offset((_rtl ? 1 : -1) * travel * total, 0),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              if (_reveal > 0) {
                _animateTo(0);
              }
            },
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: rowMin),
              child: content,
            ),
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
    // Committing: slide the row off the trailing edge (phase one), then
    // collapse its height to zero so siblings slide up (phase two). Gestures
    // are swallowed until the caller removes the row.
    final double screenWidth = MediaQuery.sizeOf(context).width;
    return IgnorePointer(
      ignoring: true,
      child: ClipRect(
        child: Align(
          alignment: Alignment.topCenter,
          heightFactor: _collapse.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset((_rtl ? 1 : -1) * _slide * screenWidth, 0),
            child: row,
          ),
        ),
      ),
    );
  }
}

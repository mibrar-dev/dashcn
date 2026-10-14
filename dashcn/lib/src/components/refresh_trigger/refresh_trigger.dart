// The `refresh_trigger` component: [RefreshTrigger] and its state.
//
// Ported from `components/overlay/refresh_trigger`: no `material.dart`, dead
// `checkbox` import and empty physics deleted, null `onRefresh` disables
// pulling, zero `minExtent` guarded, no `rendering.dart` direction tracking.
// P7-WB: gesture drags alone never armed a pull for desktop-web users —
// wheel/trackpad scrolls (`PointerScrollEvent`) bypass the gesture arena, so
// at the list's edge the inner scrollable expresses no interest and the outer
// page scrolls instead ("cannot pull; it opens all the way up"). The trigger
// accumulates outward wheel scrolls at the leading edge now, and tracks mouse
// drags itself (scrollables only claim touch-like devices); touch drags keep
// working through the notification path.
//
// Three files by responsibility: this one (pull mechanics + refresh
// lifecycle), `refresh_trigger_input.dart` (the pull-phase transition table
// shared by the touch/mouse/wheel paths) and `refresh_trigger_indicator.dart`
// (the default pill).

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/constants.dart';
import '../../primitives/animated_value_builder.dart';
import '../../theme/theme.dart';
import 'refresh_trigger_indicator.dart';
import 'refresh_trigger_input.dart';
import 'refresh_trigger_style.dart';

export 'refresh_trigger_indicator.dart';
export 'refresh_trigger_input.dart';
export 'refresh_trigger_style.dart';

/// Pull-to-refresh wrapper; null [onRefresh] disables pulling.
class RefreshTrigger extends StatefulWidget {
  const RefreshTrigger({
    super.key,
    this.minExtent,
    this.maxExtent,
    this.onRefresh,
    this.direction = Axis.vertical,
    this.reverse = false,
    this.indicatorBuilder,
    this.curve,
    this.completeDuration,
    required this.child,
    this.theme,
  });

  final double? minExtent;
  final double? maxExtent;
  final Future<void> Function()? onRefresh;
  final Axis direction;
  final bool reverse;
  final RefreshIndicatorBuilder? indicatorBuilder;
  final Curve? curve;
  final Duration? completeDuration;
  final Widget child;

  final RefreshTriggerTheme? theme;

  /// Default pill indicator (arrow, spinner, check + labels).
  static Widget defaultIndicatorBuilder(
    BuildContext context,
    RefreshTriggerStage stage,
  ) {
    return DefaultRefreshIndicator(stage: stage);
  }

  @override
  State<RefreshTrigger> createState() => RefreshTriggerState();
}

class RefreshTriggerState extends State<RefreshTrigger> {
  TriggerStage _stage = TriggerStage.idle;
  Future<void>? _currentFuture;
  int _futureCount = 0;
  late double _minExtent;
  late double _maxExtent;
  late RefreshIndicatorBuilder _indicatorBuilder;
  late Curve _curve;
  late Duration _completeDuration;

  late final RefreshPullInput _input = RefreshPullInput(
    onChanged: () {
      if (mounted) setState(() {});
    },
    onFire: () => refresh(),
  );

  /// The lifecycle stage; maps the input's pull phase to [TriggerStage].
  TriggerStage get stage =>
      _input.phase == PullPhase.pulling ? TriggerStage.pulling : _stage;

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _resolve();
  }

  @override
  void didUpdateWidget(covariant RefreshTrigger oldWidget) {
    super.didUpdateWidget(oldWidget);
    _resolve();
  }

  void _resolve() {
    final double scale = Theme.of(context).scaling;
    final RefreshTriggerTheme style =
        resolveComponentStyle<RefreshTriggerTheme, RefreshTriggerTheme>(
          context,
          widget: widget.theme,
          select: (t) => t,
          defaults: refreshTriggerDefaults,
        );
    _minExtent = (widget.minExtent ?? style.minExtent ?? 75) * scale;
    _maxExtent = (widget.maxExtent ?? style.maxExtent ?? 150) * scale;
    _input.minExtent = _minExtent;
    _indicatorBuilder =
        widget.indicatorBuilder ??
        style.indicatorBuilder ??
        RefreshTrigger.defaultIndicatorBuilder;
    _curve = widget.curve ?? style.curve ?? Curves.easeOutSine;
    _completeDuration =
        widget.completeDuration ??
        style.completeDuration ??
        const Duration(milliseconds: 500);
  }

  double _clampExtent(double extent, double arm) {
    if (widget.reverse) extent = -extent;
    if (extent <= arm) return extent;
    final double range = _maxExtent - arm;
    if (range <= 0) return arm;
    final double relative = extent - arm;
    final double normalized = (range - relative) / range;
    return _maxExtent -
        Curves.decelerate.transform(normalized.clamp(0, 1)) *
            (range - relative);
  }

  bool _handleScroll(ScrollNotification notification) {
    if (notification.depth != 0) return false;
    _input.atEdge = widget.reverse
        ? notification.metrics.extentAfter == 0
        : notification.metrics.extentBefore == 0;
    if (widget.onRefresh == null) return false;
    if (notification is ScrollStartNotification) {
      _input.scrollStart();
    } else if (notification is ScrollEndNotification) {
      _input.scrollEnd();
    } else if (notification is ScrollUpdateNotification) {
      final double? delta = notification.scrollDelta;
      if (delta == null) return false;
      _input.scrollDelta(_outwardForUpdate(notification.metrics, delta));
    } else if (notification is OverscrollNotification) {
      final double over = _outwardForUpdate(
        notification.metrics,
        notification.overscroll,
      );
      // Overscroll below zero never armed a pull; only forward the pull.
      if (over > 0) _input.scrollDelta(over);
    }
    return false;
  }

  /// Signs a scroll delta outward: dragging down (vertical) or right
  /// (horizontal) at the leading edge pulls.
  double _outwardForUpdate(ScrollMetrics metrics, double delta) {
    final AxisDirection axis = metrics.axisDirection;
    final double out =
        (axis == AxisDirection.down || axis == AxisDirection.right)
        ? -delta
        : delta;
    return widget.reverse ? -out : out;
  }

  /// Accumulates wheel/trackpad ticks into a pull.
  ///
  /// Pointer scrolls bypass the gesture arena: at the child's edge the inner
  /// scrollable expresses no interest and the event bubbles to the outer
  /// page, so without this no pull could ever arm from a wheel or trackpad.
  /// The tracker grows the pull, fires it after the ticks pause, or snaps it
  /// back below the threshold.
  void _handlePointerSignal(PointerSignalEvent event) {
    if (event is! PointerScrollEvent) return;
    if (widget.onRefresh == null) return;
    if (_stage == TriggerStage.refreshing || _stage == TriggerStage.completed) {
      return;
    }
    final bool vertical = widget.direction == Axis.vertical;
    final double raw = vertical ? event.scrollDelta.dy : event.scrollDelta.dx;
    _input.wheelTick(widget.reverse ? raw : -raw);
  }

  Future<void> refresh([Future<void> Function()? callback]) async {
    _input.reset();
    final int count = ++_futureCount;
    if (_currentFuture != null) await _currentFuture;
    if (!mounted) return;
    setState(() {
      _stage = TriggerStage.refreshing;
      _currentFuture = (callback ?? widget.onRefresh)?.call() ?? Future.value();
    });
    return _currentFuture!.whenComplete(() {
      if (!mounted || count != _futureCount) return;
      setState(() {
        _currentFuture = null;
        _stage = TriggerStage.completed;
        Timer(_completeDuration, () {
          if (!mounted) return;
          setState(() {
            _stage = TriggerStage.idle;
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double arm = _minExtent <= 0 ? 1 : _minExtent;
    final bool vertical = widget.direction == Axis.vertical;
    final bool pulling = _input.phase == PullPhase.pulling;
    final TriggerStage stage = pulling ? TriggerStage.pulling : _stage;
    return Listener(
      onPointerSignal: _handlePointerSignal,
      // Mouse-drag tracking: raw pointer events, never a gesture recognizer,
      // so touch-like drags stay claimed by the child scrollable and resolve
      // through scroll notifications.
      onPointerDown: _mouseDown,
      onPointerMove: _mouseMove,
      onPointerUp: _mouseUp,
      onPointerCancel: _mouseCancel,
      child: NotificationListener<ScrollNotification>(
        onNotification: _handleScroll,
        child: AnimatedValueBuilder<double>(
          value:
              _stage == TriggerStage.refreshing ||
                  _stage == TriggerStage.completed
              ? _minExtent
              : _input.extent,
          duration: pulling ? Duration.zero : kDefaultDuration,
          curve: _curve,
          builder: (context, value, _) {
            final RefreshTriggerStage snapshot = RefreshTriggerStage(
              stage,
              AlwaysStoppedAnimation<double>(value / arm),
              widget.direction,
              widget.reverse,
            );
            final double slide = _clampExtent(value, arm);
            final Offset offscreen = vertical
                ? (widget.reverse ? const Offset(0, 1) : const Offset(0, -1))
                : (widget.reverse ? const Offset(1, 0) : const Offset(-1, 0));
            final Offset shift = vertical ? Offset(0, slide) : Offset(slide, 0);
            final Positioned indicator = vertical
                ? Positioned(
                    top: !widget.reverse ? 0 : null,
                    bottom: !widget.reverse ? null : 0,
                    left: 0,
                    right: 0,
                    child: _sliding(offscreen, shift, snapshot),
                  )
                : Positioned(
                    top: 0,
                    bottom: 0,
                    left: widget.reverse ? null : 0,
                    right: widget.reverse ? 0 : null,
                    child: _sliding(offscreen, shift, snapshot),
                  );
            return Stack(
              fit: StackFit.passthrough,
              children: <Widget>[
                widget.child,
                Positioned.fill(
                  child: ClipRect(child: Stack(children: <Widget>[indicator])),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// Arms a mouse-drag pull on left-button press; the tracker re-checks the
  /// edge on the first move.
  void _mouseDown(PointerDownEvent event) {
    if (event.kind != PointerDeviceKind.mouse) return;
    if (event.buttons != kPrimaryButton) return;
    if (widget.onRefresh == null) return;
    _input.mouseDown();
  }

  /// Grows (or shrinks) a mouse-armed pull.
  void _mouseMove(PointerMoveEvent event) {
    if (event.kind != PointerDeviceKind.mouse) return;
    if (widget.onRefresh == null) return;
    final bool vertical = widget.direction == Axis.vertical;
    final double delta = vertical ? event.delta.dy : event.delta.dx;
    _input.mouseMove(
      widget.reverse ? -delta : delta,
      event.buttons & kPrimaryButton != 0,
    );
  }

  /// Resolves a mouse-armed pull on release.
  void _mouseUp(PointerUpEvent event) {
    if (event.kind != PointerDeviceKind.mouse) return;
    _input.mouseUp();
  }

  /// A cancelled mouse drag snaps back without refreshing.
  void _mouseCancel(PointerCancelEvent event) {
    _input.mouseCancel();
  }

  /// Indicator translated from off-screen by the pull [shift].
  Widget _sliding(Offset offscreen, Offset shift, RefreshTriggerStage stage) {
    return FractionalTranslation(
      translation: offscreen,
      child: Transform.translate(
        offset: shift,
        child: _indicatorBuilder(context, stage),
      ),
    );
  }
}

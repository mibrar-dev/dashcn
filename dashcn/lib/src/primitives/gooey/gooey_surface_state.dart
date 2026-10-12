// State machine of `GooeySurface`: the open/close controller, the compact morph
// controller, the autopilot timers and the interaction flags.
//
// Split out of `gooey_surface.dart` so each file stays under the ~400-line
// rule. Every value the widget exposes is read from the widget itself, so a
// `didUpdateWidget` is enough to re-resolve the whole policy.

import 'dart:async';

import 'package:flutter/gestures.dart' show PointerEnterEvent, PointerExitEvent;
import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';
import 'gooey_content.dart';
import 'gooey_surface.dart';
import 'gooey_frame.dart';

/// Minimum expanded height as a multiple of the pill height.
const double _kMinExpandRatio = 2.25;

class GooeySurfaceState extends State<GooeySurface>
    with TickerProviderStateMixin {
  bool _ready = false;
  bool _expanded = false;
  bool _hovered = false;
  bool _pressed = false;
  bool _lastInteracting = false;
  Timer? _expandTimer;
  Timer? _collapseTimer;
  bool? _notifiedOpen;
  double _measuredBodyHeight = 0;
  double _frozenBodyHeight = kGooeySurfacePillHeight * _kMinExpandRatio;
  late final AnimationController _open;
  late CurvedAnimation _openCurve;
  late final AnimationController _compactMorph;
  late CurvedAnimation _compactMorphCurve;

  /// Outgoing compact frame captured when [morphKey] changes.
  GooeyCompactMorphFrame _outgoing = const GooeyCompactMorphFrame();
  bool _morphing = false;

  bool get _hasBodyContent =>
      widget.body != null ||
      widget.description != null ||
      widget.action != null;

  bool get _hasBody => widget.expandable && _hasBodyContent;

  bool get _isInteracting => _hovered || _pressed;

  bool get _targetOpen => _hasBody && _expanded;

  @override
  void initState() {
    super.initState();
    _open = AnimationController(
      vsync: this,
      duration: widget.openDuration,
      reverseDuration: widget.openDuration,
    );
    _openCurve = CurvedAnimation(parent: _open, curve: widget.openCurve);
    _compactMorph = AnimationController(
      vsync: this,
      duration: widget.compactMorph.duration,
    );
    _compactMorphCurve = CurvedAnimation(
      parent: _compactMorph,
      curve: widget.compactMorph.curve,
    );
    _compactMorph.addStatusListener(_onMorphStatus);
    _scheduleAutopilot();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() => _ready = true);
      }
    });
  }

  @override
  void didUpdateWidget(covariant GooeySurface oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.openDuration != widget.openDuration) {
      _open
        ..duration = widget.openDuration
        ..reverseDuration = widget.openDuration;
    }
    if (oldWidget.openCurve != widget.openCurve) {
      _openCurve.dispose();
      _openCurve = CurvedAnimation(parent: _open, curve: widget.openCurve);
    }
    if (oldWidget.compactMorph.duration != widget.compactMorph.duration) {
      _compactMorph.duration = widget.compactMorph.duration;
    }
    if (oldWidget.compactMorph.curve != widget.compactMorph.curve) {
      _compactMorphCurve.dispose();
      _compactMorphCurve = CurvedAnimation(
        parent: _compactMorph,
        curve: widget.compactMorph.curve,
      );
    }
    final bool keyed =
        oldWidget.contentKey != null || widget.contentKey != null;
    final bool contentChanged =
        oldWidget.contentKey != widget.contentKey ||
        oldWidget.expandable != widget.expandable ||
        oldWidget.description != widget.description ||
        oldWidget.expandDelay != widget.expandDelay ||
        oldWidget.collapseDelay != widget.collapseDelay ||
        (!keyed &&
            (oldWidget.body != widget.body ||
                oldWidget.action != widget.action));
    if (oldWidget.morphKey != widget.morphKey) {
      _captureOutgoing(oldWidget);
    }
    if (contentChanged) {
      if (!_hasBody && _expanded) {
        _expanded = false;
      }
      _syncOpen();
      _scheduleAutopilot();
    }
  }

  @override
  void dispose() {
    widget.onInteractionChanged?.call(false);
    _expandTimer?.cancel();
    _collapseTimer?.cancel();
    _compactMorph.removeStatusListener(_onMorphStatus);
    _compactMorphCurve.dispose();
    _compactMorph.dispose();
    _openCurve.dispose();
    _open.dispose();
    super.dispose();
  }

  void _onMorphStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed && mounted && _morphing) {
      setState(() => _morphing = false);
    }
  }

  /// Snapshots the outgoing compact frame and restarts the morph.
  ///
  /// Runs from `didUpdateWidget`: the callback is only ever a rebuilt subtree
  /// of the same widget, so no widget-dependent state leaks across frames.
  void _captureOutgoing(GooeySurface oldWidget) {
    _outgoing = GooeyCompactMorphFrame(
      title: oldWidget.title,
      titleStyle: oldWidget.titleStyle,
      leading: oldWidget.leading,
    );
    if (!mounted) {
      return;
    }
    setState(() => _morphing = true);
    _compactMorph.forward(from: 0);
  }

  void _setExpanded(bool value) {
    if (_expanded == value) {
      return;
    }
    setState(() => _expanded = value);
    _syncOpen();
  }

  void _syncOpen() {
    // Notify only on a genuine transition: `_syncOpen` also runs after
    // content updates while already open, and listeners (the toast card's
    // close-button state) must not rebuild on no-op notifications.
    if (_notifiedOpen != _targetOpen) {
      _notifiedOpen = _targetOpen;
      widget.onExpansionChanged?.call(_targetOpen);
    }
    if (_targetOpen) {
      _open.forward();
    } else {
      _open.reverse();
    }
  }

  void _toggle() {
    if (!_hasBody) {
      return;
    }
    _collapseTimer?.cancel();
    _setExpanded(!_expanded);
  }

  void _scheduleAutopilot() {
    _expandTimer?.cancel();
    _collapseTimer?.cancel();
    if (!_hasBody) {
      return;
    }
    final Duration? expandDelay = widget.expandDelay;
    final Duration? collapseDelay = widget.collapseDelay;
    if (expandDelay != null) {
      _expandTimer = Timer(
        expandDelay > Duration.zero ? expandDelay : Duration.zero,
        () {
          if (mounted) {
            _setExpanded(true);
          }
        },
      );
    }
    if (collapseDelay != null && collapseDelay > Duration.zero) {
      _collapseTimer = Timer(collapseDelay, () {
        if (!mounted || !_hasBody || _isInteracting) {
          return;
        }
        _setExpanded(false);
      });
    }
  }

  void _setHovered(bool value) {
    if (_hovered == value || !mounted) {
      return;
    }
    setState(() => _hovered = value);
    _emitInteraction();
    if (!_hasBody) {
      return;
    }
    if (value) {
      _collapseTimer?.cancel();
      _setExpanded(true);
    } else {
      _setExpanded(false);
    }
  }

  void _setPressed(bool value) {
    if (_pressed == value || !mounted) {
      return;
    }
    setState(() => _pressed = value);
    _emitInteraction();
  }

  void _emitInteraction() {
    if (!widget.pauseOnHover) {
      return;
    }
    final bool interacting = _isInteracting;
    if (interacting == _lastInteracting) {
      return;
    }
    _lastInteracting = interacting;
    widget.onInteractionChanged?.call(interacting);
  }

  void _onBodyMeasured(Size size) {
    final double next = size.height.clamp(0.0, 4000.0).toDouble();
    if (!mounted || (next - _measuredBodyHeight).abs() < 0.5) {
      return;
    }
    setState(() => _measuredBodyHeight = next);
  }

  /// Pill width: text width plus the leading bubble, gap and padding.
  double _pillWidth(TextStyle titleStyle, TextDirection direction) =>
      GooeySurfacePill.measureWidth(
        title: widget.title,
        style: titleStyle,
        direction: direction,
        pillHeight: kGooeySurfacePillHeight,
        maxWidth: widget.width,
      );

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double pillHeight = kGooeySurfacePillHeight;
    final double blur = widget.enableGooeyBlur
        ? widget.roundness * kGooeyBlurRatio
        : 0.0;
    final double pillBase = pillHeight + blur * 3;
    final double rawBody = _hasBody
        ? (_measuredBodyHeight + pillHeight)
              .clamp(pillHeight * _kMinExpandRatio, 1000.0)
              .toDouble()
        : pillHeight * _kMinExpandRatio;
    if (_targetOpen) {
      _frozenBodyHeight = rawBody;
    }
    // Measure with the style the pill paints (ambient + theme, family incl.).
    final TextStyle titleStyle = DefaultTextStyle.of(
      context,
    ).style.merge(widget.titleStyle);
    final double pillWidth = _pillWidth(titleStyle, Directionality.of(context));
    final double alignX = widget.compactAlignment.x;
    final double pillX = alignX <= -0.5
        ? 0
        : alignX >= 0.5
        ? widget.width - pillWidth
        : (widget.width - pillWidth) / 2;
    return MouseRegion(
      onEnter: (PointerEnterEvent event) => _setHovered(true),
      onExit: (PointerExitEvent event) => _setHovered(false),
      child: Listener(
        onPointerDown: (PointerDownEvent event) => _setPressed(true),
        onPointerUp: (PointerUpEvent event) => _setPressed(false),
        onPointerCancel: (PointerCancelEvent event) => _setPressed(false),
        child: AnimatedBuilder(
          animation: _compactMorphCurve,
          builder: (BuildContext context, Widget? child) {
            final GooeyCompactMorphFrame frame = _morphing
                ? GooeyCompactMorphFrame(
                    progress: _compactMorphCurve.value
                        .clamp(0.0, 1.0)
                        .toDouble(),
                    title: _outgoing.title,
                    titleStyle: _outgoing.titleStyle,
                    leading: _outgoing.leading,
                  )
                : const GooeyCompactMorphFrame();
            return AnimatedBuilder(
              animation: _openCurve,
              builder: (BuildContext context, Widget? child) =>
                  GooeySurfaceFrame(
                    ready: _ready,
                    progress: _openCurve.value,
                    width: widget.width,
                    pillHeight: pillHeight,
                    pillBase: pillBase,
                    targetHeight: _targetOpen ? rawBody : _frozenBodyHeight,
                    pillWidth: pillWidth,
                    pillX: pillX,
                    roundness: widget.roundness,
                    color: widget.fill.resolve(theme.colors),
                    fillAlpha: widget.fillAlpha,
                    blur: blur,
                    surfaceBlur: widget.surfaceBlur,
                    enableGooeyBlur: widget.enableGooeyBlur,
                    expandUp: widget.expandUp,
                    bodyAnimation: widget.bodyAnimation,
                    shadowColor: widget.shadows.isEmpty
                        ? null
                        : widget.shadows.first.color,
                    pill: GooeySurfacePill(
                      title: widget.title,
                      titleStyle: titleStyle,
                      width: pillWidth,
                      height: pillHeight,
                      morph: frame,
                      morphSlide: widget.compactMorph.slideOffset,
                      morphScaleFrom: widget.compactMorph.scaleFrom,
                      leading: widget.leading,
                      expandUp: widget.expandUp,
                      onTap: _hasBody ? _toggle : null,
                    ),
                    body: GooeySurfaceBody(
                      width: widget.width,
                      onSizeChanged: _onBodyMeasured,
                      description: widget.description,
                      descriptionStyle: widget.descriptionStyle,
                      body: widget.body,
                      action: widget.action,
                    ),
                  ),
            );
          },
        ),
      ),
    );
  }
}

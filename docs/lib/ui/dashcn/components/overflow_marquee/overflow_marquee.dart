// The `overflow_marquee` component: continuous self-scrolling content with
// seamless looping, soft edge fades, pause on hover/focus, and reduced-motion
// support.

import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import 'overflow_marquee_controller.dart';
import 'overflow_marquee_render.dart';
import 'overflow_marquee_style.dart';
import '../../primitives/localizations/localizations.dart';

export 'overflow_marquee_controller.dart';
export 'overflow_marquee_render.dart' show MarqueeLayout, RenderMarquee;
export 'overflow_marquee_style.dart';

/// Scrolls [child] along [direction] in a continuous seamless loop.
///
/// Pauses on hover, on keyboard focus, or via [controller]. When reduced
/// motion (`MediaQuery.disableAnimations`) is active, the ticker halts and
/// the content is shown truncated at its start position.
class OverflowMarquee extends StatefulWidget {
  /// Creates an overflow marquee.
  const OverflowMarquee({
    super.key,
    required this.child,
    this.direction,
    this.speed,
    this.gap,
    this.pauseOnHover,
    this.pauseOnFocus,
    this.loop,
    this.controller,
    this.leading,
    this.trailing,
    this.builder,
    this.duration,
    this.delayDuration,
    this.step,
    this.fadePortion,
    this.curve,
    this.theme,
  });

  /// Content to scroll.
  final Widget child;

  /// Scroll direction: [AxisDirectional] or legacy [Axis].
  final Object? direction;

  /// Speed in pixels per second; overrides [step] and [duration].
  final double? speed;

  /// Gap between looping instances in pixels.
  final double? gap;

  /// Whether hovering pauses the marquee.
  final bool? pauseOnHover;

  /// Whether keyboard focus pauses the marquee.
  final bool? pauseOnFocus;

  /// Whether the marquee loops continuously.
  final bool? loop;

  /// Controller for external play/pause management.
  final MarqueeController? controller;

  /// Optional builder slot placed before the scrolling marquee.
  final Widget? leading;

  /// Optional builder slot placed after the scrolling marquee.
  final Widget? trailing;

  /// Builder wrapping the scrolling subtree.
  final Widget Function(BuildContext context, Widget child)? builder;

  /// Time one run of [step] pixels takes (legacy timing).
  final Duration? duration;

  /// Pause at each end of a run (legacy timing).
  final Duration? delayDuration;

  /// Pixels covered per [duration] (legacy timing).
  final double? step;

  /// Fade width per edge as a fraction of the visible extent (`0..0.5`).
  final double? fadePortion;

  /// Easing of each run.
  final Curve? curve;

  /// Widget-leg theme override.
  final OverflowMarqueeTheme? theme;

  @override
  State<OverflowMarquee> createState() => _OverflowMarqueeState();
}

class _OverflowMarqueeState extends State<OverflowMarquee>
    with SingleTickerProviderStateMixin {
  late final ValueNotifier<Duration> _elapsed = ValueNotifier<Duration>(
    Duration.zero,
  );
  late final Ticker _ticker;

  bool _isHovered = false;
  bool _isFocused = false;
  Duration _pauseStartTime = Duration.zero;
  Duration _pausedDuration = Duration.zero;
  bool _wasPaused = false;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_onControllerChanged);
    _ticker = createTicker(_onTick);
  }

  @override
  void didUpdateWidget(OverflowMarquee oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_onControllerChanged);
      widget.controller?.addListener(_onControllerChanged);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncTicker();
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onControllerChanged);
    _ticker.dispose();
    _elapsed.dispose();
    super.dispose();
  }

  bool _isPaused(MarqueeSurface surface, bool reducedMotion) {
    if (reducedMotion) return true;
    if (widget.controller?.isPaused ?? false) return true;
    final bool hoverActive = widget.pauseOnHover ?? surface.pauseOnHover;
    if (hoverActive && _isHovered) return true;
    final bool focusActive = widget.pauseOnFocus ?? surface.pauseOnFocus;
    return focusActive && _isFocused;
  }

  void _onTick(Duration elapsed) {
    final bool reduced =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    final MarqueeSurface surface = _resolve(context);
    final bool paused = _isPaused(surface, reduced);

    if (paused) {
      if (!_wasPaused) {
        _pauseStartTime = elapsed;
        _wasPaused = true;
      }
      return;
    }
    if (_wasPaused) {
      _pausedDuration += (elapsed - _pauseStartTime);
      _wasPaused = false;
    }
    _elapsed.value = elapsed - _pausedDuration;
  }

  void _syncTicker() {
    final bool reduced =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    if (reduced) {
      if (_ticker.isActive) _ticker.stop();
      _elapsed.value = Duration.zero;
    } else if (!_ticker.isActive) {
      _ticker.start();
    }
  }

  void _onControllerChanged() => setState(() {});

  MarqueeSurface _resolve(BuildContext context) => resolveMarqueeSurface(
    context,
    widgetTheme: widget.theme,
    direction: widget.direction,
    speed: widget.speed,
    gap: widget.gap,
    pauseOnHover: widget.pauseOnHover,
    pauseOnFocus: widget.pauseOnFocus,
    loop: widget.loop,
    duration: widget.duration,
    delayDuration: widget.delayDuration,
    step: widget.step,
    fadePortion: widget.fadePortion,
    curve: widget.curve,
  );

  @override
  Widget build(BuildContext context) {
    final bool reduced =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    final MarqueeSurface surface = _resolve(context);
    final TextDirection textDir = Directionality.of(context);
    final bool isHorizontal =
        surface.direction == AxisDirectional.start ||
        surface.direction == AxisDirectional.end;

    _syncTicker();

    Widget scrollingChild = widget.child;
    if (reduced) {
      scrollingChild = DefaultTextStyle.merge(
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        child: scrollingChild,
      );
    }

    Widget core = MarqueeLayout(
      direction: surface.direction,
      speed: surface.speed,
      gap: surface.gap,
      loop: surface.loop,
      reducedMotion: reduced,
      elapsed: _elapsed,
      textDirection: textDir,
      child: scrollingChild,
    );

    if (surface.fadePortion > 0 && !reduced) {
      core = ShaderMask(
        shaderCallback: (Rect bounds) {
          final double portion = surface.fadePortion.clamp(0.0, 0.5);
          final (Alignment begin, Alignment end) = isHorizontal
              ? (
                  AlignmentDirectional.centerStart.resolve(textDir),
                  AlignmentDirectional.centerEnd.resolve(textDir),
                )
              : (Alignment.topCenter, Alignment.bottomCenter);
          return LinearGradient(
            begin: begin,
            end: end,
            colors: const <Color>[
              Color(0x00FFFFFF),
              Color(0xFFFFFFFF),
              Color(0xFFFFFFFF),
              Color(0x00FFFFFF),
            ],
            stops: <double>[0.0, portion, 1.0 - portion, 1.0],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: core,
      );
    }

    Widget result = ClipRect(child: core);

    final bool hoverActive = widget.pauseOnHover ?? surface.pauseOnHover;
    final bool focusActive = widget.pauseOnFocus ?? surface.pauseOnFocus;

    if (hoverActive || focusActive) {
      result = MouseRegion(
        onEnter: hoverActive ? (_) => setState(() => _isHovered = true) : null,
        onExit: hoverActive ? (_) => setState(() => _isHovered = false) : null,
        child: Focus(
          onFocusChange: focusActive
              ? (f) => setState(() => _isFocused = f)
              : null,
          child: result,
        ),
      );
    }

    if (widget.leading != null || widget.trailing != null) {
      result = Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (widget.leading != null) widget.leading!,
          Flexible(child: result),
          if (widget.trailing != null) widget.trailing!,
        ],
      );
    }

    if (widget.builder != null) {
      result = widget.builder!(context, result);
    }

    return Semantics(
      container: true,
      label: ComponentLocalizations.of(context).marqueeContent,
      child: result,
    );
  }
}

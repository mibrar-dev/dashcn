// One-shot error shake for form fields.
//
// `ErrorShake` nudges its child horizontally (plus/minus 4 px, decaying)
// once when [trigger] becomes non-null — typically the moment a field-level
// error message appears. Transform-only: layout and hit-testing never
// change. Under reduced motion the child builds static with no ticker.

import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../../theme/motion.dart';
import '../../theme/theme.dart';

/// Shakes its child once when [trigger] becomes non-null.
class ErrorShake extends StatefulWidget {
  /// Creates an error shake wrapper.
  const ErrorShake({
    super.key,
    required this.trigger,
    required this.child,
    this.amplitude = 4.0,
    this.duration,
  });

  /// The error value. A transition from null to non-null shakes once.
  final Object? trigger;

  /// The wrapped child (field plus its error message).
  final Widget child;

  /// Horizontal travel in logical px. Defaults to 4.
  final double amplitude;

  /// Shake duration. Defaults to the theme fast (150 ms).
  final Duration? duration;

  @override
  State<ErrorShake> createState() => ErrorShakeState();
}

/// State of `ErrorShake`.
///
/// Public for tests, which assert [shakeCount] and drive [shake].
class ErrorShakeState extends State<ErrorShake>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 150),
  );

  /// How many shakes have run.
  int shakeCount = 0;

  bool get _reduced {
    final media = MediaQuery.maybeOf(context);
    if (media != null && media.disableAnimations) {
      return true;
    }
    return !Theme.of(context).motion.enabled;
  }

  @override
  void initState() {
    super.initState();
    // A field that mounts with an error already showing shakes once, so an
    // error that arrives with the first build still reads as an error.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && widget.trigger != null) {
        shake();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final MotionTokens motion = Theme.of(context).motion;
    _controller.duration = widget.duration ?? motion.durations.fast;
  }

  @override
  void didUpdateWidget(covariant ErrorShake oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      final MotionTokens motion = Theme.of(context).motion;
      _controller.duration = widget.duration ?? motion.durations.fast;
    }
    if (widget.trigger != null &&
        widget.trigger != oldWidget.trigger &&
        !_reduced) {
      shake();
    }
  }

  /// Runs one shake cycle.
  void shake() {
    if (_reduced) {
      return;
    }
    shakeCount++;
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_reduced) {
      return widget.child;
    }
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (BuildContext context, Widget? child) {
        final double t = _controller.value;
        final double dx = t == 0.0 || t == 1.0
            ? 0.0
            : widget.amplitude * math.sin(t * math.pi * 4.0) * (1.0 - t);
        return Transform.translate(offset: Offset(dx, 0), child: child);
      },
    );
  }
}

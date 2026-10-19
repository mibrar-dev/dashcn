// Progress bar for `audio_player`: track + buffered + played + thumb.
//
// Widgets-only `GestureDetector` + `CustomPaint` with keyboard support
// (arrows/Home/End), RTL mirroring and `Semantics(slider: true)`.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// Value the bar reports.
typedef AudioSeekChanged = void Function(Duration position);

/// A seek bar with a buffered range.
class AudioProgressBar extends StatefulWidget {
  /// Creates a progress bar.
  const AudioProgressBar({
    super.key,
    required this.position,
    required this.duration,
    required this.buffered,
    required this.onSeek,
    this.trackColor = const Color(0xFFE5E5E5),
    this.bufferedColor = const Color(0xFFD4D4D4),
    this.fillColor = const Color(0xFF18181B),
    this.thumbColor = const Color(0xFF18181B),
    this.trackHeight = 4,
    this.enabled = true,
    this.semanticLabel,
    this.focusNode,
  });

  /// Current playhead.
  final Duration position;

  /// Total length.
  final Duration duration;

  /// Buffered-ahead point.
  final Duration buffered;

  /// Called with the seek target.
  final AudioSeekChanged? onSeek;

  /// Unplayed track colour.
  final Color trackColor;

  /// Buffered fill colour.
  final Color bufferedColor;

  /// Played fill colour.
  final Color fillColor;

  /// Thumb colour.
  final Color thumbColor;

  /// Track height in logical pixels.
  final double trackHeight;

  /// Whether scrubbing reacts.
  final bool enabled;

  /// Accessible label.
  final String? semanticLabel;

  /// Focus node; one is created internally when null.
  final FocusNode? focusNode;

  @override
  State<AudioProgressBar> createState() => _AudioProgressBarState();
}

class _AudioProgressBarState extends State<AudioProgressBar> {
  FocusNode? _owned;
  bool _focused = false;

  FocusNode get _node => widget.focusNode ?? (_owned ??= FocusNode());

  @override
  void dispose() {
    _owned?.dispose();
    super.dispose();
  }

  double get _fraction {
    if (widget.duration <= Duration.zero) return 0;
    return (widget.position.inMicroseconds / widget.duration.inMicroseconds)
        .clamp(0.0, 1.0);
  }

  double get _bufferedFraction {
    if (widget.duration <= Duration.zero) return 0;
    return (widget.buffered.inMicroseconds / widget.duration.inMicroseconds)
        .clamp(0.0, 1.0);
  }

  void _seekFromDx(double dx, double width) {
    if (!widget.enabled || width <= 0) return;
    final bool rtl = Directionality.of(context) == TextDirection.rtl;
    double t = (dx / width).clamp(0.0, 1.0);
    if (rtl) t = 1 - t;
    final int micros = (t * widget.duration.inMicroseconds).round();
    widget.onSeek?.call(Duration(microseconds: micros));
  }

  void _step(int direction) {
    if (!widget.enabled) return;
    final bool rtl = Directionality.of(context) == TextDirection.rtl;
    final int dir = rtl ? -direction : direction;
    Duration target = widget.position + Duration(seconds: 5 * dir);
    if (target <= Duration.zero) {
      target = Duration.zero;
    } else if (target >= widget.duration) {
      target = widget.duration;
    }
    widget.onSeek?.call(target);
  }

  @override
  Widget build(BuildContext context) {
    final bool rtl = Directionality.of(context) == TextDirection.rtl;
    return Semantics(
      label: widget.semanticLabel ?? 'Seek',
      slider: true,
      enabled: widget.enabled,
      value: '${widget.position.inSeconds}s of ${widget.duration.inSeconds}s',
      increasedValue:
          '${(widget.position + const Duration(seconds: 5)).inSeconds}s',
      decreasedValue:
          '${(widget.position - const Duration(seconds: 5)).inSeconds}s',
      onIncrease: widget.enabled ? () => _step(1) : null,
      onDecrease: widget.enabled ? () => _step(-1) : null,
      child: Focus(
        focusNode: _node,
        onFocusChange: (v) => setState(() => _focused = v),
        onKeyEvent: (node, event) {
          if (!widget.enabled || event is! KeyDownEvent) {
            return KeyEventResult.ignored;
          }
          if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
            _step(1);
            return KeyEventResult.handled;
          }
          if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            _step(-1);
            return KeyEventResult.handled;
          }
          if (event.logicalKey == LogicalKeyboardKey.home) {
            widget.onSeek?.call(Duration.zero);
            return KeyEventResult.handled;
          }
          if (event.logicalKey == LogicalKeyboardKey.end) {
            widget.onSeek?.call(widget.duration);
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (d) {
            final RenderBox box = context.findRenderObject()! as RenderBox;
            _seekFromDx(box.globalToLocal(d.globalPosition).dx, box.size.width);
          },
          onHorizontalDragUpdate: (d) {
            final RenderBox box = context.findRenderObject()! as RenderBox;
            _seekFromDx(box.globalToLocal(d.globalPosition).dx, box.size.width);
          },
          child: SizedBox(
            height: 48,
            child: CustomPaint(
              painter: _AudioBarPainter(
                fraction: _fraction,
                bufferedFraction: _bufferedFraction,
                trackColor: widget.trackColor,
                bufferedColor: widget.bufferedColor,
                fillColor: widget.fillColor,
                thumbColor: widget.thumbColor,
                trackHeight: widget.trackHeight,
                focused: _focused,
                rtl: rtl,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Paints track, buffered range, played fill and thumb; mirrors for RTL.
class _AudioBarPainter extends CustomPainter {
  const _AudioBarPainter({
    required this.fraction,
    required this.bufferedFraction,
    required this.trackColor,
    required this.bufferedColor,
    required this.fillColor,
    required this.thumbColor,
    required this.trackHeight,
    required this.focused,
    required this.rtl,
  });

  final double fraction;
  final double bufferedFraction;
  final Color trackColor;
  final Color bufferedColor;
  final Color fillColor;
  final Color thumbColor;
  final double trackHeight;
  final bool focused;
  final bool rtl;

  @override
  void paint(Canvas canvas, Size size) {
    final double cy = size.height / 2;
    final double half = trackHeight / 2;
    final Paint paint = Paint()..style = PaintingStyle.fill;
    final Rect full = Rect.fromLTWH(0, cy - half, size.width, trackHeight);
    paint.color = trackColor;
    canvas.drawRRect(
      RRect.fromRectAndRadius(full, Radius.circular(half)),
      paint,
    );
    if (bufferedFraction > 0) {
      final double bw = size.width * bufferedFraction;
      final Rect bRect = rtl
          ? Rect.fromLTWH(size.width - bw, cy - half, bw, trackHeight)
          : Rect.fromLTWH(0, cy - half, bw, trackHeight);
      paint.color = bufferedColor;
      canvas.drawRRect(
        RRect.fromRectAndRadius(bRect, Radius.circular(half)),
        paint,
      );
    }
    if (fraction > 0) {
      final double fw = size.width * fraction;
      final Rect fRect = rtl
          ? Rect.fromLTWH(size.width - fw, cy - half, fw, trackHeight)
          : Rect.fromLTWH(0, cy - 2, fw, trackHeight);
      paint.color = fillColor;
      canvas.drawRRect(
        RRect.fromRectAndRadius(fRect, Radius.circular(half)),
        paint,
      );
    }
    final double tx = rtl ? size.width * (1 - fraction) : size.width * fraction;
    paint.color = thumbColor;
    canvas.drawCircle(Offset(tx, cy), focused ? 8 : 6, paint);
  }

  @override
  bool shouldRepaint(covariant _AudioBarPainter old) {
    return old.fraction != fraction ||
        old.bufferedFraction != bufferedFraction ||
        old.trackColor != trackColor ||
        old.bufferedColor != bufferedColor ||
        old.fillColor != fillColor ||
        old.thumbColor != thumbColor ||
        old.trackHeight != trackHeight ||
        old.focused != focused ||
        old.rtl != rtl;
  }
}

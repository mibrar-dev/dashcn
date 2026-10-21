// Scrub bar for `video_player`: track + buffered + played + thumb.
//
// Widgets-only `GestureDetector` + `CustomPaint` with full keyboard support
// (arrows/Home/End), RTL mirroring and `Semantics(slider: true)`.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'video_player_buttons.dart';

/// Value the scrub bar reports.
typedef VideoScrubChanged = void Function(Duration position);

/// A seek bar with a buffered range.
class VideoScrubBar extends StatefulWidget {
  /// Creates a scrub bar.
  const VideoScrubBar({
    super.key,
    required this.position,
    required this.duration,
    required this.buffered,
    required this.onSeek,
    this.trackColor = const Color(0x59FFFFFF),
    this.bufferedColor = const Color(0x99FFFFFF),
    this.fillColor = const Color(0xFFFFFFFF),
    this.thumbColor = const Color(0xFFFFFFFF),
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
  final VideoScrubChanged? onSeek;

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
  State<VideoScrubBar> createState() => _VideoScrubBarState();
}

class _VideoScrubBarState extends State<VideoScrubBar> {
  FocusNode? _owned;
  final GlobalKey _trackKey = GlobalKey();
  bool _focused = false;
  bool _hovered = false;

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

  void _step(int direction, {bool fine = false}) {
    if (!widget.enabled) return;
    final bool rtl = Directionality.of(context) == TextDirection.rtl;
    final int dir = rtl ? -direction : direction;
    // SPEC keyboard map: 10 s steps, 5 s with Shift.
    Duration target =
        widget.position + Duration(seconds: (fine ? 5 : 10) * dir);
    if (target <= Duration.zero) {
      target = Duration.zero;
    } else if (target >= widget.duration) {
      target = widget.duration;
    }
    widget.onSeek?.call(target);
  }

  RenderBox? get _trackBox =>
      _trackKey.currentContext?.findRenderObject() as RenderBox?;

  double get _trackWidth {
    final RenderBox? box = _trackBox;
    if (box == null || !box.hasSize) return 0;
    return box.size.width;
  }

  Offset _trackLocal(Offset globalPosition) {
    final RenderBox? box = _trackBox;
    if (box == null || !box.hasSize) return Offset.zero;
    return box.globalToLocal(globalPosition);
  }

  @override
  Widget build(BuildContext context) {
    final double fraction = _fraction;
    final double buffered = _bufferedFraction;
    final bool rtl = Directionality.of(context) == TextDirection.rtl;
    return Semantics(
      label: widget.semanticLabel ?? 'Seek',
      slider: true,
      enabled: widget.enabled,
      value: formatVideoTimeValuetext(widget.position, widget.duration),
      increasedValue:
          '${(widget.position + const Duration(seconds: 10)).inSeconds}s',
      decreasedValue:
          '${(widget.position - const Duration(seconds: 10)).inSeconds}s',
      onIncrease: widget.enabled ? () => _step(1) : null,
      onDecrease: widget.enabled ? () => _step(-1) : null,
      child: Focus(
        focusNode: _node,
        onFocusChange: (v) => setState(() => _focused = v),
        onKeyEvent: (node, event) {
          if (!widget.enabled || event is! KeyDownEvent) {
            return KeyEventResult.ignored;
          }
          final bool fine = HardwareKeyboard.instance.isShiftPressed;
          if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
            _step(1, fine: fine);
            return KeyEventResult.handled;
          }
          if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            _step(-1, fine: fine);
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
        child: MouseRegion(
          cursor: widget.enabled
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (d) {
              _seekFromDx(_trackLocal(d.globalPosition).dx, _trackWidth);
            },
            onHorizontalDragUpdate: (d) {
              _seekFromDx(_trackLocal(d.globalPosition).dx, _trackWidth);
            },
            child: SizedBox(
              key: _trackKey,
              height: 24,
              child: CustomPaint(
                painter: _ScrubPainter(
                  fraction: fraction,
                  bufferedFraction: buffered,
                  trackColor: widget.trackColor,
                  bufferedColor: widget.bufferedColor,
                  fillColor: widget.fillColor,
                  thumbColor: widget.thumbColor,
                  trackHeight: widget.trackHeight,
                  focused: _focused || _hovered,
                  rtl: rtl,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Paints track, buffered range, played fill and thumb; mirrors for RTL.
class _ScrubPainter extends CustomPainter {
  const _ScrubPainter({
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
    final RRect track = RRect.fromRectAndRadius(full, Radius.circular(half));
    paint.color = trackColor;
    canvas.drawRRect(track, paint);
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
          : Rect.fromLTWH(0, cy - half, fw, trackHeight);
      paint.color = fillColor;
      canvas.drawRRect(
        RRect.fromRectAndRadius(fRect, Radius.circular(half)),
        paint,
      );
    }
    final double tx = rtl ? size.width * (1 - fraction) : size.width * fraction;
    paint.color = thumbColor;
    canvas.drawCircle(Offset(tx, cy), focused ? 6 : 4, paint);
  }

  @override
  bool shouldRepaint(covariant _ScrubPainter old) {
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

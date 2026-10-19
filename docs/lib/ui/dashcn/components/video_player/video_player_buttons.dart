// Shared buttons for `video_player`: icon button, play button, volume.
//
// Split from the controls bar so both files stay small.

import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/touch_hit_area.dart';
import 'video_player_controller.dart';
import 'video_player_style.dart';

/// Builds one chrome part with live controller state.
typedef VideoPartBuilder =
    Widget Function(BuildContext context, VideoPlaybackController controller);

/// Formats a duration as m:ss or h:mm:ss.
String formatMediaTime(Duration value) {
  final int total = value.inSeconds.clamp(0, 86400 * 99);
  final int h = total ~/ 3600;
  final int m = (total % 3600) ~/ 60;
  final int s = total % 60;
  if (h > 0) {
    return '$h:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
  return '$m:${s.toString().padLeft(2, '0')}';
}

/// 48px accessible icon button.
Widget videoIconButton({
  required String label,
  required IconData icon,
  required double size,
  required Color fg,
  String? text,
  VoidCallback? onTap,
}) {
  return TouchHitArea(
    vertical: 4,
    horizontal: 4,
    child: Semantics(
      label: label,
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          width: 48,
          height: 48,
          child: Center(
            child: text != null
                ? ExcludeSemantics(
                    child: Text(
                      text,
                      style: TextStyle(color: fg, fontSize: 12),
                    ),
                  )
                : Icon(icon, size: size, color: fg),
          ),
        ),
      ),
    ),
  );
}

/// Centre play/pause button.
Widget videoPlayButton(
  BuildContext context,
  VideoPlayerTheme style,
  Color fg,
  VideoPlaybackController c, {
  bool big = false,
  VideoPartBuilder? overrideBuilder,
}) {
  if (overrideBuilder != null && !big) return overrideBuilder(context, c);
  final double size = big ? (style.controlSize ?? 56) : 48;
  return TouchHitArea(
    vertical: 4,
    horizontal: 4,
    child: Semantics(
      label: c.isPlaying ? 'Pause' : 'Play',
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: c.toggle,
        child: Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            color: Color(0x99000000),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(
            c.isPlaying ? LucideIcons.pause : LucideIcons.play,
            size: big ? 28 : (style.iconSize ?? 20),
            color: fg,
          ),
        ),
      ),
    ),
  );
}

/// Inline volume track painter.
class VolumePainter extends CustomPainter {
  /// Creates a volume painter.
  const VolumePainter({
    required this.value,
    required this.fill,
    required this.rtl,
  });

  /// Volume 0..1.
  final double value;

  /// Fill colour.
  final Color fill;

  /// Whether layout is RTL.
  final bool rtl;

  @override
  void paint(Canvas canvas, Size size) {
    final double cy = size.height / 2;
    final Paint paint = Paint()..style = PaintingStyle.fill;
    paint.color = fill.withValues(alpha: 0.35);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, cy - 2, size.width, 4),
        const Radius.circular(2),
      ),
      paint,
    );
    paint.color = fill;
    final double w = size.width * value.clamp(0.0, 1.0);
    final Rect rect = rtl
        ? Rect.fromLTWH(size.width - w, cy - 2, w, 4)
        : Rect.fromLTWH(0, cy - 2, w, 4);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(2)),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant VolumePainter old) {
    return old.value != value || old.fill != fill || old.rtl != rtl;
  }
}

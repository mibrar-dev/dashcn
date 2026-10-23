// Shared buttons for `video_player`: icon button, play button, volume.
//
// Split from the controls bar so both files stay small.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/focus_tap.dart';
import '../../primitives/localizations/localizations.dart';
import '../../primitives/surface.dart';
import 'video_player_controller.dart';
import 'video_player_style.dart';

/// Formats a speed multiplier without a trailing `.0` (`1x`, `0.5x`).
String formatVideoSpeed(double speed) =>
    speed.toString().replaceAll(RegExp(r'\.0$'), '');

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

/// Formats a duration as spoken text for accessibility.
///
/// English fallback for code without locale access; widget builds should
/// prefer [formatVideoSpokenDuration], which pluralizes in the ambient locale.
String _formatSpokenDuration(Duration value) {
  final int total = value.inSeconds.clamp(0, 86400 * 99);
  final int h = total ~/ 3600;
  final int m = (total % 3600) ~/ 60;
  final int s = total % 60;
  final List<String> parts = <String>[];
  if (h > 0) parts.add('$h ${h == 1 ? "hour" : "hours"}');
  if (m > 0) parts.add('$m ${m == 1 ? "minute" : "minutes"}');
  if (s > 0 || parts.isEmpty) parts.add('$s ${s == 1 ? "second" : "seconds"}');
  return parts.join(' ');
}

/// Formats playhead and duration as slider valuetext time.
///
/// English fallback for code without a [BuildContext]; widget builds should
/// prefer [formatVideoTimeValuetextIn], which reads the ambient locale.
String formatVideoTimeValuetext(Duration position, Duration duration) {
  return '${_formatSpokenDuration(position)} of ${_formatSpokenDuration(duration)}';
}

/// Locale-aware spoken duration for accessibility announcements.
String formatVideoSpokenDuration(
  ComponentLocalizations strings,
  Duration value,
) {
  final int total = value.inSeconds.clamp(0, 86400 * 99);
  final int h = total ~/ 3600;
  final int m = (total % 3600) ~/ 60;
  final int s = total % 60;
  final List<String> parts = <String>[];
  if (h > 0) parts.add(strings.mediaHours(h));
  if (m > 0) parts.add(strings.mediaMinutes(m));
  if (s > 0 || parts.isEmpty) parts.add(strings.mediaSeconds(s));
  return parts.join(' ');
}

/// Locale-aware [formatVideoTimeValuetext] for widget builds.
String formatVideoTimeValuetextIn(
  BuildContext context,
  Duration position,
  Duration duration,
) {
  final ComponentLocalizations strings = ComponentLocalizations.of(context);
  return strings.mediaPositionOf(
    formatVideoSpokenDuration(strings, position),
    formatVideoSpokenDuration(strings, duration),
  );
}

/// Accessible icon button for player chrome.
///
/// [minTarget] floors the tap target (48 default; 32 compact under 380px).
Widget videoIconButton({
  required String label,
  required IconData icon,
  required double size,
  required Color fg,
  String? text,
  double minTarget = 48,
  VoidCallback? onTap,
}) {
  return FocusableTap(
    label: label,
    onTap: onTap,
    minWidth: minTarget,
    minHeight: minTarget,
    child: SizedBox(
      width: 32,
      height: 32,
      child: Center(
        child: text != null
            ? ExcludeSemantics(
                child: Text(
                  text,
                  style: TextStyle(
                    color: fg,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            : Icon(icon, size: size, color: fg),
      ),
    ),
  );
}

/// Centre or bar play/pause button.
///
/// The big variant is the SPEC 56px translucent glass circle; the bar
/// variant is icon-only at 32px.
Widget videoPlayButton(
  BuildContext context,
  VideoPlayerTheme style,
  Color fg,
  VideoPlaybackController c, {
  bool big = false,
  double minTarget = 48,
  VideoPartBuilder? overrideBuilder,
}) {
  if (overrideBuilder != null && !big) return overrideBuilder(context, c);
  final double size = big
      ? (style.controlSize ?? resolveVideoMetrics(style).controlSize)
      : 32;
  final double iconSize = big ? 28 : (style.iconSize ?? 16);
  final Widget visual = Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: big ? const Color(0x66FFFFFF) : const Color(0x33FFFFFF),
      shape: BoxShape.circle,
      border: big ? Border.all(color: const Color(0x80FFFFFF)) : null,
    ),
    alignment: Alignment.center,
    child: Icon(
      c.isPlaying ? LucideIcons.pause : LucideIcons.play,
      size: iconSize,
      color: big ? const Color(0xFF18181B) : fg,
    ),
  );
  final Widget button = big
      ? GlassSurface(
          surfaceBlur:
              resolveSurfaceBlur(context, component: style.surfaceBlur) ?? 8,
          borderRadius: BorderRadius.circular(size / 2),
          child: visual,
        )
      : visual;
  return FocusableTap(
    label: c.isPlaying
        ? ComponentLocalizations.of(context).mediaPause
        : ComponentLocalizations.of(context).mediaPlay,
    onTap: c.toggle,
    minWidth: big ? 48 : minTarget,
    minHeight: big ? 48 : minTarget,
    circular: true,
    child: button,
  );
}

/// Handles keyboard events for video playback.
///
/// Space/K toggles; Left/Right seek 10 s (5 s with Shift); Up/Down volume;
/// M mute; F fullscreen; C captions.
KeyEventResult handleVideoKey({
  required KeyEvent event,
  required VideoPlaybackController controller,
  VoidCallback? onFullscreenRequested,
}) {
  if (event is! KeyDownEvent) return KeyEventResult.ignored;
  final bool shift = HardwareKeyboard.instance.isShiftPressed;
  final Duration step = shift
      ? const Duration(seconds: 5)
      : const Duration(seconds: 10);
  switch (event.logicalKey) {
    case LogicalKeyboardKey.space:
    case LogicalKeyboardKey.keyK:
      controller.toggle();
      return KeyEventResult.handled;
    case LogicalKeyboardKey.arrowRight:
      controller.seekTo(controller.position + step);
      return KeyEventResult.handled;
    case LogicalKeyboardKey.arrowLeft:
      controller.seekTo(controller.position - step);
      return KeyEventResult.handled;
    case LogicalKeyboardKey.arrowUp:
      controller.setVolume((controller.volume + 0.1).clamp(0.0, 1.0));
      return KeyEventResult.handled;
    case LogicalKeyboardKey.arrowDown:
      controller.setVolume((controller.volume - 0.1).clamp(0.0, 1.0));
      return KeyEventResult.handled;
    case LogicalKeyboardKey.keyM:
      controller.setMuted(!controller.isMuted);
      return KeyEventResult.handled;
    case LogicalKeyboardKey.keyF:
      onFullscreenRequested?.call();
      return KeyEventResult.handled;
    case LogicalKeyboardKey.keyC:
      controller.toggleCaptions();
      return KeyEventResult.handled;
  }
  return KeyEventResult.ignored;
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
    final double midY = size.height / 2;
    final Paint track = Paint()
      ..color = fill.withAlpha(0x59)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    final Paint active = Paint()
      ..color = fill
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(0, midY), Offset(size.width, midY), track);
    final double fillWidth = size.width * value.clamp(0.0, 1.0);
    if (rtl) {
      canvas.drawLine(
        Offset(size.width, midY),
        Offset(size.width - fillWidth, midY),
        active,
      );
    } else {
      canvas.drawLine(Offset(0, midY), Offset(fillWidth, midY), active);
    }
  }

  @override
  bool shouldRepaint(VolumePainter oldDelegate) =>
      oldDelegate.value != value ||
      oldDelegate.fill != fill ||
      oldDelegate.rtl != rtl;
}

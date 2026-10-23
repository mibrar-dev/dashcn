// Compact pill parts for `audio_player`: icon button, speed chip, volume.
//
// Split from `audio_player_compact.dart` so both files stay small.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/focus_tap.dart';
import '../../primitives/tap_target.dart';
import '../../primitives/localizations/localizations.dart';
import '../../theme/theme.dart';
import 'audio_player_controller.dart';

/// Small icon button for the compact pill (volume cluster, download).
Widget audioPillButton({
  required String label,
  required IconData icon,
  required Color fg,
  double size = 16,
  VoidCallback? onTap,
}) {
  return FocusableTap(
    label: label,
    onTap: onTap,
    minWidth: 36,
    minHeight: 36,
    child: SizedBox(
      width: 36,
      height: 36,
      child: Icon(icon, size: size, color: fg),
    ),
  );
}

/// Speed number chip: tap cycles 1x, 1.25x, 1.5x, 2x, 3x (SPEC reference 1).
class AudioSpeedChip extends StatelessWidget {
  /// Creates a speed chip.
  const AudioSpeedChip({
    super.key,
    required this.controller,
    required this.fg,
    required this.speeds,
  });

  /// Playback controller.
  final AudioPlaybackController controller;

  /// Text colour.
  final Color fg;

  /// Speeds to cycle through.
  final List<double> speeds;

  @override
  Widget build(BuildContext context) {
    final AudioPlaybackController c = controller;
    final String text = c.playbackSpeed.toString().replaceAll(
      RegExp(r'\.0$'),
      '',
    );
    return FocusableTap(
      label: ComponentLocalizations.of(context).mediaPlaybackSpeed(text),
      onTap: () => c.cycleSpeed(speeds),
      minWidth: 36,
      minHeight: 36,
      child: SizedBox(
        width: 36,
        height: 36,
        child: Center(
          child: ExcludeSemantics(
            child: Text(
              text,
              style: TextStyle(
                color: fg,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Volume icon; hover/focus reveals a small inline slider (SPEC reference 1).
class AudioVolumeButton extends StatefulWidget {
  /// Creates a volume button.
  const AudioVolumeButton({
    super.key,
    required this.controller,
    required this.fg,
  });

  /// Playback controller.
  final AudioPlaybackController controller;

  /// Icon and slider colour.
  final Color fg;

  @override
  State<AudioVolumeButton> createState() => _AudioVolumeButtonState();
}

class _AudioVolumeButtonState extends State<AudioVolumeButton> {
  bool _open = false;
  final FocusNode _node = FocusNode(debugLabel: 'AudioVolumeButton');

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AudioPlaybackController c = widget.controller;
    return MouseRegion(
      onEnter: (_) => setState(() => _open = true),
      onExit: (_) {
        if (!_node.hasFocus) setState(() => _open = false);
      },
      child: Focus(
        focusNode: _node,
        onFocusChange: (v) => setState(() => _open = _open || v),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            audioPillButton(
              label: c.isMuted
                  ? ComponentLocalizations.of(context).mediaUnmute
                  : ComponentLocalizations.of(context).mediaMute,
              icon: c.isMuted ? LucideIcons.volumeOff : LucideIcons.volume2,
              fg: widget.fg,
              onTap: () => c.setMuted(!c.isMuted),
            ),
            if (_open) _VolumeSlider(controller: c, fg: widget.fg),
          ],
        ),
      ),
    );
  }
}

/// Thin inline level painter for the compact volume slider.
class _MiniLevel extends CustomPainter {
  const _MiniLevel({
    required this.value,
    required this.track,
    required this.fill,
    required this.rtl,
    this.focused = false,
  });

  final double value;
  final Color track;
  final Color fill;
  final bool rtl;

  /// Whether the slider has keyboard focus (draws a focus underline).
  final bool focused;

  @override
  void paint(Canvas canvas, Size size) {
    final double midY = size.height / 2;
    final Paint trackPaint = Paint()
      ..color = track
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    final Paint active = Paint()
      ..color = fill
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(4, midY), Offset(size.width - 4, midY), trackPaint);
    final double w = (size.width - 8) * value.clamp(0.0, 1.0);
    if (rtl) {
      canvas.drawLine(
        Offset(size.width - 4, midY),
        Offset(size.width - 4 - w, midY),
        active,
      );
    } else {
      canvas.drawLine(Offset(4, midY), Offset(4 + w, midY), active);
    }
    if (focused) {
      final Paint ring = Paint()
        ..color = fill.withAlpha(0xB3)
        ..strokeWidth = 1.5;
      canvas.drawRRect(
        RRect.fromLTRBR(
          2,
          midY - 8,
          size.width - 2,
          midY + 8,
          const Radius.circular(4),
        ),
        ring,
      );
    }
  }

  @override
  bool shouldRepaint(_MiniLevel old) =>
      old.value != value ||
      old.track != track ||
      old.fill != fill ||
      old.rtl != rtl ||
      old.focused != focused;
}

/// Inline volume slider for the compact pill.
///
/// Tap maps to the tapped position of the 64px line (RTL-aware); drag moves
/// relative to the line width; arrow keys step 10% when focused.
class _VolumeSlider extends StatefulWidget {
  /// Creates a volume slider.
  const _VolumeSlider({required this.controller, required this.fg});

  /// Playback controller.
  final AudioPlaybackController controller;

  /// Line colour.
  final Color fg;

  @override
  State<_VolumeSlider> createState() => _VolumeSliderState();
}

class _VolumeSliderState extends State<_VolumeSlider> {
  final GlobalKey _lineKey = GlobalKey();
  bool _focused = false;

  double get _level => widget.controller.isMuted ? 0 : widget.controller.volume;

  double _fractionAt(Offset globalPosition) {
    final RenderBox? box =
        _lineKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return _level;
    final double dx = box.globalToLocal(globalPosition).dx - 4;
    final double w = box.size.width - 8;
    if (w <= 0) return _level;
    double t = (dx / w).clamp(0.0, 1.0);
    if (Directionality.of(context) == TextDirection.rtl) t = 1 - t;
    return t;
  }

  @override
  Widget build(BuildContext context) {
    final AudioPlaybackController c = widget.controller;
    return Semantics(
      label: ComponentLocalizations.of(context).mediaVolume,
      slider: true,
      value: '${(_level * 100).round()}%',
      increasedValue: '${(((_level + 0.1).clamp(0.0, 1.0)) * 100).round()}%',
      decreasedValue: '${(((_level - 0.1).clamp(0.0, 1.0)) * 100).round()}%',
      onIncrease: () => c.setVolume(_level + 0.1),
      onDecrease: () => c.setVolume(_level - 0.1),
      child: Focus(
        onFocusChange: (bool v) => setState(() => _focused = v),
        onKeyEvent: (FocusNode node, KeyEvent event) {
          if (event is! KeyDownEvent) return KeyEventResult.ignored;
          if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
              event.logicalKey == LogicalKeyboardKey.arrowUp) {
            c.setVolume(_level + 0.1);
            return KeyEventResult.handled;
          }
          if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
              event.logicalKey == LogicalKeyboardKey.arrowDown) {
            c.setVolume(_level - 0.1);
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        },
        child: TapTarget(
          minWidth: 48,
          minHeight: 48,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onHorizontalDragUpdate: (DragUpdateDetails d) {
              final RenderBox? box =
                  _lineKey.currentContext?.findRenderObject() as RenderBox?;
              if (box == null || !box.hasSize) return;
              final double w = box.size.width - 8;
              if (w <= 0) return;
              final double step =
                  Directionality.of(context) == TextDirection.rtl
                  ? -d.delta.dx / w
                  : d.delta.dx / w;
              c.setVolume(_level + step);
            },
            onTapDown: (TapDownDetails d) =>
                c.setVolume(_fractionAt(d.globalPosition)),
            child: SizedBox(
              key: _lineKey,
              width: 64,
              height: 36,
              child: CustomPaint(
                painter: _MiniLevel(
                  value: _level,
                  track: Theme.of(context).colors.border,
                  fill: widget.fg,
                  focused: _focused,
                  rtl: Directionality.of(context) == TextDirection.rtl,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

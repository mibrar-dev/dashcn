// Compact pill parts for `audio_player`: icon button, speed chip, volume.
//
// Split from `audio_player_compact.dart` so both files stay small.

import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/tap_target.dart';
import '../../primitives/localizations/localizations.dart';
import 'audio_player_controller.dart';

/// Small icon button for the compact pill (volume cluster, download).
Widget audioPillButton({
  required String label,
  required IconData icon,
  required Color fg,
  double size = 18,
  VoidCallback? onTap,
}) {
  return Semantics(
    label: label,
    button: true,
    child: TapTarget(
      minWidth: 48,
      minHeight: 48,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          width: 32,
          height: 48,
          child: Icon(icon, size: size, color: fg),
        ),
      ),
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
    return Semantics(
      label: ComponentLocalizations.of(
        context,
      ).mediaPlaybackSpeed(c.playbackSpeed),
      button: true,
      child: TapTarget(
        minWidth: 48,
        minHeight: 48,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => c.cycleSpeed(speeds),
          child: SizedBox(
            width: 32,
            height: 48,
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
          children: <Widget>[
            audioPillButton(
              label: c.isMuted
                  ? ComponentLocalizations.of(context).mediaUnmute
                  : ComponentLocalizations.of(context).mediaMute,
              icon: c.isMuted ? LucideIcons.volumeOff : LucideIcons.volume2,
              fg: widget.fg,
              onTap: () => c.setMuted(!c.isMuted),
            ),
            if (_open)
              Semantics(
                label: ComponentLocalizations.of(context).mediaVolume,
                slider: true,
                value: '${(c.volume * 100).round()}%',
                onIncrease: () => c.setVolume(c.volume + 0.1),
                onDecrease: () => c.setVolume(c.volume - 0.1),
                child: TapTarget(
                  minHeight: 48,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onHorizontalDragUpdate: (d) =>
                        c.setVolume(c.volume + d.delta.dx / 64),
                    onTapDown: (d) {
                      final RenderBox box =
                          context.findRenderObject()! as RenderBox;
                      final double t =
                          (box.globalToLocal(d.globalPosition).dx /
                                  box.size.width)
                              .clamp(0.0, 1.0);
                      c.setVolume(t);
                    },
                    child: SizedBox(
                      width: 64,
                      height: 48,
                      child: CustomPaint(
                        painter: _MiniLevel(
                          value: c.isMuted ? 0 : c.volume,
                          fill: widget.fg,
                          rtl: Directionality.of(context) == TextDirection.rtl,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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
    required this.fill,
    required this.rtl,
  });

  final double value;
  final Color fill;
  final bool rtl;

  @override
  void paint(Canvas canvas, Size size) {
    final double midY = size.height / 2;
    final Paint track = Paint()
      ..color = fill.withAlpha(0x3D)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    final Paint active = Paint()
      ..color = fill
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(4, midY), Offset(size.width - 4, midY), track);
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
  }

  @override
  bool shouldRepaint(_MiniLevel old) =>
      old.value != value || old.fill != fill || old.rtl != rtl;
}

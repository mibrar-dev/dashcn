// Volume cluster for `video_player`: mute button + inline level slider.
//
// Split from `video_player_controls.dart` so both files stay small.

import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/tap_target.dart';
import 'video_player_buttons.dart';
import 'video_player_controller.dart';
import 'video_player_style.dart';

/// Mute button with an inline level slider (icon only when [compact]).
Widget videoVolumeCluster({
  required BuildContext context,
  required VideoPlaybackController c,
  required VideoPlayerTheme style,
  required Color fg,
  bool compact = false,
  double minTarget = 48,
}) {
  final Widget mute = videoIconButton(
    label: c.isMuted ? 'Unmute' : 'Mute',
    icon: c.isMuted ? LucideIcons.volumeOff : LucideIcons.volume2,
    size: style.iconSize ?? 16,
    fg: fg,
    minTarget: minTarget,
    onTap: () => c.setMuted(!c.isMuted),
  );
  if (compact) return mute;
  final double level = c.isMuted ? 0 : c.volume;
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      mute,
      Semantics(
        label: 'Volume',
        slider: true,
        value: '${(level * 100).round()}%',
        increasedValue: '${(((level + 0.1).clamp(0.0, 1.0)) * 100).round()}%',
        decreasedValue: '${(((level - 0.1).clamp(0.0, 1.0)) * 100).round()}%',
        onIncrease: () => c.setVolume(level + 0.1),
        onDecrease: () => c.setVolume(level - 0.1),
        child: TapTarget(
          minWidth: minTarget,
          minHeight: minTarget,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (_) => c.setVolume(0.5),
            child: SizedBox(
              width: 56,
              height: 32,
              child: CustomPaint(
                painter: VolumePainter(
                  value: level,
                  fill: fg,
                  rtl: Directionality.of(context) == TextDirection.rtl,
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

// Volume cluster for `video_player`: icon with a pop-up level slider.
//
// Split from `video_player_controls.dart` so both files stay small. SPEC
// shows a volume icon in the bar row; the slider opens on tap, hover or
// focus and maps taps/drags to the tapped position (RTL-aware).

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/localizations/localizations.dart';
import '../../primitives/tap_target.dart';
import 'video_player_buttons.dart';
import 'video_player_controller.dart';
import 'video_player_style.dart';

/// Mute button with a pop-up level slider (icon only when closed).
Widget videoVolumeCluster({
  required BuildContext context,
  required VideoPlaybackController c,
  required VideoPlayerTheme style,
  required Color fg,
  bool compact = false,
  double minTarget = 48,
}) {
  if (compact) {
    return videoIconButton(
      label: c.isMuted
          ? ComponentLocalizations.of(context).mediaUnmute
          : ComponentLocalizations.of(context).mediaMute,
      icon: c.isMuted ? LucideIcons.volumeOff : LucideIcons.volume2,
      size: style.iconSize ?? 16,
      fg: fg,
      minTarget: minTarget,
      onTap: () => c.setMuted(!c.isMuted),
    );
  }
  return _VideoVolumeCluster(c: c, style: style, fg: fg, minTarget: minTarget);
}

class _VideoVolumeCluster extends StatefulWidget {
  const _VideoVolumeCluster({
    required this.c,
    required this.style,
    required this.fg,
    required this.minTarget,
  });

  final VideoPlaybackController c;
  final VideoPlayerTheme style;
  final Color fg;
  final double minTarget;

  @override
  State<_VideoVolumeCluster> createState() => _VideoVolumeClusterState();
}

class _VideoVolumeClusterState extends State<_VideoVolumeCluster> {
  final GlobalKey _lineKey = GlobalKey();
  bool _open = false;
  bool _sliderFocused = false;

  double get _level => widget.c.isMuted ? 0 : widget.c.volume;

  double _fractionAt(Offset globalPosition) {
    final RenderBox? box =
        _lineKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return _level;
    final double dx = box.globalToLocal(globalPosition).dx;
    final double w = box.size.width;
    if (w <= 0) return _level;
    double t = (dx / w).clamp(0.0, 1.0);
    if (Directionality.of(context) == TextDirection.rtl) t = 1 - t;
    return t;
  }

  @override
  Widget build(BuildContext context) {
    final VideoPlaybackController c = widget.c;
    return MouseRegion(
      onEnter: (_) => setState(() => _open = true),
      onExit: (_) => setState(() => _open = false),
      child: Focus(
        onFocusChange: (bool v) => setState(() {
          _sliderFocused = v;
          if (v) _open = true;
        }),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            videoIconButton(
              label: c.isMuted
                  ? ComponentLocalizations.of(context).mediaUnmute
                  : ComponentLocalizations.of(context).mediaMute,
              icon: c.isMuted ? LucideIcons.volumeOff : LucideIcons.volume2,
              size: widget.style.iconSize ?? 16,
              fg: widget.fg,
              minTarget: widget.minTarget,
              onTap: () {
                c.setMuted(!c.isMuted);
                setState(() => _open = !_open);
              },
            ),
            if (_open)
              Semantics(
                label: ComponentLocalizations.of(context).mediaVolume,
                slider: true,
                value: '${(_level * 100).round()}%',
                increasedValue:
                    '${(((_level + 0.1).clamp(0.0, 1.0)) * 100).round()}%',
                decreasedValue:
                    '${(((_level - 0.1).clamp(0.0, 1.0)) * 100).round()}%',
                onIncrease: () => c.setVolume(_level + 0.1),
                onDecrease: () => c.setVolume(_level - 0.1),
                child: Focus(
                  onFocusChange: (bool v) => setState(() => _sliderFocused = v),
                  onKeyEvent: (FocusNode node, KeyEvent event) {
                    if (event is! KeyDownEvent) {
                      return KeyEventResult.ignored;
                    }
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
                    if (event.logicalKey == LogicalKeyboardKey.escape) {
                      setState(() => _open = false);
                      return KeyEventResult.handled;
                    }
                    return KeyEventResult.ignored;
                  },
                  child: TapTarget(
                    minWidth: widget.minTarget,
                    minHeight: widget.minTarget,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTapDown: (TapDownDetails d) =>
                          c.setVolume(_fractionAt(d.globalPosition)),
                      onHorizontalDragUpdate: (DragUpdateDetails d) {
                        final RenderBox? box =
                            _lineKey.currentContext?.findRenderObject()
                                as RenderBox?;
                        if (box == null || !box.hasSize) return;
                        final double w = box.size.width;
                        if (w <= 0) return;
                        final double step =
                            Directionality.of(context) == TextDirection.rtl
                            ? -d.delta.dx / w
                            : d.delta.dx / w;
                        c.setVolume(_level + step);
                      },
                      child: SizedBox(
                        key: _lineKey,
                        width: 56,
                        height: 32,
                        child: CustomPaint(
                          painter: VolumePainter(
                            value: _level,
                            fill: _sliderFocused
                                ? widget.fg
                                : widget.fg.withAlpha(0xD9),
                            rtl:
                                Directionality.of(context) == TextDirection.rtl,
                          ),
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

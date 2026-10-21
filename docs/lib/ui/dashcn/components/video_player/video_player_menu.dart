// More menu for `video_player`: speed chips, captions toggle, quality.
//
// Split from `video_player_controls.dart` so both files stay small. The menu
// renders as a full-width section above the buttons row, so the buttons row
// never overflows and every item stays hit-testable.

import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/tap_target.dart';
import 'video_player_buttons.dart';
import 'video_player_controller.dart';
import 'video_player_style.dart';

/// The three-dots button that opens the menu section.
Widget videoMoreButton({
  required VideoPlayerTheme style,
  required Color fg,
  required VideoPlaybackController c,
  required double minTarget,
  required VoidCallback onTap,
}) {
  return videoIconButton(
    label: 'More options, playback speed ${c.playbackSpeed}x',
    icon: LucideIcons.ellipsis,
    size: style.iconSize ?? 16,
    fg: fg,
    minTarget: minTarget,
    onTap: onTap,
  );
}

/// Speed/captions menu section: wrapping speed chips, captions toggle and
/// quality note (SPEC more-menu).
Widget videoMenuSection({
  required VideoPlaybackController c,
  required VideoPlayerTheme style,
  required Color fg,
  required List<double> speeds,
  required VoidCallback onDone,
}) {
  final List<double> steps = speeds.isEmpty ? const <double>[1] : speeds;
  return Container(
    margin: const EdgeInsets.only(top: 4),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(
      color: const Color(0x33FFFFFF),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: <Widget>[
            for (final double s in steps)
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  c.setPlaybackSpeed(s);
                  onDone();
                },
                child: Semantics(
                  label: 'Speed ${s}x',
                  button: true,
                  child: TapTarget(
                    minWidth: 48,
                    minHeight: 32,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: c.playbackSpeed == s ? fg : fg.withAlpha(0x66),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ExcludeSemantics(
                        child: Text(
                          '${s}x',
                          style: TextStyle(
                            color: fg,
                            fontSize: 12,
                            fontWeight: c.playbackSpeed == s
                                ? FontWeight.w700
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  c.toggleCaptions();
                  onDone();
                },
                child: Semantics(
                  label: c.areCaptionsEnabled ? 'Captions on' : 'Captions off',
                  button: true,
                  child: TapTarget(
                    minHeight: 32,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: ExcludeSemantics(
                        child: Text(
                          c.areCaptionsEnabled ? 'Captions on' : 'Captions off',
                          style: TextStyle(color: fg, fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ExcludeSemantics(
              child: Text(
                'Quality Auto',
                style: TextStyle(color: fg.withAlpha(0xB3), fontSize: 12),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

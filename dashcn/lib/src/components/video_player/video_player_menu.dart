// More menu for `video_player`: speed chips, captions toggle, quality.
//
// Split from `video_player_controls.dart` so both files stay small. The menu
// renders as a full-width section above the buttons row, so the buttons row
// never overflows and every item stays hit-testable.

import 'package:flutter/widgets.dart';

import '../../foundation/icons/lucide_icons.dart';
import '../../primitives/focus_tap.dart';
import '../../primitives/localizations/localizations.dart';
import '../../theme/theme.dart';
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
  ComponentLocalizations? strings,
}) {
  return videoIconButton(
    label:
        strings?.mediaMoreOptionsSpeed(formatVideoSpeed(c.playbackSpeed)) ??
        'More options, playback speed ${formatVideoSpeed(c.playbackSpeed)}x',
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
  required BuildContext context,
  required VideoPlaybackController c,
  required VideoPlayerTheme style,
  required Color fg,
  required List<double> speeds,
  required VoidCallback onDone,
  ComponentLocalizations? strings,
}) {
  final List<double> steps = speeds.isEmpty ? const <double>[1] : speeds;
  return Container(
    margin: const EdgeInsets.only(top: 8),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    decoration: BoxDecoration(
      color: const Color(0x33FFFFFF),
      borderRadius: BorderRadius.circular(Theme.of(context).radiusLg),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            for (final double s in steps)
              FocusableTap(
                label:
                    strings?.mediaSpeed(formatVideoSpeed(s)) ??
                    'Speed ${formatVideoSpeed(s)}x',
                onTap: () {
                  c.setPlaybackSpeed(s);
                  onDone();
                },
                minWidth: 48,
                minHeight: 32,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: c.playbackSpeed == s ? fg : fg.withAlpha(0x66),
                    ),
                    borderRadius: BorderRadius.circular(
                      Theme.of(context).radiusLg,
                    ),
                  ),
                  child: ExcludeSemantics(
                    child: Text(
                      '${formatVideoSpeed(s)}x',
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
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            Expanded(
              child: FocusableTap(
                label: c.areCaptionsEnabled
                    ? strings?.mediaCaptionsOn ?? 'Captions on'
                    : strings?.mediaCaptionsOff ?? 'Captions off',
                onTap: () {
                  c.toggleCaptions();
                  onDone();
                },
                minWidth: 48,
                minHeight: 32,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ExcludeSemantics(
                    child: Text(
                      c.areCaptionsEnabled
                          ? strings?.mediaCaptionsOn ?? 'Captions on'
                          : strings?.mediaCaptionsOff ?? 'Captions off',
                      style: TextStyle(color: fg, fontSize: 12),
                    ),
                  ),
                ),
              ),
            ),
            ExcludeSemantics(
              child: Text(
                strings?.mediaQualityAuto ?? 'Quality Auto',
                style: TextStyle(color: fg.withAlpha(0xB3), fontSize: 12),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

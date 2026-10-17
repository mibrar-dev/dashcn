// Named examples for the `overflow_marquee` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.
//
// P7-WB: realistic scenes instead of lorem ticker — a now-playing row, a news
// ticker and a long filename in a fixed-width card. Every marquee sits in an
// explicitly bounded box (the ticker measures its overflow against the
// constraints), so no stage shape can shrink one to zero.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/theme.dart';
import '../badge/badge.dart';
import '../button/button.dart';
import 'overflow_marquee.dart';

/// A bordered band for the ticker-style examples.
Widget _band(BuildContext context, Widget child) {
  final theme = Theme.of(context);
  return DecoratedBox(
    decoration: BoxDecoration(
      color: theme.colors.card,
      border: Border.all(color: theme.colors.border),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Padding(padding: EdgeInsets.all(theme.spacing.sm), child: child),
  );
}

/// Now-playing row with a play/pause toggle: long song titles scroll.
class _NowPlaying extends StatefulWidget {
  const _NowPlaying();

  @override
  State<_NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<_NowPlaying> {
  bool _playing = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 320,
          child: _band(
            context,
            Row(
              children: <Widget>[
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: theme.colors.muted,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Icon(
                      LucideIcons.music,
                      size: 20,
                      color: theme.colors.mutedForeground,
                    ),
                  ),
                ),
                Gap(theme.spacing.sm),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const OverflowMarquee(
                        duration: Duration(seconds: 6),
                        child: Text(
                          'Midnight City — M83 (Extended Club Mix, 2024 Remaster)',
                        ),
                      ),
                      Text(
                        _playing ? 'Playing · Synthwave' : 'Paused · Synthwave',
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colors.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(theme.spacing.sm),
                Button(
                  size: ButtonSize.icon,
                  variant: ButtonVariant.ghost,
                  onPressed: () => setState(() => _playing = !_playing),
                  child: Semantics(
                    label: _playing ? 'Pause' : 'Play',
                    child: Icon(
                      _playing ? LucideIcons.pause : LucideIcons.play,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// A live-news band: a LIVE badge plus scrolling headlines.
Widget _newsTicker(BuildContext context) {
  final theme = Theme.of(context);
  return SizedBox(
    width: 320,
    child: _band(
      context,
      Row(
        children: <Widget>[
          const Badge(variant: BadgeVariant.destructive, child: Text('LIVE')),
          Gap(theme.spacing.sm),
          const Expanded(
            child: OverflowMarquee(
              duration: Duration(seconds: 12),
              child: Text(
                'dashcn 1.0 ships 145 components  •  '
                'pull-to-refresh learns trackpads  •  '
                'dots keep their gaps  •  '
                'cards never collapse',
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

/// A long filename scrolling inside a fixed-width file card.
Widget _filenameCard(BuildContext context) {
  final theme = Theme.of(context);
  return SizedBox(
    width: 240,
    child: _band(
      context,
      Row(
        children: <Widget>[
          Icon(
            LucideIcons.fileText,
            size: 16,
            color: theme.colors.mutedForeground,
          ),
          Gap(theme.spacing.sm),
          const Expanded(
            child: OverflowMarquee(
              duration: Duration(seconds: 5),
              child: Text('quarterly-report-final-v2-ACTUAL-final.pdf'),
            ),
          ),
          Gap(theme.spacing.sm),
          Text(
            '2.4 MB',
            style: TextStyle(fontSize: 11, color: theme.colors.mutedForeground),
          ),
        ],
      ),
    ),
  );
}

Widget _nowPlaying(BuildContext context) => const _NowPlaying();

/// Named docs examples for `overflow_marquee`; the first entry is the default.
const List<ComponentPreview> overflowMarqueePreviews = <ComponentPreview>[
  ComponentPreview('Now playing', _nowPlaying),
  ComponentPreview('News ticker', _newsTicker),
  ComponentPreview('Filename', _filenameCard),
];

// Named examples for the `overflow_marquee` component (P6-F3 preview contract).
//
// One focused demo per example; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle.
//
// Every marquee continuously loops (seamless infinite marquee) and pauses on
// pointer hover or keyboard focus.

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/gap.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/theme.dart';
import '../badge/badge.dart';
import '../button/button.dart';
import 'overflow_marquee.dart';

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

Widget _defaultMarquee(BuildContext context) {
  final theme = Theme.of(context);
  return SizedBox(
    width: 340,
    child: _band(
      context,
      Row(
        children: <Widget>[
          Icon(LucideIcons.bell, size: 16, color: theme.colors.primary),
          Gap(theme.spacing.sm),
          Expanded(
            child: OverflowMarquee(
              speed: 45.0,
              gap: 28.0,
              child: Text(
                docsSample(
                  context,
                  docsSample(context, 'Breaking News: dashcn continuous marquee components now live across all platforms! • Seamless looping with soft edge fades • Fully keyboard accessible'),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _NowPlaying extends StatefulWidget {
  const _NowPlaying();

  @override
  State<_NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<_NowPlaying> {
  final MarqueeController _controller = MarqueeController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 320,
      child: _band(
        context,
        Row(
          children: <Widget>[
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: theme.colors.muted,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Icon(
                  LucideIcons.music,
                  size: 20,
                  color: theme.colors.primary,
                ),
              ),
            ),
            Gap(theme.spacing.sm),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  OverflowMarquee(
                    controller: _controller,
                    speed: 40.0,
                    gap: 32.0,
                    child: Text(
                      docsSample(
                        context,
                        docsSample(
                          context,
                          docsSample(context, 'Midnight City — M83 (Extended Club Mix, 2024 Remaster)'),
                        ),
                      ),
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    _controller.isPlaying
                        ? docsSample(context, 'Playing · Synthwave')
                        : docsSample(context, 'Paused'),
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
              onPressed: () {
                _controller.toggle();
                setState(() {});
              },
              child: Semantics(
                label: _controller.isPlaying
                    ? docsSample(context, 'Pause')
                    : docsSample(context, 'Play'),
                child: Icon(
                  _controller.isPlaying ? LucideIcons.pause : LucideIcons.play,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _newsTicker(BuildContext context) {
  final theme = Theme.of(context);
  return SizedBox(
    width: 340,
    child: _band(
      context,
      Row(
        children: <Widget>[
          const Badge(variant: BadgeVariant.destructive, child: Text('LIVE')),
          Gap(theme.spacing.sm),
          const Expanded(
            child: OverflowMarquee(
              speed: 55.0,
              gap: 32.0,
              child: Text(
                'dashcn 1.0 ships 145 components • pull-to-refresh learns trackpads • '
                'continuous marquees loop seamlessly • cards never collapse',
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _verticalCredits(BuildContext context) {
  return SizedBox(
    width: 280,
    height: 96,
    child: _band(
      context,
      Center(
        child: OverflowMarquee(
          direction: AxisDirectional.up,
          speed: 25.0,
          gap: 16.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                docsSample(context, 'Directed by dashcn Team'),
                style: TextStyle(fontSize: 13),
              ),
              Text(
                docsSample(context, 'Original Score by Synthwave'),
                style: TextStyle(fontSize: 12),
              ),
              Text(
                docsSample(context, 'Starring Continuous Marquee'),
                style: TextStyle(fontSize: 12),
              ),
              Text(
                docsSample(context, 'Special Thanks to Open Source'),
                style: TextStyle(fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _rtlTicker(BuildContext context) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: SizedBox(
      width: 320,
      child: Builder(
        builder: (context) {
          final theme = Theme.of(context);
          return _band(
            context,
            Row(
              children: <Widget>[
                const Badge(child: Text('عاجل')),
                Gap(theme.spacing.sm),
                Expanded(
                  child: OverflowMarquee(
                    direction: AxisDirectional.start,
                    speed: 45.0,
                    gap: 30.0,
                    child: Text(
                      docsSample(
                        context,
                        docsSample(
                          context,
                          docsSample(context, 'مكتبة dashcn تدعم الاتجاه من اليمين إلى اليسار بشكل كامل مع حركة مستمرة وسلسة'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}

Widget _customizedMarquee(BuildContext context) {
  final theme = Theme.of(context);
  return SizedBox(
    width: 340,
    child: _band(
      context,
      OverflowMarquee(
        speed: 75.0,
        gap: 40.0,
        fadePortion: 0.15,
        leading: Padding(
          padding: EdgeInsets.only(right: theme.spacing.sm),
          child: const Badge(
            variant: BadgeVariant.secondary,
            child: Text('FAST'),
          ),
        ),
        trailing: Padding(
          padding: EdgeInsets.only(left: theme.spacing.sm),
          child: Icon(LucideIcons.zap, size: 16, color: theme.colors.primary),
        ),
        child: Text(
          docsSample(
            context,
            docsSample(
              context,
              docsSample(context, 'Custom speed: 75 px/s • Custom gap: 40 px • Custom edge fades • Pinned builder slots'),
            ),
          ),
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    ),
  );
}

/// Named docs examples for `overflow_marquee`; the first entry is the default.
List<ComponentPreview> get overflowMarqueePreviews => <ComponentPreview>[
  ComponentPreview(docsSample(null, 'Default'), _defaultMarquee),
  ComponentPreview(docsSample(null, 'Now playing'), _nowPlaying),
  ComponentPreview(docsSample(null, 'News ticker'), _newsTicker),
  ComponentPreview(docsSample(null, 'Vertical'), _verticalCredits),
  ComponentPreview(docsSample(null, 'RTL reverse'), _rtlTicker),
  ComponentPreview(docsSample(null, 'Customized'), _customizedMarquee),
];

Widget _nowPlaying(BuildContext context) => const _NowPlaying();

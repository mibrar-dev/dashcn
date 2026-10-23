// Home showcase: charts-like stat cards (P6-H1).
//
// Extends the Theme Studio stat blocks (`studio_blocks/studio_stats.dart`):
// the bar chart and sparklines are the same docs-only painters, re-shelled
// in [CollageCard] for the home wall.

import 'package:flutter/widgets.dart';
import '../routing/docs_router.dart';
import '../state/docs_content_home.dart';

import '../ui/dashcn/components/badge/badge.dart';
import '../ui/dashcn/components/progress/progress.dart';
import '../ui/dashcn/components/select/select.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/foundation/icons/lucide_icons.dart';
import '../ui/dashcn/theme/theme.dart';
import 'collage_cards.dart';
import 'studio_blocks/studio_card.dart';
import 'studio_blocks/studio_paint.dart';
import '../ui/dashcn/foundation/component_preview.dart';

/// `Contribution History`: the reference's bar chart plus a payout row.
class HomeContributionCard extends StatelessWidget {
  /// Creates the card.
  const HomeContributionCard({super.key});

  static const List<ContributionBar> bars = <ContributionBar>[
    ContributionBar(label: 'Dec', value: 0.45),
    ContributionBar(label: 'Jan', value: 0.72),
    ContributionBar(label: 'Feb', value: 0.55),
    ContributionBar(label: 'Mar', value: 0.88),
    ContributionBar(label: 'Apr', value: 1),
    ContributionBar(label: 'May', value: 0.62),
  ];

  @override
  Widget build(BuildContext context) {
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    final ThemeData theme = Theme.of(context);
    return CollageCard(
      title: docsHome(locale, 'homeContribHist'),
      subtitle: docsHome(locale, 'homeContribHistSub'),
      children: <Widget>[
        const StudioContributionChart(bars: bars),
        const Gap(16),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'UPCOMING',
                style: theme.typography.xSmall.copyWith(
                  letterSpacing: 0.6,
                  color: theme.colors.mutedForeground,
                ),
              ),
            ),
            Badge(
              variant: BadgeVariant.secondary,
              child: Text(docsSample(context, 'May 25, 2026')),
            ),
          ],
        ),
        const Gap(4),
        Text(
          r'$1,000 scheduled',
          style: theme.typography.small.copyWith(fontWeight: FontWeight.w600),
        ),
        const Gap(2),
        StudioHelper(
          docsSample(context, 'Accelerated savings plan · recurring monthly'),
        ),
      ],
    );
  }
}

/// A KPI number over a sparkline, the reference's stat card.
class HomeSparkCard extends StatelessWidget {
  /// Creates the card.
  const HomeSparkCard({
    super.key,
    required this.title,
    required this.value,
    required this.caption,
    required this.samples,
  });

  /// Card title.
  final String title;

  /// Formatted value line.
  final String value;

  /// Muted delta line.
  final String caption;

  /// Sparkline samples.
  final List<double> samples;

  @override
  Widget build(BuildContext context) {
    return CollageCard(
      title: title,
      subtitle: caption,
      children: <Widget>[
        StudioValue(value, size: 28),
        const Gap(12),
        StudioSparkline(values: samples),
      ],
    );
  }
}

/// `Power Usage`: a usage strip with a selected window.
class HomeUsageCard extends StatefulWidget {
  /// Creates the card.
  const HomeUsageCard({super.key});

  @override
  State<HomeUsageCard> createState() => _HomeUsageCardState();
}

class _HomeUsageCardState extends State<HomeUsageCard> {
  static const List<String> windows = <String>[
    '6a',
    '8a',
    '10a',
    '12p',
    '2p',
    '4p',
    '6p',
    '8p',
  ];
  static const List<double> samples = <double>[
    1.1,
    1.4,
    2.2,
    2.6,
    3.4,
    3.1,
    2.3,
    1.6,
  ];

  String _window = '12p';

  @override
  Widget build(BuildContext context) {
    final Locale locale =
        DocsRouterScope.maybeOf(context)?.state.locale ?? const Locale('en');
    final ThemeData theme = Theme.of(context);
    return CollageCard(
      title: docsHome(locale, 'homePowerTitle'),
      subtitle: docsHome(locale, 'homePowerSub'),
      children: <Widget>[
        Select<String>(
          value: _window,
          onChanged: (String? next) =>
              setState(() => _window = next ?? _window),
          items: <Widget>[
            for (final String window in windows)
              SelectItem<String>(value: window, child: Text(window)),
          ],
          itemBuilder: (BuildContext context, String value) => Text(value),
        ),
        const Gap(16),
        const StudioSparkline(values: samples),
        const Gap(16),
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  StudioCaption(docsSample(context, 'Currently Using')),
                  Gap(4),
                  StudioValue(docsSample(context, '3.4 kW'), size: 20),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  StudioCaption(docsSample(context, 'Solar Gen')),
                  Gap(4),
                  StudioValue(docsSample(context, '+1.2 kW'), size: 20),
                ],
              ),
            ),
          ],
        ),
        const Gap(12),
        Progress(
          value: 0.85,
          height: 4,
          semanticsLabel: docsSample(context, 'Battery level 85 percent'),
        ),
        const Gap(8),
        Row(
          children: <Widget>[
            Expanded(child: StudioHelper(docsSample(context, 'Battery Level'))),
            Icon(
              LucideIcons.batteryCharging,
              size: 14,
              color: theme.colors.mutedForeground,
            ),
            const Gap(6),
            const Text('85%'),
          ],
        ),
      ],
    );
  }
}

// `/charts` — the charts hub: a hero plus one card per chart family.
//
// Each card shows the family name, its description, the chart count and a
// link to the family page. There is no Components-style trust table: the hub
// only routes to the families.

import 'package:flutter/widgets.dart';

import '../routing/docs_router.dart';
import '../ui/dashcn/components/badge/badge.dart';
import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/foundation/icons/lucide_icons.dart';
import '../ui/dashcn/theme/theme.dart';
import '../widgets/announcement.dart';
import '../widgets/copy_button.dart';
import '../widgets/docs_tokens.dart';
import 'charts_family_page.dart';

/// Outer padding + max width of the charts section (mirrors Blocks/Flows).
const double kChartsMaxWidth = 1400;

/// `/charts` — the charts hub.
class ChartsHubPage extends StatelessWidget {
  /// Creates the hub page.
  const ChartsHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _ChartsHero(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 64),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: kChartsMaxWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    for (final ChartFamily family
                        in kChartFamilies) ...<Widget>[
                      ChartFamilyCard(
                        key: ValueKey<String>('chart-family-${family.id}'),
                        family: family,
                      ),
                      const Gap(24),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartsHero extends StatelessWidget {
  const _ChartsHero();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double width = MediaQuery.sizeOf(context).width;
    final bool wide = width >= 1024;
    final int charts = kChartFamilies.fold<int>(
      0,
      (int sum, ChartFamily family) => sum + family.examples.length,
    );
    return Padding(
      padding: EdgeInsets.fromLTRB(24, wide ? 64 : 32, 24, 32),
      child: Column(
        children: <Widget>[
          Announcement(
            label: '$charts charts ready to install',
            onPressed: () =>
                DocsRouterScope.of(context).go(context, '/docs/components'),
          ),
          Gap(wide ? theme.spacing.lg : theme.spacing.sm),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 896),
            child: Text(
              'Charts',
              textAlign: TextAlign.center,
              style: docsText(
                context,
                size: wide ? 40 : 30,
                weight: FontWeight.w600,
                height: 1.15,
                letterSpacing: wide ? -1 : 0,
                color: theme.colors.foreground,
              ),
            ),
          ),
          Gap(theme.spacing.md),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              'Line, area, bar, donut and scatter charts painted with '
              'CustomPaint. Pick a family to see every example with its code.',
              textAlign: TextAlign.center,
              style: docsText(
                context,
                size: width >= 640 ? 17 : 15,
                height: 1.6,
              ),
            ),
          ),
          const Gap(20),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: theme.spacing.sm,
            runSpacing: theme.spacing.sm,
            children: <Widget>[
              Button(
                variant: ButtonVariant.primary,
                size: ButtonSize.md,
                onPressed: () =>
                    DocsRouterScope.of(context).go(context, '/charts/line'),
                child: const Text('View Line charts'),
              ),
              Button(
                variant: ButtonVariant.secondary,
                size: ButtonSize.md,
                leading: const Icon(LucideIcons.terminal, size: 16),
                onPressed: () =>
                    DocsRouterScope.of(context).go(context, '/docs/cli'),
                child: const Text('CLI reference'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// One family card: count badge, install copy, title, description and the
/// link to the family page.
class ChartFamilyCard extends StatelessWidget {
  /// Creates the card for [family].
  const ChartFamilyCard({super.key, required this.family});

  /// The chart family to render.
  final ChartFamily family;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String count = family.examples.length == 1
        ? '1 chart'
        : '${family.examples.length} charts';
    return DecoratedBox(
      position: DecorationPosition.foreground,
      decoration: BoxDecoration(
        borderRadius: theme.borderRadiusXl,
        border: Border.all(color: theme.colors.border),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colors.background,
          borderRadius: theme.borderRadiusXl,
        ),
        child: ClipRRect(
          borderRadius: theme.borderRadiusXl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Wrap(
                      spacing: theme.spacing.sm,
                      runSpacing: theme.spacing.sm,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        Badge(
                          variant: BadgeVariant.secondary,
                          child: Text(count),
                        ),
                        const CopyButton(
                          text: 'dashcn add chart',
                          showLabel: true,
                        ),
                      ],
                    ),
                    const Gap(12),
                    Text(
                      family.title,
                      style: docsText(
                        context,
                        size: 16,
                        weight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      family.description,
                      style: docsText(
                        context,
                        size: 13,
                        height: 1.4,
                        color: theme.colors.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Wrap(
                  alignment: WrapAlignment.end,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    Button(
                      variant: ButtonVariant.outline,
                      size: ButtonSize.sm,
                      leading: const Icon(LucideIcons.externalLink, size: 14),
                      onPressed: () => DocsRouterScope.of(
                        context,
                      ).go(context, '/charts/${family.id}'),
                      child: Text('Open ${family.title}'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

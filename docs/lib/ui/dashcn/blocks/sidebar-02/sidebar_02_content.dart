// The `sidebar-02` block, part 2: the sample content area. Imported by
// `sidebar_02.dart`; a block never imports another block.

import 'package:flutter/widgets.dart';

import '../../components/avatar/avatar.dart';
import '../../components/badge/badge.dart';
import '../../components/button/button.dart';
import '../../components/card/card.dart';
import '../../components/divider/divider.dart';
import '../../components/progress/progress.dart';
import '../../foundation/gap.dart';
import '../../theme/theme.dart';
import '../../primitives/localizations/localizations.dart';
import '../../foundation/component_preview.dart';

/// The sample content area: stats, usage, files and activity.
class Sidebar02Content extends StatelessWidget {
  /// Creates the content area.
  const Sidebar02Content({super.key, required this.selected});

  /// Index of the selected navigation link; drives the heading.
  final int selected;

  @override
  Widget build(BuildContext context) {
    final strings = ComponentLocalizations.of(context);
    final ThemeData theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(_sidebar02Title(selected), style: theme.typography.h2),
        Gap(theme.spacing.xs),
        Text(
          docsSample(context, 'Experiment with the API before you ship it.'),
          style: theme.typography.textMuted.copyWith(
            color: theme.colors.mutedForeground,
          ),
        ),
        Gap(theme.spacing.lg),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            Badge(
              variant: BadgeVariant.secondary,
              child: Text(docsSample(context, 'Stable')),
            ),
            Badge(
              variant: BadgeVariant.outline,
              child: Text(docsSample(context, 'Beta channel')),
            ),
            Badge(
              variant: BadgeVariant.primary,
              child: Text(docsSample(context, 'New: batches')),
            ),
          ],
        ),
        Gap(theme.spacing.lg),
        const _Sidebar02Stats(),
        Gap(theme.spacing.lg),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                strings.blockUsageThisMonth,
                style: theme.typography.textLarge,
              ),
              Gap(theme.spacing.lg),
              const Progress(value: 0.68),
              Gap(theme.spacing.sm),
              Text(
                docsSample(context, '2,040,000 of 3,000,000 tokens'),
                style: theme.typography.textSmall.copyWith(
                  color: theme.colors.mutedForeground,
                ),
              ),
              Gap(theme.spacing.lg),
              const Divider(),
              Gap(theme.spacing.lg),
              Button(onPressed: () {}, child: Text(strings.blockUpgradePlan)),
            ],
          ),
        ),
        Gap(theme.spacing.lg),
        const _Sidebar02Files(),
        Gap(theme.spacing.lg),
        const _Sidebar02Activity(),
      ],
    );
  }
}

String _sidebar02Title(int selected) => switch (selected) {
  1 => docsSample(null, 'Models'),
  2 => docsSample(null, 'Documentation'),
  3 => docsSample(null, 'Design system'),
  4 => docsSample(null, 'Marketing site'),
  _ => docsSample(null, 'Playground'),
};

class _Sidebar02Stats extends StatelessWidget {
  const _Sidebar02Stats();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final int columns = constraints.maxWidth >= 560 ? 3 : 1;
        final double gap = theme.spacing.lg;
        final double cardWidth = columns == 1
            ? constraints.maxWidth
            : (constraints.maxWidth - gap * (columns - 1)) / columns;
        List<(String, String)> stats = <(String, String)>[
          (docsSample(context, 'Projects'), '12'),
          (docsSample(context, 'Members'), '8'),
          (docsSample(context, 'Deploys'), '1,204'),
        ];
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: <Widget>[
            for (final (String, String) stat in stats)
              SizedBox(
                width: cardWidth,
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        stat.$1,
                        style: theme.typography.textSmall.copyWith(
                          color: theme.colors.mutedForeground,
                        ),
                      ),
                      Gap(theme.spacing.sm),
                      Text(stat.$2, style: theme.typography.h3),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _Sidebar02Files extends StatelessWidget {
  const _Sidebar02Files();

  @override
  Widget build(BuildContext context) {
    final strings = ComponentLocalizations.of(context);
    final ThemeData theme = Theme.of(context);
    List<(String, String, String)> files = <(String, String, String)>[
      (
        'SM',
        'Summer lookbook.pdf',
        docsSample(context, '2.4 MB · edited 3m ago'),
      ),
      ('BR', 'Brand tokens.json', docsSample(context, '18 KB · edited 1h ago')),
      ('RD', 'Roadmap Q4.md', docsSample(context, '44 KB · edited yesterday')),
    ];
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(strings.blockRecentFiles, style: theme.typography.textLarge),
          Gap(theme.spacing.lg),
          for (final (String, String, String) file in files) ...<Widget>[
            Row(
              children: <Widget>[
                Avatar(initials: file.$1, size: 32),
                Gap(theme.spacing.md),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(file.$2, style: theme.typography.textSmall),
                      Gap(theme.spacing.xs),
                      Text(
                        file.$3,
                        style: theme.typography.xSmall.copyWith(
                          color: theme.colors.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (file != files.last) Gap(theme.spacing.md),
          ],
        ],
      ),
    );
  }
}

class _Sidebar02Activity extends StatelessWidget {
  const _Sidebar02Activity();

  @override
  Widget build(BuildContext context) {
    final strings = ComponentLocalizations.of(context);
    final ThemeData theme = Theme.of(context);
    List<(String, String)> events = <(String, String)>[
      (
        docsSample(context, 'Ada deployed Marketing site to production'),
        docsSample(context, '12m ago'),
      ),
      (
        docsSample(context, 'Bjarne invited Sofia to Design system'),
        docsSample(context, '1h ago'),
      ),
      (
        docsSample(context, 'Nightly backup completed'),
        docsSample(context, '6h ago'),
      ),
    ];
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(strings.blockActivity, style: theme.typography.textLarge),
          Gap(theme.spacing.lg),
          for (final (String, String) event in events) ...<Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(event.$1, style: theme.typography.textSmall),
                ),
                Gap(theme.spacing.md),
                Text(
                  event.$2,
                  style: theme.typography.xSmall.copyWith(
                    color: theme.colors.mutedForeground,
                  ),
                ),
              ],
            ),
            if (event != events.last) Gap(theme.spacing.md),
          ],
        ],
      ),
    );
  }
}

// The Starters pages (P9-Z2), loaded as one deferred library so the
// starter catalog stays out of the landing route's chunk.
//
// `/docs/starters` — the index: hero and one [StarterCard] per starter.
// `/docs/starters/<id>` — what you get (routes table with flow/block links),
// the create command in Package | Own-the-code tabs, the theme-file split,
// the rendered-template file tree and next steps. Detail sections live in
// `widgets/starter_sections.dart` for the ~400-line rule.

import 'package:flutter/widgets.dart';

import '../generated/docs_starters.dart';
import '../routing/docs_nav.dart';
import '../routing/docs_router.dart';
import '../ui/dashcn/components/badge/badge.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/theme/theme.dart';
import '../widgets/announcement.dart';
import '../widgets/copy_button.dart';
import '../widgets/docs_tokens.dart';
import '../widgets/heading_anchor.dart';
import '../widgets/starter_card.dart';
import '../widgets/starter_install_block.dart';
import '../widgets/starter_sections.dart';

/// Outer padding + max width of the starters section (mirrors Flows).
const double kStartersMaxWidth = 1400;

/// `/docs/starters` — the starters index: hero plus a responsive grid of
/// compact cards (3 columns at ≥1100 px, 2 at ≥700 px, 1 below).
class StartersIndexPage extends StatelessWidget {
  /// Creates the index page.
  const StartersIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _StartersHero(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 64),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: kStartersMaxWidth),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final int columns = constraints.maxWidth >= 1100
                        ? 3
                        : constraints.maxWidth >= 700
                        ? 2
                        : 1;
                    if (columns == 1) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          for (final DocsStarter starter
                              in kStarters) ...<Widget>[
                            StarterCard(
                              key: ValueKey<String>(starter.id),
                              starter: starter,
                            ),
                            const Gap(24),
                          ],
                        ],
                      );
                    }
                    const double spacing = 24;
                    final double width =
                        (constraints.maxWidth - (columns - 1) * spacing) /
                        columns;
                    return Wrap(
                      spacing: spacing,
                      runSpacing: spacing,
                      children: <Widget>[
                        for (final DocsStarter starter in kStarters)
                          SizedBox(
                            width: width,
                            child: StarterCard(
                              key: ValueKey<String>(starter.id),
                              starter: starter,
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StartersHero extends StatelessWidget {
  const _StartersHero();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double width = MediaQuery.sizeOf(context).width;
    final bool wide = width >= 1024;
    return Padding(
      padding: EdgeInsets.fromLTRB(24, wide ? 64 : 32, 24, 32),
      child: Column(
        children: <Widget>[
          Announcement(
            label: '${kStarters.length} starters ready to create',
            onPressed: () =>
                DocsRouterScope.of(context).go(context, '/docs/components'),
          ),
          Gap(wide ? 16 : 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 896),
            child: Text(
              'Start from a template',
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
          const Gap(12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Text(
              'One command scaffolds a runnable app from flows, blocks and '
              'a theme. Pick a starter below, then own every line.',
              textAlign: TextAlign.center,
              style: docsText(
                context,
                size: width >= 640 ? 17 : 15,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// `/docs/starters/<id>` — one starter: routes, install tabs, files, next.
class StarterPage extends StatelessWidget {
  /// Creates the page for [starterId].
  const StarterPage({super.key, required this.starterId});

  /// The registry starter id (`saas`).
  final String starterId;

  @override
  Widget build(BuildContext context) {
    final DocsStarter? starter = kStarters
        .where((DocsStarter s) => s.id == starterId)
        .firstOrNull;
    if (starter == null) {
      return MissingStarter(starterId: starterId);
    }
    final ({String? previousId, String? nextId}) neighbors = starterNeighbors(
      starter.id,
    );
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 64),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: kStartersMaxWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _StarterPageHeader(starter: starter),
                const Gap(24),
                const HeadingAnchor(id: 'routes', title: 'What you get'),
                const Gap(12),
                StarterRoutesTable(starter: starter),
                const Gap(32),
                StarterInstallBlock(starter: starter),
                const Gap(32),
                const HeadingAnchor(id: 'files', title: 'Generated files'),
                const Gap(12),
                StarterFileTree(starter: starter),
                const Gap(32),
                const HeadingAnchor(id: 'next', title: 'Next steps'),
                const Gap(12),
                const StarterNextSteps(),
                const Gap(32),
                StarterPager(
                  previousId: neighbors.previousId,
                  nextId: neighbors.nextId,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StarterPageHeader extends StatelessWidget {
  const _StarterPageHeader({required this.starter});

  final DocsStarter starter;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Badge(
              variant: BadgeVariant.secondary,
              child: Text('${starter.flows.length} flows'),
            ),
            Badge(
              variant: BadgeVariant.outline,
              child: Text('theme ${starter.themePreset}'),
            ),
            CopyButton(text: starter.install, showLabel: true),
          ],
        ),
        const Gap(12),
        Text(
          starter.name,
          style: docsText(
            context,
            size: 30,
            weight: FontWeight.w600,
            height: 36 / 30,
            letterSpacing: -0.75,
          ),
        ),
        const Gap(8),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Text(
            starter.description,
            style: docsText(
              context,
              size: 16,
              height: 1.5,
              color: theme.colors.mutedForeground,
            ),
          ),
        ),
        const Gap(8),
        Text(
          'Platforms: ${starter.platforms.join(', ')}',
          style: docsText(
            context,
            size: 13,
            height: 1.5,
            color: theme.colors.mutedForeground,
          ),
        ),
      ],
    );
  }
}

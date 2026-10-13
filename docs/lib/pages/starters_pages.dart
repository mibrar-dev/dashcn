// The Starters pages (P9-Z2), loaded as one deferred library so the
// starter catalog stays out of the landing route's chunk.
//
// `/docs/starters` — the index: hero and one [StarterCard] per starter.
// `/docs/starters/<id>` — what you get (routes table with flow/block links),
// the create command in Package | Own-the-code tabs, the theme-file split,
// the rendered-template file tree and next steps.

import 'package:flutter/widgets.dart';

import '../generated/docs_starters.dart';
import '../routing/docs_nav.dart';
import '../routing/docs_router.dart';
import '../ui/dashcn/components/badge/badge.dart';
import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/foundation/icons/lucide_icons.dart';
import '../ui/dashcn/theme/theme.dart';
import '../web_bridge.dart';
import '../widgets/announcement.dart';
import '../widgets/copy_button.dart';
import '../widgets/docs_footer.dart' show kDocsRepoUrl;
import '../widgets/docs_tokens.dart';
import '../widgets/heading_anchor.dart';
import '../widgets/starter_card.dart';
import '../widgets/starter_install_block.dart';
import '../widgets/typeset.dart';

/// Outer padding + max width of the starters section (mirrors Flows).
const double kStartersMaxWidth = 1400;

/// `/docs/starters` — the starters index.
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    for (final DocsStarter starter in kStarters) ...<Widget>[
                      StarterCard(
                        key: ValueKey<String>(starter.id),
                        starter: starter,
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
      return _MissingStarter(starterId: starterId);
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
                _RoutesTable(starter: starter),
                const Gap(32),
                StarterInstallBlock(starter: starter),
                const Gap(32),
                const HeadingAnchor(id: 'files', title: 'Generated files'),
                const Gap(12),
                _FileTree(starter: starter),
                const Gap(32),
                const HeadingAnchor(id: 'next', title: 'Next steps'),
                const Gap(12),
                const _NextSteps(),
                const Gap(32),
                _StarterPager(
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

/// The starter's routes: app path + title + backing flow/block link.
class _RoutesTable extends StatelessWidget {
  const _RoutesTable({required this.starter});

  final DocsStarter starter;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        for (final DocsStarterRoute route in starter.routes)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 110,
                  child: Text(
                    route.path,
                    style: theme.typography.mono.copyWith(fontSize: 13),
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        route.title,
                        style: docsText(
                          context,
                          size: 14,
                          weight: FontWeight.w500,
                        ),
                      ),
                      const Gap(2),
                      _RouteRef(route: route),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _RouteRef extends StatelessWidget {
  const _RouteRef({required this.route});

  final DocsStarterRoute route;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle style = docsText(
      context,
      size: 13,
      color: theme.colors.mutedForeground,
    );
    if (route.kind == 'flow') {
      return TypesetLink(
        label: '${route.ref} flow',
        onPressed: () =>
            DocsRouterScope.of(context).go(context, '/docs/flows/${route.ref}'),
      );
    }
    if (route.kind == 'block') {
      return TypesetLink(
        label: '${route.ref} block',
        onPressed: () =>
            DocsRouterScope.of(context).go(context, '/blocks/${route.ref}'),
      );
    }
    return Text('Starter page (${route.ref})', style: style);
  }
}

/// The rendered-template file list (targets) with a GitHub source link.
class _FileTree extends StatelessWidget {
  const _FileTree({required this.starter});

  final DocsStarter starter;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (final DocsStarterFile file in starter.files)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              file.target,
              style: theme.typography.mono.copyWith(fontSize: 13),
            ),
          ),
        const Gap(8),
        TypesetLink(
          label: 'Browse template sources on GitHub',
          onPressed: () => webOpenUrl(
            '$kDocsRepoUrl/blob/main/dashcn/lib/src/starters/'
            '${starter.id}/templates',
          ),
        ),
      ],
    );
  }
}

class _NextSteps extends StatelessWidget {
  const _NextSteps();

  @override
  Widget build(BuildContext context) {
    return const TypesetBullets(
      items: <List<InlineSpan>>[
        <InlineSpan>[
          TextSpan(
            text:
                'Run it: cd my_app, then flutter analyze, flutter test, '
                'flutter run.',
          ),
        ],
        <InlineSpan>[
          TextSpan(
            text:
                'Own it: replace the in-memory repository in '
                'lib/data/repository.dart with your backend.',
          ),
        ],
      ],
    );
  }
}

/// Previous/next starter pager in [kStarters] order.
class _StarterPager extends StatelessWidget {
  const _StarterPager({required this.previousId, required this.nextId});

  final String? previousId;
  final String? nextId;

  @override
  Widget build(BuildContext context) {
    final Widget previous = previousId == null
        ? const SizedBox.shrink()
        : Button(
            variant: ButtonVariant.secondary,
            size: ButtonSize.sm,
            leading: const Icon(LucideIcons.arrowLeft, size: 16),
            onPressed: () => DocsRouterScope.of(
              context,
            ).go(context, '/docs/starters/$previousId'),
            child: Text(_labelOf(previousId!), overflow: TextOverflow.ellipsis),
          );
    final Widget next = nextId == null
        ? const SizedBox.shrink()
        : Button(
            variant: ButtonVariant.secondary,
            size: ButtonSize.sm,
            trailing: const Icon(LucideIcons.arrowRight, size: 16),
            onPressed: () => DocsRouterScope.of(
              context,
            ).go(context, '/docs/starters/$nextId'),
            child: Text(_labelOf(nextId!), overflow: TextOverflow.ellipsis),
          );
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth < 560) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Align(alignment: Alignment.centerLeft, child: previous),
              const Gap(8),
              Align(alignment: Alignment.centerRight, child: next),
            ],
          );
        }
        return Row(children: <Widget>[previous, const Spacer(), next]);
      },
    );
  }

  String _labelOf(String id) =>
      kStarters.firstWhere((DocsStarter s) => s.id == id).name;
}

class _MissingStarter extends StatelessWidget {
  const _MissingStarter({required this.starterId});

  final String starterId;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'No starter named `$starterId`.',
              style: docsText(context, size: 16, weight: FontWeight.w600),
            ),
            const Gap(12),
            Button(
              variant: ButtonVariant.secondary,
              size: ButtonSize.sm,
              onPressed: () =>
                  DocsRouterScope.of(context).go(context, '/docs/starters'),
              child: const Text('Back to Starters'),
            ),
          ],
        ),
      ),
    );
  }
}

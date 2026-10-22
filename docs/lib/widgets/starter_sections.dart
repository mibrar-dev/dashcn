// Detail sections for the Starters pages (P9-Z2), split from
// `pages/starters_pages.dart` for the ~400-line rule.
//
// Routes table (app path + backing flow/block links), the rendered-template
// file tree (targets only, with a GitHub source link), next steps, the
// previous/next pager and the unknown-id page.

import 'package:flutter/widgets.dart';

import '../routing/docs_router.dart';
import '../state/docs_strings.dart';

import '../generated/docs_starters.dart';

import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/foundation/icons/lucide_icons.dart';
import '../ui/dashcn/theme/theme.dart';
import '../web_bridge.dart';
import 'docs_footer.dart' show kDocsRepoUrl;
import 'docs_tokens.dart';
import 'typeset.dart';

/// The starter's routes: app path + title + backing flow/block link.
class StarterRoutesTable extends StatelessWidget {
  /// Creates the routes table for [starter].
  const StarterRoutesTable({super.key, required this.starter});

  /// The registry starter.
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
class StarterFileTree extends StatelessWidget {
  /// Creates the file tree for [starter].
  const StarterFileTree({super.key, required this.starter});

  /// The registry starter.
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

/// Next steps after `dashcn create`: run, then own the repository.
class StarterNextSteps extends StatelessWidget {
  /// Creates the next-steps list.
  const StarterNextSteps({super.key});

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
class StarterPager extends StatelessWidget {
  /// Creates the pager.
  const StarterPager({
    super.key,
    required this.previousId,
    required this.nextId,
  });

  /// Previous starter id, or null.
  final String? previousId;

  /// Next starter id, or null.
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

/// Unknown starter id page.
class MissingStarter extends StatelessWidget {
  /// Creates the missing page for [starterId].
  const MissingStarter({super.key, required this.starterId});

  /// The unknown id from the URL.
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
              child: Text(
                docsChrome(
                  DocsRouterScope.maybeOf(context)?.state.locale ??
                      const Locale('en'),
                  'backStarters',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

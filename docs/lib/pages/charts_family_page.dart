// `/charts/<family>` — one chart family on the gallery shell: the same hero
// and family nav as the hub, with just that family's section below.
//
// Full-width like Blocks/Themes: no docs sidebar. Live previews and code come
// from the existing `chart` preview and example-source data.

import 'package:flutter/widgets.dart';

import '../routing/docs_router.dart';
import '../state/docs_strings.dart';

import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/theme/theme.dart';
import '../widgets/docs_tokens.dart';
import 'charts_data.dart';
import 'charts_gallery.dart';

/// `/charts/<family>` — the gallery scoped to one family.
class ChartFamilyPage extends StatelessWidget {
  /// Creates the page for [familyId].
  const ChartFamilyPage({super.key, required this.familyId});

  /// The chart family id (`area`).
  final String familyId;

  @override
  Widget build(BuildContext context) {
    final bool known = kChartFamilies.any(
      (ChartFamily family) => family.id == familyId,
    );
    if (!known) {
      return _MissingFamily(familyId: familyId);
    }
    return ChartsGallery(familyId: familyId);
  }
}

class _MissingFamily extends StatelessWidget {
  const _MissingFamily({required this.familyId});

  final String familyId;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'No chart family named `$familyId`.',
              style: docsText(context, size: 16, weight: FontWeight.w600),
            ),
            Gap(Theme.of(context).spacing.md),
            Button(
              variant: ButtonVariant.secondary,
              size: ButtonSize.sm,
              onPressed: () =>
                  DocsRouterScope.of(context).go(context, '/charts'),
              child: Text(
                docsChrome(
                  DocsRouterScope.maybeOf(context)?.state.locale ??
                      const Locale('en'),
                  'backCharts',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

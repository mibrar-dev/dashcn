// The chart family pages: one page per chart family (area, bar, line, pie,
// radar, radial, tooltip, scatter), each with a title, a description, a
// single Examples section and one Preview | Code card per example.
//
// The cards reuse the `chart` component's named previews through
// [ExamplePreviewCard] (live preview, Code tab, copy button), so the pages
// never duplicate chart code.

import 'package:flutter/widgets.dart';

import '../generated/docs_example_sources.dart';
import '../generated/docs_previews.dart';
import '../routing/docs_nav.dart';
import '../routing/docs_router.dart';
import '../ui/dashcn/components/button/button.dart';
import '../ui/dashcn/foundation/gap.dart';
import '../ui/dashcn/theme/theme.dart';
import '../widgets/docs_article.dart';
import '../widgets/docs_shell.dart';
import '../widgets/docs_tokens.dart';
import '../widgets/example_preview_card.dart';
import '../widgets/heading_anchor.dart';

/// One chart family: its page id, title, description and the named `chart`
/// previews it shows, in display order.
class ChartFamily {
  /// Creates a family entry.
  const ChartFamily({
    required this.id,
    required this.title,
    required this.description,
    required this.examples,
  });

  /// Page id (`area`) and `/charts/<id>` segment.
  final String id;

  /// Page title.
  final String title;

  /// One-line description under the title.
  final String description;

  /// Names from the `chart` preview list, in display order.
  final List<String> examples;
}

/// The chart families, in hub-card order.
const List<ChartFamily> kChartFamilies = <ChartFamily>[
  ChartFamily(
    id: 'area',
    title: 'Area',
    description:
        'Filled area charts for part-to-whole trends over time, with markers.',
    examples: <String>[
      'Area Chart - Interactive',
      'Area Chart',
      'Area Chart - Linear',
      'Area Chart - Step',
      'Area Chart - Legend',
      'Area Chart - Stacked',
      'Area Chart - Stacked Expanded',
      'Area Chart - Icons',
      'Area Chart - Gradient',
      'Area Chart - Axes',
    ],
  ),
  ChartFamily(
    id: 'bar',
    title: 'Bar',
    description: 'Grouped and stacked bars for comparing values across groups.',
    examples: <String>[
      'Bar Chart - Interactive',
      'Bar Chart',
      'Bar Chart - Horizontal',
      'Bar Chart - Multiple',
      'Bar Chart - Stacked + Legend',
      'Bar Chart - Label',
      'Bar Chart - Custom Label',
      'Bar Chart - Mixed',
      'Bar Chart - Active',
      'Bar Chart - Negative',
    ],
  ),
  ChartFamily(
    id: 'line',
    title: 'Line',
    description:
        'Line charts for trends, from the default view to custom dots and '
        'labels.',
    examples: <String>[
      'Line Chart - Interactive',
      'Line Chart',
      'Line Chart - Linear',
      'Line Chart - Step',
      'Line Chart - Multiple',
      'Line Chart - Dots',
      'Line Chart - Custom Dots',
      'Line Chart - Dots Colors',
      'Line Chart - Label',
      'Line Chart - Custom Label',
    ],
  ),
  ChartFamily(
    id: 'pie',
    title: 'Pie',
    description: 'Donut-style pie charts for share-of-total breakdowns.',
    examples: <String>[
      'Pie Chart',
      'Pie Chart - Separator None',
      'Pie Chart - Label',
      'Pie Chart - Custom Label',
      'Pie Chart - Label List',
      'Pie Chart - Legend',
      'Pie Chart - Donut',
      'Pie Chart - Donut Active',
      'Pie Chart - Donut with Text',
      'Pie Chart - Stacked',
      'Pie Chart - Interactive',
    ],
  ),
  ChartFamily(
    id: 'radar',
    title: 'Radar',
    description:
        'Polar web charts for comparing multivariate profiles across axes.',
    examples: <String>[
      'Radar Chart',
      'Radar Chart - Dots',
      'Radar Chart - Lines Only',
      'Radar Chart - Custom Label',
      'Radar Chart - Grid Custom',
      'Radar Chart - Grid None',
      'Radar Chart - Grid Circle',
      'Radar Chart - Grid Circle - No lines',
      'Radar Chart - Grid Circle Filled',
      'Radar Chart - Grid Filled',
      'Radar Chart - Multiple',
      'Radar Chart - Legend',
    ],
  ),
  ChartFamily(
    id: 'radial',
    title: 'Radial',
    description:
        'Radial bar charts for single-measure progress and stacked totals.',
    examples: <String>[
      'Radial Chart',
      'Radial Chart - Label',
      'Radial Chart - Grid',
      'Radial Chart - Text',
      'Radial Chart - Shape',
      'Radial Chart - Stacked',
    ],
  ),
  ChartFamily(
    id: 'tooltip',
    title: 'Tooltip',
    description:
        'Tooltip content styles: indicators, labels, formatters and totals.',
    examples: <String>[
      'Tooltip - Default',
      'Tooltip - Line Indicator',
      'Tooltip - No Indicator',
      'Tooltip - Custom label',
      'Tooltip - Label Formatter',
      'Tooltip - No Label',
      'Tooltip - Formatter',
      'Tooltip - Icons',
      'Tooltip - Advanced',
    ],
  ),
  ChartFamily(
    id: 'scatter',
    title: 'Scatter',
    description: 'Scatter plots for individual measurements and outliers.',
    examples: <String>['Scatter'],
  ),
];

/// Title of the family with [id].
String chartFamilyTitle(String id) =>
    kChartFamilies.firstWhere((ChartFamily family) => family.id == id).title;

/// `/charts/<family>` — one family page.
class ChartFamilyPage extends StatelessWidget {
  /// Creates the page for [familyId].
  const ChartFamilyPage({super.key, required this.familyId});

  /// The chart family id (`area`).
  final String familyId;

  @override
  Widget build(BuildContext context) {
    final ChartFamily? family = kChartFamilies
        .where((ChartFamily entry) => entry.id == familyId)
        .firstOrNull;
    if (family == null) {
      return _MissingFamily(familyId: familyId);
    }
    final List<String> names = kComponentPreviews['chart'] ?? const <String>[];
    final List<DocsExampleSource> sources =
        kExampleSources['chart'] ?? const <DocsExampleSource>[];
    final ({String? previousId, String? nextId}) neighbors = chartNeighbors(
      familyId,
    );
    DocsNavLink? linkOf(String? id) => id == null
        ? null
        : DocsNavLink(label: chartFamilyTitle(id), location: '/charts/$id');
    return DocsLayout(
      child: DocsArticle(
        title: family.title,
        description: family.description,
        previous: neighbors.previousId != null
            ? linkOf(neighbors.previousId)
            : const DocsNavLink(label: 'Charts', location: '/charts'),
        next: linkOf(neighbors.nextId),
        children: <Widget>[
          const HeadingAnchor(id: 'examples', title: 'Examples'),
          for (final String name in family.examples) ...<Widget>[
            HeadingAnchor(id: _anchorId(name), title: name, level: 3),
            ExamplePreviewCard(
              componentId: 'chart',
              exampleIndex: names.indexOf(name),
              source: sources[names.indexOf(name)],
              isMain: name == family.examples.first,
            ),
          ],
        ],
      ),
    );
  }
}

/// URL-safe anchor id for an example name.
String _anchorId(String name) {
  final String slug = name
      .toLowerCase()
      .replaceAll(RegExp('[^a-z0-9]+'), '-')
      .replaceAll(RegExp('^-+|-+\$'), '');
  return 'example-${slug.isEmpty ? 'chart' : slug}';
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
              child: const Text('Back to Charts'),
            ),
          ],
        ),
      ),
    );
  }
}

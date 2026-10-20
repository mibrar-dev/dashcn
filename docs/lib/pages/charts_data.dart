// The chart family model shared by the charts hub, the family pages and the
// gallery widgets: one family per `/charts/<family>` route.

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

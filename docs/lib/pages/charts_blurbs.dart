// One-line card descriptions for the charts gallery, keyed by variant
// keyword in match order.
//
// The kit previews carry no per-example description, so the gallery derives
// a short line from the variant suffix (`- Stacked`, `- Donut`, ...); bare
// family names fall back to the generic line.

/// One-line description for the example named [name].
String chartExampleBlurb(String name) {
  final String variant = name.contains(' - ')
      ? name.split(' - ').sublist(1).join(' - ').toLowerCase()
      : '';
  for (final (String, String) entry in _kChartBlurbs) {
    if (variant.contains(entry.$1)) {
      return entry.$2;
    }
  }
  return 'A ready-to-use chart with copy-paste code.';
}

/// Variant keyword (lowercase) to one-line description, first match wins.
const List<(String, String)> _kChartBlurbs = <(String, String)>[
  ('interactive', 'Filter the range and watch every series update.'),
  ('stacked expanded', 'Stacked series normalized to 100 percent.'),
  ('stacked + legend', 'Stacked bars with a legend for each series.'),
  ('stacked', 'Several series stacked in one shape.'),
  ('label list', 'A label list beside every slice.'),
  ('label formatter', 'Custom formatting for the tooltip labels.'),
  ('custom label', 'Custom labels on every point.'),
  ('no label', 'A clean chart without value labels.'),
  ('label', 'Value labels on every point.'),
  ('line indicator', 'A tooltip with a line indicator.'),
  ('no indicator', 'A tooltip without an indicator.'),
  ('formatter', 'Custom value formatting in the tooltip.'),
  ('advanced', 'Fully customized tooltip content.'),
  ('gradient', 'The area fill fades through a gradient.'),
  ('icons', 'An icon marks every entry.'),
  ('axes', 'Custom axis ticks and grid lines.'),
  ('step', 'Step interpolation between points.'),
  ('linear', 'Straight lines between every point.'),
  ('horizontal', 'Bars run horizontally for long labels.'),
  ('multiple', 'Several series side by side.'),
  ('dots colors', 'Dots tinted in each series color.'),
  ('custom dots', 'Custom dot markers on the line.'),
  ('dots', 'A dot marks every data point.'),
  ('lines only', 'Web lines with no fill.'),
  ('mixed', 'Bars and lines in a single chart.'),
  ('active', 'The active shape stands out.'),
  ('negative', 'Values below zero render correctly.'),
  ('separator none', 'Slices meet with no separator.'),
  ('donut with text', 'A donut with centered summary text.'),
  ('donut active', 'A donut with an active slice.'),
  ('donut', 'A pie with a hollow center.'),
  ('legend', 'A legend for every series.'),
  ('grid circle - no lines', 'Circular rings with no web lines.'),
  ('grid circle filled', 'Filled circular grid rings.'),
  ('grid circle', 'Circular grid rings.'),
  ('grid custom', 'A custom-styled grid.'),
  ('grid none', 'No grid lines behind the data.'),
  ('grid filled', 'Filled bands behind the web.'),
  ('grid', 'Grid rings behind the bars.'),
  ('text', 'A centered text summary.'),
  ('shape', 'Custom bar shapes.'),
  ('default', 'The standard tooltip content.'),
];

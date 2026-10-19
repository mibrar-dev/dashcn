// Named examples for the `chart` component (preview contract).
//
// One focused demo per entry; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle. Controllers live inside their example's own
// StatefulWidget so two examples never share one.

import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import '../../foundation/icons/lucide_icons.dart';
import '../../theme/theme.dart';
import 'chart.dart';

/// Interactive line chart with a 90d/30d/7d range filter.
class _LineInteractive extends StatefulWidget {
  const _LineInteractive();

  @override
  State<_LineInteractive> createState() => _LineInteractiveState();
}

class _LineInteractiveState extends State<_LineInteractive> {
  String _range = '90d';

  int get _count => _range == '7d'
      ? 7
      : _range == '30d'
      ? 30
      : 90;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _RangeButtons(
          options: const <String>['90d', '30d', '7d'],
          selected: _range,
          onSelect: (String value) => setState(() => _range = value),
        ),
        const SizedBox(height: 8),
        Chart(
          labels: _AreaInteractiveState.dayLabels.sublist(90 - _count),
          series: <ChartSeries>[
            ChartSeries(
              label: 'Desktop',
              values: _AreaInteractiveState.desktopData.sublist(90 - _count),
            ),
            ChartSeries(
              label: 'Mobile',
              values: _AreaInteractiveState.mobileData.sublist(90 - _count),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _chartLineInteractive(BuildContext context) => const _LineInteractive();

Widget _chartLineDefault(BuildContext context) {
  return const Chart(
    labels: _areaMonths,
    tooltip: ChartTooltipConfig(showLabel: false),
    series: <ChartSeries>[ChartSeries(label: 'Desktop', values: _barDesktop)],
  );
}

Widget _chartLineLinear(BuildContext context) {
  return const Chart(
    lineStyle: ChartLineStyle.linear,
    labels: _areaMonths,
    tooltip: ChartTooltipConfig(showLabel: false),
    series: <ChartSeries>[ChartSeries(label: 'Desktop', values: _barDesktop)],
  );
}

Widget _chartLineStep(BuildContext context) {
  return const Chart(
    lineStyle: ChartLineStyle.step,
    labels: _areaMonths,
    tooltip: ChartTooltipConfig(showLabel: false),
    series: <ChartSeries>[ChartSeries(label: 'Desktop', values: _barDesktop)],
  );
}

Widget _chartLineMultiple(BuildContext context) {
  return const Chart(
    labels: _areaMonths,
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _barDesktop),
      ChartSeries(label: 'Mobile', values: _barMobile),
    ],
  );
}

Widget _chartLineDots(BuildContext context) {
  return const Chart(
    labels: _areaMonths,
    showMarkers: true,
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _barDesktop),
      ChartSeries(label: 'Mobile', values: _barMobile),
    ],
  );
}

Widget _chartLineDotsCustom(BuildContext context) {
  return const Chart(
    labels: _areaMonths,
    showMarkers: true,
    tooltip: ChartTooltipConfig(showLabel: false),
    series: <ChartSeries>[
      ChartSeries(
        label: 'Desktop',
        values: _barDesktop,
        markerShape: ChartMarkerShape.commit,
      ),
    ],
  );
}

Widget _chartLineDotsColors(BuildContext context) {
  return Chart(
    labels: _browserNames,
    showMarkers: true,
    tooltip: const ChartTooltipConfig(
      indicator: ChartTooltipIndicator.line,
      showLabel: false,
    ),
    series: <ChartSeries>[
      ChartSeries(
        label: 'Visitors',
        values: _browserVisitors,
        pointColors: _browserColors(context),
      ),
    ],
  );
}

Widget _chartLineLabel(BuildContext context) {
  return const Chart(
    labels: _areaMonths,
    showMarkers: true,
    showPointLabels: true,
    tooltip: ChartTooltipConfig(indicator: ChartTooltipIndicator.line),
    series: <ChartSeries>[ChartSeries(label: 'Desktop', values: _barDesktop)],
  );
}

Widget _chartLineLabelCustom(BuildContext context) {
  return Chart(
    labels: _browserNames,
    showMarkers: true,
    showPointLabels: true,
    pointLabels: _browserNames,
    tooltip: const ChartTooltipConfig(
      indicator: ChartTooltipIndicator.line,
      showLabel: false,
    ),
    series: <ChartSeries>[
      ChartSeries(label: 'Visitors', values: _browserVisitors),
    ],
  );
}

const List<double> _barDesktop = <double>[186, 305, 237, 73, 209, 214];
const List<double> _barMobile = <double>[80, 200, 120, 190, 130, 140];

const List<String> _browserNames = <String>[
  'Chrome',
  'Safari',
  'Firefox',
  'Edge',
  'Other',
];

const List<double> _browserVisitors = <double>[275, 200, 187, 173, 90];

List<Color> _browserColors(BuildContext context) {
  final List<Color> palette = Theme.of(context).colors.chartColors;
  return <Color>[
    for (var i = 0; i < _browserVisitors.length; i++)
      palette[i % palette.length],
  ];
}

/// Interactive bar chart with a 90d/30d/7d range filter.
class _BarInteractive extends StatefulWidget {
  const _BarInteractive();

  @override
  State<_BarInteractive> createState() => _BarInteractiveState();
}

class _BarInteractiveState extends State<_BarInteractive> {
  String _range = '90d';

  int get _count => _range == '7d'
      ? 7
      : _range == '30d'
      ? 30
      : 90;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _RangeButtons(
          options: const <String>['90d', '30d', '7d'],
          selected: _range,
          onSelect: (String value) => setState(() => _range = value),
        ),
        const SizedBox(height: 8),
        Chart(
          type: ChartType.bar,
          labels: _AreaInteractiveState.dayLabels.sublist(90 - _count),
          series: <ChartSeries>[
            ChartSeries(
              label: 'Desktop',
              values: _AreaInteractiveState.desktopData.sublist(90 - _count),
            ),
            ChartSeries(
              label: 'Mobile',
              values: _AreaInteractiveState.mobileData.sublist(90 - _count),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _chartBarInteractive(BuildContext context) => const _BarInteractive();

Widget _chartBarDefault(BuildContext context) {
  return const Chart(
    type: ChartType.bar,
    labels: _areaMonths,
    series: <ChartSeries>[ChartSeries(label: 'Desktop', values: _barDesktop)],
  );
}

Widget _chartBarHorizontal(BuildContext context) {
  return const Chart(
    type: ChartType.bar,
    barLayout: ChartBarLayout.horizontal,
    labels: _areaMonths,
    series: <ChartSeries>[ChartSeries(label: 'Desktop', values: _barDesktop)],
  );
}

Widget _chartBarMultiple(BuildContext context) {
  return const Chart(
    type: ChartType.bar,
    labels: _areaMonths,
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _barDesktop),
      ChartSeries(label: 'Mobile', values: _barMobile),
    ],
  );
}

Widget _chartBarStacked(BuildContext context) {
  return const Chart(
    type: ChartType.bar,
    barMode: ChartBarMode.stacked,
    labels: _areaMonths,
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _barDesktop),
      ChartSeries(label: 'Mobile', values: _barMobile),
    ],
  );
}

Widget _chartBarLabel(BuildContext context) {
  return const Chart(
    type: ChartType.bar,
    labels: _areaMonths,
    showBarLabels: true,
    series: <ChartSeries>[ChartSeries(label: 'Desktop', values: _barDesktop)],
  );
}

Widget _chartBarLabelCustom(BuildContext context) {
  return const Chart(
    type: ChartType.bar,
    barLayout: ChartBarLayout.horizontal,
    labels: _areaMonths,
    showLabels: false,
    showBarLabels: true,
    showBarCategories: true,
    series: <ChartSeries>[ChartSeries(label: 'Desktop', values: _barDesktop)],
  );
}

Widget _chartBarMixed(BuildContext context) {
  return Chart(
    type: ChartType.bar,
    barLayout: ChartBarLayout.horizontal,
    labels: _browserNames,
    showLegend: false,
    series: <ChartSeries>[
      ChartSeries(
        values: _browserVisitors,
        pointColors: _browserColors(context),
      ),
    ],
  );
}

Widget _chartBarActive(BuildContext context) {
  return Chart(
    type: ChartType.bar,
    labels: _browserNames,
    showLegend: false,
    barRadius: 8,
    initialSelectedIndex: 2,
    tooltip: const ChartTooltipConfig(showLabel: false),
    series: <ChartSeries>[
      ChartSeries(
        // Same order as the reference: firefox (275) is the active index.
        values: const <double>[187, 200, 275, 173, 90],
        pointColors: _browserColors(context),
      ),
    ],
  );
}

Widget _chartBarNegative(BuildContext context) {
  return const Chart(
    type: ChartType.bar,
    labels: _areaMonths,
    series: <ChartSeries>[
      ChartSeries(
        label: 'Desktop',
        values: <double>[186, 305, -120, 73, -90, 214],
      ),
    ],
  );
}

/// Interactive donut chart with a dropdown driving the active slice.
class _PieInteractive extends StatefulWidget {
  const _PieInteractive();

  @override
  State<_PieInteractive> createState() => _PieInteractiveState();
}

class _PieInteractiveState extends State<_PieInteractive> {
  static const List<String> months = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
  ];
  static const List<double> visitors = <double>[186, 305, 237, 173, 209];

  int _active = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Align(
          alignment: Alignment.centerRight,
          child: _PieDropdown(
            options: months,
            selected: months[_active],
            onSelect: (String value) =>
                setState(() => _active = months.indexOf(value)),
          ),
        ),
        const SizedBox(height: 8),
        Chart(
          type: ChartType.donut,
          height: 250,
          labels: months,
          initialSelectedIndex: _active,
          onSelected: (int? index) {
            if (index != null && index != _active) {
              setState(() => _active = index);
            }
          },
          centerLabel: '${visitors[_active].toInt()}',
          centerSublabel: 'Visitors',
          pie: const ChartPieConfig(activeRing: true),
          tooltip: const ChartTooltipConfig(showLabel: false),
          series: <ChartSeries>[
            ChartSeries(values: visitors, pointColors: _browserColors(context)),
          ],
        ),
      ],
    );
  }
}

/// Minimal dropdown trigger with an expanding option list (widgets only).
class _PieDropdown extends StatefulWidget {
  const _PieDropdown({
    required this.options,
    required this.selected,
    required this.onSelect,
  });

  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelect;

  @override
  State<_PieDropdown> createState() => _PieDropdownState();
}

class _PieDropdownState extends State<_PieDropdown> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colors;
    final TextStyle itemStyle = TextStyle(
      fontSize: 12,
      color: colors.foreground,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          onTap: () => setState(() => _open = !_open),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colors.border),
              color: colors.background,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(widget.selected, style: itemStyle),
                const SizedBox(width: 6),
                Icon(
                  LucideIcons.chevronDown,
                  size: 14,
                  color: colors.mutedForeground,
                ),
              ],
            ),
          ),
        ),
        if (_open)
          Container(
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colors.border),
              color: colors.popover,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                for (final String option in widget.options)
                  GestureDetector(
                    onTap: () {
                      widget.onSelect(option);
                      setState(() => _open = false);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      color: option == widget.selected
                          ? colors.accent
                          : const Color(0x00000000),
                      child: Text(
                        option,
                        style: TextStyle(
                          fontSize: 12,
                          color: option == widget.selected
                              ? colors.accentForeground
                              : colors.foreground,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

Widget _chartPieInteractive(BuildContext context) => const _PieInteractive();

Widget _chartPieSimple(BuildContext context) {
  return const Chart(
    type: ChartType.pie,
    height: 250,
    labels: _browserNames,
    series: <ChartSeries>[ChartSeries(values: _browserVisitors)],
  );
}

Widget _chartPieSeparatorNone(BuildContext context) {
  return const Chart(
    type: ChartType.pie,
    height: 250,
    labels: _browserNames,
    pie: ChartPieConfig(showDividers: false),
    series: <ChartSeries>[ChartSeries(values: _browserVisitors)],
  );
}

Widget _chartPieLabel(BuildContext context) {
  return const Chart(
    type: ChartType.pie,
    height: 250,
    labels: _browserNames,
    pie: ChartPieConfig(labels: ChartPieLabels.outside),
    series: <ChartSeries>[ChartSeries(values: _browserVisitors)],
  );
}

Widget _chartPieLabelCustom(BuildContext context) {
  return const Chart(
    type: ChartType.pie,
    height: 250,
    labels: _browserNames,
    pie: ChartPieConfig(labels: ChartPieLabels.outside, labelValues: true),
    series: <ChartSeries>[ChartSeries(values: _browserVisitors)],
  );
}

Widget _chartPieLabelList(BuildContext context) {
  return const Chart(
    type: ChartType.pie,
    height: 250,
    labels: _browserNames,
    pie: ChartPieConfig(labels: ChartPieLabels.inside),
    series: <ChartSeries>[ChartSeries(values: _browserVisitors)],
  );
}

Widget _chartPieLegend(BuildContext context) {
  return const Chart(
    type: ChartType.pie,
    height: 250,
    labels: _browserNames,
    series: <ChartSeries>[
      ChartSeries(label: 'Browsers', values: _browserVisitors),
    ],
  );
}

Widget _chartPieDonut(BuildContext context) {
  return const Chart(
    type: ChartType.donut,
    height: 250,
    labels: _browserNames,
    series: <ChartSeries>[ChartSeries(values: _browserVisitors)],
  );
}

Widget _chartPieDonutActive(BuildContext context) {
  return const Chart(
    type: ChartType.donut,
    height: 250,
    labels: _browserNames,
    initialSelectedIndex: 1,
    series: <ChartSeries>[ChartSeries(values: _browserVisitors)],
  );
}

Widget _chartPieDonutText(BuildContext context) {
  return const Chart(
    type: ChartType.donut,
    height: 250,
    labels: _browserNames,
    centerLabel: '925',
    centerSublabel: 'Visitors',
    series: <ChartSeries>[ChartSeries(values: _browserVisitors)],
  );
}

Widget _chartPieStacked(BuildContext context) {
  return const Chart(
    type: ChartType.donut,
    height: 250,
    labels: <String>['January', 'February', 'March', 'April', 'May'],
    showLegend: false,
    pie: ChartPieConfig(stacked: true),
    tooltip: ChartTooltipConfig(indicator: ChartTooltipIndicator.line),
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: <double>[186, 305, 237, 173, 209]),
      ChartSeries(label: 'Mobile', values: <double>[80, 200, 120, 190, 130]),
    ],
  );
}

Widget _chartScatter(BuildContext context) {
  return const Chart(
    type: ChartType.scatter,
    series: <ChartSeries>[
      ChartSeries(label: 'Latency', values: <double>[2, 5, 3, 8, 6, 9, 4]),
    ],
  );
}

Widget _chartSparkline(BuildContext context) {
  return const SizedBox(
    width: 160,
    child: Chart(
      type: ChartType.sparkline,
      data: <double>[1, 3, 2, 5, 4, 6],
      height: 48,
    ),
  );
}

/// Live streaming demo: appends a point every 800 ms into a 40-point window.
class _ChartStreaming extends StatefulWidget {
  const _ChartStreaming();

  @override
  State<_ChartStreaming> createState() => _ChartStreamingState();
}

class _ChartStreamingState extends State<_ChartStreaming> {
  late final ChartController _controller;
  Timer? _timer;
  double _t = 6;

  @override
  void initState() {
    super.initState();
    _controller = ChartController(
      maxPoints: 40,
      initial: const <ChartSeries>[
        ChartSeries(label: 'Live', values: <double>[3, 5, 2, 6, 4, 7]),
      ],
    );
    _timer = Timer.periodic(const Duration(milliseconds: 800), (_) {
      _t += 1;
      final double next = 5 + (_t % 7) - 3 + ((_t * 37) % 5) / 5;
      _controller.append(next);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chart(
      controller: _controller,
      semanticsLabel: 'Streaming line chart, last 40 points',
    );
  }
}

Widget _chartStreaming(BuildContext context) => const _ChartStreaming();

const List<String> _radarMonths = <String>[
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
];

const List<double> _radarDesktop = <double>[186, 305, 237, 73, 209, 214];
const List<double> _radarMobile = <double>[80, 200, 120, 190, 130, 140];

Widget _chartRadarDefault(BuildContext context) {
  return const Chart(
    type: ChartType.radar,
    labels: _radarMonths,
    height: 260,
    series: <ChartSeries>[ChartSeries(values: _radarDesktop)],
  );
}

Widget _chartRadarDots(BuildContext context) {
  return const Chart(
    type: ChartType.radar,
    labels: _radarMonths,
    height: 260,
    showMarkers: true,
    series: <ChartSeries>[ChartSeries(values: _radarDesktop)],
  );
}

Widget _chartRadarLinesOnly(BuildContext context) {
  return const Chart(
    type: ChartType.radar,
    labels: _radarMonths,
    height: 260,
    series: <ChartSeries>[ChartSeries(values: _radarDesktop, fillOpacity: 0)],
  );
}

Widget _chartRadarLabelCustom(BuildContext context) {
  return const Chart(
    type: ChartType.radar,
    labels: _radarMonths,
    height: 260,
    radar: ChartRadarConfig(showValues: true),
    series: <ChartSeries>[
      ChartSeries(values: _radarDesktop),
      ChartSeries(values: _radarMobile),
    ],
  );
}

Widget _chartRadarGridCustom(BuildContext context) {
  return const Chart(
    type: ChartType.radar,
    labels: _radarMonths,
    height: 260,
    radar: ChartRadarConfig(rings: 1, showSpokes: false),
    series: <ChartSeries>[ChartSeries(values: _radarDesktop)],
  );
}

Widget _chartRadarGridNone(BuildContext context) {
  return const Chart(
    type: ChartType.radar,
    labels: _radarMonths,
    height: 260,
    radar: ChartRadarConfig(grid: ChartRadarGrid.none),
    series: <ChartSeries>[ChartSeries(values: _radarDesktop)],
  );
}

Widget _chartRadarGridCircle(BuildContext context) {
  return const Chart(
    type: ChartType.radar,
    labels: _radarMonths,
    height: 260,
    radar: ChartRadarConfig(grid: ChartRadarGrid.circle),
    series: <ChartSeries>[ChartSeries(values: _radarDesktop)],
  );
}

Widget _chartRadarGridCircleNoLines(BuildContext context) {
  return const Chart(
    type: ChartType.radar,
    labels: _radarMonths,
    height: 260,
    radar: ChartRadarConfig(grid: ChartRadarGrid.circle, showSpokes: false),
    series: <ChartSeries>[ChartSeries(values: _radarDesktop)],
  );
}

Widget _chartRadarGridCircleFilled(BuildContext context) {
  return const Chart(
    type: ChartType.radar,
    labels: _radarMonths,
    height: 260,
    radar: ChartRadarConfig(grid: ChartRadarGrid.circle, filled: true),
    series: <ChartSeries>[ChartSeries(values: _radarDesktop)],
  );
}

Widget _chartRadarGridFilled(BuildContext context) {
  return const Chart(
    type: ChartType.radar,
    labels: _radarMonths,
    height: 260,
    radar: ChartRadarConfig(filled: true),
    series: <ChartSeries>[ChartSeries(values: _radarDesktop)],
  );
}

Widget _chartRadarMultiple(BuildContext context) {
  return const Chart(
    type: ChartType.radar,
    labels: _radarMonths,
    height: 260,
    series: <ChartSeries>[
      ChartSeries(values: _radarDesktop),
      ChartSeries(values: _radarMobile),
    ],
  );
}

Widget _chartRadarLegend(BuildContext context) {
  return const Chart(
    type: ChartType.radar,
    labels: _radarMonths,
    height: 260,
    series: <ChartSeries>[
      ChartSeries(label: 'Desktop', values: _radarDesktop),
      ChartSeries(label: 'Mobile', values: _radarMobile),
    ],
  );
}

/// Named docs examples for `chart`; the first entry is the default.
const List<ComponentPreview> chartPreviews = <ComponentPreview>[
  ComponentPreview('Line Chart - Interactive', _chartLineInteractive),
  ComponentPreview('Line Chart', _chartLineDefault),
  ComponentPreview('Line Chart - Linear', _chartLineLinear),
  ComponentPreview('Line Chart - Step', _chartLineStep),
  ComponentPreview('Line Chart - Multiple', _chartLineMultiple),
  ComponentPreview('Line Chart - Dots', _chartLineDots),
  ComponentPreview('Line Chart - Custom Dots', _chartLineDotsCustom),
  ComponentPreview('Line Chart - Dots Colors', _chartLineDotsColors),
  ComponentPreview('Line Chart - Label', _chartLineLabel),
  ComponentPreview('Line Chart - Custom Label', _chartLineLabelCustom),
  ComponentPreview('Area Chart - Interactive', _chartAreaInteractive),
  ComponentPreview('Area Chart', _chartAreaDefault),
  ComponentPreview('Area Chart - Linear', _chartAreaLinear),
  ComponentPreview('Area Chart - Step', _chartAreaStep),
  ComponentPreview('Area Chart - Legend', _chartAreaLegend),
  ComponentPreview('Area Chart - Stacked', _chartAreaStacked),
  ComponentPreview('Area Chart - Stacked Expanded', _chartAreaStackedExpanded),
  ComponentPreview('Area Chart - Icons', _chartAreaIcons),
  ComponentPreview('Area Chart - Gradient', _chartAreaGradient),
  ComponentPreview('Area Chart - Axes', _chartAreaAxes),
  ComponentPreview('Bar Chart - Interactive', _chartBarInteractive),
  ComponentPreview('Bar Chart', _chartBarDefault),
  ComponentPreview('Bar Chart - Horizontal', _chartBarHorizontal),
  ComponentPreview('Bar Chart - Multiple', _chartBarMultiple),
  ComponentPreview('Bar Chart - Stacked + Legend', _chartBarStacked),
  ComponentPreview('Bar Chart - Label', _chartBarLabel),
  ComponentPreview('Bar Chart - Custom Label', _chartBarLabelCustom),
  ComponentPreview('Bar Chart - Mixed', _chartBarMixed),
  ComponentPreview('Bar Chart - Active', _chartBarActive),
  ComponentPreview('Bar Chart - Negative', _chartBarNegative),
  ComponentPreview('Pie Chart', _chartPieSimple),
  ComponentPreview('Pie Chart - Separator None', _chartPieSeparatorNone),
  ComponentPreview('Pie Chart - Label', _chartPieLabel),
  ComponentPreview('Pie Chart - Custom Label', _chartPieLabelCustom),
  ComponentPreview('Pie Chart - Label List', _chartPieLabelList),
  ComponentPreview('Pie Chart - Legend', _chartPieLegend),
  ComponentPreview('Pie Chart - Donut', _chartPieDonut),
  ComponentPreview('Pie Chart - Donut Active', _chartPieDonutActive),
  ComponentPreview('Pie Chart - Donut with Text', _chartPieDonutText),
  ComponentPreview('Pie Chart - Stacked', _chartPieStacked),
  ComponentPreview('Pie Chart - Interactive', _chartPieInteractive),
  ComponentPreview('Scatter', _chartScatter),
  ComponentPreview('Sparkline', _chartSparkline),
  ComponentPreview('Streaming', _chartStreaming),
  ComponentPreview('Radar Chart', _chartRadarDefault),
  ComponentPreview('Radar Chart - Dots', _chartRadarDots),
  ComponentPreview('Radar Chart - Lines Only', _chartRadarLinesOnly),
  ComponentPreview('Radar Chart - Custom Label', _chartRadarLabelCustom),
  ComponentPreview('Radar Chart - Grid Custom', _chartRadarGridCustom),
  ComponentPreview('Radar Chart - Grid None', _chartRadarGridNone),
  ComponentPreview('Radar Chart - Grid Circle', _chartRadarGridCircle),
  ComponentPreview(
    'Radar Chart - Grid Circle - No lines',
    _chartRadarGridCircleNoLines,
  ),
  ComponentPreview(
    'Radar Chart - Grid Circle Filled',
    _chartRadarGridCircleFilled,
  ),
  ComponentPreview('Radar Chart - Grid Filled', _chartRadarGridFilled),
  ComponentPreview('Radar Chart - Multiple', _chartRadarMultiple),
  ComponentPreview('Radar Chart - Legend', _chartRadarLegend),
  ComponentPreview('Radial Chart', _chartRadialSimple),
  ComponentPreview('Radial Chart - Label', _chartRadialLabel),
  ComponentPreview('Radial Chart - Grid', _chartRadialGrid),
  ComponentPreview('Radial Chart - Text', _chartRadialText),
  ComponentPreview('Radial Chart - Shape', _chartRadialShape),
  ComponentPreview('Radial Chart - Stacked', _chartRadialStacked),
  ComponentPreview('Tooltip - Default', _chartTooltipDefault),
  ComponentPreview('Tooltip - Line Indicator', _chartTooltipLineIndicator),
  ComponentPreview('Tooltip - No Indicator', _chartTooltipNoIndicator),
  ComponentPreview('Tooltip - Custom label', _chartTooltipCustomLabel),
  ComponentPreview('Tooltip - Label Formatter', _chartTooltipLabelFormatter),
  ComponentPreview('Tooltip - No Label', _chartTooltipNoLabel),
  ComponentPreview('Tooltip - Formatter', _chartTooltipFormatter),
  ComponentPreview('Tooltip - Icons', _chartTooltipIcons),
  ComponentPreview('Tooltip - Advanced', _chartTooltipAdvanced),
];

const List<String> _tooltipDays = <String>[
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
];

const List<double> _tooltipRunning = <double>[450, 380, 520, 140, 600, 480];
const List<double> _tooltipSwimming = <double>[300, 420, 120, 550, 350, 400];

Chart _tooltipBase({
  ChartTooltipConfig tooltip = const ChartTooltipConfig(),
  List<ChartSeries>? series,
}) {
  return Chart(
    type: ChartType.bar,
    barMode: ChartBarMode.stacked,
    labels: _tooltipDays,
    height: 220,
    initialSelectedIndex: 1,
    tooltip: tooltip,
    series:
        series ??
        const <ChartSeries>[
          ChartSeries(label: 'Running', values: _tooltipRunning),
          ChartSeries(label: 'Swimming', values: _tooltipSwimming),
        ],
  );
}

Widget _chartTooltipDefault(BuildContext context) => _tooltipBase();

Widget _chartTooltipLineIndicator(BuildContext context) => _tooltipBase(
  tooltip: const ChartTooltipConfig(indicator: ChartTooltipIndicator.line),
);

Widget _chartTooltipNoIndicator(BuildContext context) => _tooltipBase(
  tooltip: const ChartTooltipConfig(indicator: ChartTooltipIndicator.none),
);

String _tooltipCustomLabel(int index) => 'Activities';

Widget _chartTooltipCustomLabel(BuildContext context) => _tooltipBase(
  tooltip: const ChartTooltipConfig(
    indicator: ChartTooltipIndicator.line,
    labelFormatter: _tooltipCustomLabel,
  ),
);

String _tooltipWeekday(int index) => _tooltipDays[index];

Widget _chartTooltipLabelFormatter(BuildContext context) => _tooltipBase(
  tooltip: const ChartTooltipConfig(labelFormatter: _tooltipWeekday),
);

Widget _chartTooltipNoLabel(BuildContext context) =>
    _tooltipBase(tooltip: const ChartTooltipConfig(showLabel: false));

Widget _chartTooltipFormatter(BuildContext context) => _tooltipBase(
  tooltip: const ChartTooltipConfig(showLabel: false, valueSuffix: ' kcal'),
);

Widget _chartTooltipIcons(BuildContext context) => _tooltipBase(
  tooltip: const ChartTooltipConfig(showLabel: false),
  series: const <ChartSeries>[
    ChartSeries(
      label: 'Running',
      values: _tooltipRunning,
      icon: Icon(LucideIcons.footprints),
    ),
    ChartSeries(
      label: 'Swimming',
      values: _tooltipSwimming,
      icon: Icon(LucideIcons.waves),
    ),
  ],
);

Widget _chartTooltipAdvanced(BuildContext context) => _tooltipBase(
  tooltip: const ChartTooltipConfig(
    showLabel: false,
    valueSuffix: ' kcal',
    showTotal: true,
  ),
);

const List<String> _areaMonths = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
];

const List<double> _areaDesktop = <double>[186, 305, 237, 73, 209, 214];
const List<double> _areaMobile = <double>[80, 200, 120, 190, 130, 140];

/// 90 days of deterministic sample data (Apr 1 - Jun 29) for the
/// interactive range-filter examples.
List<double> _trend(int seed) {
  return <double>[
    for (var i = 0; i < 90; i++) (150 + ((i * 53 + seed) % 260)).toDouble(),
  ];
}

String _trendDay(int i) {
  const List<int> lens = <int>[30, 31, 30];
  const List<String> names = <String>['Apr', 'May', 'Jun'];
  var d = i;
  var m = 0;
  while (m < 2 && d >= lens[m]) {
    d -= lens[m];
    m++;
  }
  return '${names[m]} ${d + 1}';
}

/// Range-filter buttons for the interactive examples.
class _RangeButtons extends StatelessWidget {
  const _RangeButtons({
    required this.options,
    required this.selected,
    required this.onSelect,
  });

  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colors;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: <Widget>[
        for (final String option in options)
          GestureDetector(
            onTap: () => onSelect(option),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: option == selected ? colors.foreground : colors.border,
                ),
              ),
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 12,
                  color: option == selected
                      ? colors.foreground
                      : colors.mutedForeground,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// Interactive area chart with a 90d/30d/7d range filter.
class _AreaInteractive extends StatefulWidget {
  const _AreaInteractive();

  @override
  State<_AreaInteractive> createState() => _AreaInteractiveState();
}

class _AreaInteractiveState extends State<_AreaInteractive> {
  static final List<double> desktopData = _trend(11);
  static final List<double> mobileData = _trend(101);
  static final List<String> dayLabels = <String>[
    for (var i = 0; i < 90; i++) _trendDay(i),
  ];

  String _range = '90d';

  int get _count => _range == '7d'
      ? 7
      : _range == '30d'
      ? 30
      : 90;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _RangeButtons(
          options: const <String>['90d', '30d', '7d'],
          selected: _range,
          onSelect: (String value) => setState(() => _range = value),
        ),
        const SizedBox(height: 8),
        Chart(
          type: ChartType.area,
          areaMode: ChartAreaMode.stacked,
          labels: dayLabels.sublist(90 - _count),
          series: <ChartSeries>[
            ChartSeries(
              label: 'Mobile',
              values: mobileData.sublist(90 - _count),
            ),
            ChartSeries(
              label: 'Desktop',
              values: desktopData.sublist(90 - _count),
            ),
          ],
        ),
      ],
    );
  }
}

Widget _chartAreaInteractive(BuildContext context) => const _AreaInteractive();

Widget _chartAreaDefault(BuildContext context) {
  return const Chart(
    type: ChartType.area,
    labels: _areaMonths,
    fillOpacity: 0.4,
    tooltip: ChartTooltipConfig(indicator: ChartTooltipIndicator.line),
    series: <ChartSeries>[ChartSeries(label: 'Desktop', values: _areaDesktop)],
  );
}

Widget _chartAreaLinear(BuildContext context) {
  return const Chart(
    type: ChartType.area,
    lineStyle: ChartLineStyle.linear,
    labels: _areaMonths,
    fillOpacity: 0.4,
    tooltip: ChartTooltipConfig(indicator: ChartTooltipIndicator.line),
    series: <ChartSeries>[ChartSeries(label: 'Desktop', values: _areaDesktop)],
  );
}

Widget _chartAreaStep(BuildContext context) {
  return const Chart(
    type: ChartType.area,
    lineStyle: ChartLineStyle.step,
    labels: _areaMonths,
    fillOpacity: 0.4,
    series: <ChartSeries>[ChartSeries(label: 'Desktop', values: _areaDesktop)],
  );
}

Widget _chartAreaLegend(BuildContext context) {
  return const Chart(
    type: ChartType.area,
    areaMode: ChartAreaMode.stacked,
    labels: _areaMonths,
    series: <ChartSeries>[
      ChartSeries(label: 'Mobile', values: _areaMobile),
      ChartSeries(label: 'Desktop', values: _areaDesktop),
    ],
  );
}

Widget _chartAreaStacked(BuildContext context) {
  return const Chart(
    type: ChartType.area,
    areaMode: ChartAreaMode.stacked,
    labels: _areaMonths,
    showLegend: false,
    series: <ChartSeries>[
      ChartSeries(values: _areaMobile),
      ChartSeries(values: _areaDesktop),
    ],
  );
}

Widget _chartAreaStackedExpanded(BuildContext context) {
  return const Chart(
    type: ChartType.area,
    areaMode: ChartAreaMode.expanded,
    labels: _areaMonths,
    showLegend: false,
    series: <ChartSeries>[
      ChartSeries(values: _areaMobile),
      ChartSeries(values: _areaDesktop),
    ],
  );
}

Widget _chartAreaIcons(BuildContext context) {
  return const Chart(
    type: ChartType.area,
    areaMode: ChartAreaMode.stacked,
    labels: _areaMonths,
    series: <ChartSeries>[
      ChartSeries(
        label: 'Mobile',
        values: _areaMobile,
        icon: Icon(LucideIcons.trendingUp),
      ),
      ChartSeries(
        label: 'Desktop',
        values: _areaDesktop,
        icon: Icon(LucideIcons.trendingDown),
      ),
    ],
  );
}

Widget _chartAreaGradient(BuildContext context) {
  final palette = Theme.of(context).colors.chartColors;
  LinearGradient fill(Color color) => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[color.withValues(alpha: 0.8), color.withValues(alpha: 0.1)],
  );
  return Chart(
    type: ChartType.area,
    areaMode: ChartAreaMode.stacked,
    labels: _areaMonths,
    series: <ChartSeries>[
      ChartSeries(
        label: 'Mobile',
        values: _areaMobile,
        gradient: fill(palette[1]),
      ),
      ChartSeries(
        label: 'Desktop',
        values: _areaDesktop,
        gradient: fill(palette[0]),
      ),
    ],
  );
}

Widget _chartAreaAxes(BuildContext context) {
  return const Chart(
    type: ChartType.area,
    areaMode: ChartAreaMode.stacked,
    labels: _areaMonths,
    showAxes: false,
    showLegend: false,
    yAxis: ChartAxis(tickCount: 3),
    series: <ChartSeries>[
      ChartSeries(values: _areaMobile),
      ChartSeries(values: _areaDesktop),
    ],
  );
}

const List<double> _radialBrowserValues = <double>[275, 200, 187, 173, 90];

const List<String> _radialBrowserLabels = <String>[
  'Chrome',
  'Safari',
  'Firefox',
  'Edge',
  'Other',
];

List<ChartSeries> _radialBrowsers({bool labeled = true}) {
  return <ChartSeries>[
    for (var i = 0; i < _radialBrowserValues.length; i++)
      ChartSeries(
        label: labeled ? _radialBrowserLabels[i] : null,
        values: <double>[_radialBrowserValues[i]],
      ),
  ];
}

Widget _chartRadialSimple(BuildContext context) {
  return Chart(
    type: ChartType.radial,
    height: 260,
    showLegend: false,
    series: _radialBrowsers(),
  );
}

Widget _chartRadialLabel(BuildContext context) {
  return const Chart(
    type: ChartType.radial,
    height: 260,
    showLegend: false,
    radial: ChartRadialConfig(showRingLabels: true),
    series: <ChartSeries>[
      ChartSeries(label: 'Chrome', values: <double>[275]),
      ChartSeries(label: 'Safari', values: <double>[200]),
      ChartSeries(label: 'Firefox', values: <double>[187]),
      ChartSeries(label: 'Edge', values: <double>[173]),
      ChartSeries(label: 'Other', values: <double>[90]),
    ],
  );
}

Widget _chartRadialGrid(BuildContext context) {
  return Chart(
    type: ChartType.radial,
    height: 260,
    showLegend: false,
    radial: const ChartRadialConfig(showGrid: true),
    series: _radialBrowsers(),
  );
}

Widget _chartRadialText(BuildContext context) {
  return const Chart(
    type: ChartType.radial,
    height: 260,
    showLegend: false,
    centerLabel: '200',
    centerSublabel: 'Visitors',
    radial: ChartRadialConfig(sweep: 250 / 360, rounded: true),
    series: <ChartSeries>[
      ChartSeries(values: <double>[200]),
    ],
  );
}

Widget _chartRadialShape(BuildContext context) {
  return const Chart(
    type: ChartType.radial,
    height: 260,
    showLegend: false,
    centerLabel: '1,260',
    centerSublabel: 'Visitors',
    radial: ChartRadialConfig(sweep: 100 / 360, thickness: 0.35),
    series: <ChartSeries>[
      ChartSeries(values: <double>[1260]),
    ],
  );
}

Widget _chartRadialStacked(BuildContext context) {
  return const Chart(
    type: ChartType.radial,
    height: 260,
    showLegend: false,
    centerLabel: '1,830',
    centerSublabel: 'Visitors',
    radial: ChartRadialConfig(sweep: 0.5, stacked: true, rounded: true),
    series: <ChartSeries>[
      ChartSeries(label: 'Mobile', values: <double>[570]),
      ChartSeries(label: 'Desktop', values: <double>[1260]),
    ],
  );
}

// Named examples for the `chart` component (preview contract).
//
// One focused demo per entry; the first entry is the default. Spacing comes
// from the ambient theme, so the examples follow the selected preset and the
// site light/dark toggle. Controllers live inside their example's own
// StatefulWidget so two examples never share one.

import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../foundation/component_preview.dart';
import 'chart.dart';

Widget _chartDefault(BuildContext context) {
  return const Chart(
    data: <double>[3, 5, 2, 6, 4, 7],
    semanticsLabel: 'Line chart with six points trending up',
  );
}

Widget _chartArea(BuildContext context) {
  return const Chart(
    type: ChartType.area,
    showMarkers: true,
    series: <ChartSeries>[
      ChartSeries(label: 'Revenue', values: <double>[2, 4, 3, 5, 6, 8]),
      ChartSeries(label: 'Costs', values: <double>[1, 2, 2, 3, 4, 5]),
    ],
  );
}

Widget _chartBarGrouped(BuildContext context) {
  return const Chart(
    type: ChartType.bar,
    series: <ChartSeries>[
      ChartSeries(label: 'Web', values: <double>[4, 6, 5, 7]),
      ChartSeries(label: 'Mobile', values: <double>[3, 4, 6, 5]),
    ],
    labels: <String>['Q1', 'Q2', 'Q3', 'Q4'],
  );
}

Widget _chartBarStacked(BuildContext context) {
  return const Chart(
    type: ChartType.bar,
    barMode: ChartBarMode.stacked,
    series: <ChartSeries>[
      ChartSeries(label: 'Free', values: <double>[2, 3, 4]),
      ChartSeries(label: 'Pro', values: <double>[3, 2, 5]),
    ],
    labels: <String>['Jan', 'Feb', 'Mar'],
  );
}

Widget _chartDonut(BuildContext context) {
  return const Chart(
    type: ChartType.donut,
    series: <ChartSeries>[
      ChartSeries(label: 'Share', values: <double>[40, 30, 20, 10]),
    ],
    showDataTable: true,
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

const List<double> _radarDesktop = <double>[186, 305, 237, 273, 209, 214];
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
  ComponentPreview('Default', _chartDefault),
  ComponentPreview('Area', _chartArea),
  ComponentPreview('BarGrouped', _chartBarGrouped),
  ComponentPreview('BarStacked', _chartBarStacked),
  ComponentPreview('Donut', _chartDonut),
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
];

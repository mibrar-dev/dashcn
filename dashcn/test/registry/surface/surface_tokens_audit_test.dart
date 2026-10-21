// Frost audit for the surface-tokens pass: every fixed family honours the
// ambient `ThemeData.surfaceOpacity` / `surfaceBlur` through
// `primitives/surface.dart` (the `navigation_bar` path).
//
// Each group pumps its surface under `surfaceOpacity: 0.5, surfaceBlur: 8`
// and asserts the painted fill is translucent (alpha <= 0.6) with a
// `BackdropFilter` present. At the opaque default `surfaceColor` returns the
// base unchanged and `GlassSurface` adds no layer, so defaults are identical.

import 'package:dashcn/src/components/chart/chart_model.dart';
import 'package:dashcn/src/components/chart/chart_style.dart';
import 'package:dashcn/src/components/chart/chart_tooltip.dart';
import 'package:dashcn/src/components/code_snippet/code_snippet.dart';
import 'package:dashcn/src/components/error_system/error_system.dart';
import 'package:dashcn/src/components/feature_carousel/feature_carousel.dart';
import 'package:dashcn/src/components/search_bar/search_bar.dart';
import 'package:dashcn/src/components/toolbar/toolbar.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

const ThemeData _glass = ThemeData(surfaceOpacity: 0.5, surfaceBlur: 8);
const Color _saturated = Color(0xFFD81B60);

Widget _frame(Widget child) {
  return Theme(
    data: _glass,
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: ColoredBox(
        color: _saturated,
        child: Center(child: child),
      ),
    ),
  );
}

List<Color> _paints(WidgetTester tester, Finder scope) {
  final List<Color> out = <Color>[];
  for (final DecoratedBox box in tester.widgetList<DecoratedBox>(
    find.descendant(of: scope, matching: find.byType(DecoratedBox)),
  )) {
    final d = box.decoration;
    if (d is BoxDecoration && d.color != null) out.add(d.color!);
  }
  for (final Container box in tester.widgetList<Container>(
    find.descendant(of: scope, matching: find.byType(Container)),
  )) {
    final d = box.decoration;
    if (d is BoxDecoration && d.color != null) out.add(d.color!);
    if (box.color != null) out.add(box.color!);
  }
  for (final ColoredBox box in tester.widgetList<ColoredBox>(
    find.descendant(of: scope, matching: find.byType(ColoredBox)),
  )) {
    out.add(box.color);
  }
  return out;
}

void _expectGlass(WidgetTester tester, Finder scope) {
  final List<Color> paints = _paints(tester, scope);
  expect(paints, isNotEmpty, reason: 'no background paint under $scope');
  expect(
    paints.first.a,
    lessThanOrEqualTo(0.6),
    reason: 'surface fill is opaque: ${paints.first}',
  );
  expect(
    find.descendant(of: scope, matching: find.byType(BackdropFilter)),
    findsWidgets,
    reason: 'no BackdropFilter under $scope',
  );
}

const ChartSurface _tooltipSurface = ChartSurface(
  gridColor: Color(0xFF000001),
  axisColor: Color(0xFF000002),
  tickStyle: TextStyle(fontSize: 12),
  legendStyle: TextStyle(fontSize: 12),
  tooltipFill: Color(0xFFFFFFFF),
  tooltipStyle: TextStyle(fontSize: 12),
  seriesPalette: <Color>[Color(0xFF000003)],
  strokeWidth: 2,
  markerRadius: 3,
  barRadius: 2,
  barGap: 0.2,
  barGroupGap: 0.2,
  fillOpacity: 0.2,
  contentPadding: EdgeInsets.all(8),
  showGrid: true,
  showAxes: true,
  showTicks: true,
  showLabels: true,
  showLegend: true,
  showTooltip: true,
  showMarkers: true,
  animationDuration: Duration.zero,
  animationCurve: Curves.linear,
  animate: false,
  donutHole: 0.5,
  backgroundColor: null,
);

void main() {
  group('chart_tooltip', () {
    testWidgets('tooltip card frosts', (tester) async {
      await tester.pumpWidget(
        _frame(
          const ChartTooltipCard(
            data: ChartTooltipData(
              index: 0,
              label: 'Jan',
              rows: <ChartTooltipRow>[
                ChartTooltipRow(label: 'a', value: 1, color: Color(0xFF000001)),
              ],
            ),
            config: ChartTooltipConfig(),
            surface: _tooltipSurface,
          ),
        ),
      );
      _expectGlass(tester, find.byType(ChartTooltipCard));
    });
  });

  group('code_snippet', () {
    testWidgets('block frosts', (tester) async {
      await tester.pumpWidget(
        _frame(const CodeSnippet(code: Text('const x = 1;'))),
      );
      await tester.pump();
      _expectGlass(tester, find.byType(CodeSnippet));
    });
  });

  group('error_system', () {
    testWidgets('full-section overlay frosts', (tester) async {
      final ValueNotifier<AppError?> channel = ValueNotifier<AppError?>(
        AppError(code: AppErrorCode.server, title: 't', message: 'm'),
      );
      addTearDown(channel.dispose);
      await tester.pumpWidget(
        _frame(AppErrorGate(notifier: channel, child: const Text('behind'))),
      );
      await tester.pump();
      _expectGlass(tester, find.byType(AppErrorGate));
    });
  });

  group('feature_carousel', () {
    testWidgets('section backdrop frosts', (tester) async {
      final FeatureCarouselController controller = FeatureCarouselController(
        autoPlay: false,
      );
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        _frame(
          SizedBox(
            width: 480,
            child: FeatureCarousel(
              controller: controller,
              items: const <FeatureCarouselItem>[
                FeatureCarouselItem(title: 'Fast', description: 'Ship.'),
              ],
            ),
          ),
        ),
      );
      await tester.pump();
      // The centre card stays opaque (its own card fill); the section
      // backdrop behind it is the frosted surface.
      final Finder scope = find.byType(FeatureCarousel);
      final List<Color> frosted = _paints(
        tester,
        scope,
      ).where((Color c) => c.a > 0.05 && c.a <= 0.6).toList();
      expect(frosted, isNotEmpty, reason: 'backdrop never frosts');
      expect(
        find.descendant(of: scope, matching: find.byType(BackdropFilter)),
        findsWidgets,
        reason: 'no BackdropFilter under $scope',
      );
    });
  });

  group('search_bar', () {
    testWidgets('popover surface frosts', (tester) async {
      await tester.pumpWidget(
        _frame(const SearchBar<String>(items: <String>['apple'])),
      );
      await tester.pump();
      _expectGlass(tester, find.byType(SearchBar<String>));
    });
  });

  group('toolbar', () {
    testWidgets('container frosts', (tester) async {
      await tester.pumpWidget(
        _frame(
          const Toolbar(children: <Widget>[ToolbarItem(child: Text('a'))]),
        ),
      );
      await tester.pump();
      _expectGlass(tester, find.byType(Toolbar));
    });
  });
}

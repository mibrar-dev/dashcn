// Charts section tests: the `/charts` hub and the family pages.
//
// The hub has one card per chart family; each family page shows every one of
// its examples as its own Preview | Code card. The old
// `/docs/components/chart` URL resolves to the hub.
//
// The line family mounts the Streaming example (a periodic timer), whose
// repeating frames never let the scheduler settle: navigation here uses
// bounded pumps instead of `pumpAndSettle` (the same reason
// `component_examples_test.dart` avoids settling the full sweep).

import 'package:docs/pages/charts_family_page.dart';
import 'package:docs/pages/charts_hub_page.dart';
import 'package:docs/routing/docs_router.dart';
import 'package:docs/widgets/docs_header.dart';
import 'package:docs/widgets/docs_sidebar.dart';
import 'package:docs/widgets/example_preview_card.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/app_harness.dart';

/// Family id to the named `chart` previews it must show, in display order.
const Map<String, List<String>> kChartFamilyExamples = <String, List<String>>{
  'area': <String>[
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
  'bar': <String>[
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
  'line': <String>[
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
  'pie': <String>[
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
  'radar': <String>[
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
  'radial': <String>[
    'Radial Chart',
    'Radial Chart - Label',
    'Radial Chart - Grid',
    'Radial Chart - Text',
    'Radial Chart - Shape',
    'Radial Chart - Stacked',
  ],
  'tooltip': <String>[
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
  'scatter': <String>['Scatter'],
};

/// Bounded settle: enough frames for the deferred preview chunk and the lazy
/// cards, without hanging on the Streaming example's repeating timer.
Future<void> _pumpSoon(WidgetTester tester) async {
  for (int i = 0; i < 30; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

/// Navigates to [location] with bounded pumps (see above).
Future<void> _go(
  WidgetTester tester,
  DocsRouterDelegate delegate,
  String location,
) async {
  delegate.go(tester.element(find.byType(Navigator).last), location);
  await _pumpSoon(tester);
}

void main() {
  group('charts routes', () {
    test('parse maps the charts sitemap', () {
      expect(
        DocsRouteConfiguration.parse('/charts'),
        DocsRouteConfiguration.charts,
      );
      for (final String id in kChartFamilyExamples.keys) {
        expect(
          DocsRouteConfiguration.parse('/charts/$id'),
          DocsRouteConfiguration.chartFamily(id),
        );
        expect(DocsRouteConfiguration.chartFamily(id).location, '/charts/$id');
      }
    });

    test('the old component url resolves to the charts hub', () {
      expect(
        DocsRouteConfiguration.parse('/docs/components/chart'),
        DocsRouteConfiguration.charts,
      );
      expect(DocsRouteConfiguration.charts.location, '/charts');
    });

    test('unknown charts segments are not-found', () {
      // Every unknown slug stays not-found; `tooltips` (plural) has no page.
      for (final String id in <String>['tooltips']) {
        expect(
          DocsRouteConfiguration.parse('/charts/$id').route,
          DocsRoute.notFound,
          reason: id,
        );
      }
      expect(
        DocsRouteConfiguration.parse('/charts/area/extra').route,
        DocsRoute.notFound,
      );
    });
  });

  group('charts hub', () {
    testWidgets('hero and one card per family', (WidgetTester tester) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      await _go(tester, delegate, '/charts');
      expect(find.text('Charts'), findsWidgets);
      expect(
        find.byType(ChartFamilyCard),
        findsNWidgets(kChartFamilies.length),
      );
      for (final ChartFamily family in kChartFamilies) {
        expect(find.text(family.title), findsWidgets, reason: family.id);
        expect(
          find.text('Open ${family.title}'),
          findsOneWidget,
          reason: family.id,
        );
      }
      // No Components-style trust table on the hub.
      expect(find.text('How we measure'), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('hub cards link to their family pages', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      await _go(tester, delegate, '/charts');
      await tester.tap(find.text('Open Area'));
      await _pumpSoon(tester);
      expect(
        delegate.currentConfiguration,
        DocsRouteConfiguration.chartFamily('area'),
      );
      expect(find.text('Area'), findsWidgets);
      expect(tester.takeException(), isNull);
    });
  });

  group('chart family pages', () {
    testWidgets('each family shows every example with preview+code tabs', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      for (final MapEntry<String, List<String>> entry
          in kChartFamilyExamples.entries) {
        await _go(tester, delegate, '/charts/${entry.key}');
        final int count = entry.value.length;
        expect(
          find.byType(ExamplePreviewCard),
          findsNWidgets(count),
          reason: entry.key,
        );
        expect(
          find.descendant(
            of: find.byType(ExamplePreviewCard),
            matching: find.text('Preview'),
          ),
          findsNWidgets(count),
          reason: '${entry.key} preview tabs',
        );
        expect(
          find.descendant(
            of: find.byType(ExamplePreviewCard),
            matching: find.text('Code'),
          ),
          findsNWidgets(count),
          reason: '${entry.key} code tabs',
        );
        for (final String name in entry.value) {
          expect(find.text(name), findsWidgets, reason: '${entry.key}/$name');
        }
        expect(tester.takeException(), isNull, reason: entry.key);
      }
    });

    testWidgets('each family page fits 375px with no overflow', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(
        tester,
        width: 375,
        height: 812,
      );
      tester.takeException();
      for (final String id in kChartFamilyExamples.keys) {
        await _go(tester, delegate, '/charts/$id');
        // Reveal the below-fold cards too: lazy placeholders keep the stage
        // height, so only revealed cards can overflow.
        for (int i = 0; i < kChartFamilyExamples[id]!.length; i++) {
          await tester.ensureVisible(find.byType(ExamplePreviewCard).at(i));
          await _pumpSoon(tester);
        }
        expect(tester.takeException(), isNull, reason: 'overflow at $id@375');
      }
    });
  });

  group('charts navigation', () {
    testWidgets('header and sidebar list Charts, not the chart component', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(
        tester,
        width: 1600,
      );
      await _go(tester, delegate, '/docs');
      expect(
        find.descendant(
          of: find.byType(DocsHeader),
          matching: find.text('Charts'),
        ),
        findsOneWidget,
      );
      final Finder sidebar = find.byType(DocsSidebar);
      expect(sidebar, findsOneWidget);
      expect(
        find.descendant(of: sidebar, matching: find.text('Charts')),
        findsWidgets,
      );
      for (final ChartFamily family in kChartFamilies) {
        expect(
          find.descendant(of: sidebar, matching: find.text(family.title)),
          findsWidgets,
          reason: family.id,
        );
      }
      // `chart` left the Components list: no sidebar row is named Chart.
      expect(
        find.descendant(of: sidebar, matching: find.text('Chart')),
        findsNothing,
      );
      expect(tester.takeException(), isNull);
    });
  });
}

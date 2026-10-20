// Charts gallery tests: `/charts` shows every family section on one
// full-width page; `/charts/<family>` shows just that family.
//
// Both routes render without the docs sidebar. Each card carries its title,
// description, live chart, a Copy button and a View code dialog. The old
// `/docs/components/chart` URL resolves to the hub.
//
// Navigation uses bounded pumps instead of `pumpAndSettle` (chart previews
// can hold repeating tickers, the same reason `component_examples_test.dart`
// avoids settling the full sweep).

import 'package:docs/pages/charts_data.dart';
import 'package:docs/pages/charts_gallery.dart';
import 'package:docs/pages/charts_section.dart';
import 'package:docs/routing/docs_nav.dart';
import 'package:docs/routing/docs_router.dart';
import 'package:docs/widgets/docs_header.dart';
import 'package:docs/widgets/docs_sidebar.dart';
import 'package:docs/widgets/sidebar_groups.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/app_harness.dart';

/// Family id to the named `chart` previews it must show, in display order.
Map<String, List<String>> get kChartFamilyExamples => <String, List<String>>{
  for (final ChartFamily family in kChartFamilies) family.id: family.examples,
};

/// Bounded settle: enough frames for the deferred preview chunk, without
/// hanging on any repeating ticker.
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

/// Total example cards across every family.
int get _totalExamples => kChartFamilies.fold<int>(
  0,
  (int sum, ChartFamily family) => sum + family.examples.length,
);

void main() {
  group('charts routes', () {
    test('parse maps the charts sitemap', () {
      expect(
        DocsRouteConfiguration.parse('/charts'),
        DocsRouteConfiguration.charts,
      );
      for (final ChartFamily family in kChartFamilies) {
        expect(
          DocsRouteConfiguration.parse('/charts/${family.id}'),
          DocsRouteConfiguration.chartFamily(family.id),
        );
        expect(
          DocsRouteConfiguration.chartFamily(family.id).location,
          '/charts/${family.id}',
        );
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
    testWidgets('hero has title, subtitle and two actions', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      await _go(tester, delegate, '/charts');
      expect(find.text('Charts'), findsWidgets);
      expect(
        find.text(
          'Copy-paste charts for every dataset, from trends to breakdowns.',
        ),
        findsOneWidget,
      );
      expect(find.text('Browse charts'), findsOneWidget);
      expect(find.text('Documentation'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('hub shows every family section with every example card', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      await _go(tester, delegate, '/charts');
      expect(
        find.byType(ChartFamilySection),
        findsNWidgets(kChartFamilies.length),
      );
      expect(find.byType(ChartExampleCard), findsNWidgets(_totalExamples));
      for (final ChartFamily family in kChartFamilies) {
        expect(
          find.byKey(ValueKey<String>('chart-family-section-${family.id}')),
          findsOneWidget,
          reason: family.id,
        );
        for (final String name in family.examples) {
          expect(find.text(name), findsWidgets, reason: '${family.id}/$name');
        }
      }
      // No Components-style trust table on the hub.
      expect(find.text('How we measure'), findsNothing);
      expect(tester.takeException(), isNull);
    });

    testWidgets('family nav pills link to their family pages', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      await _go(tester, delegate, '/charts');
      expect(find.byType(ChartFamilyNav), findsOneWidget);
      for (final ChartFamily family in kChartFamilies) {
        expect(
          find.byKey(ValueKey<String>('chart-family-pill-${family.id}')),
          findsOneWidget,
          reason: family.id,
        );
      }
      await tester.tap(
        find.byKey(const ValueKey<String>('chart-family-pill-area')),
      );
      await _pumpSoon(tester);
      expect(
        delegate.currentConfiguration,
        DocsRouteConfiguration.chartFamily('area'),
      );
      expect(find.byType(ChartFamilySection), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('charts pages have no sidebar', (WidgetTester tester) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      await _go(tester, delegate, '/charts');
      expect(find.byType(DocsSidebar), findsNothing);
      expect(find.byType(ChartFamilyNav), findsOneWidget);
      await _go(tester, delegate, '/charts/line');
      expect(find.byType(DocsSidebar), findsNothing);
      expect(find.byType(ChartFamilyNav), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('hub fits 375px with no overflow', (WidgetTester tester) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(
        tester,
        width: 375,
        height: 812,
      );
      tester.takeException();
      await _go(tester, delegate, '/charts');
      for (int i = 0; i < _totalExamples; i++) {
        await tester.ensureVisible(find.byType(ChartExampleCard).at(i));
        await tester.pump(const Duration(milliseconds: 100));
      }
      expect(tester.takeException(), isNull);
    });
  });

  group('chart family pages', () {
    testWidgets('each family shows just its own section and cards', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      for (final MapEntry<String, List<String>> entry
          in kChartFamilyExamples.entries) {
        await _go(tester, delegate, '/charts/${entry.key}');
        expect(find.byType(ChartFamilySection), findsOneWidget);
        expect(
          find.byType(ChartExampleCard),
          findsNWidgets(entry.value.length),
          reason: entry.key,
        );
        for (final String name in entry.value) {
          expect(find.text(name), findsWidgets, reason: '${entry.key}/$name');
        }
        expect(tester.takeException(), isNull, reason: entry.key);
      }
    });

    testWidgets('documentation button resolves to the charts hub', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      await _go(tester, delegate, '/charts/area');
      await tester.tap(find.text('Documentation'));
      await _pumpSoon(tester);
      expect(
        delegate.currentConfiguration,
        DocsRouteConfiguration.charts,
        reason: '/docs/components/chart resolves to the hub',
      );
      expect(
        find.byType(ChartFamilySection),
        findsNWidgets(kChartFamilies.length),
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('view code opens the example code dialog', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      await _go(tester, delegate, '/charts/area');
      await tester.ensureVisible(find.text('View code').first);
      await tester.pump(const Duration(milliseconds: 100));
      await tester.tap(find.text('View code').first);
      await _pumpSoon(tester);
      expect(
        find.byKey(const ValueKey<String>('chart-code-dialog')),
        findsOneWidget,
      );
      // The dialog offers its own copy control.
      expect(find.text('Copy'), findsWidgets);
      expect(tester.takeException(), isNull);
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
      for (final MapEntry<String, List<String>> entry
          in kChartFamilyExamples.entries) {
        await _go(tester, delegate, '/charts/${entry.key}');
        for (int i = 0; i < entry.value.length; i++) {
          await tester.ensureVisible(find.byType(ChartExampleCard).at(i));
          await tester.pump(const Duration(milliseconds: 100));
        }
        expect(
          tester.takeException(),
          isNull,
          reason: 'overflow at ${entry.key}@375',
        );
      }
    });
  });

  group('charts navigation', () {
    testWidgets('header keeps Charts; sidebar drops the Charts group', (
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
      // Neither the Sections entry nor the Charts group label remain.
      // `Tooltip` is skipped below: the tooltip *component* keeps its own
      // sidebar row (the row model test below proves no row links to
      // /charts).
      expect(
        find.descendant(of: sidebar, matching: find.text('Charts')),
        findsNothing,
      );
      for (final ChartFamily family in kChartFamilies) {
        if (family.title == 'Tooltip') {
          continue;
        }
        expect(
          find.descendant(of: sidebar, matching: find.text(family.title)),
          findsNothing,
          reason: family.id,
        );
      }
      expect(tester.takeException(), isNull);
    });

    test('sections and sidebar rows have no charts entries', () {
      for (final DocsNavLink link in kDocsSections) {
        expect(link.location.startsWith('/charts'), isFalse);
      }
      final List<SidebarRow> rows = buildSidebarRows('/docs');
      expect(
        rows.any(
          (SidebarRow row) =>
              row.label == 'Charts' ||
              (row.location ?? '').startsWith('/charts'),
        ),
        isFalse,
      );
      // The header still lists Charts (it owns the gallery link now).
      expect(
        kHeaderNav.any((DocsNavLink link) => link.location == '/charts'),
        isTrue,
      );
    });

    test('family nav links resolve to family pages', () {
      for (final DocsNavLink link in kChartLinks) {
        final DocsRouteConfiguration config = DocsRouteConfiguration.parse(
          link.location,
        );
        expect(config.route, DocsRoute.chartFamily, reason: link.location);
      }
      expect(chartGalleryFamilyIds, hasLength(kChartFamilies.length));
      for (final ChartFamily family in kChartFamilies) {
        expect(chartGalleryFamilyIds, contains(family.id));
      }
    });
  });
}

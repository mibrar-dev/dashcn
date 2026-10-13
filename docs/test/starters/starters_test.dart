// P9-Z2 starters tests: the index lists every starter from generated data,
// the starter page shows routes, the create command, files and next steps,
// and the search index finds starters.

import 'package:docs/generated/docs_search.dart';
import 'package:docs/generated/docs_starters.dart';
import 'package:docs/pages/starters_pages.dart';
import 'package:docs/routing/docs_nav.dart';
import 'package:docs/routing/docs_router.dart';
import 'package:docs/widgets/palette.dart';
import 'package:docs/widgets/palette_model.dart';
import 'package:docs/widgets/sidebar_groups.dart';
import 'package:docs/widgets/starter_card.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/app_harness.dart';

/// Palette-style matching over the generated index (mirrors the palette).
List<DocsSearchEntry> searchIndex(String query) {
  final String needle = query.toLowerCase();
  return kDocsSearchIndex
      .where(
        (DocsSearchEntry entry) =>
            entry.label.toLowerCase().contains(needle) ||
            (entry.tag?.toLowerCase().contains(needle) ?? false) ||
            entry.keywords.any(
              (String keyword) => keyword.toLowerCase().contains(needle),
            ),
      )
      .toList(growable: false);
}

void main() {
  group('starters index', () {
    testWidgets('one card per starter from generated data', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      await goTo(tester, delegate, '/docs/starters');
      expect(find.text('Start from a template'), findsOneWidget);
      expect(find.byType(StarterCard), findsNWidgets(kStarters.length));
      for (final DocsStarter starter in kStarters) {
        expect(find.text(starter.name), findsWidgets, reason: starter.id);
        expect(
          find.text(starter.description),
          findsOneWidget,
          reason: starter.id,
        );
        expect(find.text(starter.install), findsWidgets, reason: starter.id);
      }
      expect(tester.takeException(), isNull);
    });

    testWidgets('every starter page opens from its card route', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      for (final DocsStarter starter in kStarters) {
        await goTo(tester, delegate, '/docs/starters/${starter.id}');
        expect(find.byType(StarterPage), findsOneWidget, reason: starter.id);
        expect(find.text(starter.name), findsOneWidget, reason: starter.id);
      }
    });

    testWidgets('unknown starter id shows the missing page', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      await goTo(tester, delegate, '/docs/starters/nope');
      expect(
        find.text('No starter named `nope`.', skipOffstage: false),
        findsOneWidget,
      );
    });
  });

  group('starter page content', () {
    testWidgets('saas shows routes, command tabs, files and next steps', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      await goTo(tester, delegate, '/docs/starters/saas');
      final DocsStarter saas = kStarters.firstWhere(
        (DocsStarter s) => s.id == 'saas',
      );
      // Routes table: every app path is listed.
      for (final DocsStarterRoute route in saas.routes) {
        expect(find.text(route.path), findsOneWidget, reason: route.path);
        expect(find.text(route.title), findsWidgets, reason: route.title);
      }
      // Flow/block links resolve to their pages.
      expect(find.text('auth-01 flow'), findsOneWidget);
      expect(find.text('dashboard-01 block'), findsOneWidget);
      // Package tab shows the package command + theme file.
      expect(
        find.text('dashcn create saas my_app --mode package'),
        findsOneWidget,
      );
      expect(find.text('lib/app_theme.dart'), findsWidgets);
      // Switch to Own the code: copy command + owned theme file.
      await tester.tap(find.text('Own the code').first);
      await tester.pumpAndSettle();
      expect(
        find.text('dashcn create saas my_app --mode copy'),
        findsOneWidget,
      );
      expect(find.text('lib/ui/dashcn/theme/app_theme.dart'), findsWidgets);
      // Rendered-template file list (targets, never `.tmpl` text).
      for (final DocsStarterFile file in saas.files) {
        expect(find.text(file.target), findsWidgets, reason: file.target);
      }
      expect(find.textContaining('.tmpl'), findsNothing);
      // Theme options + next steps.
      expect(find.textContaining('--theme'), findsWidgets);
      expect(find.textContaining('flutter run'), findsOneWidget);
      expect(find.textContaining('lib/data/repository.dart'), findsWidgets);
      expect(find.text('Browse template sources on GitHub'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('shop product-grid route has no flow/block link', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      await goTo(tester, delegate, '/docs/starters/shop');
      expect(find.text('/shop'), findsOneWidget);
      expect(find.text('Starter page (product-grid)'), findsOneWidget);
    });

    testWidgets('route links navigate to flow and block pages', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      await goTo(tester, delegate, '/docs/starters/saas');
      await tester.tap(find.text('auth-01 flow'));
      await tester.pumpAndSettle();
      expect(delegate.currentConfiguration.location, '/docs/flows/auth-01');
      await goTo(tester, delegate, '/docs/starters/saas');
      await tester.tap(find.text('dashboard-01 block'));
      await tester.pumpAndSettle();
      expect(delegate.currentConfiguration.location, '/blocks/dashboard-01');
    });
  });

  group('starters search and nav', () {
    test('searching "saas" finds the saas starter', () {
      final List<DocsSearchEntry> hits = searchIndex('saas');
      expect(
        hits.any(
          (DocsSearchEntry entry) => entry.route == '/docs/starters/saas',
        ),
        isTrue,
        reason: 'routes: ${hits.map((DocsSearchEntry e) => e.route).toList()}',
      );
    });

    test('searching "starter" finds the index page', () {
      expect(
        searchIndex(
          'starter',
        ).any((DocsSearchEntry entry) => entry.route == '/docs/starters'),
        isTrue,
      );
    });

    test('starters are reachable from header, sidebar and palette', () {
      expect(
        kHeaderNav.any((DocsNavLink link) => link.location == '/docs/starters'),
        isTrue,
      );
      final List<SidebarRow> rows = buildSidebarRows('/docs/starters');
      expect(
        rows.any((SidebarRow row) => row.location == '/docs/starters/saas'),
        isTrue,
      );
      final Set<String> paletteRoutes = <String>{
        for (final PaletteEntry entry in buildPaletteEntries()) entry.route,
      };
      for (final DocsStarter starter in kStarters) {
        expect(
          paletteRoutes.contains('/docs/starters/${starter.id}'),
          isTrue,
          reason: starter.id,
        );
      }
    });

    test('starter install block commands come from one source', () {
      // The card chip and the page command share the manifest install line.
      for (final DocsStarter starter in kStarters) {
        expect(starter.install, 'dashcn create ${starter.id} my_app');
      }
      expect(
        kDocsSearchIndex
            .where((DocsSearchEntry e) => e.kind == DocsSearchKind.starter)
            .length,
        kStarters.length,
      );
    });

    testWidgets('getting started links to the starters index', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      await goTo(tester, delegate, '/docs/installation');
      expect(find.text('Start from a template'), findsNothing);
      expect(find.textContaining('Start from a template'), findsOneWidget);
      await tester.tap(find.text('browse the starters'));
      await tester.pumpAndSettle();
      expect(delegate.currentConfiguration.location, '/docs/starters');
    });

    testWidgets('palette typing saas shows the starter group', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      delegate.openPalette();
      await tester.pumpAndSettle();
      await tester.enterText(
        find.descendant(
          of: find.byType(DocsPalette),
          matching: find.byType(EditableText),
        ),
        'saas',
      );
      await tester.pumpAndSettle();
      expect(
        find.descendant(
          of: find.byType(DocsPalette),
          matching: find.text('SaaS starter'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(DocsPalette),
          matching: find.text('Starters'),
        ),
        findsOneWidget,
      );
    });
  });
}

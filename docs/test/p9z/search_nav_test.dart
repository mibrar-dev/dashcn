// P9-Z search, nav and theme import discoverability.
//
// The generated search index covers flows and the P9-era prose pages;
// every `kDocsSections` route is reachable from the sidebar or the palette;
// the studio import/export opens from the Themes nav entry.

import 'package:docs/generated/docs_search.dart';
import 'package:docs/routing/docs_nav.dart';
import 'package:docs/widgets/palette_model.dart';
import 'package:docs/widgets/sidebar_groups.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/app_harness.dart';

/// Palette-style matching over the generated index (label/tag/keywords,
/// case-insensitive substring).
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
  group('p9z search and nav', () {
    test('searching "otp" finds the auth flow', () {
      final List<DocsSearchEntry> hits = searchIndex('otp');
      expect(
        hits.any(
          (DocsSearchEntry entry) => entry.route == '/docs/flows/auth-01',
        ),
        isTrue,
        reason: 'routes: ${hits.map((e) => e.route).toList()}',
      );
    });

    test('searching "contrast" finds the scorecards page', () {
      final List<DocsSearchEntry> hits = searchIndex('contrast');
      expect(
        hits.any((DocsSearchEntry entry) => entry.route == '/docs/scorecards'),
        isTrue,
        reason: 'routes: ${hits.map((e) => e.route).toList()}',
      );
    });

    test('searching "package or own" finds the package page', () {
      expect(
        searchIndex(
          'package or own',
        ).any((DocsSearchEntry entry) => entry.route == '/docs/package-or-own'),
        isTrue,
      );
    });

    test('every docs section is reachable from nav or palette', () {
      final Set<String> navLocations = <String>{
        ...kHeaderNav.map((DocsNavLink link) => link.location),
        ...kDocsSections.map((DocsNavLink link) => link.location),
        for (final SidebarRow row in buildSidebarRows('/docs'))
          if (row.isLink) row.location!,
      };
      final Set<String> paletteRoutes = <String>{
        for (final PaletteEntry entry in buildPaletteEntries()) entry.route,
      };
      for (final DocsNavLink link in kDocsSections) {
        expect(
          navLocations.contains(link.location) ||
              paletteRoutes.contains(link.location),
          isTrue,
          reason: '${link.location} reachable',
        );
      }
    });

    testWidgets('sidebar links the studio import panel', (
      WidgetTester tester,
    ) async {
      final List<SidebarRow> rows = buildSidebarRows('/themes');
      final SidebarRow import = rows.firstWhere(
        (SidebarRow row) => row.label == 'Import a web theme',
      );
      expect(import.location, '/themes?panel=import');

      final delegate = await pumpDocsApp(tester);
      await goTo(tester, delegate, '/themes?panel=import');
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('Import Web Theme'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('studio export opens from the rail Get Code button', (
      WidgetTester tester,
    ) async {
      final delegate = await pumpDocsApp(tester, width: 1400, height: 900);
      await goTo(tester, delegate, '/themes');
      await tester.pumpAndSettle();
      await tester.tap(
        find.byKey(const ValueKey<String>('theme-rail-get-code')),
      );
      await tester.pumpAndSettle();
      expect(find.text('Get Code'), findsWidgets);
      expect(tester.takeException(), isNull);
    });
  });
}

// File-count badge singular/plural (live-qa #1).
//
// Root cause: the badge interpolated `'${count} files'` unconditionally,
// so 1-file components (App, Page Route, …) rendered `1 files`.
// Fix: `fileCountLabel` in `docs_tokens.dart` + the search-index generator
// now emit `1 file` vs `N files`.

import 'package:docs/generated/docs_search.dart';
import 'package:docs/routing/docs_router.dart';
import 'package:docs/widgets/docs_tokens.dart';
import 'package:docs/widgets/palette_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/app_harness.dart';

void main() {
  test('fileCountLabel uses singular for 1', () {
    expect(fileCountLabel(1), '1 file');
    expect(fileCountLabel(4), '4 files');
    expect(fileCountLabel(0), '0 files');
  });

  test('generated search tags use singular for 1-file components', () {
    final Map<String, String?> tags = <String, String?>{
      for (final DocsSearchEntry entry in kDocsSearchIndex)
        entry.route: entry.tag,
    };
    expect(tags['/docs/components/app'], '1 file');
    expect(tags['/docs/components/page_route'], '1 file');
    expect(tags['/docs/components/drawer'], '4 files');
    expect(
      kDocsSearchIndex.where((DocsSearchEntry e) => e.tag == '1 files'),
      isEmpty,
      reason: 'no "1 files" tags remain in the search index',
    );
  });

  testWidgets('component page badge shows 1 file for App', (tester) async {
    final DocsRouterDelegate delegate = await pumpDocsApp(tester);
    await goTo(tester, delegate, '/docs/components/app');
    expect(find.text('1 file'), findsOneWidget);
    expect(find.text('1 files'), findsNothing);
  });

  testWidgets('component page badge shows 4 files for Drawer', (tester) async {
    final DocsRouterDelegate delegate = await pumpDocsApp(tester);
    await goTo(tester, delegate, '/docs/components/drawer');
    expect(find.text('4 files'), findsOneWidget);
  });

  test('palette tags use singular for 1-file components', () {
    final List<PaletteEntry> entries = buildPaletteEntries();
    String? tagFor(String route) => entries
        .where((PaletteEntry e) => e.route == route)
        .map((PaletteEntry e) => e.tag)
        .firstOrNull;
    // `app`/`page_route` are unlisted building blocks (not in the palette);
    // `popup` is a listed 1-file component.
    expect(tagFor('/docs/components/popup'), '1 file');
    expect(tagFor('/docs/components/drawer'), '4 files');
  });
}

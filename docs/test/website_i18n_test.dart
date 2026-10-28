// Website i18n tests: every chrome key exists in every locale, the locale
// switcher lists every locale the kit ships, and choosing one switches the
// whole website (same page), persists, and flips direction for RTL.

import 'package:docs/playground/playground_config.dart';
import 'package:docs/routing/docs_router.dart';
import 'package:docs/state/docs_state.dart';
import 'package:docs/state/docs_strings.dart';
import 'package:docs/ui/dashcn/primitives/localizations/localizations.dart';
import 'package:docs/widgets/docs_header.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/app_harness.dart';

void main() {
  test('every chrome key exists in every locale table', () {
    for (final Locale locale in ComponentLocalizations.supportedLocales) {
      final String tag = docsLocaleTag(locale);
      for (final String key in kDocsChromeKeys) {
        final String value = docsChrome(locale, key);
        expect(
          value,
          isNot(key),
          reason: 'missing chrome key "$key" for locale "$tag"',
        );
        expect(value, isNotEmpty, reason: 'empty "$key" for "$tag"');
      }
    }
  });

  test('every supported locale has a table and a native name', () {
    expect(
      kDocsLocaleNativeNames.length,
      ComponentLocalizations.supportedLocales.length,
    );
    for (final Locale locale in ComponentLocalizations.supportedLocales) {
      final String tag = docsLocaleTag(locale);
      expect(
        kDocsLocaleNativeNames[tag],
        isNotNull,
        reason: 'missing native name for "$tag"',
      );
      expect(
        kDocsLocaleNativeNames[tag],
        isNotEmpty,
        reason: 'empty native name for "$tag"',
      );
      // Round-trips through the tag parser.
      expect(docsLocaleTag(docsLocaleFromTag(tag)), tag);
    }
  });

  test('locale tags cover pt_BR and the zh scripts distinctly', () {
    expect(docsLocaleTag(const Locale('pt', 'BR')), 'pt_BR');
    expect(
      docsLocaleTag(
        const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
      ),
      'zh_Hant',
    );
    expect(
      docsLocaleTag(
        const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
      ),
      'zh_Hans',
    );
    expect(DocsLocaleSwitcher.triggerLabel(const Locale('pt', 'BR')), 'PT-BR');
    expect(
      DocsLocaleSwitcher.triggerLabel(
        const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
      ),
      '繁',
    );
  });

  test('setLocale persists, reports ?locale= and restores from the URL', () {
    final MemoryDocsStorage storage = MemoryDocsStorage();
    final DocsState state = DocsState(storage: storage);
    addTearDown(state.dispose);

    state.setLocale(const Locale('de'));
    expect(docsLocaleTag(state.locale), 'de');
    expect(storage.values[kDocsLocaleKey], 'de');

    final Uri reported = state.reportUri(Uri.parse('/docs/components/button'));
    expect(reported.queryParameters[kDocsLocaleQueryKey], 'de');

    final DocsState second = DocsState(storage: storage);
    addTearDown(second.dispose);
    second.applyRouteUri(reported);
    expect(docsLocaleTag(second.locale), 'de');

    // Unknown tags never change the choice.
    second.applyLocaleQuery('xx-unknown');
    expect(docsLocaleTag(second.locale), 'de');

    // Back to the default drops the query key.
    second.setLocale(const Locale('en'));
    expect(
      second.reportUri(Uri.parse('/docs')).queryParameters,
      isNot(contains(kDocsLocaleQueryKey)),
    );
  });

  test('RTL helpers mark the kit RTL locales', () {
    for (final String code in <String>['ar', 'he', 'fa', 'ur', 'ps']) {
      expect(isRtlLocale(Locale(code)), isTrue, reason: code);
      expect(
        textDirectionForLocale(Locale(code)),
        TextDirection.rtl,
        reason: code,
      );
    }
    expect(textDirectionForLocale(const Locale('de')), TextDirection.ltr);
    expect(textDirectionForLocale(const Locale('en')), TextDirection.ltr);
  });

  testWidgets('the switcher lists every locale with its native name', (
    WidgetTester tester,
  ) async {
    await pumpDocsApp(tester, width: 1400, height: 900);
    await tester.tap(
      find.byKey(const ValueKey<String>('docs-locale-switcher')),
    );
    // Popups animate in (the overlay never fully settles under
    // `pumpAndSettle`), so pump past the enter transition instead.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    for (final Locale locale in ComponentLocalizations.supportedLocales) {
      expect(
        find.text(docsLocaleNativeName(locale)),
        findsOneWidget,
        reason: 'switcher misses ${docsLocaleTag(locale)}',
      );
    }
  });

  testWidgets('choosing a language switches the site, keeps the page', (
    WidgetTester tester,
  ) async {
    final DocsRouterDelegate delegate = await pumpDocsApp(
      tester,
      width: 1400,
      height: 900,
    );
    await goTo(tester, delegate, '/docs/components/button');
    expect(delegate.currentConfiguration.location, '/docs/components/button');

    await tester.tap(
      find.byKey(const ValueKey<String>('docs-locale-switcher')),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    await tester.ensureVisible(find.text('Deutsch'));
    await tester.pump();
    await tester.tap(find.text('Deutsch'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));

    // Same page, German chrome.
    expect(delegate.currentConfiguration.location, '/docs/components/button');
    // Switch-aware: with the playground hidden there is no Playground
    // button (German "Spielwiese"); flip kShowPlayground to re-enable.
    if (kShowPlayground) {
      expect(find.text('Spielwiese'), findsWidgets);
    } else {
      expect(find.text('Spielwiese'), findsNothing);
    }
    expect(find.text('Vertrauens-Scorecards'), findsOneWidget);
    expect(find.text('Verwendung'), findsOneWidget);
  });

  testWidgets('an RTL locale flips the app direction', (
    WidgetTester tester,
  ) async {
    await pumpDocsApp(tester, width: 1400, height: 900);
    docsState.setLocale(const Locale('ar'));
    await tester.pumpAndSettle();
    expect(
      Directionality.of(tester.element(find.byType(DocsHeader))),
      TextDirection.rtl,
    );
    // Landing hero in Arabic, same page.
    expect(find.text('كل المنصات معًا'), findsOneWidget);
    expect(find.text('ابدأ'), findsWidgets);
    docsState.setLocale(const Locale('en'));
    await tester.pumpAndSettle();
    expect(
      Directionality.of(tester.element(find.byType(DocsHeader))),
      TextDirection.ltr,
    );
    expect(find.text('Every platform at once'), findsOneWidget);
  });
}

// Website content i18n tests: every content key exists in every locale,
// and switching the locale changes the listed strings (categories,
// component descriptions, page titles, home cards, prose).

import 'package:docs/state/docs_content_categories.dart';
import 'package:docs/state/docs_content_components.dart';
import 'package:docs/state/docs_content_home.dart';
import 'package:docs/state/docs_content_pages.dart';
import 'package:docs/state/docs_content_prose1.dart';
import 'package:docs/state/docs_content_prose2.dart';
import 'package:docs/state/docs_content_registry.dart';
import 'package:docs/state/docs_strings.dart';
import 'package:docs/ui/dashcn/primitives/localizations/localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every content key exists in every locale table', () {
    for (final Locale locale in ComponentLocalizations.supportedLocales) {
      final String tag = docsLocaleTag(locale);
      for (final String key in kDocsContentCategoryKeys) {
        final String value = docsContentCategory(locale, key);
        expect(
          value,
          isNot(key),
          reason: 'missing category key "$key" for "$tag"',
        );
        expect(value, isNotEmpty, reason: 'empty "$key" for "$tag"');
      }
      for (final String key in kDocsContentPageKeys) {
        final String value = docsContentPage(locale, key);
        expect(value, isNot(key), reason: 'missing page key "$key" for "$tag"');
        expect(value, isNotEmpty, reason: 'empty "$key" for "$tag"');
      }
      for (final String key in kDocsContentComponentKeys) {
        final String value = docsContentComponent(locale, key);
        expect(
          value,
          isNot(key),
          reason: 'missing component key "$key" for "$tag"',
        );
        expect(value, isNotEmpty, reason: 'empty "$key" for "$tag"');
      }
      for (final String key in kDocsContentRegistryKeys) {
        final String value = docsRegistryDesc(locale, key);
        expect(
          value,
          isNot(key),
          reason: 'missing registry key "$key" for "$tag"',
        );
        expect(value, isNotEmpty, reason: 'empty "$key" for "$tag"');
      }
      for (final String key in kDocsContentHomeKeys) {
        final String value = docsHome(locale, key);
        expect(value, isNot(key), reason: 'missing home key "$key" for "$tag"');
        expect(value, isNotEmpty, reason: 'empty "$key" for "$tag"');
      }
      for (final String key in kDocsContentProseKeys1) {
        final String value = docsProse1(locale, key);
        expect(
          value,
          isNot(key),
          reason: 'missing prose1 key "$key" for "$tag"',
        );
        expect(value, isNotEmpty, reason: 'empty "$key" for "$tag"');
      }
      for (final String key in kDocsContentProseKeys2) {
        final String value = docsProse2(locale, key);
        expect(
          value,
          isNot(key),
          reason: 'missing prose2 key "$key" for "$tag"',
        );
        expect(value, isNotEmpty, reason: 'empty "$key" for "$tag"');
      }
    }
  });

  test('switching the locale changes the listed strings', () {
    const Locale en = Locale('en');
    const Locale de = Locale('de');
    final Locale zhHant = const Locale.fromSubtags(
      languageCode: 'zh',
      scriptCode: 'Hant',
    );
    const Locale ar = Locale('ar');

    // Categories.
    expect(docsCategoryName('Forms & Inputs', en), 'Forms & Inputs');
    expect(docsCategoryName('Forms & Inputs', de), isNot('Forms & Inputs'));
    expect(docsCategoryName('Data Display', zhHant), isNot('Data Display'));
    expect(docsCategoryName('Overlays', ar), isNot('Overlays'));

    // Block families (sidebar group labels).
    expect(docsBlockFamilyName('Authentication', en), 'Authentication');
    expect(docsBlockFamilyName('Authentication', de), isNot('Authentication'));
    expect(
      docsBlockFamilyName('Settings & Account', zhHant),
      isNot('Settings & Account'),
    );
    expect(docsBlockFamilyName('Sidebar', ar), isNot('Sidebar'));

    // Component descriptions (names stay English, descriptions translate).
    expect(
      docsComponentDescription('button', en),
      contains('Pressable action control'),
    );
    expect(
      docsComponentDescription('button', de),
      isNot(docsComponentDescription('button', en)),
    );
    expect(
      docsComponentDescription('button', zhHant),
      isNot(docsComponentDescription('button', en)),
    );
    expect(
      docsComponentDescription('button', ar),
      isNot(docsComponentDescription('button', en)),
    );

    // Page titles and descriptions.
    expect(docsContentPage(en, 'pageComponentsTitle'), 'Components');
    expect(docsContentPage(de, 'pageComponentsTitle'), isNot('Components'));
    expect(
      docsContentPage(zhHant, 'pageBlocksTitle'),
      isNot(docsContentPage(en, 'pageBlocksTitle')),
    );
    expect(
      docsContentPage(ar, 'pageFlowsTitle'),
      isNot(docsContentPage(en, 'pageFlowsTitle')),
    );

    // Home cards.
    expect(docsHome(en, 'homeCreateTitle'), 'Create Account');
    expect(docsHome(de, 'homeCreateTitle'), isNot('Create Account'));
    expect(
      docsHome(zhHant, 'homeWelcomeTitle'),
      isNot(docsHome(en, 'homeWelcomeTitle')),
    );

    // Prose.
    expect(docsProse1(en, 'proseIntroH1'), 'Source you own');
    expect(docsProse1(de, 'proseIntroH1'), isNot('Source you own'));
    expect(docsProse2(ar, 'proseDarkH1'), isNot(docsProse2(en, 'proseDarkH1')));
  });
}

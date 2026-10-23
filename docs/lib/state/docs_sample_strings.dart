// Sample-string lookup for component previews and home collage cards.
//
// The table itself is generated from docs/i18n/samples/*.json into
// `generated/docs_sample_table.dart` (run docs/tool/gen_sample_strings.dart).
// Keys are the English source text. A locale without a translation for a key
// falls back to the next related table (`zh` for `zh_Hans`), then to English,
// and never to another language's text.

import 'package:flutter/widgets.dart';

import '../generated/docs_sample_table.dart';
import '../routing/docs_router.dart';
import '../ui/dashcn/foundation/component_preview.dart';
import 'docs_strings.dart';

/// The active locale used when [docsSample] is called without a [BuildContext].
Locale currentDocsLocale = const Locale('en');

/// Updates the active sample-strings locale (called on website locale changes).
void setDocsSampleLocale(Locale locale) {
  currentDocsLocale = locale;
}

/// Installs the [docsSampleResolver] hook in the kit preview contract.
void installDocsSampleResolver() {
  docsSampleResolver = (BuildContext? context, String key) {
    Locale? locale;
    if (context != null) {
      try {
        locale =
            Localizations.maybeLocaleOf(context) ??
            DocsRouterScope.maybeOf(context)?.state.locale;
      } catch (_) {
        locale = null;
      }
    }
    locale ??= currentDocsLocale;
    return docsSampleString(locale, key);
  };
}

/// Resolves sample string [key] for [locale] (English fallback).
String docsSampleString(Locale locale, String key) {
  final String tag = docsLocaleTag(locale);
  final String? direct = docsSampleTable[tag]?[key];
  if (direct != null) {
    return direct;
  }
  // A regional or scripted variant (`pt_BR`, `zh_Hant`) may still have a
  // plain-language table only when it is the same script family; otherwise
  // the lookup goes straight to English. Never fall back to another script.
  if (locale.countryCode != null || locale.scriptCode != null) {
    final String? baseTag = _baseTagFor(locale);
    final String? baseValue = baseTag == null
        ? null
        : docsSampleTable[baseTag]?[key];
    if (baseValue != null) {
      return baseValue;
    }
  }
  return key;
}

/// The plain-language table a regional or scripted locale may fall back to.
///
/// `zh_Hans` and `zh_Hant` are different scripts, so neither falls back to the
/// other, and `zh` (no script) is Simplified-Chinese by convention and gets its
/// own table only when translated.
String? _baseTagFor(Locale locale) {
  if (locale.languageCode == 'zh') {
    return null;
  }
  return locale.languageCode;
}

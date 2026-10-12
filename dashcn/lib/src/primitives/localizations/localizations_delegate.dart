import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/widgets.dart';

import 'localizations_ar.dart';
import 'localizations_bg.dart';
import 'localizations_bn.dart';
import 'localizations_cs.dart';
import 'localizations_da.dart';
import 'localizations_de.dart';
import 'localizations_el.dart';
import 'localizations_es.dart';
import 'localizations_fa.dart';
import 'localizations_fi.dart';
import 'localizations_fil.dart';
import 'localizations_fr.dart';
import 'localizations_he.dart';
import 'localizations_hi.dart';
import 'localizations_hu.dart';
import 'localizations_id.dart';
import 'localizations_it.dart';
import 'localizations_ja.dart';
import 'localizations_ko.dart';
import 'localizations_mr.dart';
import 'localizations_ms.dart';
import 'localizations_nb.dart';
import 'localizations_nl.dart';
import 'localizations_pl.dart';
import 'localizations_ps.dart';
import 'localizations_pt.dart';
import 'localizations_ro.dart';
import 'localizations_ru.dart';
import 'localizations_sk.dart';
import 'localizations_sv.dart';
import 'localizations_ta.dart';
import 'localizations_te.dart';
import 'localizations_th.dart';
import 'localizations_tr.dart';
import 'localizations_uk.dart';
import 'localizations_ur.dart';
import 'localizations_vi.dart';
import 'localizations_zh.dart';
import 'localizations_zh_hant.dart';
import 'localizations.dart';

/// Loads [ComponentLocalizations] for every locale that ships translated data.
///
/// Matching is on the language code, so `de_AT` resolves to German and
/// `zh_TW` to the traditional-Chinese table.
class ComponentLocalizationsDelegate
    extends LocalizationsDelegate<ComponentLocalizations> {
  /// Creates the delegate.
  const ComponentLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ComponentLocalizations.supportedLocales
      .any((supported) => supported.languageCode == locale.languageCode);

  @override
  Future<ComponentLocalizations> load(Locale locale) =>
      SynchronousFuture<ComponentLocalizations>(
        lookupComponentLocalizations(locale),
      );

  @override
  bool shouldReload(ComponentLocalizationsDelegate old) => false;
}

/// Returns the translated [ComponentLocalizations] for [locale].
///
/// Locales without their own table fall back to the English defaults, so this
/// is total: it never throws.
ComponentLocalizations lookupComponentLocalizations(Locale locale) {
  switch (locale.languageCode) {
    case 'ar':
      return ComponentLocalizationsAr(locale);
    case 'bg':
      return ComponentLocalizationsBg(locale);
    case 'bn':
      return ComponentLocalizationsBn(locale);
    case 'cs':
      return ComponentLocalizationsCs(locale);
    case 'da':
      return ComponentLocalizationsDa(locale);
    case 'de':
      return ComponentLocalizationsDe(locale);
    case 'el':
      return ComponentLocalizationsEl(locale);
    case 'es':
      return ComponentLocalizationsEs(locale);
    case 'fa':
      return ComponentLocalizationsFa(locale);
    case 'fi':
      return ComponentLocalizationsFi(locale);
    case 'fil':
      return ComponentLocalizationsFil(locale);
    case 'fr':
      return ComponentLocalizationsFr(locale);
    case 'he':
      return ComponentLocalizationsHe(locale);
    case 'hi':
      return ComponentLocalizationsHi(locale);
    case 'hu':
      return ComponentLocalizationsHu(locale);
    case 'id':
      return ComponentLocalizationsId(locale);
    case 'it':
      return ComponentLocalizationsIt(locale);
    case 'ja':
      return ComponentLocalizationsJa(locale);
    case 'ko':
      return ComponentLocalizationsKo(locale);
    case 'mr':
      return ComponentLocalizationsMr(locale);
    case 'ms':
      return ComponentLocalizationsMs(locale);
    case 'nb':
      return ComponentLocalizationsNb(locale);
    case 'nl':
      return ComponentLocalizationsNl(locale);
    case 'pl':
      return ComponentLocalizationsPl(locale);
    case 'ps':
      return ComponentLocalizationsPs(locale);
    case 'pt':
      return ComponentLocalizationsPt(locale);
    case 'ro':
      return ComponentLocalizationsRo(locale);
    case 'ru':
      return ComponentLocalizationsRu(locale);
    case 'sk':
      return ComponentLocalizationsSk(locale);
    case 'sv':
      return ComponentLocalizationsSv(locale);
    case 'ta':
      return ComponentLocalizationsTa(locale);
    case 'te':
      return ComponentLocalizationsTe(locale);
    case 'th':
      return ComponentLocalizationsTh(locale);
    case 'tr':
      return ComponentLocalizationsTr(locale);
    case 'uk':
      return ComponentLocalizationsUk(locale);
    case 'ur':
      return ComponentLocalizationsUr(locale);
    case 'vi':
      return ComponentLocalizationsVi(locale);
    case 'zh':
      // Traditional first, then the regions that write in that script.
      if (locale.scriptCode == 'Hant' ||
          (locale.scriptCode == null &&
              (locale.countryCode == 'TW' ||
                  locale.countryCode == 'HK' ||
                  locale.countryCode == 'MO'))) {
        return ComponentLocalizationsZhHant(locale);
      }
      return ComponentLocalizationsZh(locale);
    default:
      return ComponentLocalizations(locale);
  }
}

---
title: "Class: ComponentLocalizations"
description: "Every user-facing string the registry components read."
---

```dart
/// Every user-facing string the registry components read.
///
/// One instance per locale, reached with [of]. The values here are the English
/// defaults, grouped by domain into the `localizations_<domain>.dart` mixins
/// this class applies; locales with translated data subclass it and override
/// what they translate (see [lookupComponentLocalizations]).
///
/// ```dart
/// Localizations.override(
///   context: context,
///   delegates: ComponentLocalizations.localizationsDelegates,
///   child: child,
/// );
/// Text(ComponentLocalizations.of(context).formLengthLessThan(4));
/// ```
class ComponentLocalizations with ComponentLocalizationsForm, ComponentLocalizationsOverlay, ComponentLocalizationsDateTime, ComponentLocalizationsFiles, ComponentLocalizationsMisc, ComponentLocalizationsError {
  const ComponentLocalizations(this.locale);
  /// The English defaults, for code that has no [BuildContext] to call [of]
  /// on.
  static const ComponentLocalizations english = ComponentLocalizations(Locale('en'));
  /// The locale these strings belong to.
  final Locale locale;
  /// [locale] in the form `intl` expects: `language[-COUNTRY][-SCRIPT]`.
  String get localeName;
  /// Loads [ComponentLocalizations] for [context]'s locale.
  ///
  /// Falls back to English when no delegate was installed.
  static ComponentLocalizations of(BuildContext context);
  /// Delegate to add to an app's `localizationsDelegates`.
  static const LocalizationsDelegate<ComponentLocalizations> delegate = ComponentLocalizationsDelegate();
  /// [delegate] on its own, ready to spread into `localizationsDelegates`.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[delegate];
  /// Locales this delegate can load; must match the app's `supportedLocales`.
  ///
  /// One entry per translated table, with [Locale('en')] first: English is the
  /// base fallback, so an unknown device locale resolves to English instead of
  /// the first translated table. Text direction is *not* handled here: Flutter
  /// resolves it from [WidgetsLocalizations] and [Directionality].
  static const List<Locale> supportedLocales = <Locale>[Locale('en'), Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'), Locale('ar'), Locale('bg'), Locale('bn'), Locale('cs'), Locale('da'), Locale('de'), Locale('el'), Locale('es'), Locale('fa'), Locale('fi'), Locale('fil'), Locale('fr'), Locale('he'), Locale('hi'), Locale('hu'), Locale('id'), Locale('it'), Locale('ja'), Locale('ko'), Locale('mr'), Locale('ms'), Locale('nb'), Locale('nl'), Locale('pl'), Locale('ps'), Locale('pt'), Locale('ro'), Locale('ru'), Locale('sk'), Locale('sv'), Locale('ta'), Locale('te'), Locale('th'), Locale('tr'), Locale('uk'), Locale('ur'), Locale('vi'), Locale('zh')];
  /// Resolves a device [locale] against [supported] (a `supportedLocales`
  /// list), matching by **language code first**, then refining by
  /// script/country:
  ///
  /// * `en_US`, `en_GB` → the `en` entry;
  /// * `de_AT` → the `de` entry;
  /// * `zh_Hant*` and `zh_TW`/`zh_HK`/`zh_MO` → the `zh_Hant` entry;
  /// * other `zh` regions (`zh_CN`, `zh_SG`, …) → the plain `zh` entry;
  /// * an unknown language (`sw`) → the first fallback entry (`en`).
  ///
  /// Use it as a `localeResolutionCallback` (the `app` component does) so a
  /// locale whose language is supported never loses to an earlier script or
  /// country entry.
  static Locale resolveLocale(Locale locale, Iterable<Locale> supported);
}
```

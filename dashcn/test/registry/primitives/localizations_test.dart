import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:dashcn/src/components/app/app.dart';
import 'package:dashcn/src/foundation/time_of_day.dart';
import 'package:dashcn/src/primitives/localizations/localizations.dart';
import 'package:dashcn/src/primitives/localizations/localizations_de.dart';
import 'package:dashcn/src/primitives/localizations/localizations_zh.dart';
import 'package:dashcn/src/primitives/localizations/localizations_zh_hant.dart';
import 'package:dashcn/src/primitives/localizations/locale_parts.dart';
import 'package:dashcn/src/primitives/localizations/localizations_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

/// Reads the localizations instance installed for [locale].
Future<ComponentLocalizations> loadFor(
  WidgetTester tester,
  Locale locale,
) async {
  late ComponentLocalizations result;
  await tester.pumpWidget(
    Localizations(
      locale: locale,
      // The Localizations widget insists on a WidgetsLocalizations delegate;
      // an app normally gets it from `WidgetsApp`/`MaterialApp`.
      delegates: <LocalizationsDelegate<dynamic>>[
        ...ComponentLocalizations.localizationsDelegates,
        GlobalWidgetsLocalizations.delegate,
      ],
      child: Builder(
        builder: (context) {
          result = ComponentLocalizations.of(context);
          return Directionality(
            textDirection: TextDirection.ltr,
            child: Text(result.commandEmpty),
          );
        },
      ),
    ),
  );
  return result;
}

void main() {
  group('delegate', () {
    test('supports exactly the locales it lists', () {
      const delegate = ComponentLocalizations.delegate;
      for (final locale in ComponentLocalizations.supportedLocales) {
        expect(delegate.isSupported(locale), isTrue, reason: '$locale');
      }
      expect(delegate.isSupported(const Locale('xx')), isFalse);
      // A regional variant of a supported language resolves too.
      expect(delegate.isSupported(const Locale('de', 'AT')), isTrue);
    });

    test('localizationsDelegates carries the delegate', () {
      expect(
        ComponentLocalizations.localizationsDelegates,
        contains(ComponentLocalizations.delegate),
      );
    });

    test('shouldReload is false, so strings are never rebuilt', () {
      const delegate = ComponentLocalizations.delegate;
      expect(delegate.shouldReload(delegate), isFalse);
    });

    testWidgets('loads English', (tester) async {
      final localizations = await loadFor(tester, const Locale('en'));

      expect(localizations, isNot(isA<ComponentLocalizationsDe>()));
      expect(localizations.commandEmpty, 'No results found');
      expect(
        localizations.formLengthLessThan(4),
        'Must be at least 4 characters.',
      );
      expect(localizations.getMonth(DateTime.march), 'March');
      expect(localizations.getAbbreviatedWeekday(DateTime.friday), 'Fri');
    });

    testWidgets('loads a second locale from its data file', (tester) async {
      final localizations = await loadFor(tester, const Locale('de'));

      expect(localizations, isA<ComponentLocalizationsDe>());
      expect(localizations.locale.languageCode, 'de');
      expect(localizations.commandEmpty, 'Keine Ergebnisse gefunden.');
      expect(localizations.monthMarch, 'März');
      expect(localizations.formNotEmpty, 'Dieses Feld darf nicht leer sein');
      // Flutter's own `modalBarrierDismissLabel` for German, so the dialog
      // barrier label is translated rather than the English fallback.
      expect(localizations.dialogDismiss, 'Schließen');
    });

    testWidgets('numbers inside messages follow the loaded locale', (
      tester,
    ) async {
      final english = await loadFor(tester, const Locale('en'));
      final german = await loadFor(tester, const Locale('de'));

      // German writes 1.234,5; English writes 1,234.5.
      expect(english.formLessThan(1234.5), 'Must be less than 1234.5.');
      expect(german.formLessThan(1234.5), 'Muss kleiner als 1.234,5 sein');
    });

    testWidgets('every supported locale loads a translated table', (
      tester,
    ) async {
      const delegate = ComponentLocalizations.delegate;
      expect(
        ComponentLocalizations.supportedLocales.length,
        42,
        reason: 'one table per shipped locale, plus the English fallback',
      );

      final seen = <String>{};
      for (final locale in ComponentLocalizations.supportedLocales) {
        expect(delegate.isSupported(locale), isTrue, reason: '$locale');

        final loaded = await loadFor(tester, locale);
        expect(loaded.locale.languageCode, locale.languageCode);
        expect(loaded.commandEmpty, isNotEmpty, reason: '$locale');
        // Every table overrides the whole English surface: nothing may silently
        // fall back, and no override may be an empty string.
        expect(loaded.monthJanuary, isNotEmpty, reason: '$locale');
        expect(loaded.formNotEmpty, isNotEmpty, reason: '$locale');
        expect(loaded.buttonCancel, isNotEmpty, reason: '$locale');
        expect(loaded.timeDaysAbbreviation, isNotEmpty, reason: '$locale');
        // The parameterized messages must interpolate, not throw. The digits
        // are the locale's own - bn renders 1 with a Bengali digit - so compare
        // two inputs rather than hunting for ASCII digits.
        expect(
          loaded.formBetweenInclusively(1, 2),
          isNot(loaded.formBetweenInclusively(9, 10)),
          reason: '$locale must interpolate its arguments',
        );
        expect(loaded.formLengthLessThan(3), isNotEmpty);

        seen.add(loaded.runtimeType.toString());
      }
      expect(
        seen.length,
        ComponentLocalizations.supportedLocales.length,
        reason: 'each locale resolves to its own class, no two share one',
      );
    });

    test('regional variants resolve to their language table', () {
      const delegate = ComponentLocalizations.delegate;
      expect(delegate.isSupported(const Locale('de', 'AT')), isTrue);

      expect(
        lookupComponentLocalizations(const Locale('de', 'AT')),
        isA<ComponentLocalizationsDe>(),
      );
      expect(
        lookupComponentLocalizations(const Locale('en')),
        isNot(
          isA<Object>().having(
            (type) => type,
            'type',
            isA<ComponentLocalizationsDe>(),
          ),
        ),
      );
    });

    test('zh picks the table that matches the script and region', () {
      expect(
        lookupComponentLocalizations(const Locale('zh')).runtimeType,
        ComponentLocalizationsZh().runtimeType,
      );
      expect(
        lookupComponentLocalizations(
          Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
        ).runtimeType,
        ComponentLocalizationsZhHant().runtimeType,
      );
      for (final country in ['TW', 'HK', 'MO']) {
        expect(
          lookupComponentLocalizations(Locale('zh', country)).runtimeType,
          ComponentLocalizationsZhHant().runtimeType,
          reason: country,
        );
      }
      expect(
        lookupComponentLocalizations(const Locale('zh', 'CN')).runtimeType,
        ComponentLocalizationsZh().runtimeType,
      );
    });

    test('an unknown language falls back to English instead of throwing', () {
      final fallback = lookupComponentLocalizations(const Locale('xx'));
      expect(fallback, isA<ComponentLocalizations>());
      expect(fallback.commandEmpty, 'No results found');
    });

    group('odd browser locales fall back to English (P9-Z)', () {
      // Only well-formed-enough tags reach Dart as Locale objects: '' fails
      // the `Locale` assert and null never becomes an object, so those two
      // are repaired one layer down by the docs `index.html` shim (which the
      // P9-Z Playwright repro covers). Everything constructible here must
      // resolve without throwing.
      const List<Locale> odd = <Locale>[
        Locale('C'),
        Locale.fromSubtags(languageCode: 'xx', countryCode: 'YY'),
      ];

      test('none is claimed as supported', () {
        const delegate = ComponentLocalizations.delegate;
        for (final Locale locale in odd) {
          expect(delegate.isSupported(locale), isFalse, reason: '$locale');
        }
      });

      test('resolveLocale maps each one to English', () {
        for (final Locale locale in odd) {
          expect(
            ComponentLocalizations.resolveLocale(
              locale,
              ComponentLocalizations.supportedLocales,
            ),
            const Locale('en'),
            reason: '$locale',
          );
        }
      });

      test('lookup returns English defaults without throwing', () {
        for (final Locale locale in odd) {
          final ComponentLocalizations strings = lookupComponentLocalizations(
            locale,
          );
          expect(strings.runtimeType, ComponentLocalizations);
          expect(strings.commandEmpty, 'No results found');
        }
      });

      testWidgets('DashcnApp with an odd locale shows English', (tester) async {
        // The app's `localeResolutionCallback` maps odd tags to `en`
        // before any delegate loads, so `GlobalWidgetsLocalizations`
        // never sees them either.
        for (final Locale locale in odd) {
          late ComponentLocalizations strings;
          await tester.pumpWidget(
            DashcnApp(
              locale: locale,
              home: Builder(
                builder: (BuildContext context) {
                  strings = ComponentLocalizations.of(context);
                  return const SizedBox.shrink();
                },
              ),
            ),
          );
          // P7I-fix-focus2: `DashcnApp` builds its content one frame
          // after startup.
          await tester.pump();
          expect(strings.commandEmpty, 'No results found', reason: '$locale');
          expect(tester.takeException(), isNull, reason: '$locale');
        }
      });

      testWidgets('no explicit locale (null) resolves to English', (
        tester,
      ) async {
        // A null device locale lets the framework fall back to the first
        // supported locale, which must stay English for the kit to load it.
        expect(
          ComponentLocalizations.supportedLocales.first,
          const Locale('en'),
        );
        late ComponentLocalizations strings;
        await tester.pumpWidget(
          Localizations(
            locale: ComponentLocalizations.supportedLocales.first,
            delegates: <LocalizationsDelegate<dynamic>>[
              ...ComponentLocalizations.localizationsDelegates,
              GlobalWidgetsLocalizations.delegate,
            ],
            child: Builder(
              builder: (BuildContext context) {
                strings = ComponentLocalizations.of(context);
                return const SizedBox.shrink();
              },
            ),
          ),
        );
        expect(strings.locale, const Locale('en'));
        expect(strings.commandEmpty, 'No results found');
        expect(tester.takeException(), isNull);
      });
    });

    testWidgets('falls back to English without a delegate', (tester) async {
      late ComponentLocalizations localizations;
      await tester.pumpWidget(
        Builder(
          builder: (context) {
            localizations = ComponentLocalizations.of(context);
            return const SizedBox.shrink();
          },
        ),
      );

      expect(localizations.locale, const Locale('en'));
      expect(localizations.commandEmpty, 'No results found');
    });
  });

  group('localeName', () {
    test('is the canonicalized locale string', () {
      expect(const ComponentLocalizations(Locale('en')).localeName, 'en');
      expect(
        const ComponentLocalizations(Locale('de', 'AT')).localeName,
        'de_AT',
      );
    });
  });

  group('extensions', () {
    const english = ComponentLocalizations(Locale('en'));

    test('formatNumber drops the decimal point for whole numbers', () {
      expect(english.formatNumber(1500), '1500');
      expect(english.formatNumber(1500.0), '1500');
      expect(english.formatNumber(1.5), '1.5');
      expect(english.formatNumber(-3), '-3');
    });

    test('formatDateTime renders date and time', () {
      final dateTime = DateTime(2026, 3, 9, 14, 5, 7);

      expect(
        english.formatDateTime(dateTime),
        'March 9, 2026 14:5',
        reason: 'no zero padding, as in the old implementation',
      );
      expect(
        english.formatDateTime(dateTime, showSeconds: true),
        'March 9, 2026 14:5:7',
      );
      expect(
        english.formatDateTime(dateTime, showTime: false),
        'March 9, 2026',
      );
      expect(english.formatDateTime(dateTime, showDate: false), '14:5');
    });

    test('formatDateTime switches to 12-hour on request', () {
      final afternoon = DateTime(2026, 3, 9, 14, 5);
      final morning = DateTime(2026, 3, 9, 9, 5);

      expect(
        english.formatDateTime(
          afternoon,
          showDate: false,
          use24HourFormat: false,
        ),
        '2:5 PM',
      );
      expect(
        english.formatDateTime(
          morning,
          showDate: false,
          use24HourFormat: false,
        ),
        '9:5 AM',
      );
    });

    test('formatTimeOfDay zero-pads and honours the clock convention', () {
      const time = TimeOfDay(hour: 9, minute: 5, second: 7);

      expect(english.formatTimeOfDay(time), '09:05');
      expect(english.formatTimeOfDay(time, showSeconds: true), '09:05:07');
      expect(english.formatTimeOfDay(time, use24HourFormat: false), '9:05 AM');
      expect(
        english.formatTimeOfDay(
          time,
          use24HourFormat: false,
          showSeconds: true,
        ),
        '9:05:07 AM',
      );
    });

    test('formatTimeOfDay converts to 12-hour clock', () {
      expect(
        english.formatTimeOfDay(
          const TimeOfDay(hour: 18, minute: 45),
          use24HourFormat: false,
        ),
        '6:45 PM',
      );
      expect(
        english.formatTimeOfDay(
          const TimeOfDay(hour: 0, minute: 0),
          use24HourFormat: false,
        ),
        '12:00 AM',
        reason: 'midnight is 12:00 AM',
      );
      expect(
        english.formatTimeOfDay(
          const TimeOfDay(hour: 12, minute: 0),
          use24HourFormat: false,
        ),
        '12:00 PM',
        reason: 'noon is 12:00 PM',
      );
      expect(
        english.formatTimeOfDay(
          const TimeOfDay(hour: 12, minute: 0),
          use24HourFormat: false,
          showSeconds: true,
        ),
        '12:00:00 PM',
      );
      expect(
        english.formatTimeOfDay(const TimeOfDay(hour: 18, minute: 45)),
        '18:45',
      );
    });

    test('formatDuration joins the non-zero components', () {
      expect(
        english.formatDuration(const Duration(hours: 2, minutes: 30)),
        '2h 30m',
      );
      expect(
        english.formatDuration(
          const Duration(days: 1, hours: 2, minutes: 3, seconds: 4),
        ),
        '1d 2h 3m 4s',
      );
      expect(english.formatDuration(Duration.zero), '');
    });

    test('formatDuration honours the per-component flags', () {
      const duration = Duration(days: 1, hours: 2, minutes: 3, seconds: 4);
      expect(english.formatDuration(duration, showDays: false), '2h 3m 4s');
      expect(
        english.formatDuration(duration, showDays: false, showHours: false),
        '3m 4s',
      );
      expect(english.formatDuration(duration, showSeconds: false), '1d 2h 3m');
    });

    test('date component abbreviations are exposed', () {
      expect(english.dateYearAbbreviation, 'YYYY');
      expect(english.dateMonthAbbreviation, 'MM');
      expect(english.dateDayAbbreviation, 'DD');
    });

    test('datePartsOrder defaults to month, day, year', () {
      expect(english.datePartsOrder, const [
        DatePart.month,
        DatePart.day,
        DatePart.year,
      ]);
    });

    test('getDatePartAbbreviation maps every date part', () {
      expect(
        english.getDatePartAbbreviation(DatePart.year),
        english.dateYearAbbreviation,
      );
      expect(
        english.getDatePartAbbreviation(DatePart.month),
        english.dateMonthAbbreviation,
      );
      expect(
        english.getDatePartAbbreviation(DatePart.day),
        english.dateDayAbbreviation,
      );
    });

    test('getTimePartAbbreviation reads the clock placeholders', () {
      expect(english.getTimePartAbbreviation(TimePart.hour), 'HH');
      expect(english.getTimePartAbbreviation(TimePart.minute), 'MM');
      expect(english.getTimePartAbbreviation(TimePart.second), 'SS');
    });

    test('getDurationPartAbbreviation maps every duration part', () {
      expect(english.getDurationPartAbbreviation(DurationPart.day), 'DD');
      expect(english.getDurationPartAbbreviation(DurationPart.hour), 'HH');
      expect(english.getDurationPartAbbreviation(DurationPart.minute), 'MM');
      expect(english.getDurationPartAbbreviation(DurationPart.second), 'SS');
    });

    test('the placeholders come from the locale, not hard-coded English', () {
      const german = ComponentLocalizationsDe(Locale('de'));
      expect(german.getTimePartAbbreviation(TimePart.hour), 'SS');
      expect(german.timeDaysAbbreviation, 'TT');
      expect(
        german.getDurationPartAbbreviation(DurationPart.day),
        german.timeDaysAbbreviation,
      );
    });

    test('every part enum case is covered by its abbreviation mapping', () {
      for (final part in DatePart.values) {
        expect(english.getDatePartAbbreviation(part), isNotEmpty);
      }
      for (final part in TimePart.values) {
        expect(english.getTimePartAbbreviation(part), isNotEmpty);
      }
      for (final part in DurationPart.values) {
        expect(english.getDurationPartAbbreviation(part), isNotEmpty);
      }
    });
  });

  group('resolveLocale', () {
    Locale resolve(String language, [String? country, String? script]) {
      return ComponentLocalizations.resolveLocale(
        Locale.fromSubtags(
          languageCode: language,
          countryCode: country,
          scriptCode: script,
        ),
        ComponentLocalizations.supportedLocales,
      );
    }

    test('en is the first entry and a supported fallback', () {
      expect(ComponentLocalizations.supportedLocales.first, const Locale('en'));
      expect(
        ComponentLocalizations.delegate.isSupported(const Locale('en')),
        isTrue,
      );
    });

    test('en_US and en_GB resolve to the English entry', () {
      expect(resolve('en', 'US'), const Locale('en'));
      expect(resolve('en', 'GB'), const Locale('en'));
    });

    test('de_AT resolves by language code', () {
      expect(resolve('de', 'AT'), const Locale('de'));
    });

    test('zh_TW / zh_HK / zh_MO / zh_Hant resolve to the Hant entry', () {
      const Locale hant = Locale.fromSubtags(
        languageCode: 'zh',
        scriptCode: 'Hant',
      );
      expect(resolve('zh', 'TW'), hant);
      expect(resolve('zh', 'HK'), hant);
      expect(resolve('zh', 'MO'), hant);
      expect(resolve('zh', null, 'Hant'), hant);
    });

    test('zh_CN and zh_SG resolve to simplified zh', () {
      expect(resolve('zh', 'CN'), const Locale('zh'));
      expect(resolve('zh', 'SG'), const Locale('zh'));
    });

    test('an unknown language falls back to the first entry (en)', () {
      expect(resolve('sw'), const Locale('en'));
    });

    test('lookup picks the table from the resolved locale', () {
      expect(
        lookupComponentLocalizations(resolve('zh', 'TW')),
        isA<ComponentLocalizationsZhHant>(),
      );
      expect(
        lookupComponentLocalizations(resolve('zh', 'CN')),
        isA<ComponentLocalizationsZh>(),
      );
    });
  });
}

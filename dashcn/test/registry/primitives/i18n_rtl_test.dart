// Widget tests for the kit's bidirectional support: the locale implies its
// text direction, directional icons mirror in RTL, numbers stay LTR, and the
// 375 pt phone width neither overflows nor mis-points chevrons.

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/app/app.dart';
import 'package:dashcn/src/components/button/button.dart';
import 'package:dashcn/src/components/date_picker/date_picker.dart';
import 'package:dashcn/src/components/dialog/dialog.dart' as dashcn_dialog;
import 'package:dashcn/src/components/pagination/pagination.dart';
import 'package:dashcn/src/foundation/icons/lucide_icons.dart';
import 'package:dashcn/src/primitives/localizations/localizations.dart';
import 'package:flutter_test/flutter_test.dart';

/// Opens a dialog whose card holds a date picker and localized actions.
Future<void> _openDateDialog(BuildContext context) {
  return dashcn_dialog.showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      final ComponentLocalizations strings = ComponentLocalizations.of(context);
      return Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DatePicker(value: DateTime(2026, 5, 4), onChanged: (_) {}),
            const SizedBox(height: 12),
            // Kit dialog actions wrap (see the dialog preview pattern) so
            // long translations reflow instead of overflowing a 375 pt card.
            Wrap(
              alignment: WrapAlignment.end,
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                Button(
                  variant: ButtonVariant.ghost,
                  onPressed: () => Navigator.pop(context),
                  child: Text(strings.buttonCancel),
                ),
                Button(
                  onPressed: () => Navigator.pop(context),
                  child: Text(strings.buttonSave),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

/// Phone-width fixture: pagination, a date picker and an opener for a dialog
/// that itself holds a date picker.
class _I18nFixture extends StatelessWidget {
  const _I18nFixture();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Pagination(page: 2, totalPages: 20, onPageChanged: (_) {}),
        DatePicker(value: DateTime(2026, 5, 4), onChanged: (_) {}),
        Button(
          onPressed: () => _openDateDialog(context),
          child: const Text('open'),
        ),
      ],
    );
  }
}

Future<void> _pumpPhone(
  WidgetTester tester,
  Locale locale, {
  bool openDialog = false,
}) async {
  tester.view.physicalSize = const Size(1125, 2436);
  tester.view.devicePixelRatio = 3.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(
    DashcnApp(locale: locale, home: const _I18nFixture()),
  );
  await tester.pumpAndSettle();
  if (openDialog) {
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
  }
  expect(tester.takeException(), isNull);
}

/// The chevron rendered inside the button carrying [semanticsLabel].
IconData _buttonChevron(WidgetTester tester, String semanticsLabel) {
  final Finder label = find.bySemanticsLabel(semanticsLabel);
  expect(label, findsOneWidget, reason: semanticsLabel);
  final Finder icon = find.descendant(of: label, matching: find.byType(Icon));
  expect(icon, findsOneWidget, reason: semanticsLabel);
  return tester.widget<Icon>(icon).icon!;
}

void main() {
  group('locale implies text direction', () {
    test('RTL languages', () {
      for (final String code in <String>['ar', 'he', 'fa', 'ur']) {
        expect(isRtlLocale(Locale(code)), isTrue, reason: code);
        expect(
          textDirectionForLocale(Locale(code)),
          TextDirection.rtl,
          reason: code,
        );
      }
      // Regional variants stay RTL: only the language code matters.
      expect(isRtlLocale(const Locale('ar', 'EG')), isTrue);
    });

    test('LTR languages', () {
      for (final String code in <String>[
        'en',
        'de',
        'fr',
        'es',
        'it',
        'pt',
        'nl',
        'ru',
        'tr',
        'ja',
        'ko',
        'zh',
        'hi',
      ]) {
        expect(isRtlLocale(Locale(code)), isFalse, reason: code);
        expect(
          textDirectionForLocale(Locale(code)),
          TextDirection.ltr,
          reason: code,
        );
      }
    });
  });

  group('DashcnLocalizations lookup', () {
    testWidgets('is the component lookup with an English fallback', (
      tester,
    ) async {
      late ComponentLocalizations viaAlias;
      late ComponentLocalizations viaClass;
      await tester.pumpWidget(
        Builder(
          builder: (BuildContext context) {
            viaAlias = DashcnLocalizations.of(context);
            viaClass = ComponentLocalizations.of(context);
            return const SizedBox.shrink();
          },
        ),
      );
      expect(viaAlias.commandEmpty, 'No results found');
      expect(identical(viaAlias, viaClass), isTrue);
      expect(DashcnLocalizations.english.commandEmpty, 'No results found');
    });

    testWidgets('DashcnLocaleOverride re-strings one subtree', (tester) async {
      late String outer;
      late String inner;
      late TextDirection innerDirection;
      await tester.pumpWidget(
        DashcnApp(
          locale: const Locale('en'),
          home: Builder(
            builder: (BuildContext context) {
              outer = ComponentLocalizations.of(context).commandEmpty;
              return DashcnLocaleOverride(
                locale: const Locale('ar'),
                child: Builder(
                  builder: (BuildContext context) {
                    inner = ComponentLocalizations.of(context).commandEmpty;
                    innerDirection = Directionality.of(context);
                    return const SizedBox.shrink();
                  },
                ),
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(outer, 'No results found');
      expect(inner, 'لا توجد نتائج.');
      expect(innerDirection, TextDirection.rtl);
      expect(tester.takeException(), isNull);
    });

    testWidgets('DashcnLtr keeps numbers LTR inside RTL', (tester) async {
      late TextDirection seen;
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.rtl,
          child: DashcnLtr(
            child: Builder(
              builder: (BuildContext context) {
                seen = Directionality.of(context);
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
      expect(seen, TextDirection.ltr);
    });
  });

  group('DashcnDirectionalIcon mirrors', () {
    Future<IconData> pumpIcon(
      WidgetTester tester,
      TextDirection direction,
      bool forward,
    ) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: direction,
          child: forward
              ? const DashcnDirectionalIcon.forward(
                  left: LucideIcons.chevronLeft,
                  right: LucideIcons.chevronRight,
                )
              : const DashcnDirectionalIcon.backward(
                  left: LucideIcons.chevronLeft,
                  right: LucideIcons.chevronRight,
                ),
        ),
      );
      return tester.widget<Icon>(find.byType(Icon)).icon!;
    }

    testWidgets('forward points with the reading direction', (tester) async {
      expect(
        await pumpIcon(tester, TextDirection.ltr, true),
        LucideIcons.chevronRight,
      );
      expect(
        await pumpIcon(tester, TextDirection.rtl, true),
        LucideIcons.chevronLeft,
      );
      expect(
        await pumpIcon(tester, TextDirection.ltr, false),
        LucideIcons.chevronLeft,
      );
      expect(
        await pumpIcon(tester, TextDirection.rtl, false),
        LucideIcons.chevronRight,
      );
    });
  });

  group('pt-BR and zh-Hans resolve to their tables', () {
    test('lookup', () {
      expect(
        lookupComponentLocalizations(
          const Locale('pt', 'BR'),
        ).locale.languageCode,
        'pt',
      );
      expect(
        lookupComponentLocalizations(
          Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
        ).locale.languageCode,
        'zh',
      );
    });

    test('resolveLocale', () {
      expect(
        ComponentLocalizations.resolveLocale(
          const Locale('pt', 'BR'),
          ComponentLocalizations.supportedLocales,
        ),
        const Locale('pt', 'BR'),
      );
      expect(
        ComponentLocalizations.resolveLocale(
          Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
          ComponentLocalizations.supportedLocales,
        ),
        Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
      );
    });
  });

  group('375 pt phone width: no overflow, mirrored chevrons', () {
    testWidgets('en: LTR, chevron points left on Previous', (tester) async {
      await _pumpPhone(tester, const Locale('en'), openDialog: true);
      expect(_buttonChevron(tester, 'Previous'), LucideIcons.chevronLeft);
      expect(_buttonChevron(tester, 'Next'), LucideIcons.chevronRight);
    });

    testWidgets('ar: RTL, chevron mirrors on Previous', (tester) async {
      await _pumpPhone(tester, const Locale('ar'), openDialog: true);
      expect(
        find.byWidgetPredicate(
          (Widget w) =>
              w is Directionality && w.textDirection == TextDirection.rtl,
        ),
        findsWidgets,
      );
      expect(
        _buttonChevron(tester, 'السابق'),
        LucideIcons.chevronRight,
        reason: 'Previous mirrors in RTL',
      );
      expect(
        _buttonChevron(tester, 'التالي'),
        LucideIcons.chevronLeft,
        reason: 'Next mirrors in RTL',
      );
    });

    testWidgets('de: long strings fit with date picker and dialog open', (
      tester,
    ) async {
      await _pumpPhone(tester, const Locale('de'), openDialog: true);
      // The German dialog actions and date trigger render translated.
      expect(find.text('Abbrechen'), findsWidgets);
      expect(find.text('Speichern'), findsWidgets);
    });
  });
}

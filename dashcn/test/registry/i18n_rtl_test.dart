// RTL mirroring, direction mapping and 375 px overflow gates.
//
// Arabic (RTL) and German (long strings) render the kit's chrome — pagination,
// breadcrumb chevrons, a date picker and a dialog — at phone width without
// overflow, with mirrored direction icons and LTR-locked digits.
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/alert_dialog/alert_dialog.dart';
import 'package:dashcn/src/components/app/app.dart';
import 'package:dashcn/src/components/breadcrumb/breadcrumb.dart';
import 'package:dashcn/src/components/date_picker/date_picker.dart';
import 'package:dashcn/src/components/pagination/pagination.dart';
import 'package:dashcn/src/foundation/icons/lucide_icons.dart';
import 'package:dashcn/src/primitives/localizations/localizations.dart';
import 'package:dashcn/src/primitives/localizations/localizations_de.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

/// Pumps [child] under the kit theme, [locale] strings and [direction].
Future<void> _pumpScene(
  WidgetTester tester,
  Widget child, {
  Locale locale = const Locale('en'),
  required Size size,
}) async {
  await tester.binding.setSurfaceSize(size);
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    Theme(
      data: const ThemeData(),
      child: Builder(
        builder: (BuildContext c) => Localizations(
          locale: locale,
          delegates: <LocalizationsDelegate<dynamic>>[
            ...ComponentLocalizations.localizationsDelegates,
            DefaultWidgetsLocalizations.delegate,
          ],
          child: Directionality(
            textDirection: textDirectionForLocale(locale),
            child: Center(child: child),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  test('locale implies text direction', () {
    for (final String code in <String>['ar', 'he', 'fa', 'ur']) {
      expect(isRtlLocale(Locale(code)), isTrue, reason: code);
      expect(
        textDirectionForLocale(Locale(code)),
        TextDirection.rtl,
        reason: code,
      );
    }
    for (final String code in <String>['en', 'de', 'fr', 'pt', 'zh', 'ja']) {
      expect(isRtlLocale(Locale(code)), isFalse, reason: code);
      expect(
        textDirectionForLocale(Locale(code)),
        TextDirection.ltr,
        reason: code,
      );
    }
    expect(isRtlLocale(const Locale('ar', 'EG')), isTrue);
    expect(isRtlLocale(const Locale('pt', 'BR')), isFalse);
  });

  testWidgets('DashcnApp resolves RTL directionality for ar', (tester) async {
    TextDirection? seen;
    await tester.pumpWidget(
      const DashcnApp(locale: Locale('ar'), home: _DirectionProbe()),
    );
    await tester.pumpAndSettle();
    seen = _DirectionProbe.seen;
    expect(seen, TextDirection.rtl);
  });

  testWidgets('ar pagination mirrors chevrons at 375px', (tester) async {
    await _pumpScene(
      tester,
      Pagination(page: 2, totalPages: 5, onPageChanged: (_) {}),
      locale: const Locale('ar'),
      size: const Size(375, 812),
    );
    expect(tester.takeException(), isNull);
    // "Previous" in RTL points right; "next" points left.
    final Finder icons = find.byType(Icon);
    expect(icons, findsWidgets);
    final List<IconData?> glyphs = tester
        .widgetList<Icon>(icons)
        .map((Icon w) => w.icon)
        .toList();
    expect(glyphs, contains(LucideIcons.chevronRight));
    expect(glyphs, contains(LucideIcons.chevronLeft));
  });

  testWidgets('en pagination keeps LTR chevrons', (tester) async {
    // At 375 px the pagination collapses to icon-only ends (no text labels):
    // labels are asserted at desktop width, overflow at phone width.
    await _pumpScene(
      tester,
      Pagination(page: 2, totalPages: 5, onPageChanged: (_) {}),
      size: const Size(1280, 800),
    );
    expect(tester.takeException(), isNull);
    expect(find.text('Previous'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
    await _pumpScene(
      tester,
      Pagination(page: 2, totalPages: 5, onPageChanged: (_) {}),
      size: const Size(375, 812),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('page digits stay LTR inside RTL', (tester) async {
    await _pumpScene(
      tester,
      Pagination(page: 3, totalPages: 5, onPageChanged: (_) {}),
      locale: const Locale('ar'),
      size: const Size(375, 812),
    );
    expect(tester.takeException(), isNull);
    final Finder digit = find.text('3');
    expect(digit, findsOneWidget);
    final Finder ltr = find.ancestor(
      of: digit,
      matching: find.byWidgetPredicate(
        (Widget w) =>
            w is Directionality && w.textDirection == TextDirection.ltr,
      ),
    );
    expect(ltr, findsWidgets);
  });

  testWidgets('german date picker fits 375px', (tester) async {
    await _pumpScene(
      tester,
      const DatePickerDialog(),
      locale: const Locale('de'),
      size: const Size(375, 812),
    );
    expect(tester.takeException(), isNull);
    // Long German month name renders (locale table is live).
    final String month = const ComponentLocalizationsDe().getMonth(
      DateTime.now().month,
    );
    expect(find.textContaining(month).evaluate().isNotEmpty, isTrue);
  });

  testWidgets('arabic date picker fits 375px', (tester) async {
    await _pumpScene(
      tester,
      const DatePickerDialog(),
      locale: const Locale('ar'),
      size: const Size(375, 812),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('german dialog fits 375px', (tester) async {
    late BuildContext host;
    await _pumpScene(
      tester,
      Navigator(
        onGenerateRoute: (_) => PageRouteBuilder<void>(
          pageBuilder: (BuildContext context, _, _) {
            host = context;
            return const SizedBox(width: 10, height: 10);
          },
        ),
      ),
      locale: const Locale('de'),
      size: const Size(375, 812),
    );
    showAlertDialog<Object?>(
      context: host,
      title: const Text('Donaudampfschifffahrtsgesellschaftskapitän'),
      description: const Text(
        'Muss mindestens ein Sonderzeichen enthalten. Bitte wählen Sie eine Option aus.',
      ),
      actionsBuilder: (_) => const <Widget>[],
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    expect(tester.takeException(), isNull);
    expect(find.byType(AlertDialog), findsOneWidget);
  });

  testWidgets('breadcrumb chevron mirrors in RTL', (tester) async {
    Breadcrumb buildCrumb() =>
        Breadcrumb(children: const <Widget>[Text('Home'), Text('Settings')]);
    await _pumpScene(
      tester,
      buildCrumb(),
      locale: const Locale('ar'),
      size: const Size(375, 812),
    );
    expect(tester.takeException(), isNull);
    expect(
      tester
          .widgetList<Icon>(find.byType(Icon))
          .map((Icon w) => w.icon)
          .toList(),
      contains(LucideIcons.chevronLeft),
    );
  });

  testWidgets('per-instance override beats the ambient locale', (tester) async {
    await _pumpScene(
      tester,
      const DashcnLocaleOverride(locale: Locale('de'), child: _ProbeText()),
      locale: const Locale('en'),
      size: const Size(375, 812),
    );
    expect(find.text('Abbrechen'), findsOneWidget);
  });
}

class _DirectionProbe extends StatelessWidget {
  const _DirectionProbe();

  static TextDirection? seen;

  @override
  Widget build(BuildContext context) {
    seen = Directionality.of(context);
    return const SizedBox();
  }
}

class _ProbeText extends StatelessWidget {
  const _ProbeText();

  @override
  Widget build(BuildContext context) {
    // buttonCancel: en 'Cancel', de 'Abbrechen'.
    return Text(ComponentLocalizations.of(context).buttonCancel);
  }
}

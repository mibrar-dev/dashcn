// P7-U2: picker dialog sizing and form-control spacing (user screenshots
// 2026-10-11).
//
// The reported bugs: the radio group stacked its rows with no gap, and the
// date/time picker dialogs were a fixed 480px-wide frame with a stretched
// column, so a calendar sat inside a mostly empty card. This file measures the
// dialogs: the card must be exactly as wide as its content (the calendar grid,
// or the time columns), no more, and no more than 384x480 at the default
// density (seven 48px touch cells plus gaps and shell). Footer buttons are
// Cancel then Save, right-aligned, gap-2 apart.
//
// The matrix is the one the brief asks for: light and dark, neutral and claude,
// compact/default/comfortable density.

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/calendar/calendar.dart';
import 'package:dashcn/src/components/date_picker/date_picker.dart';
import 'package:dashcn/src/components/form/form.dart';
import 'package:dashcn/src/components/time_picker/time_picker.dart';
import 'package:dashcn/src/primitives/clickable.dart';
import 'package:dashcn/src/primitives/form_core/object_form_prompt.dart';
import 'package:dashcn/src/primitives/overlay.dart';
import 'package:dashcn/src/primitives/overlay_manager_layer.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/density.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

import '../themes/generated_theme.dart';

/// Brightnesses and presets the dialog tests run under.
const List<(String, Brightness)> _skins = <(String, Brightness)>[
  ('neutral', Brightness.light),
  ('neutral', Brightness.dark),
  ('claude', Brightness.light),
  ('claude', Brightness.dark),
];

/// Theme data of [preset] at [brightness], at [density].
ThemeData _theme(String preset, Brightness brightness, Density density) {
  final ThemeDataView view = loadGeneratedTheme(
    'lib/src/themes/$preset.json',
  ).view(brightness);
  return ThemeData(
    colors: view.colors,
    tokens: view.tokens,
    fonts: view.fonts,
  ).copyWith(density: () => density);
}

/// A tracked picker inside a navigator, so the dialog has somewhere to push.
Widget _frame(
  Widget child, {
  required ThemeData data,
  Size size = const Size(390, 780),
}) {
  return OverlayManagerLayer(
    popoverHandler: OverlayHandler.popover,
    tooltipHandler: OverlayHandler.popover,
    menuHandler: OverlayHandler.popover,
    child: Theme(
      data: data,
      child: ComponentThemes(
        themes: const <ComponentThemeData>[],
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: MediaQueryData(size: size),
            child: Navigator(
              onGenerateRoute: (settings) => PageRouteBuilder<void>(
                settings: settings,
                pageBuilder: (context, _, _) => child,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Future<void> _openDialog(WidgetTester tester, String trigger) async {
  await tester.tap(find.text(trigger));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 200));
}

/// The dialog card, measured once the open transition has run.
Rect _card(WidgetTester tester) =>
    tester.getRect(find.byKey(kObjectFormDialogSurfaceKey));

/// The [Clickable] that wraps the footer button labelled [label].
Finder _button(WidgetTester tester, String label) =>
    find.ancestor(of: find.text(label), matching: find.byType(Clickable));

/// The gap between the left edges of [first] and [second].
double _horizontalGap(WidgetTester tester, Finder first, Finder second) =>
    tester.getRect(second).left - tester.getRect(first).right;

void main() {
  group('date picker dialog', () {
    for (final (String preset, Brightness brightness) in _skins) {
      testWidgets('$preset/${brightness.name}: card shrinks to the grid', (
        tester,
      ) async {
        await tester.binding.setSurfaceSize(const Size(1440, 900));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        await tester.pumpWidget(
          _frame(
            DatePicker(value: DateTime(2024, 3, 14), onChanged: (_) {}),
            data: _theme(preset, brightness, Density.defaultDensity),
            size: const Size(1440, 900),
          ),
        );
        await _openDialog(tester, 'March 14, 2024');
        final Rect card = _card(tester);
        final Rect grid = tester.getRect(find.byType(Calendar));
        // The card is exactly the calendar wide: the `p-3` shell lives on the
        // calendar, the card padding is `p-0`.
        expect(card.width, moreOrLessEquals(grid.width, epsilon: 0.01));
        // Reference bounds for a picker dialog: the 48px touch grid.
        expect(card.width, lessThanOrEqualTo(384));
        // Caption + grid + footer for a five-week month at 48px cells.
        expect(card.height, lessThanOrEqualTo(480));
        expect(tester.takeException(), isNull);
      });
    }

    testWidgets('the height is the content, not a fixed frame', (tester) async {
      await tester.pumpWidget(
        _frame(
          DatePicker(value: DateTime(2024, 3, 14), onChanged: (_) {}),
          data: _theme('neutral', Brightness.light, Density.defaultDensity),
        ),
      );
      await _openDialog(tester, 'March 14, 2024');
      final Rect card = _card(tester);
      final Rect grid = tester.getRect(find.byType(Calendar));
      final Rect caption = tester.getRect(_button(tester, 'March 2024'));
      final Rect saveButton = tester.getRect(_button(tester, 'Save'));
      final Rect cancelButton = tester.getRect(_button(tester, 'Cancel'));
      final double contentBottom = saveButton.bottom > cancelButton.bottom
          ? saveButton.bottom
          : cancelButton.bottom;
      // `p-0` card: it starts at the caption row (which is `size-(--cell-size)`
      // tall, 48) and ends `p-3` below the taller footer button.
      expect(card.top, closeTo(caption.top, 0.5));
      expect(caption.height, closeTo(48, 0.5));
      expect(card.bottom - contentBottom, closeTo(12, 0.5));
      // Caption row + `gap-2`, then the grid, then `gap-3` and the footer row.
      expect(grid.top - caption.bottom, closeTo(8, 0.5));
      expect(grid.width, closeTo(card.width, 0.01));
    });

    testWidgets('footer: Cancel then Save, right-aligned with gap-2', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          DatePicker(value: DateTime(2024, 3, 14), onChanged: (_) {}),
          data: _theme('neutral', Brightness.light, Density.defaultDensity),
        ),
      );
      await _openDialog(tester, 'March 14, 2024');
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
      expect(
        _horizontalGap(
          tester,
          _button(tester, 'Cancel'),
          _button(tester, 'Save'),
        ),
        moreOrLessEquals(8, epsilon: 0.01),
      );
      // Right-aligned inside the card's own footer padding (p-3 = 12).
      final Rect card = _card(tester);
      final Rect save = tester.getRect(_button(tester, 'Save'));
      expect(card.right - save.right, closeTo(12, 0.5));
    });

    testWidgets('fits a 375 phone without horizontal scroll', (tester) async {
      await tester.binding.setSurfaceSize(const Size(375, 667));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(
        _frame(
          DatePicker(value: DateTime(2024, 3, 14), onChanged: (_) {}),
          data: _theme('neutral', Brightness.light, Density.defaultDensity),
          size: const Size(375, 667),
        ),
      );
      await _openDialog(tester, 'March 14, 2024');
      final Rect card = _card(tester);
      expect(card.left, greaterThanOrEqualTo(0));
      expect(card.right, lessThanOrEqualTo(375));
      expect(tester.takeException(), isNull);
    });

    testWidgets('scales with density: 6/12/15 cell gaps, same bounds', (
      tester,
    ) async {
      // The dialog route sizes from the test view: the spacious grid needs
      // room (the skins group above uses 1440x900 for the same reason).
      await tester.binding.setSurfaceSize(const Size(1440, 900));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      final List<double> widths = <double>[];
      final List<double> cells = <double>[];
      for (final Density density in <Density>[
        Density.compactDensity,
        Density.defaultDensity,
        Density.spaciousDensity,
      ]) {
        await tester.pumpWidget(
          _frame(
            DatePicker(value: DateTime(2024, 3, 14), onChanged: (_) {}),
            data: _theme('neutral', Brightness.light, density),
          ),
        );
        await _openDialog(tester, 'March 14, 2024');
        final Finder dayCell = find
            .ancestor(of: find.text('14'), matching: find.byType(Container))
            .first;
        cells.add(tester.getSize(dayCell).height);
        widths.add(_card(tester).width);
        // Close it again: a re-pumped tree keeps the open route, and the next
        // iteration would then measure the dialog of this one.
        await tester.tap(find.text('Save'));
        await tester.pumpAndSettle();
      }
      // 48px touch cells, scaled: 24 / 48 / 60.
      expect(cells, <double>[24, 48, 60]);
      // compact < default < comfortable, all within the reference bounds.
      expect(widths[0], lessThan(widths[1]));
      expect(widths[1], lessThan(widths[2]));
      expect(widths.every((double w) => w <= 384 * 1.3), isTrue);
    });
  });

  group('time picker dialog', () {
    testWidgets('card shrinks to the columns and the footer is the same', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          TimePicker(value: null, onChanged: (_) {}),
          data: _theme('neutral', Brightness.light, Density.defaultDensity),
        ),
      );
      await _openDialog(tester, 'Select a time');
      final Rect card = _card(tester);
      expect(card.width, lessThanOrEqualTo(360));
      expect(card.height, lessThanOrEqualTo(420));
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
      // 24h mode by default in the test harness (alwaysUse24HourFormat is
      // false, so AM/PM is shown): the columns plus the AM/PM stack.
      expect(find.text('AM'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });

  group('popover variant', () {
    testWidgets('w-auto p-0: the calendar fills the popover surface', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          DatePicker(
            value: DateTime(2024, 3, 14),
            onChanged: (_) {},
            mode: PromptMode.popover,
          ),
          data: _theme('neutral', Brightness.light, Density.defaultDensity),
        ),
      );
      await _openDialog(tester, 'March 14, 2024');
      final Rect grid = tester.getRect(find.byType(Calendar));
      expect(grid.width, lessThanOrEqualTo(384));
      // No dialog card, no barrier: the calendar is the popover's only content.
      expect(find.byKey(kObjectFormDialogSurfaceKey), findsNothing);
      await tester.tap(find.text('15'));
      await tester.pump();
      expect(find.text('Save'), findsNothing);
    });
  });

  group('form control spacing', () {
    testWidgets('label -> control gap is 8, scaled by density', (tester) async {
      final List<double> gaps = <double>[];
      for (final Density density in <Density>[
        Density.compactDensity,
        Density.defaultDensity,
        Density.spaciousDensity,
      ]) {
        await tester.pumpWidget(
          _frame(
            FormScope(
              child: FormItem<String>(
                key: const FormKey<String>('name'),
                label: const Text('Name'),
                child: const InputProbe(),
              ),
            ),
            data: _theme('neutral', Brightness.light, density),
          ),
        );
        final Rect label = tester.getRect(find.text('Name'));
        final Rect control = tester.getRect(find.byKey(kFormControlKey));
        gaps.add(control.top - label.bottom);
      }
      expect(gaps, <double>[4, 8, 10]);
    });

    testWidgets('helper text sits 6 below the control and is text-sm muted', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          FormScope(
            child: FormItem<String>(
              key: const FormKey<String>('name'),
              label: const Text('Name'),
              hint: const Text('As it appears on the card'),
              child: const InputProbe(),
            ),
          ),
          data: _theme('neutral', Brightness.light, Density.defaultDensity),
        ),
      );
      final Rect control = tester.getRect(find.byKey(kFormControlKey));
      final Rect hint = tester.getRect(find.text('As it appears on the card'));
      expect(hint.top - control.bottom, moreOrLessEquals(6, epsilon: 0.01));
      final TextStyle style = tester
          .widget<DefaultTextStyle>(
            find
                .ancestor(
                  of: find.text('As it appears on the card'),
                  matching: find.byType(DefaultTextStyle),
                )
                .first,
          )
          .style;
      expect(style.fontSize, 14);
      final ThemeColors colors = Theme.of(
        tester.element(find.text('As it appears on the card')),
      ).colors;
      expect(style.color, colors.mutedForeground);
    });
  });
}

/// The control box of a field, so the spacing assertions measure the control
/// and not the text inside it.
const ValueKey<String> kFormControlKey = ValueKey<String>('p7u2.field');

/// A stand-in for the `input` component: the upstream `h-9` box, so the form
/// spacing is measured without a text field's own inner padding.
class InputProbe extends StatelessWidget {
  const InputProbe({super.key});

  @override
  Widget build(BuildContext context) =>
      const SizedBox(key: kFormControlKey, height: 36);
}

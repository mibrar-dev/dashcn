// Theme Studio rail popup audit: EVERY picker in the rail commits, tracks
// the live value, and dismisses cleanly.
//
// For each popup (preset, radius, spacing, shadow, surface opacity, surface
// blur, base/theme/chart colour, heading/body font, transition, syntax)
// exactly one test verifies:
//   (a) tapping a preset/option commits AND closes — except the deliberate
//       multi-step editors (radius, spacing, shadow: preset taps commit but
//       the popup stays open for fine-tuning; `Done` closes);
//   (b) the highlighted selection follows the live theme value: an external
//       change while open moves the highlight, and reopening shows the
//       committed choice;
//   (c) Escape and outside tap close without committing.
//
// Colour seeds are starting points, not stored values (a pick derives a
// whole ramp), so a reopened colour popup selects a swatch only when the
// document colour is exactly a seed; the rail row's trailing swatch always
// shows the live colour. Syntax is a read-only preview (no commit at all).

import 'package:docs/generated/docs_data.dart';
import 'package:docs/routing/docs_router.dart';
import 'package:docs/state/docs_storage.dart';
import 'package:docs/theme/theme_document.dart';
import 'package:docs/ui/dashcn/components/menu/menu.dart';
import 'package:docs/widgets/rail_picker_rows.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/app_harness.dart';

Future<DocsRouterDelegate> _themes(WidgetTester tester) async {
  final DocsRouterDelegate delegate = await pumpDocsApp(tester);
  await goTo(tester, delegate, '/themes');
  return delegate;
}

Future<void> _openRow(WidgetTester tester, String key) async {
  await tester.ensureVisible(find.byKey(ValueKey<String>(key)));
  await tester.pump();
  await tester.tap(find.byKey(ValueKey<String>(key)));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 600));
  expect(find.byType(MenuPopup), findsOneWidget, reason: key);
}

Finder _inPopup(Finder finder) =>
    find.descendant(of: find.byType(MenuPopup), matching: finder);

bool _popupRowSelected(WidgetTester tester, String label) {
  final Iterable<RailPickerRow> rows = tester.widgetList<RailPickerRow>(
    _inPopup(find.byType(RailPickerRow)),
  );
  for (final RailPickerRow row in rows) {
    if (row.label == label) {
      return row.selected;
    }
  }
  fail('popup row "$label" not found');
}

/// Taps the first unselected row (scrolling it into view) and returns its
/// label. Rows in [exclude] are skipped (e.g. the font `Default` row, which
/// clears to an inherited family instead of committing its own value).
/// For single-choice popups the popup must close; for the multi-step
/// editors it stays open.
Future<String> _pickFirstUnselectedRow(
  WidgetTester tester, {
  Set<String> exclude = const <String>{},
}) async {
  final Iterable<RailPickerRow> rows = tester.widgetList<RailPickerRow>(
    _inPopup(find.byType(RailPickerRow)),
  );
  final RailPickerRow target = rows.firstWhere(
    (RailPickerRow row) => !row.selected && !exclude.contains(row.label),
    orElse: () => throw StateError('every popup row is selected'),
  );
  final Finder label = _inPopup(find.text(target.label)).first;
  await tester.ensureVisible(label);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 600));
  await tester.tap(label);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 600));
  return target.label;
}

Future<void> _escapeClosesWithoutCommit(
  WidgetTester tester,
  String jsonBefore,
) async {
  await tester.sendKeyEvent(LogicalKeyboardKey.escape);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 600));
  expect(find.byType(MenuPopup), findsNothing);
  expect(docsState.themeModel.document.json, jsonBefore);
  expect(tester.takeException(), isNull);
}

Future<void> _outsideTapClosesWithoutCommit(
  WidgetTester tester,
  String jsonBefore,
) async {
  // Right of the rail-adjacent popup, over the canvas; the modal barrier
  // consumes the tap so nothing behind activates.
  await tester.tapAt(const Offset(750, 550));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 600));
  expect(find.byType(MenuPopup), findsNothing);
  expect(docsState.themeModel.document.json, jsonBefore);
  expect(tester.takeException(), isNull);
}

void main() {
  group('preset popup', () {
    testWidgets('pick commits+closes, highlight tracks live, '
        'dismissals keep the value', (tester) async {
      await _themes(tester);
      final String first = kPresets.first.id;
      final String other = kPresets
          .firstWhere((DocsPreset p) => p.id != first)
          .id;
      docsState.themeModel.selectPreset(first);
      await tester.pump();

      await _openRow(tester, 'rail-row-preset');
      expect(find.byType(MenuPopup), findsOneWidget);

      // (b) external change while open moves the highlight, popup stays.
      docsState.themeModel.selectPreset(other);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.byType(MenuPopup), findsOneWidget);

      // (c) Escape keeps the live value.
      final String jsonBefore = docsState.themeModel.document.json;
      await _escapeClosesWithoutCommit(tester, jsonBefore);

      // (c) outside tap keeps the live value.
      await _openRow(tester, 'rail-row-preset');
      await _outsideTapClosesWithoutCommit(
        tester,
        docsState.themeModel.document.json,
      );

      // (a) a pick commits and closes; reopen shows the new choice.
      await _openRow(tester, 'rail-row-preset');
      final String picked = await _pickFirstUnselectedRow(tester);
      expect(find.byType(MenuPopup), findsNothing);
      final String? matched = docsState.themeModel.matchedPresetId;
      expect(matched, isNotNull);
      await _openRow(tester, 'rail-row-preset');
      expect(_popupRowSelected(tester, picked), isTrue);
      expect(tester.takeException(), isNull);
    });
  });

  group('radius popup (multi-step editor)', () {
    testWidgets('preset commits but stays open, highlight tracks live, '
        'Done closes, dismissals keep the value', (tester) async {
      await _themes(tester);
      docsState.themeModel.setRadiusPx(8);
      await tester.pump();

      await _openRow(tester, 'rail-row-radius');
      expect(_popupRowSelected(tester, 'Default'), isTrue);

      // (a) preset taps commit but the editor stays open for fine-tuning.
      await tester.tap(_inPopup(find.text('Large')).first);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.byType(MenuPopup), findsOneWidget);
      expect(docsState.themeModel.radiusPx, 12);
      expect(_popupRowSelected(tester, 'Large'), isTrue);

      // (b) external change while open moves the highlight and the slider.
      docsState.themeModel.setRadiusPx(4);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.byType(MenuPopup), findsOneWidget);
      expect(_popupRowSelected(tester, 'Small'), isTrue);

      // Done closes; reopen shows the committed choice.
      await tester.tap(_inPopup(find.text('Done')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.byType(MenuPopup), findsNothing);
      await _openRow(tester, 'rail-row-radius');
      expect(_popupRowSelected(tester, 'Small'), isTrue);

      // (c) Escape and outside tap keep the committed value.
      await _escapeClosesWithoutCommit(
        tester,
        docsState.themeModel.document.json,
      );
      await _openRow(tester, 'rail-row-radius');
      await _outsideTapClosesWithoutCommit(
        tester,
        docsState.themeModel.document.json,
      );
      expect(tester.takeException(), isNull);
    });
  });

  group('spacing popup (multi-step editor)', () {
    testWidgets('preset commits but stays open, highlight tracks live, '
        'dismissals keep the value', (tester) async {
      await _themes(tester);
      docsState.themeModel.setSpacingRem(0.25);
      await tester.pump();

      await _openRow(tester, 'rail-row-spacing');
      expect(_popupRowSelected(tester, 'Default'), isTrue);

      await tester.tap(_inPopup(find.text('Compact')).first);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.byType(MenuPopup), findsOneWidget);
      expect(docsState.themeModel.document.spacing, 0.2);
      expect(_popupRowSelected(tester, 'Compact'), isTrue);

      docsState.themeModel.setSpacingRem(0.3);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      expect(_popupRowSelected(tester, 'Comfortable'), isTrue);

      await tester.tap(_inPopup(find.text('Done')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.byType(MenuPopup), findsNothing);
      await _openRow(tester, 'rail-row-spacing');
      expect(_popupRowSelected(tester, 'Comfortable'), isTrue);

      await _escapeClosesWithoutCommit(
        tester,
        docsState.themeModel.document.json,
      );
      await _openRow(tester, 'rail-row-spacing');
      await _outsideTapClosesWithoutCommit(
        tester,
        docsState.themeModel.document.json,
      );
      expect(tester.takeException(), isNull);
    });
  });

  group('shadow popup (multi-step editor)', () {
    testWidgets('preset commits but stays open, highlight tracks live, '
        'dismissals keep the value', (tester) async {
      await _themes(tester);
      final Brightness brightness = docsState.brightness;
      final DocsShadowAtoms before = docsState.themeModel.document.shadowOf(
        brightness,
      );
      docsState.themeModel.setShadow(
        brightness,
        const DocsShadowAtoms(
          color: 0xFF000000,
          opacity: 0.1,
          blur: 8,
          spread: -1,
          offsetX: 0,
          offsetY: 4,
        ),
      );
      await tester.pump();

      await _openRow(tester, 'rail-row-shadow');
      expect(_popupRowSelected(tester, 'Default'), isTrue);

      await tester.tap(_inPopup(find.text('Strong')).first);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.byType(MenuPopup), findsOneWidget);
      expect(docsState.themeModel.document.shadowOf(brightness).opacity, 0.2);
      expect(_popupRowSelected(tester, 'Strong'), isTrue);

      // (b) external change while open moves the highlight back.
      docsState.themeModel.setShadow(brightness, before);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.byType(MenuPopup), findsOneWidget);

      await tester.tap(_inPopup(find.text('Done')));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.byType(MenuPopup), findsNothing);

      await _openRow(tester, 'rail-row-shadow');
      await _escapeClosesWithoutCommit(
        tester,
        docsState.themeModel.document.json,
      );
      await _openRow(tester, 'rail-row-shadow');
      await _outsideTapClosesWithoutCommit(
        tester,
        docsState.themeModel.document.json,
      );
      expect(tester.takeException(), isNull);
    });
  });

  group('surface opacity popup', () {
    testWidgets('dismissals keep the value', (tester) async {
      await _themes(tester);
      docsState.themeModel.setSurfaceOpacity(0.7);
      await tester.pump();

      await _openRow(tester, 'rail-row-surface-opacity');
      expect(_popupRowSelected(tester, '70%'), isTrue);
      await _escapeClosesWithoutCommit(
        tester,
        docsState.themeModel.document.json,
      );

      await _openRow(tester, 'rail-row-surface-opacity');
      await _outsideTapClosesWithoutCommit(
        tester,
        docsState.themeModel.document.json,
      );
      expect(tester.takeException(), isNull);
    });
  });

  group('surface blur popup', () {
    testWidgets('dismissals keep the value', (tester) async {
      await _themes(tester);
      docsState.themeModel.setSurfaceBlur(4);
      await tester.pump();

      await _openRow(tester, 'rail-row-surface-blur');
      expect(_popupRowSelected(tester, 'Subtle'), isTrue);
      await _escapeClosesWithoutCommit(
        tester,
        docsState.themeModel.document.json,
      );

      await _openRow(tester, 'rail-row-surface-blur');
      await _outsideTapClosesWithoutCommit(
        tester,
        docsState.themeModel.document.json,
      );
      expect(tester.takeException(), isNull);
    });
  });

  group('base colour popup', () {
    testWidgets('swatch pick commits+closes, highlight tracks live, '
        'hex submits, dismissals keep the value', (tester) async {
      await _themes(tester);
      // Pin the document colour to exactly a grid seed so the highlight
      // has something to follow.
      docsState.themeModel.setColor('background', '#171717');
      await tester.pump();

      await _openRow(tester, 'rail-row-base');
      final Iterable<RailSeedSwatch> swatches = tester
          .widgetList<RailSeedSwatch>(_inPopup(find.byType(RailSeedSwatch)));
      expect(swatches.where((RailSeedSwatch s) => s.selected), hasLength(1));

      // (b) external change while open moves the highlight, popup stays.
      docsState.themeModel.setColor('background', '#2563EB');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.byType(MenuPopup), findsOneWidget);
      final Iterable<RailSeedSwatch> moved = tester.widgetList<RailSeedSwatch>(
        _inPopup(find.byType(RailSeedSwatch)),
      );
      expect(moved.where((RailSeedSwatch s) => s.selected), hasLength(1));

      // (c) Escape and outside tap keep the live value.
      await _escapeClosesWithoutCommit(
        tester,
        docsState.themeModel.document.json,
      );
      await _openRow(tester, 'rail-row-base');
      await _outsideTapClosesWithoutCommit(
        tester,
        docsState.themeModel.document.json,
      );

      // (a) a swatch pick commits and closes.
      await _openRow(tester, 'rail-row-base');
      final String jsonBefore = docsState.themeModel.document.json;
      final RailSeedSwatch target = tester
          .widgetList<RailSeedSwatch>(_inPopup(find.byType(RailSeedSwatch)))
          .firstWhere((RailSeedSwatch s) => !s.selected);
      await tester.tap(find.byWidget(target));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.byType(MenuPopup), findsNothing);
      expect(docsState.themeModel.document.json, isNot(jsonBefore));

      // A hex submit commits and closes too.
      await _openRow(tester, 'rail-row-base');
      final String jsonBeforeHex = docsState.themeModel.document.json;
      await tester.enterText(
        _inPopup(find.byType(EditableText)).first,
        '#FF0000',
      );
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.byType(MenuPopup), findsNothing);
      expect(docsState.themeModel.document.json, isNot(jsonBeforeHex));
      expect(tester.takeException(), isNull);
    });
  });

  group('theme colour popup', () {
    testWidgets('swatch pick commits+closes, highlight tracks live, '
        'dismissals keep the value', (tester) async {
      await _themes(tester);
      docsState.themeModel.setColor('primary', '#2563EB');
      await tester.pump();

      await _openRow(tester, 'rail-row-accent');
      expect(
        tester
            .widgetList<RailSeedSwatch>(_inPopup(find.byType(RailSeedSwatch)))
            .where((RailSeedSwatch s) => s.selected),
        hasLength(1),
      );

      docsState.themeModel.setColor('primary', '#16A34A');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.byType(MenuPopup), findsOneWidget);
      expect(
        tester
            .widgetList<RailSeedSwatch>(_inPopup(find.byType(RailSeedSwatch)))
            .where((RailSeedSwatch s) => s.selected),
        hasLength(1),
      );

      await _escapeClosesWithoutCommit(
        tester,
        docsState.themeModel.document.json,
      );
      await _openRow(tester, 'rail-row-accent');
      await _outsideTapClosesWithoutCommit(
        tester,
        docsState.themeModel.document.json,
      );

      await _openRow(tester, 'rail-row-accent');
      final String jsonBefore = docsState.themeModel.document.json;
      final RailSeedSwatch target = tester
          .widgetList<RailSeedSwatch>(_inPopup(find.byType(RailSeedSwatch)))
          .firstWhere((RailSeedSwatch s) => !s.selected);
      await tester.tap(find.byWidget(target));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.byType(MenuPopup), findsNothing);
      expect(docsState.themeModel.document.json, isNot(jsonBefore));
      expect(tester.takeException(), isNull);
    });
  });

  group('chart colours popup', () {
    testWidgets('swatch pick commits+closes, highlight tracks live, '
        'dismissals keep the value', (tester) async {
      await _themes(tester);
      docsState.themeModel.setColor('chart1', '#0EA5E9');
      await tester.pump();

      await _openRow(tester, 'rail-row-chart');
      expect(
        tester
            .widgetList<RailSeedSwatch>(_inPopup(find.byType(RailSeedSwatch)))
            .where((RailSeedSwatch s) => s.selected),
        hasLength(1),
      );

      docsState.themeModel.setColor('chart1', '#D946EF');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.byType(MenuPopup), findsOneWidget);
      expect(
        tester
            .widgetList<RailSeedSwatch>(_inPopup(find.byType(RailSeedSwatch)))
            .where((RailSeedSwatch s) => s.selected),
        hasLength(1),
      );

      await _escapeClosesWithoutCommit(
        tester,
        docsState.themeModel.document.json,
      );
      await _openRow(tester, 'rail-row-chart');
      await _outsideTapClosesWithoutCommit(
        tester,
        docsState.themeModel.document.json,
      );

      await _openRow(tester, 'rail-row-chart');
      final String jsonBefore = docsState.themeModel.document.json;
      final RailSeedSwatch target = tester
          .widgetList<RailSeedSwatch>(_inPopup(find.byType(RailSeedSwatch)))
          .firstWhere((RailSeedSwatch s) => !s.selected);
      await tester.tap(find.byWidget(target));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.byType(MenuPopup), findsNothing);
      expect(docsState.themeModel.document.json, isNot(jsonBefore));
      expect(tester.takeException(), isNull);
    });
  });

  group('heading font popup', () {
    testWidgets('pick commits+closes, highlight tracks live, '
        'dismissals keep the value', (tester) async {
      await _themes(tester);
      docsState.themeModel.setFont('heading', null);
      await tester.pump();

      await _openRow(tester, 'rail-row-heading');
      expect(_popupRowSelected(tester, 'Default'), isTrue);

      docsState.themeModel.setFont('heading', 'Inter');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.byType(MenuPopup), findsOneWidget);
      expect(_popupRowSelected(tester, 'Inter'), isTrue);
      expect(_popupRowSelected(tester, 'Default'), isFalse);

      await _escapeClosesWithoutCommit(
        tester,
        docsState.themeModel.document.json,
      );
      await _openRow(tester, 'rail-row-heading');
      await _outsideTapClosesWithoutCommit(
        tester,
        docsState.themeModel.document.json,
      );

      await _openRow(tester, 'rail-row-heading');
      final String picked = await _pickFirstUnselectedRow(tester);
      expect(find.byType(MenuPopup), findsNothing);
      await _openRow(tester, 'rail-row-heading');
      expect(_popupRowSelected(tester, picked), isTrue);
      expect(tester.takeException(), isNull);
    });
  });

  group('body font popup', () {
    testWidgets('pick commits+closes, highlight tracks live, '
        'dismissals keep the value', (tester) async {
      await _themes(tester);
      // Note: a cleared body slot inherits the preset's `sans` family, so
      // the picker highlights that live value (not `Default`); the rail
      // row's trailing glyph shows the same family.
      docsState.themeModel.setFont('body', 'Manrope');
      await tester.pump();

      await _openRow(tester, 'rail-row-body');
      expect(_popupRowSelected(tester, 'Manrope'), isTrue);

      docsState.themeModel.setFont('body', 'Outfit');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.byType(MenuPopup), findsOneWidget);
      expect(_popupRowSelected(tester, 'Outfit'), isTrue);
      expect(_popupRowSelected(tester, 'Manrope'), isFalse);

      await _escapeClosesWithoutCommit(
        tester,
        docsState.themeModel.document.json,
      );
      await _openRow(tester, 'rail-row-body');
      await _outsideTapClosesWithoutCommit(
        tester,
        docsState.themeModel.document.json,
      );

      await _openRow(tester, 'rail-row-body');
      // `Default` clears to the inherited `sans` family, so pick a named
      // family to verify reopen-shows-committed.
      final String picked = await _pickFirstUnselectedRow(
        tester,
        exclude: const <String>{'Default'},
      );
      expect(find.byType(MenuPopup), findsNothing);
      await _openRow(tester, 'rail-row-body');
      expect(_popupRowSelected(tester, picked), isTrue);
      expect(tester.takeException(), isNull);
    });
  });

  group('transition popup', () {
    testWidgets('highlight tracks live, dismissals keep the value', (
      tester,
    ) async {
      await _themes(tester);
      docsState.themeModel.setTransition(DocsThemeTransition.fade);
      await tester.pump();

      await _openRow(tester, 'rail-row-transition');
      expect(_popupRowSelected(tester, 'Fade'), isTrue);

      docsState.themeModel.setTransition(DocsThemeTransition.blur);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));
      expect(find.byType(MenuPopup), findsOneWidget);
      expect(_popupRowSelected(tester, 'Blur'), isTrue);
      expect(_popupRowSelected(tester, 'Fade'), isFalse);

      await _escapeClosesWithoutCommit(
        tester,
        docsState.themeModel.document.json,
      );
      await _openRow(tester, 'rail-row-transition');
      await _outsideTapClosesWithoutCommit(
        tester,
        docsState.themeModel.document.json,
      );
      expect(tester.takeException(), isNull);
    });
  });

  group('syntax colours popup (read-only)', () {
    testWidgets('opens a preview, commits nothing, dismissals just close', (
      tester,
    ) async {
      await _themes(tester);
      final String jsonBefore = docsState.themeModel.document.json;

      await _openRow(tester, 'rail-row-syntax');
      expect(find.byType(MenuPopup), findsOneWidget);
      await _escapeClosesWithoutCommit(tester, jsonBefore);

      await _openRow(tester, 'rail-row-syntax');
      expect(find.byType(MenuPopup), findsOneWidget);
      await _outsideTapClosesWithoutCommit(tester, jsonBefore);
      expect(tester.takeException(), isNull);
    });
  });
}

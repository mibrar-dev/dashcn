// `PlaygroundPanel` widget tests: breakpoints, live controls, reset, URL
// round-trip, tri-state nullables and dependent-range clamps.
//
// The panel is pumped inside the real app shell (see `panel_harness.dart`);
// preview assertions scope through `PreviewStage` so the panel's own
// control widgets never confuse the finders.

import 'package:docs/playground/ui/playground_panel.dart';
import 'package:docs/playground/ui/query.dart';
import 'package:docs/routing/docs_router.dart';
import 'package:docs/ui/dashcn/components/button/button.dart';
import 'package:docs/ui/dashcn/components/pagination/pagination.dart';
import 'package:docs/ui/dashcn/components/slider/slider.dart';
import 'package:docs/ui/dashcn/components/switch/switch.dart';
import 'package:docs/widgets/preview_stage.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'panel_harness.dart';

Finder _previewOf<T>() =>
    find.descendant(of: find.byType(PreviewStage), matching: find.byType(T));

String _code(WidgetTester tester) {
  final Finder figure = find.byKey(const ValueKey<String>('playground-code'));
  expect(figure, findsOneWidget);
  final StringBuffer out = StringBuffer();
  for (final Element element
      in find.descendant(of: figure, matching: find.byType(Text)).evaluate()) {
    final String? data = (element.widget as Text).data;
    if (data != null) {
      out.write(data);
    }
  }
  for (final Element element
      in find
          .descendant(of: figure, matching: find.byType(RichText))
          .evaluate()) {
    out.write((element.widget as RichText).text.toPlainText());
  }
  return out.toString();
}

Future<void> _pickOption(
  WidgetTester tester,
  String control,
  String option,
) async {
  final Finder trigger = find.byKey(
    ValueKey<String>('playground-select-$control'),
  );
  await reveal(tester, trigger);
  await tester.tap(trigger);
  await pumpPanels(tester, 5);
  await tester.tap(find.text(option).last);
  await pumpPanels(tester, 5);
}

Future<void> _typeNumber(
  WidgetTester tester,
  String control,
  String text,
) async {
  final Finder field = find.descendant(
    of: find.byKey(ValueKey<String>('playground-number-$control')),
    matching: find.byType(EditableText),
  );
  await reveal(tester, field);
  await tester.enterText(field, text);
  await pumpPanels(tester);
}

void main() {
  group('breakpoints', () {
    testWidgets('1280 renders side-by-side without overflow', (
      WidgetTester tester,
    ) async {
      await pumpPanel(tester, 'button');
      expect(find.text('Controls'), findsOneWidget);
      expect(
        find.byKey(const ValueKey<String>('playground-code')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('playground-open-sheet')),
        findsNothing,
      );
      expectNoPanelErrors(tester, 'button at 1280');
    });

    testWidgets('900 stacks controls below the preview', (
      WidgetTester tester,
    ) async {
      await pumpPanel(tester, 'button', viewport: const Size(900, 900));
      expect(find.text('Controls'), findsOneWidget);
      expect(
        find.byKey(const ValueKey<String>('playground-code')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('playground-open-sheet')),
        findsNothing,
      );
      expectNoPanelErrors(tester, 'button at 900');
    });

    testWidgets('390 hides controls behind a bottom sheet', (
      WidgetTester tester,
    ) async {
      await pumpPanel(tester, 'button', viewport: const Size(390, 844));
      expect(
        find.byKey(const ValueKey<String>('playground-open-sheet')),
        findsOneWidget,
      );
      expect(find.text('Controls'), findsNothing);
      await tester.tap(
        find.byKey(const ValueKey<String>('playground-open-sheet')),
      );
      await pumpPanels(tester, 6);
      expect(find.text('Controls'), findsOneWidget);
      expect(
        find.byKey(const ValueKey<String>('playground-tristate-enabled-unset')),
        findsNothing,
        reason: 'button has no nullable toggle',
      );
      expect(
        find.byKey(const ValueKey<String>('playground-select-variant')),
        findsOneWidget,
      );
      await tester.tap(
        find.byKey(const ValueKey<String>('playground-sheet-done')),
      );
      await pumpPanels(tester, 6);
      expectNoPanelErrors(tester, 'button at 390 with sheet');
    });

    testWidgets('components without specs show theme section but no code', (
      WidgetTester tester,
    ) async {
      await pumpPanel(tester, 'toggle_group');
      expect(find.byType(PlaygroundPanel), findsOneWidget);
      expect(
        find.byKey(const ValueKey<String>('playground-group-theme')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('playground-code')),
        findsNothing,
      );
      expectNoPanelErrors(tester, 'toggle_group renders theme section');
    });
  });

  group('live controls', () {
    testWidgets('select updates the preview and the code', (
      WidgetTester tester,
    ) async {
      await pumpPanel(tester, 'button');
      expect(_code(tester), isNot(contains('ButtonVariant.outline')));
      await _pickOption(tester, 'variant', 'outline');
      final Button preview = tester.widget<Button>(_previewOf<Button>());
      expect(preview.variant, ButtonVariant.outline);
      expect(_code(tester), contains('ButtonVariant.outline'));
      expectNoPanelErrors(tester, 'select change');
    });

    testWidgets('text input updates the preview and the code', (
      WidgetTester tester,
    ) async {
      await pumpPanel(tester, 'button');
      final Finder field = find.descendant(
        of: find.byKey(const ValueKey<String>('playground-text-child')),
        matching: find.byType(EditableText),
      );
      await reveal(tester, field);
      await tester.enterText(field, 'Save');
      await pumpPanels(tester);
      final Button preview = tester.widget<Button>(_previewOf<Button>());
      expect((preview.child as Text).data, 'Save');
      expect(_code(tester), contains("'Save'"));
      expectNoPanelErrors(tester, 'text change');
    });

    testWidgets('switch toggles a bool in preview and code', (
      WidgetTester tester,
    ) async {
      await pumpPanel(tester, 'button');
      expect(_code(tester), isNot(contains('autofocus')));
      final Finder control = find.byKey(
        const ValueKey<String>('playground-switch-autofocus'),
      );
      await reveal(tester, control);
      await tester.tap(control);
      await pumpPanels(tester);
      expect(tester.widget<Button>(_previewOf<Button>()).autofocus, isTrue);
      expect(_code(tester), contains('autofocus: true'));
      expectNoPanelErrors(tester, 'switch change');
    });

    testWidgets('sheet edits reach the preview and the code', (
      WidgetTester tester,
    ) async {
      final List<Map<String, String>> queries = <Map<String, String>>[];
      await pumpPanel(
        tester,
        'button',
        viewport: const Size(390, 844),
        queryLog: queries,
      );
      await tester.tap(
        find.byKey(const ValueKey<String>('playground-open-sheet')),
      );
      await pumpPanels(tester, 6);
      await _pickOption(tester, 'size', 'lg');
      expect(tester.widget<Button>(_previewOf<Button>()).size, ButtonSize.lg);
      expect(_code(tester), contains('ButtonSize.lg'));
      expect(queries.last['p.size'], 'lg');
      expectNoPanelErrors(tester, 'sheet edit');
    });
  });

  group('reset and URL', () {
    testWidgets('reset restores defaults and clears the query', (
      WidgetTester tester,
    ) async {
      final List<Map<String, String>> queries = <Map<String, String>>[];
      await pumpPanel(tester, 'button', queryLog: queries);
      await _pickOption(tester, 'variant', 'destructive');
      expect(queries.last, containsPair('p.variant', 'destructive'));
      final Finder reset = find.byKey(
        const ValueKey<String>('playground-reset'),
      );
      await reveal(tester, reset);
      await tester.tap(reset);
      await pumpPanels(tester);
      expect(
        tester.widget<Button>(_previewOf<Button>()).variant,
        ButtonVariant.primary,
      );
      expect(_code(tester), isNot(contains('ButtonVariant.destructive')));
      expect(queries.last, isEmpty);
      expectNoPanelErrors(tester, 'reset');
    });

    testWidgets('query round-trips through the router into a fresh panel', (
      WidgetTester tester,
    ) async {
      final List<Map<String, String>> queries = <Map<String, String>>[];
      await pumpPanel(tester, 'button', queryLog: queries);
      final Finder field = find.descendant(
        of: find.byKey(const ValueKey<String>('playground-text-child')),
        matching: find.byType(EditableText),
      );
      await reveal(tester, field);
      await tester.enterText(field, 'Share me');
      await _pickOption(tester, 'variant', 'outline');
      final Map<String, String> query = queries.last;
      expect(query['p.variant'], 'outline');
      expect(query['p.child'], 'Share me');

      // The component route still resolves with `?p.*` present.
      final Uri shared = Uri.parse(
        '/docs/components/button',
      ).replace(queryParameters: query);
      expect(
        DocsRouteConfiguration.parse(shared.toString()),
        DocsRouteConfiguration.component('button'),
      );

      // A fresh panel seeded from the shared URL restores the state.
      await pumpPanel(
        tester,
        'button',
        initialQuery: playgroundQueryOf(shared),
      );
      final Button preview = tester.widget<Button>(_previewOf<Button>());
      expect(preview.variant, ButtonVariant.outline);
      expect((preview.child as Text).data, 'Share me');
      expect(_code(tester), contains('ButtonVariant.outline'));
      expect(_code(tester), contains("'Share me'"));
      expectNoPanelErrors(tester, 'query restore');
    });
  });

  group('tri-state nullables', () {
    testWidgets('unset/on/off reach the preview and the code', (
      WidgetTester tester,
    ) async {
      await pumpPanel(tester, 'switch');
      Finder previewSwitch() => _previewOf<Switch>();
      // Default: null (the component default applies).
      expect(tester.widget<Switch>(previewSwitch()).enabled, isNull);
      expect(_code(tester), isNot(contains('enabled:')));
      final Finder on = find.byKey(
        const ValueKey<String>('playground-tristate-enabled-on'),
      );
      await reveal(tester, on);
      await tester.tap(on);
      await pumpPanels(tester);
      expect(tester.widget<Switch>(previewSwitch()).enabled, isTrue);
      expect(_code(tester), contains('enabled: true'));
      await tester.tap(
        find.byKey(const ValueKey<String>('playground-tristate-enabled-off')),
      );
      await pumpPanels(tester);
      expect(tester.widget<Switch>(previewSwitch()).enabled, isFalse);
      expect(_code(tester), contains('enabled: false'));
      await tester.tap(
        find.byKey(const ValueKey<String>('playground-tristate-enabled-unset')),
      );
      await pumpPanels(tester);
      expect(tester.widget<Switch>(previewSwitch()).enabled, isNull);
      expect(_code(tester), isNot(contains('enabled:')));
      expectNoPanelErrors(tester, 'tri-state');
    });
  });

  group('dependent ranges', () {
    testWidgets('slider value tracks the live min/max', (
      WidgetTester tester,
    ) async {
      await pumpPanel(tester, 'slider');
      Finder previewSlider() => _previewOf<Slider>();
      expect(tester.widget<Slider>(previewSlider()).min, 0);
      expect(tester.widget<Slider>(previewSlider()).max, 1);
      await _typeNumber(tester, 'min', '0.8');
      // The value (0) clamps into the live range.
      expect(tester.widget<Slider>(previewSlider()).min, 0.8);
      expect(tester.widget<Slider>(previewSlider()).value, 0.8);
      expect(_code(tester), contains('value: 0.8'));
      // Typing below the live min clamps back up.
      await _typeNumber(tester, 'value', '0.2');
      expect(tester.widget<Slider>(previewSlider()).value, 0.8);
      // Pushing min above max repairs max instead of throwing (the kit
      // asserts `max > min`, so max widens one step past min).
      await _typeNumber(tester, 'min', '4');
      expect(tester.widget<Slider>(previewSlider()).min, 4);
      expect(tester.widget<Slider>(previewSlider()).max, 4.1);
      expectNoPanelErrors(tester, 'slider bounds');
    });

    testWidgets('pagination page clamps to totalPages', (
      WidgetTester tester,
    ) async {
      await pumpPanel(tester, 'pagination');
      await _typeNumber(tester, 'totalPages', '3');
      await _typeNumber(tester, 'page', '9');
      final Pagination pagination = tester.widget<Pagination>(
        find.descendant(
          of: find.byType(PreviewStage),
          matching: find.byType(Pagination),
        ),
      );
      expect(pagination.page, 3);
      expect(_code(tester), contains('page: 3'));
      expectNoPanelErrors(tester, 'pagination clamp');
    });
  });
}

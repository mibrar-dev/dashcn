// Figma-like playground panel tests: grouped editable controls, hidden
// read-only entries, Reset + Copy code, and the 380 px inline mode.
//
// Groups (Appearance, Size, State, Content) come from `groups.dart`; only
// editable kinds render. Read-only entries stay in the API Reference docs.
// The component page's 380 px right panel sets `inlineControls: true` so its
// narrow width still shows the grouped controls instead of an `Edit controls`
// sheet button.

import 'package:docs/generated/app_theme.dart';
import 'package:docs/generated/docs_controls.dart';
import 'package:docs/playground/ui/groups.dart';
import 'package:docs/playground/ui/playground_panel.dart';
import 'package:docs/ui/dashcn/components/app/app.dart';
import 'package:docs/ui/dashcn/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'panel_harness.dart';

Future<void> pumpInlinePanel(
  WidgetTester tester,
  String componentId, {
  Size viewport = const Size(380, 900),
}) async {
  tester.view.physicalSize = viewport;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  final ThemeData light = buildDocsTheme('neutral', Brightness.light);
  final ThemeData dark = buildDocsTheme('neutral', Brightness.dark);
  await tester.pumpWidget(
    DashcnApp(
      theme: light,
      darkTheme: dark,
      themeMode: ThemeMode.light,
      home: Directionality(
        textDirection: TextDirection.ltr,
        child: SingleChildScrollView(
          key: const ValueKey<String>('panel-scroll'),
          child: SizedBox(
            width: viewport.width,
            child: PlaygroundPanel(
              componentId: componentId,
              inlineControls: true,
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
}

void main() {
  group('figma groups', () {
    test('groupEditableControls orders and hides read-only', () {
      final ComponentControls spec = kControlSpecs['button']!;
      final Map<String, List<ControlSpec>> grouped = groupEditableControls(
        spec,
      );
      // Button (with synthetic hasIcon/iconPosition/fullWidth) exposes all
      // four groups in fixed order.
      expect(grouped.keys.toList(), <String>[
        'appearance',
        'size',
        'state',
        'content',
      ]);
      expect(
        grouped['appearance']!.map((ControlSpec c) => c.name),
        containsAll(<String>['variant']),
      );
      expect(
        grouped['size']!.map((ControlSpec c) => c.name),
        containsAll(<String>['size', 'fullWidth']),
      );
      expect(
        grouped['state']!.map((ControlSpec c) => c.name),
        containsAll(<String>['enabled', 'status', 'autofocus']),
      );
      expect(
        grouped['content']!.map((ControlSpec c) => c.name),
        containsAll(<String>['child', 'hasIcon', 'iconPosition']),
      );
      // No read-only entries leak into any group.
      for (final List<ControlSpec> controls in grouped.values) {
        for (final ControlSpec control in controls) {
          expect(control.isEditable, isTrue, reason: control.name);
          expect(control.kind, isNot(ControlKind.readOnly));
        }
      }
      // Slider component does expose the Size group.
      final Map<String, List<ControlSpec>> sliderGrouped =
          groupEditableControls(kControlSpecs['slider']!);
      expect(sliderGrouped.keys, contains('size'));
    });

    testWidgets('button panel shows groups, reset and copy, hides read', (
      WidgetTester tester,
    ) async {
      await pumpPanel(tester, 'button');
      expect(
        find.byKey(const ValueKey<String>('playground-group-appearance')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('playground-group-size')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('playground-group-state')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('playground-group-content')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('playground-control-size')),
        findsOneWidget,
      );
      // Reset + Copy code actions.
      expect(
        find.byKey(const ValueKey<String>('playground-reset')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('playground-copy')),
        findsOneWidget,
      );
      // Read-only entries never render as control rows.
      expect(
        find.byKey(const ValueKey<String>('playground-control-onPressedAsync')),
        findsNothing,
      );
      expect(
        find.byKey(const ValueKey<String>('playground-control-successLabel')),
        findsNothing,
      );
      // Editable rows do render.
      expect(
        find.byKey(const ValueKey<String>('playground-control-variant')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('playground-control-child')),
        findsOneWidget,
      );
      expectNoPanelErrors(tester, 'button grouped controls');
    });

    testWidgets('380 px inline panel shows controls without a sheet button', (
      WidgetTester tester,
    ) async {
      await pumpInlinePanel(tester, 'button');
      expect(
        find.byKey(const ValueKey<String>('playground-open-sheet')),
        findsNothing,
      );
      expect(
        find.byKey(const ValueKey<String>('playground-group-appearance')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('playground-group-content')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('playground-copy')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('playground-reset')),
        findsOneWidget,
      );
      expectNoPanelErrors(tester, 'button at 380 inline');
    });
  });
}

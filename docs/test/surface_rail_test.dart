// Theme Studio surface controls: the rail exposes "Surface opacity" and
// "Surface blur" rows that commit on select (never on hover) and flow into
// the live theme plus the Get Code export.

import 'package:docs/routing/docs_router.dart';
import 'package:docs/ui/dashcn/components/menu/menu.dart';
import 'package:docs/widgets/theme_rail.dart';
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
  expect(find.byType(MenuPopup), findsOneWidget);
}

Future<void> _dismiss(WidgetTester tester) async {
  await tester.sendKeyEvent(LogicalKeyboardKey.escape);
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 600));
  expect(find.byType(MenuPopup), findsNothing);
}

void main() {
  group('surface rail rows', () {
    testWidgets('both rows exist with opaque defaults', (tester) async {
      await _themes(tester);
      expect(
        find.byKey(const ValueKey<String>('rail-row-surface-opacity')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('rail-row-surface-blur')),
        findsOneWidget,
      );
      expect(docsState.themeModel.document.surfaceOpacity, isNull);
      expect(docsState.themeModel.document.surfaceBlur, isNull);
      expect(tester.takeException(), isNull);
    });

    testWidgets('opacity presets commit on select', (tester) async {
      await _themes(tester);
      await _openRow(tester, 'rail-row-surface-opacity');
      await tester.tap(find.text('80%').last);
      await tester.pump();
      expect(docsState.themeModel.document.surfaceOpacity, 0.8);
      expect(docsState.themeModel.dartSource, contains('surfaceOpacity: 0.8'));
      expect(docsState.themeModel.json, contains('surfaceOpacity'));
      await _dismiss(tester);
    });

    testWidgets('blur presets commit on select', (tester) async {
      await _themes(tester);
      await _openRow(tester, 'rail-row-surface-blur');
      await tester.tap(find.text('Frosted').last);
      await tester.pump();
      expect(docsState.themeModel.document.surfaceBlur, 8);
      expect(docsState.themeModel.dartSource, contains('surfaceBlur: 8'));
      expect(docsState.themeModel.json, contains('surfaceBlur'));
      await _dismiss(tester);
    });

    testWidgets('frosted theme resolves into ThemeData', (tester) async {
      await _themes(tester);
      docsState.themeModel.setSurfaceOpacity(0.7);
      docsState.themeModel.setSurfaceBlur(8);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.byType(ThemeRail), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}

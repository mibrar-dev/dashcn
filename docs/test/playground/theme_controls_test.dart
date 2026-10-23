// Widget tests for the playground Theme section (feat/playground-theme-controls):
//
// 1. Playground button is visible on a component page without props specs (e.g. swipe_actions).
// 2. Changing radius updates a preview's BoxDecoration radius.
// 3. Query parameters round-trip through `PlaygroundThemeValues.fromQuery` and `toQuery`.

import 'package:docs/playground/theme_values.dart';
import 'package:docs/playground/ui/playground_panel.dart';
import 'package:docs/routing/docs_router.dart';
import 'package:docs/ui/dashcn/theme/theme.dart';
import 'package:docs/widgets/preview_stage.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/app_harness.dart';

void main() {
  group('playground theme controls', () {
    test('query round-trip', () {
      const ThemeData siteTheme = ThemeData();
      final PlaygroundThemeValues def = PlaygroundThemeValues.defaults(
        siteTheme,
      );

      // Default values produce an empty query.
      expect(def.toQuery(siteTheme), isEmpty);
      expect(def.isDefault(siteTheme), isTrue);

      // Non-default values serialize to t.* parameters.
      final PlaygroundThemeValues custom = def.copyWith(
        radius: 20,
        density: 'touch',
        spacingBase: 8,
        tracking: 0.5,
        shadow: 'none',
        surfaceOpacity: 0.8,
        surfaceBlur: 12,
        font: 'mono',
        mode: 'dark',
      );

      final Map<String, String> query = custom.toQuery(siteTheme);
      expect(query['t.radius'], '20');
      expect(query['t.density'], 'touch');
      expect(query['t.spacing'], '8');
      expect(query['t.shadow'], 'none');
      expect(query['t.surfaceOpacity'], '0.80');
      expect(query['t.surfaceBlur'], '12');
      expect(query['t.font'], 'mono');
      expect(query['t.mode'], 'dark');

      // fromQuery restores the values.
      final PlaygroundThemeValues restored = PlaygroundThemeValues.fromQuery(
        siteTheme,
        query,
      );
      expect(restored.radius, 20);
      expect(restored.density, 'touch');
      expect(restored.spacingBase, 8);
      expect(restored.tracking, 0.5);
      expect(restored.shadow, 'none');
      expect(restored.surfaceOpacity, 0.8);
      expect(restored.surfaceBlur, 12);
      expect(restored.font, 'mono');
      expect(restored.mode, 'dark');

      // Resetting to defaults produces an empty query again.
      final PlaygroundThemeValues reset = PlaygroundThemeValues.defaults(
        siteTheme,
      );
      expect(reset.toQuery(siteTheme), isEmpty);
    });

    testWidgets('button visible on a page without specs', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      await goTo(tester, delegate, '/docs/components/swipe_actions');
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();

      // Playground button is visible even though swipe_actions has no builder.
      final Finder playgroundBtn = find.byKey(
        const ValueKey<String>('playground-open'),
      );
      expect(playgroundBtn, findsOneWidget);

      await ensureVisibleBelowHeader(tester, playgroundBtn);
      await tester.pumpAndSettle();
      await tester.tap(playgroundBtn);
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();

      // Panel opens and shows the Theme section.
      expect(find.byType(PlaygroundPanel), findsOneWidget);
      expect(
        find.byKey(const ValueKey<String>('playground-group-theme')),
        findsOneWidget,
      );
    });

    testWidgets('changing radius updates a preview\'s BoxDecoration radius', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      await goTo(tester, delegate, '/docs/components/button');
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();

      final Finder playgroundBtn = find.byKey(
        const ValueKey<String>('playground-open'),
      );
      await ensureVisibleBelowHeader(tester, playgroundBtn);
      await tester.pumpAndSettle();
      await tester.tap(playgroundBtn);
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();

      // Tap radius preset 0 (square corners).
      final Finder preset0 = find.byKey(
        const ValueKey<String>('playground-theme-radius-preset-0'),
      );
      await ensureVisibleBelowHeader(tester, preset0);
      await tester.pumpAndSettle();
      await tester.tap(preset0);
      await tester.pumpAndSettle();

      // Find BoxDecorations within PreviewStage.
      Iterable<BoxDecoration> decorations() {
        return tester
            .widgetList<AnimatedContainer>(
              find.descendant(
                of: find.byType(PreviewStage),
                matching: find.byType(AnimatedContainer),
              ),
            )
            .map((AnimatedContainer c) => c.decoration)
            .whereType<BoxDecoration>();
      }

      final List<BoxDecoration> decs0 = decorations().toList();
      expect(decs0, isNotEmpty);
      for (final BoxDecoration d in decs0) {
        if (d.borderRadius != null) {
          final BorderRadius br = d.borderRadius! as BorderRadius;
          expect(br.topLeft.x, 0.0);
          expect(br.topRight.x, 0.0);
        }
      }

      // Tap radius preset 20.
      final Finder preset20 = find.byKey(
        const ValueKey<String>('playground-theme-radius-preset-20'),
      );
      await ensureVisibleBelowHeader(tester, preset20);
      await tester.pumpAndSettle();
      await tester.tap(preset20);
      await tester.pumpAndSettle();

      final List<BoxDecoration> decs20 = decorations().toList();
      expect(decs20, isNotEmpty);
      bool foundRadius20 = false;
      for (final BoxDecoration d in decs20) {
        if (d.borderRadius != null) {
          final BorderRadius br = d.borderRadius! as BorderRadius;
          // radiusMd for radiusLg=20 is max(0, 20 - 2) = 18.
          if (br.topLeft.x == 18.0) {
            foundRadius20 = true;
          }
        }
      }
      expect(foundRadius20, isTrue);
    });
  });
}

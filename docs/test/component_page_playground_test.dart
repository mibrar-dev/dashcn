// Component page playground integration (Figma-like): one live preview,
// grouped controls drive every example, Reset + Copy code, 380 px desktop
// panel and phone bottom sheet.
//
// While the playground is open its canvas is the single preview: the left
// column drops its duplicate main preview card but keeps the description and
// the examples list. Every example on the page re-renders from the same
// playground values, so a variant/size change reaches all of them; the Code
// tabs keep the original per-example sources (deliberate overrides stay
// documented).

import 'package:docs/generated/docs_previews.dart';
import 'package:docs/playground/playground_config.dart';
import 'package:docs/playground/ui/playground_panel.dart';
import 'package:docs/routing/docs_router.dart';
import 'package:docs/ui/dashcn/components/button/button.dart';
import 'package:docs/widgets/example_preview_card.dart';
import 'package:docs/widgets/preview_stage.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/app_harness.dart';

Future<void> _openPlayground(
  WidgetTester tester,
  DocsRouterDelegate delegate,
) async {
  await ensureVisibleBelowHeader(
    tester,
    find.byKey(const ValueKey<String>('playground-open')),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const ValueKey<String>('playground-open')));
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
}

Finder _previewButtons() => find.descendant(
  of: find.byType(PreviewStage),
  matching: find.byType(Button),
);

Future<void> _pickOption(
  WidgetTester tester,
  String control,
  String option,
) async {
  final Finder trigger = find.byKey(
    ValueKey<String>('playground-select-$control'),
  );
  await ensureVisibleBelowHeader(tester, trigger);
  await tester.pump(const Duration(milliseconds: 100));
  await tester.tap(trigger);
  for (int i = 0; i < 5; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
  await tester.tap(find.text(option).last);
  for (int i = 0; i < 5; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

void main() {
  group('playground drives the component page', () {
    testWidgets('open hides the duplicate main preview, keeps examples', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      await goTo(tester, delegate, '/docs/components/button');
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();
      if (!kShowPlayground) {
        // Switch off: hidden, not deleted — no button or panel, but the
        // main + examples preview cards still render.
        expect(
          find.byKey(const ValueKey<String>('playground-open')),
          findsNothing,
        );
        expect(find.byType(PlaygroundPanel), findsNothing);
        expect(
          tester
              .widgetList<ExamplePreviewCard>(find.byType(ExamplePreviewCard))
              .length,
          kComponentPreviews['button']!.length,
        );
        return;
      }
      final int closedCount = tester
          .widgetList<ExamplePreviewCard>(find.byType(ExamplePreviewCard))
          .length;
      expect(
        closedCount,
        kComponentPreviews['button']!.length,
        reason: 'closed: main + examples',
      );
      await _openPlayground(tester, delegate);
      // Playground panel is open with grouped controls, Reset and Copy.
      expect(find.byType(PlaygroundPanel), findsOneWidget);
      expect(
        find.byKey(const ValueKey<String>('playground-group-appearance')),
        findsWidgets,
      );
      expect(
        find.byKey(const ValueKey<String>('playground-reset')),
        findsOneWidget,
      );
      expect(
        find.byKey(const ValueKey<String>('playground-copy')),
        findsOneWidget,
      );
      // Single live preview: the left column drops the main card, keeping
      // only the examples-section cards.
      final int openCount = tester
          .widgetList<ExamplePreviewCard>(find.byType(ExamplePreviewCard))
          .length;
      expect(
        openCount,
        kComponentPreviews['button']!.length - 1,
        reason: 'open: examples only, no duplicate main preview',
      );
      // Close restores the main card.
      await tester.tap(find.byKey(const ValueKey<String>('playground-close')));
      await tester.pumpAndSettle();
      expect(
        tester
            .widgetList<ExamplePreviewCard>(find.byType(ExamplePreviewCard))
            .length,
        closedCount,
      );
    });

    testWidgets('variant and size reach every button example', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      await goTo(tester, delegate, '/docs/components/button');
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();
      if (!kShowPlayground) {
        expect(
          find.byKey(const ValueKey<String>('playground-open')),
          findsNothing,
        );
        expect(find.byType(PlaygroundPanel), findsNothing);
        return;
      }
      await _openPlayground(tester, delegate);
      await _pickOption(tester, 'variant', 'outline');
      await _pickOption(tester, 'size', 'lg');
      await tester.pumpAndSettle();
      final List<Button> buttons = tester
          .widgetList<Button>(_previewButtons())
          .toList();
      expect(buttons, isNotEmpty);
      for (final Button button in buttons) {
        expect(
          button.variant,
          ButtonVariant.outline,
          reason: 'variant drives all',
        );
        expect(button.size, ButtonSize.lg, reason: 'size drives all');
      }
    });

    testWidgets('read-only entries never render as controls', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(tester);
      await goTo(tester, delegate, '/docs/components/button');
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();
      if (!kShowPlayground) {
        expect(
          find.byKey(const ValueKey<String>('playground-open')),
          findsNothing,
        );
        expect(find.byType(PlaygroundPanel), findsNothing);
        return;
      }
      await _openPlayground(tester, delegate);
      expect(
        find.byKey(const ValueKey<String>('playground-control-onPressedAsync')),
        findsNothing,
      );
      expect(
        find.byKey(const ValueKey<String>('playground-control-leading')),
        findsNothing,
      );
    });

    testWidgets('phone shows the playground as a bottom sheet', (
      WidgetTester tester,
    ) async {
      final DocsRouterDelegate delegate = await pumpDocsApp(
        tester,
        width: 375,
        height: 812,
      );
      await goTo(tester, delegate, '/docs/components/button');
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();
      if (!kShowPlayground) {
        expect(
          find.byKey(const ValueKey<String>('playground-open')),
          findsNothing,
        );
        expect(find.byType(PlaygroundPanel), findsNothing);
        return;
      }
      await _openPlayground(tester, delegate);
      expect(find.byType(PlaygroundPanel), findsOneWidget);
      expect(
        find.byKey(const ValueKey<String>('playground-group-appearance')),
        findsWidgets,
      );
      expect(
        find.byKey(const ValueKey<String>('playground-copy')),
        findsOneWidget,
      );
    });
  });
}

// P7-D2b: the preview canvas keeps the ORIGINAL surface (background token,
// as before P7-D2 — user feedback: blurred, not grey) with the dot pattern
// as a subtle blurred texture underneath sharp content.
//
// Covers the brief's gates without opening images (numeric checks only):
//   1. the canvas fill IS the background token (neutral + claude,
//      light + dark);
//   2. the dot pattern lives on its own blurred layer (`ImageFiltered`
//      wraps the pattern only — the pattern paints under opaque content);
//   3. the edge-strength dot alpha is 6–10% of foreground in light and
//      8–12% in dark;
//   4. the pattern layer paints once (a `RepaintBoundary` + a static
//      `CustomPaint` whose painter refuses same-colour repaints).
//
// Pixel proofs sample a rasterised stage: the centre pixel is the opaque
// content surface exactly, a dot-free corner pixel is the background
// colour, and an edge dot pixel differs from the background by a small
// (soft, blurred) amount — never zero (pattern present) and never a
// hard-dot step. Components separate from the canvas through their own
// border/shadow tokens; the canvas itself is never tinted.

import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:docs/theme/theme_document.dart';
import 'package:docs/ui/shadcn/theme/theme.dart';
import 'package:docs/widgets/preview_stage.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

ShadcnThemeData _theme(String preset, Brightness mode) =>
    ThemeDocument.fromPreset(preset).theme(mode);

/// Pumps a bare 400x300 stage (no frame) with an opaque probe as content.
Future<void> _pumpStage(
  WidgetTester tester,
  ShadcnThemeData theme,
  Color probeColor,
) async {
  await tester.pumpWidget(
    ShadcnTheme(
      data: theme,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: SizedBox(
            width: 400,
            height: 300,
            child: PreviewStage(
              minHeight: 300,
              child: SizedBox(
                width: 120,
                height: 80,
                child: ColoredBox(color: probeColor),
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
}

CustomPaint _patternPaint(WidgetTester tester) => tester.widget<CustomPaint>(
  find.byWidgetPredicate(
    (Widget w) => w is CustomPaint && w.painter is PreviewDotGridPainter,
  ),
);

void main() {
  group('P7-D2b preview canvas: blurred, not grey', () {
    for (final String preset in <String>['neutral', 'claude']) {
      for (final Brightness mode in Brightness.values) {
        test('$preset/${mode.name}: canvas is the background token', () {
          final ShadcnThemeData theme = _theme(preset, mode);
          expect(
            previewCanvasColor(theme.colors),
            theme.colors.background,
            reason: '$preset/${mode.name} canvas == background',
          );
        });

        test('$preset/${mode.name}: dot alpha within the soft range', () {
          final ShadcnThemeData theme = _theme(preset, mode);
          final double alpha = previewDotColor(theme.colors).a;
          if (mode == Brightness.dark) {
            expect(alpha, inInclusiveRange(0.08, 0.12));
          } else {
            expect(alpha, inInclusiveRange(0.06, 0.10));
          }
        });
      }
    }

    testWidgets('content is not blurred: filter wraps the pattern only', (
      WidgetTester tester,
    ) async {
      final ShadcnThemeData theme = _theme('neutral', Brightness.light);
      // Distinct probe colour: neutral-light card == background, so a
      // card-coloured probe would match the stage fill's own ColoredBox.
      const Color probeColor = Color(0xFF134E4A);
      await _pumpStage(tester, theme, probeColor);

      final Finder filter = find.byType(ImageFiltered);
      expect(filter, findsOneWidget, reason: 'exactly one blur layer');
      expect(
        find.descendant(
          of: filter,
          matching: find.byWidgetPredicate(
            (Widget w) =>
                w is CustomPaint && w.painter is PreviewDotGridPainter,
          ),
        ),
        findsOneWidget,
        reason: 'the blur wraps the dot pattern',
      );
      // The blur uses the shared pattern sigma on both axes (asserted at
      // the constant; the widget tree asserts the filter wraps the
      // pattern above).
      expect(
        kPreviewPatternBlur,
        1.5,
        reason: 'pattern blur stays a soft whisper',
      );
      // The opaque content probe is a sibling above the pattern, outside
      // the filtered subtree. (The probe colour is distinct from every
      // token, so the finder is unambiguous even when card == background.)
      final Finder probe = find.byWidgetPredicate(
        (Widget w) => w is ColoredBox && w.color == probeColor,
      );
      expect(
        find.descendant(of: filter, matching: probe),
        findsNothing,
        reason: 'content is never inside the blur',
      );
      expect(probe, findsOneWidget);

      // The stage fill is the background token, not a grey tint.
      expect(
        find.byWidgetPredicate(
          (Widget w) => w is Container && w.color == theme.colors.background,
        ),
        findsOneWidget,
        reason: 'stage paints the background token',
      );
    });

    testWidgets('pattern=false renders the canvas with no blur layer', (
      WidgetTester tester,
    ) async {
      final ShadcnThemeData theme = _theme('neutral', Brightness.light);
      await tester.pumpWidget(
        ShadcnTheme(
          data: theme,
          child: const Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: SizedBox(
                width: 400,
                child: PreviewStage(minHeight: 200, pattern: false),
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(ImageFiltered), findsNothing);
      expect(find.byType(PreviewStage), findsOneWidget);
    });

    testWidgets('pattern layer paints once: boundary + static paint', (
      WidgetTester tester,
    ) async {
      final ShadcnThemeData theme = _theme('neutral', Brightness.dark);
      await _pumpStage(tester, theme, theme.colors.card);
      final CustomPaint paint = _patternPaint(tester);
      expect(paint.isComplex, isTrue, reason: 'hints raster caching');
      expect(paint.willChange, isFalse, reason: 'never marked dirty');
      expect(
        find.ancestor(
          of: find.byWidgetPredicate(
            (Widget w) =>
                w is CustomPaint && w.painter is PreviewDotGridPainter,
          ),
          matching: find.byType(RepaintBoundary),
        ),
        findsOneWidget,
        reason: 'blur output is cached behind a boundary',
      );
      final PreviewDotGridPainter painter =
          paint.painter! as PreviewDotGridPainter;
      expect(
        painter.shouldRepaint(painter),
        isFalse,
        reason: 'same-theme rebuilds do not repaint',
      );
      expect(
        painter.shouldRepaint(
          PreviewDotGridPainter(color: previewDotColor(theme.colors)),
        ),
        isFalse,
        reason: 'equal-colour repaint is skipped',
      );
      expect(
        painter.color.a,
        inInclusiveRange(0.08, 0.12),
        reason: 'dark edge dots at 10% of foreground',
      );
    });

    for (final Brightness mode in Brightness.values) {
      testWidgets('pixels: neutral/${mode.name} content exact, dots soft', (
        WidgetTester tester,
      ) async {
        final ShadcnThemeData theme = _theme('neutral', mode);
        final Color canvas = theme.colors.background;
        final Color surface = theme.colors.card;
        final GlobalKey boundary = GlobalKey(debugLabel: 'p7d2b-stage');
        await tester.pumpWidget(
          ShadcnTheme(
            data: theme,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Center(
                child: RepaintBoundary(
                  key: boundary,
                  child: SizedBox(
                    width: 400,
                    height: 300,
                    child: PreviewStage(
                      minHeight: 300,
                      child: SizedBox(
                        width: 120,
                        height: 80,
                        child: ColoredBox(color: surface),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
        await tester.pump();

        final ui.Image image =
            await tester.runAsync(() async {
                  final RenderRepaintBoundary ro =
                      boundary.currentContext!.findRenderObject()
                          as RenderRepaintBoundary;
                  return ro.toImage(pixelRatio: 1);
                })
                as ui.Image;
        final ByteData? maybeBytes = await tester.runAsync<ByteData?>(
          () => image.toByteData(format: ui.ImageByteFormat.rawRgba),
        );
        final ByteData bytes = maybeBytes!;
        Color at(int x, int y) {
          final int i = (y * image.width + x) * 4;
          return Color.fromRGBO(
            bytes.getUint8(i),
            bytes.getUint8(i + 1),
            bytes.getUint8(i + 2),
            1,
          );
        }

        int channelDiff(Color a, Color b) {
          int ch(double v) => (v * 255).round();
          return (ch(a.r) - ch(b.r)).abs() +
              (ch(a.g) - ch(b.g)).abs() +
              (ch(a.b) - ch(b.b)).abs();
        }

        // Centre: opaque content covers the pattern; the surface is exact.
        expect(
          at(200, 150),
          surface,
          reason: 'neutral/${mode.name} content pixel is the card surface',
        );
        // Dot-free corner: the calm background shows through.
        expect(
          channelDiff(at(5, 5), canvas),
          lessThanOrEqualTo(4),
          reason: 'neutral/${mode.name} canvas pixel matches background',
        );
        // (10, 10) is a dot centre near the edge (full radial strength):
        // blurred, so it differs from the canvas by a whisper — present
        // but never a hard-dot step.
        final int dotDiff = channelDiff(at(10, 10), canvas);
        expect(
          dotDiff,
          inInclusiveRange(1, 12),
          reason: 'neutral/${mode.name} edge dot is soft but present',
        );
      });
    }
  });
}

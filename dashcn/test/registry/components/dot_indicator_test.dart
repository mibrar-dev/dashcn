// Widget tests for the `dot_indicator` component.
//
// Covers both axes, the interactive and read-only forms, tap reporting, the
// theme rows and all four precedence legs, plus six regressions from the old
// module: the dead `DotItem` (so no animation), the click cursor on a
// read-only run, the double-scaled padding, the `IntrinsicHeight`/`Flexible`
// layout, the missing token defaults, and the P7-WB fused dots (the fill
// lived on the `Clickable` decoration and painted over the gap padding, so
// neighbouring dots touched with no visible gap).
//
// Painting is asserted on the dot fill boxes (the `AnimatedContainer`s with
// a `BoxDecoration`): an interactive run adds one transparent tap-target
// `AnimatedContainer` per dot around its fill box.

import 'package:flutter/gestures.dart' show PointerDeviceKind;
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/dot_indicator/dot_indicator.dart';
import 'package:dashcn/src/components/dot_indicator/preview.dart';
import 'package:dashcn/src/foundation/component_preview.dart';
import 'package:dashcn/src/primitives/clickable.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

const Color _green = Color(0xFF00FF00);
const Color _blue = Color(0xFF0000FF);

Widget _frame(
  Widget child, {
  ThemeData data = const ThemeData(),
  List<ComponentThemeData> app = const <ComponentThemeData>[],
  DotIndicatorTheme? scoped,
}) {
  Widget body = child;
  if (scoped != null) {
    body = ComponentTheme<DotIndicatorTheme>(data: scoped, child: body);
  }
  return Theme(
    data: data,
    child: ComponentThemes(
      themes: app,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Align(alignment: Alignment.topLeft, child: body),
      ),
    ),
  );
}

List<AnimatedContainer> _dots(WidgetTester tester) => tester
    .widgetList<AnimatedContainer>(find.byType(AnimatedContainer))
    .toList();

/// The dot fill boxes: the `AnimatedContainer`s carrying a `BoxDecoration`.
/// An interactive run wraps each fill box in one transparent tap-target
/// `AnimatedContainer`, so this filters those out.
List<AnimatedContainer> _fills(WidgetTester tester) => _dots(
  tester,
).where((AnimatedContainer b) => b.decoration is BoxDecoration).toList();

BoxDecoration _decorationAt(WidgetTester tester, int i) =>
    _fills(tester)[i].decoration! as BoxDecoration;

Size _fillSizeAt(WidgetTester tester, int i) =>
    tester.getSize(find.byWidget(_fills(tester)[i]));

void main() {
  group('rendering', () {
    testWidgets('draws one dot per item', (tester) async {
      await tester.pumpWidget(_frame(const DotIndicator(index: 0, length: 4)));
      expect(_dots(tester), hasLength(4));
    });

    testWidgets('the active dot uses the primary token', (tester) async {
      await tester.pumpWidget(_frame(const DotIndicator(index: 1, length: 4)));
      expect(_decorationAt(tester, 1).color, ThemeColors.lightFallback.primary);
    });

    testWidgets('inactive dots use the muted token', (tester) async {
      await tester.pumpWidget(_frame(const DotIndicator(index: 1, length: 4)));
      expect(_decorationAt(tester, 0).color, ThemeColors.lightFallback.muted);
      expect(_decorationAt(tester, 3).color, ThemeColors.lightFallback.muted);
    });

    testWidgets('dots are full circles', (tester) async {
      await tester.pumpWidget(_frame(const DotIndicator(index: 0, length: 2)));
      expect(_decorationAt(tester, 0).borderRadius, BorderRadius.circular(6));
    });

    testWidgets('an out-of-range index leaves every dot inactive', (
      tester,
    ) async {
      await tester.pumpWidget(_frame(const DotIndicator(index: 99, length: 3)));
      for (final BoxDecoration box in _dots(
        tester,
      ).map((AnimatedContainer b) => b.decoration! as BoxDecoration)) {
        expect(box.color, ThemeColors.lightFallback.muted);
      }
    });

    testWidgets('the vertical axis stacks the dots', (tester) async {
      await tester.pumpWidget(
        _frame(
          const DotIndicator(index: 0, length: 3, direction: Axis.vertical),
        ),
      );
      final Rect size = tester.getRect(find.byType(DotIndicator));
      expect(_dots(tester), hasLength(3));
      expect(size.height, greaterThan(size.width));
    });
  });

  group('interaction', () {
    testWidgets('reports the tapped index', (tester) async {
      final List<int> reported = <int>[];
      await tester.pumpWidget(
        _frame(DotIndicator(index: 0, length: 4, onChanged: reported.add)),
      );
      final List<Rect> targets = tester
          .widgetList<Clickable>(find.byType(Clickable))
          .map((Clickable c) => tester.getRect(find.byWidget(c)))
          .toList();
      expect(targets, hasLength(4));
      await tester.tapAt(targets[2].center);
      expect(reported, <int>[2]);
    });

    testWidgets('a read-only run builds no Clickable', (tester) async {
      await tester.pumpWidget(_frame(const DotIndicator(index: 0, length: 4)));
      expect(find.byType(Clickable), findsNothing);
    });

    testWidgets('regression: a read-only run answers no tap', (tester) async {
      // The old widget installed a click cursor and a live `Clickable` even
      // when `onChanged` was null, so a read-only run looked pressable.
      await tester.pumpWidget(_frame(const DotIndicator(index: 0, length: 4)));
      final Rect dot = tester.getRect(find.byType(AnimatedContainer).first);
      await tester.tapAt(dot.center);
      expect(tester.takeException(), isNull);
      expect(find.byType(Clickable), findsNothing);
    });

    testWidgets('regression: the run paints its own animated decoration', (
      tester,
    ) async {
      // `DotItem` was the only animated dot and had zero readers, so the two
      // dots the indicator built were plain Containers.
      await tester.pumpWidget(_frame(const DotIndicator(index: 0, length: 2)));
      expect(find.byType(AnimatedContainer), findsNWidgets(2));
    });

    testWidgets('regression: interactive dots keep the theme gap', (
      tester,
    ) async {
      // P7-WB: the fill lived on the `Clickable` decoration and painted over
      // the gap padding, so neighbouring dots touched. The dot edges must
      // stay apart: each 12px dot centres in a 48px touch box, so the fills
      // sit 44px apart (48 - 12 + the 8px theme gap) instead of touching.
      await tester.pumpWidget(
        _frame(DotIndicator(index: 0, length: 3, onChanged: (_) {})),
      );
      await tester.pumpAndSettle();
      final List<Rect> fills = _fills(
        tester,
      ).map((AnimatedContainer b) => tester.getRect(find.byWidget(b))).toList();
      expect(fills, hasLength(3));
      expect(fills[0].width, 12);
      expect(fills[1].left - fills[0].right, moreOrLessEquals(44));
      expect(fills[2].left - fills[1].right, moreOrLessEquals(44));
    });

    testWidgets('regression: read-only dots keep the theme gap', (
      tester,
    ) async {
      await tester.pumpWidget(_frame(const DotIndicator(index: 0, length: 3)));
      await tester.pumpAndSettle();
      final List<Rect> fills = _fills(
        tester,
      ).map((AnimatedContainer b) => tester.getRect(find.byWidget(b))).toList();
      expect(fills, hasLength(3));
      expect(fills[1].left - fills[0].right, moreOrLessEquals(8));
      expect(fills[2].left - fills[1].right, moreOrLessEquals(8));
    });

    testWidgets('regression: the vertical run gaps the dots', (tester) async {
      await tester.pumpWidget(
        _frame(
          const DotIndicator(index: 0, length: 3, direction: Axis.vertical),
        ),
      );
      await tester.pumpAndSettle();
      final List<Rect> fills = _fills(
        tester,
      ).map((AnimatedContainer b) => tester.getRect(find.byWidget(b))).toList();
      expect(fills, hasLength(3));
      expect(fills[1].top - fills[0].bottom, moreOrLessEquals(8));
      expect(fills[2].top - fills[1].bottom, moreOrLessEquals(8));
    });

    testWidgets('hover tints the inactive dot with the accent row', (
      tester,
    ) async {
      // The fill moved off the `Clickable` decoration onto the inner dot;
      // the hovered row must still reach it through the states provider.
      FocusManager.instance.highlightStrategy =
          FocusHighlightStrategy.alwaysTraditional;
      addTearDown(
        () => FocusManager.instance.highlightStrategy =
            FocusHighlightStrategy.automatic,
      );
      await tester.pumpWidget(
        _frame(DotIndicator(index: 0, length: 2, onChanged: (_) {})),
      );
      expect(_decorationAt(tester, 1).color, ThemeColors.lightFallback.muted);
      final TestGesture gesture = await tester.createGesture(
        kind: PointerDeviceKind.mouse,
      );
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);
      await tester.pump();
      await gesture.moveTo(tester.getCenter(find.byType(Clickable).at(1)));
      await tester.pump();
      expect(_decorationAt(tester, 1).color, ThemeColors.lightFallback.accent);
      // The active dot keeps its primary fill under the pointer (the active
      // row tints to 90% on hover).
      await gesture.moveTo(tester.getCenter(find.byType(Clickable).first));
      await tester.pump();
      expect(
        _decorationAt(tester, 0).color,
        ThemeColors.lightFallback.primary.withValues(alpha: 0.9),
      );
    });
  });

  group('theme', () {
    testWidgets('the widget leg wins over everything', (tester) async {
      await tester.pumpWidget(
        _frame(
          const DotIndicator(
            index: 0,
            length: 2,
            theme: DotIndicatorTheme(
              active: DotStyle(
                background: StateValue(rest: ThemedColor.value(_green)),
                size: 20,
              ),
            ),
          ),
          app: const <ComponentThemeData>[
            DotIndicatorTheme(
              active: DotStyle(
                background: StateValue(rest: ThemedColor.value(_blue)),
              ),
            ),
          ],
        ),
      );
      expect(_decorationAt(tester, 0).color, _green);
      expect(_fillSizeAt(tester, 0), const Size(20, 20));
    });

    testWidgets('the scoped leg wins over the app leg', (tester) async {
      await tester.pumpWidget(
        _frame(
          const DotIndicator(index: 0, length: 2),
          app: const <ComponentThemeData>[
            DotIndicatorTheme(
              active: DotStyle(
                background: StateValue(rest: ThemedColor.value(_blue)),
              ),
            ),
          ],
          scoped: const DotIndicatorTheme(
            active: DotStyle(
              background: StateValue(rest: ThemedColor.value(_green)),
            ),
          ),
        ),
      );
      expect(_decorationAt(tester, 0).color, _green);
    });

    testWidgets('the app leg wins over the defaults', (tester) async {
      await tester.pumpWidget(
        _frame(
          const DotIndicator(index: 0, length: 2),
          app: const <ComponentThemeData>[
            DotIndicatorTheme(
              active: DotStyle(
                background: StateValue(rest: ThemedColor.value(_green)),
              ),
            ),
          ],
        ),
      );
      expect(_decorationAt(tester, 0).color, _green);
    });

    testWidgets('a leg that sets only the fill keeps the default size', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          const DotIndicator(index: 0, length: 2),
          app: const <ComponentThemeData>[
            DotIndicatorTheme(
              active: DotStyle(
                background: StateValue(rest: ThemedColor.value(_green)),
              ),
            ),
          ],
        ),
      );
      expect(_fillSizeAt(tester, 0), const Size(12, 12));
    });

    testWidgets('regression: a caller padding is applied once, unscaled', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          const DotIndicator(index: 0, length: 2, padding: EdgeInsets.all(20)),
          data: const ThemeData(scaling: 4),
        ),
      );
      final Padding padding = tester.widget<Padding>(
        find
            .descendant(
              of: find.byType(DotIndicator),
              matching: find.byType(Padding),
            )
            .first,
      );
      expect(padding.padding, const EdgeInsets.all(20));
    });

    testWidgets('regression: no IntrinsicHeight around a fixed-size row', (
      tester,
    ) async {
      await tester.pumpWidget(_frame(const DotIndicator(index: 0, length: 5)));
      expect(find.byType(IntrinsicHeight), findsNothing);
      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(Flexible), findsNothing);
    });
  });

  group('tokens', () {
    for (final (String name, ThemeColors colors) in <(String, ThemeColors)>[
      ('light', ThemeColors.lightFallback),
      ('dark', ThemeColors.darkFallback),
    ]) {
      testWidgets('$name tokens drive the rows', (tester) async {
        await tester.pumpWidget(
          _frame(
            const DotIndicator(index: 0, length: 2),
            data: ThemeData(colors: colors),
          ),
        );
        expect(_decorationAt(tester, 0).color, colors.primary);
        expect(_decorationAt(tester, 1).color, colors.muted);
      });
    }
  });

  group('custom builder', () {
    testWidgets('the builder replaces the default fill', (tester) async {
      await tester.pumpWidget(
        _frame(
          DotIndicator(
            index: 1,
            length: 3,
            dotBuilder: (context, index, isActive) =>
                SizedBox(width: isActive ? 30 : 10, height: 10),
          ),
        ),
      );
      expect(
        _dots(tester).every((AnimatedContainer b) => b.decoration == null),
        isTrue,
      );
    });
  });

  group('previews', () {
    testWidgets('every preview example pumps without throwing', (tester) async {
      for (final ComponentPreview preview in dotIndicatorPreviews) {
        await tester.pumpWidget(_frame(Builder(builder: preview.builder)));
        await tester.pump(const Duration(milliseconds: 200));
        expect(tester.takeException(), isNull);
      }
    });
  });
}

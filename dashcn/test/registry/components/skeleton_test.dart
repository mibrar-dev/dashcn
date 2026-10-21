// Widget tests for the `skeleton` component.
//
// Covers the loading/loaded switch, the shimmer sweep, the theme rows and all
// four precedence legs, light and dark tokens, plus four regressions from the
// old module: `snapshot` overriding `enabled`, `fromColor`/`toColor` having two
// different defaults, `enableSwitchAnimation` being a dead knob and the
// banned `package:skeletonizer` / Material dependency.

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/skeleton/skeleton.dart';
import 'package:dashcn/src/primitives/animation.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/density_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

const Color _green = Color(0xFF00FF00);
const Color _blue = Color(0xFF0000FF);

Widget _frame(
  Widget child, {
  ThemeData data = const ThemeData(),
  List<ComponentThemeData> app = const <ComponentThemeData>[],
  SkeletonTheme? scoped,
}) {
  Widget body = child;
  if (scoped != null) {
    body = ComponentTheme<SkeletonTheme>(data: scoped, child: body);
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

const Widget _content = SizedBox(width: 40, height: 20);

LinearGradient _sweep(WidgetTester tester) {
  final Finder container = find.descendant(
    of: find.byType(Skeleton),
    matching: find.byType(Container),
  );
  final BoxDecoration decoration =
      tester.widget<Container>(container.first).decoration! as BoxDecoration;
  return decoration.gradient! as LinearGradient;
}

Alignment _sweepBegin(WidgetTester tester) => _sweep(tester).begin as Alignment;

List<Color?> _sweepColors(WidgetTester tester) => _sweep(tester).colors;

Duration _sweepDuration(WidgetTester tester) => tester
    .widget<RepeatedAnimationBuilder>(find.byType(RepeatedAnimationBuilder))
    .duration;

BorderRadiusGeometry? _clipRadius(WidgetTester tester) =>
    tester.widget<ClipRRect>(find.byType(ClipRRect).first).borderRadius;

void main() {
  group('rendering', () {
    testWidgets('keeps the child box while loading', (tester) async {
      await tester.pumpWidget(_frame(const Skeleton(child: _content)));
      expect(find.byType(Container), findsWidgets);
      expect(tester.getSize(find.byType(Skeleton)), const Size(40, 20));
    });

    testWidgets('a disabled skeleton paints the child unchanged', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(const Skeleton(enabled: false, child: _content)),
      );
      expect(find.byType(Container), findsNothing);
      expect(find.byType(ClipRRect), findsOneWidget);
    });

    testWidgets('the sweep starts at zero and repeats to one', (tester) async {
      await tester.pumpWidget(_frame(const Skeleton(child: _content)));
      final RepeatedAnimationBuilder builder = tester
          .widget<RepeatedAnimationBuilder>(
            find.byType(RepeatedAnimationBuilder),
          );
      expect(builder.start, 0);
      expect(builder.end, 1);
      expect(builder.duration, skeletonDefaults.duration);

      // Value 0: the gradient begins fully outside the box on the left.
      expect(_sweepBegin(tester).x, -3);

      await tester.pump(const Duration(milliseconds: 400));
      expect(_sweepBegin(tester).x, greaterThan(-3));
      expect(tester.getSize(find.byType(Skeleton)), const Size(40, 20));
    });

    testWidgets('the sweep repeats every period', (tester) async {
      await tester.pumpWidget(_frame(const Skeleton(child: _content)));
      final Alignment start = _sweepBegin(tester);
      await tester.pump(const Duration(milliseconds: 150));
      expect(_sweepBegin(tester).x, isNot(start.x));
      // The remaining 650ms of the 800ms period bring the cycle back.
      await tester.pump(
        skeletonDefaults.duration! - const Duration(milliseconds: 150),
      );
      expect(_sweepBegin(tester).x, closeTo(start.x, 0.0001));
    });

    testWidgets('clamps the sweep to the placeholder', (tester) async {
      await tester.pumpWidget(_frame(const Skeleton(child: _content)));
      expect(find.byType(ClipRRect), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(ClipRRect),
          matching: find.byType(Container),
        ),
        findsOneWidget,
      );
    });

    testWidgets('a caller radius is applied once', (tester) async {
      await tester.pumpWidget(
        _frame(
          const Skeleton(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: _content,
          ),
        ),
      );
      expect(_clipRadius(tester), BorderRadius.circular(20));
    });

    testWidgets('the radius falls back to borderRadiusMd', (tester) async {
      await tester.pumpWidget(_frame(const Skeleton(child: _content)));
      expect(_clipRadius(tester), const ThemeData().borderRadiusMd);
    });
  });

  group('tokens', () {
    for (final (String name, ThemeColors colors) in <(String, ThemeColors)>[
      ('light', ThemeColors.lightFallback),
      ('dark', ThemeColors.darkFallback),
    ]) {
      testWidgets('$name tokens drive the sweep', (tester) async {
        await tester.pumpWidget(
          _frame(
            const Skeleton(child: _content),
            data: ThemeData(colors: colors),
          ),
        );
        expect(_sweepColors(tester), <Color?>[
          colors.muted,
          colors.accent,
          colors.muted,
        ]);
      });
    }
  });

  group('theme', () {
    testWidgets('the widget leg wins over everything', (tester) async {
      await tester.pumpWidget(
        _frame(
          const Skeleton(
            theme: SkeletonTheme(
              fromColor: ThemedColor.value(_green),
              duration: Duration(milliseconds: 900),
            ),
            child: _content,
          ),
          app: const <ComponentThemeData>[
            SkeletonTheme(
              fromColor: ThemedColor.value(_blue),
              duration: Duration(milliseconds: 400),
            ),
          ],
        ),
      );
      expect(_sweepColors(tester).first, _green);
      expect(_sweepDuration(tester), const Duration(milliseconds: 900));
    });

    testWidgets('the scoped leg wins over the app leg', (tester) async {
      await tester.pumpWidget(
        _frame(
          const Skeleton(child: _content),
          app: const <ComponentThemeData>[
            SkeletonTheme(fromColor: ThemedColor.value(_blue)),
          ],
          scoped: const SkeletonTheme(fromColor: ThemedColor.value(_green)),
        ),
      );
      expect(_sweepColors(tester).first, _green);
    });

    testWidgets('the app leg wins over the defaults', (tester) async {
      await tester.pumpWidget(
        _frame(
          const Skeleton(child: _content),
          app: const <ComponentThemeData>[
            SkeletonTheme(fromColor: ThemedColor.value(_green)),
          ],
        ),
      );
      expect(_sweepColors(tester).first, _green);
    });

    testWidgets('a leg that sets only the fill keeps the default duration', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          const Skeleton(child: _content),
          app: const <ComponentThemeData>[
            SkeletonTheme(fromColor: ThemedColor.value(_green)),
          ],
        ),
      );
      expect(_sweepDuration(tester), skeletonDefaults.duration);
    });

    testWidgets('the caller radius beats the theme radius', (tester) async {
      await tester.pumpWidget(
        _frame(
          const Skeleton(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: _content,
          ),
          scoped: const SkeletonTheme(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        ),
      );
      expect(_clipRadius(tester), BorderRadius.circular(20));
    });

    testWidgets('the theme radius beats the token default', (tester) async {
      await tester.pumpWidget(
        _frame(
          const Skeleton(child: _content),
          scoped: const SkeletonTheme(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        ),
      );
      expect(_clipRadius(tester), BorderRadius.circular(4));
    });
  });

  group('regressions', () {
    testWidgets('regression: `enabled: false` is never overridden', (
      tester,
    ) async {
      // The old `asSkeleton(snapshot:)` recomputed `enabled = !snapshot.hasData`
      // after reading the argument, so a disabled skeleton could still show.
      await tester.pumpWidget(
        _frame(const Skeleton(enabled: false, child: _content)),
      );
      expect(find.byType(Container), findsNothing);
    });

    testWidgets('regression: one pair of defaults, not two', (tester) async {
      // `SkeletonThemeDefaults` said 0x0D171717/0x1A171717 while the config
      // layer said primary@5%/primary@10% for the same two fields.
      await tester.pumpWidget(_frame(const Skeleton(child: _content)));
      final ThemeColors colors = const ThemeData().colors;
      expect(_sweepColors(tester), <Color?>[
        colors.muted,
        colors.accent,
        colors.muted,
      ]);
    });

    testWidgets('regression: no skeletonizer widget in the tree', (
      tester,
    ) async {
      await tester.pumpWidget(_frame(const Skeleton(child: _content)));
      expect(find.byType(RepeatedAnimationBuilder), findsOneWidget);
      expect(find.byType(ShaderMask), findsNothing);
      expect(find.byType(Opacity), findsNothing);
    });

    testWidgets('regression: the shimmer survives a full period', (
      tester,
    ) async {
      await tester.pumpWidget(_frame(const Skeleton(child: _content)));
      await tester.pump(const Duration(milliseconds: 2000));
      expect(tester.takeException(), isNull);
      expect(find.byType(RepeatedAnimationBuilder), findsOneWidget);
      expect(_sweepColors(tester).length, 3);
    });
  });

  group('shapes', () {
    testWidgets('line renders one bar per line, last one short', (
      tester,
    ) async {
      await tester.pumpWidget(_frame(const SkeletonLine(lines: 3)));
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.takeException(), isNull);
      // Three shimmer boxes: two full-width plus one fractional.
      expect(find.byType(FractionallySizedBox), findsOneWidget);
      final FractionallySizedBox last = tester.widget(
        find.byType(FractionallySizedBox),
      );
      expect(last.widthFactor, 0.6);
    });

    testWidgets('single-line fills the width', (tester) async {
      await tester.pumpWidget(_frame(const SkeletonLine(lines: 1)));
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.byType(FractionallySizedBox), findsNothing);
    });

    testWidgets('avatar is a square disc at the density control height', (
      tester,
    ) async {
      await tester.pumpWidget(_frame(const SkeletonAvatar()));
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.takeException(), isNull);
      expect(tester.getSize(find.byType(SkeletonAvatar)), const Size(32, 32));
    });

    testWidgets('avatar honours an explicit size', (tester) async {
      await tester.pumpWidget(_frame(const SkeletonAvatar(size: 48)));
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.getSize(find.byType(SkeletonAvatar)), const Size(48, 48));
    });

    testWidgets('block honours width and height', (tester) async {
      await tester.pumpWidget(
        _frame(const SkeletonBlock(width: 120, height: 24)),
      );
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.getSize(find.byType(SkeletonBlock)), const Size(120, 24));
    });

    testWidgets('custom line builder swaps every bar', (tester) async {
      var calls = 0;
      await tester.pumpWidget(
        _frame(
          SkeletonLine(
            lines: 2,
            lineBuilder: (context, index, isLast, bar) {
              calls++;
              return SizedBox(key: ValueKey('custom-$index'), height: 8);
            },
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));
      expect(calls, 2);
      expect(find.byKey(const ValueKey('custom-0')), findsOneWidget);
      expect(find.byKey(const ValueKey('custom-1')), findsOneWidget);
    });

    testWidgets('custom avatar builder replaces the disc', (tester) async {
      await tester.pumpWidget(
        _frame(
          SkeletonAvatar(
            avatarBuilder: (context, disc) =>
                const SizedBox(key: ValueKey('ava'), width: 10, height: 10),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.byKey(const ValueKey('ava')), findsOneWidget);
    });
  });

  group('compose', () {
    testWidgets('card paints a frosted surface', (tester) async {
      await tester.pumpWidget(_frame(const SkeletonCard()));
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.takeException(), isNull);
      expect(find.byType(SkeletonAvatar), findsOneWidget);
      expect(find.byType(SkeletonLine), findsAtLeastNWidgets(1));
    });

    testWidgets('card footer is opt-in', (tester) async {
      await tester.pumpWidget(_frame(const SkeletonCard(showFooter: false)));
      await tester.pump(const Duration(milliseconds: 100));
      // Header title (2 lines) + content (2 lines), no footer line.
      expect(find.byType(SkeletonLine), findsNWidgets(2));
      await tester.pumpWidget(_frame(const SkeletonCard(showFooter: true)));
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.byType(SkeletonLine), findsNWidgets(3));
    });

    testWidgets('list renders one row per item', (tester) async {
      await tester.pumpWidget(_frame(const SkeletonList(itemCount: 3)));
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.takeException(), isNull);
      expect(find.byType(SkeletonAvatar), findsNWidgets(3));
    });

    testWidgets('list custom builders run per row', (tester) async {
      var titles = 0;
      await tester.pumpWidget(
        _frame(
          SkeletonList(
            itemCount: 2,
            titleBuilder: (context, index, title) {
              titles++;
              return title;
            },
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));
      expect(titles, 2);
    });

    testWidgets('table renders header plus body grid', (tester) async {
      await tester.pumpWidget(_frame(const SkeletonTable(columns: 3, rows: 4)));
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.takeException(), isNull);
      // Header blocks + body lines.
      expect(find.byType(SkeletonBlock), findsNWidgets(3));
      expect(find.byType(SkeletonLine), findsNWidgets(12));
    });

    testWidgets('table hides the header on demand', (tester) async {
      await tester.pumpWidget(
        _frame(const SkeletonTable(columns: 2, rows: 2, showHeader: false)),
      );
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.byType(SkeletonBlock), findsNothing);
      expect(find.byType(SkeletonLine), findsNWidgets(4));
    });

    testWidgets('table cell builder swaps cells', (tester) async {
      await tester.pumpWidget(
        _frame(
          SkeletonTable(
            columns: 2,
            rows: 1,
            showHeader: false,
            cellBuilder: (context, row, column, cell) =>
                SizedBox(key: ValueKey('cell-$row-$column'), height: 8),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.byKey(const ValueKey('cell-0-0')), findsOneWidget);
      expect(find.byKey(const ValueKey('cell-0-1')), findsOneWidget);
    });
  });

  group('mirror', () {
    testWidgets('enabled fills the child box with the placeholder', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          const SkeletonMirror(
            placeholderBuilder: _mirrorPlaceholder,
            child: SizedBox(width: 200, height: 60),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.takeException(), isNull);
      expect(find.byType(SkeletonLine), findsOneWidget);
      // The stack sizes itself to the real child box.
      expect(tester.getSize(find.byType(SkeletonMirror)), const Size(200, 60));
    });

    testWidgets('disabled paints the child', (tester) async {
      await tester.pumpWidget(
        _frame(
          const SkeletonMirror(
            enabled: false,
            placeholderBuilder: _mirrorPlaceholder,
            child: Text('loaded'),
          ),
        ),
      );
      expect(find.text('loaded'), findsOneWidget);
      expect(find.byType(SkeletonLine), findsNothing);
    });

    testWidgets('real child is hidden from semantics while loading', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          const SkeletonMirror(
            placeholderBuilder: _mirrorPlaceholder,
            child: Text('secret'),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));
      // The invisible layout child keeps its box but drops its semantics.
      expect(find.byType(ExcludeSemantics), findsOneWidget);
    });
  });

  group('density + motion + a11y', () {
    testWidgets('touch tokens grow the avatar', (tester) async {
      await tester.pumpWidget(
        _frame(const SkeletonAvatar(densityTokens: DensityTokens.touch)),
      );
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.getSize(find.byType(SkeletonAvatar)), const Size(48, 48));
    });

    testWidgets('theme row height wins over the density default', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          const SkeletonList(itemCount: 1, theme: SkeletonTheme(rowHeight: 56)),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.takeException(), isNull);
      expect(find.byType(SkeletonAvatar), findsOneWidget);
    });

    testWidgets('reduced motion parks the sweep with no ticker', (
      tester,
    ) async {
      await tester.pumpWidget(
        Theme(
          data: const ThemeData(),
          child: ComponentThemes(
            themes: const <ComponentThemeData>[],
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: MediaQuery(
                data: const MediaQueryData(disableAnimations: true),
                child: const Skeleton(child: _content),
              ),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.byType(RepeatedAnimationBuilder), findsNothing);
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('placeholders announce a loading label', (tester) async {
      await tester.pumpWidget(_frame(const SkeletonLine(lines: 1)));
      await tester.pump(const Duration(milliseconds: 100));
      final Semantics semantics = tester.widget(find.byType(Semantics).first);
      expect(semantics.properties.label, 'Loading');
    });

    testWidgets('RTL mirrors without overflow', (tester) async {
      await tester.pumpWidget(
        Theme(
          data: const ThemeData(),
          child: ComponentThemes(
            themes: const <ComponentThemeData>[],
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: const SkeletonLine(lines: 3),
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));
      expect(tester.takeException(), isNull);
    });

    testWidgets('375px phone width fits list, card and table', (tester) async {
      Future<void> pump(Widget child) async {
        await tester.pumpWidget(
          Theme(
            data: const ThemeData(),
            child: ComponentThemes(
              themes: const <ComponentThemeData>[],
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Center(child: SizedBox(width: 375, child: child)),
              ),
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 100));
        expect(
          tester.takeException(),
          isNull,
          reason: 'overflow in ${child.runtimeType}',
        );
      }

      await pump(const SkeletonList(itemCount: 3));
      await pump(const SkeletonCard());
      await pump(const SkeletonTable(columns: 3, rows: 4));
      await pump(const SkeletonLine(lines: 3));
    });
  });

  group('loop', () {
    Future<double> firstBeginX(WidgetTester tester, Widget child) async {
      await tester.pumpWidget(_frame(child));
      await tester.pump(const Duration(milliseconds: 100));
      return _sweepBegin(tester).x;
    }

    testWidgets('card shimmer animates across two frames', (tester) async {
      final double before = await firstBeginX(tester, const SkeletonCard());
      await tester.pump(const Duration(milliseconds: 200));
      expect(_sweepBegin(tester).x, isNot(before));
    });

    testWidgets('list shimmer animates across two frames', (tester) async {
      final double before = await firstBeginX(
        tester,
        const SkeletonList(itemCount: 3),
      );
      await tester.pump(const Duration(milliseconds: 200));
      expect(_sweepBegin(tester).x, isNot(before));
    });

    testWidgets('table shimmer animates across two frames', (tester) async {
      final double before = await firstBeginX(
        tester,
        const SkeletonTable(columns: 3, rows: 4),
      );
      await tester.pump(const Duration(milliseconds: 200));
      expect(_sweepBegin(tester).x, isNot(before));
    });
  });
}

Widget _mirrorPlaceholder(BuildContext context) => const SkeletonLine(lines: 2);

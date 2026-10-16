// Unit tests for the shared frosted-glass primitive
// (`primitives/surface.dart`): opacity mapping, blur-layer gating and the
// opaque default (no visual change, no extra layer).

import 'dart:ui' show ImageFilter;

import 'package:dashcn/src/primitives/surface.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

const Color _base = Color(0xFF336699);

Widget _frame({required Widget child, ThemeData data = const ThemeData()}) {
  return Theme(
    data: data,
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: Center(child: child),
    ),
  );
}

void main() {
  group('surfaceColor', () {
    test('null opacity returns the base colour unchanged', () {
      expect(surfaceColor(_base, null), _base);
    });

    test('1.0 opacity returns the base colour unchanged', () {
      expect(surfaceColor(_base, 1.0), _base);
    });

    test('opacity above 1.0 clamps to the base colour', () {
      expect(surfaceColor(_base, 2.0), _base);
    });

    test('0.7 multiplies the alpha', () {
      final Color painted = surfaceColor(_base, 0.7);
      expect(painted.a, moreOrLessEquals(_base.a * 0.7, epsilon: 0.01));
      expect(painted.r, moreOrLessEquals(_base.r, epsilon: 0.01));
      expect(painted.g, moreOrLessEquals(_base.g, epsilon: 0.01));
      expect(painted.b, moreOrLessEquals(_base.b, epsilon: 0.01));
    });

    test('0.0 paints transparent', () {
      expect(surfaceColor(_base, 0.0).a, 0.0);
    });
  });

  group('hasSurfaceBlur', () {
    test('null and zero are no blur', () {
      expect(hasSurfaceBlur(null), isFalse);
      expect(hasSurfaceBlur(0), isFalse);
      expect(hasSurfaceBlur(-4), isFalse);
    });

    test('positive sigma is a blur', () {
      expect(hasSurfaceBlur(8), isTrue);
    });
  });

  group('GlassSurface', () {
    testWidgets('default renders the child with no extra layer', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(child: const GlassSurface(child: Text('body'))),
      );
      expect(find.byType(BackdropFilter), findsNothing);
      expect(find.byType(ClipRRect), findsNothing);
      expect(find.text('body'), findsOneWidget);
    });

    testWidgets('explicit zero blur renders no layer', (tester) async {
      await tester.pumpWidget(
        _frame(child: const GlassSurface(surfaceBlur: 0, child: Text('body'))),
      );
      expect(find.byType(BackdropFilter), findsNothing);
    });

    testWidgets('positive blur wraps in ClipRRect + BackdropFilter', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          child: const GlassSurface(
            surfaceBlur: 8,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: Text('body'),
          ),
        ),
      );
      expect(find.byType(BackdropFilter), findsOneWidget);
      final ClipRRect clip = tester.widget<ClipRRect>(find.byType(ClipRRect));
      expect(clip.borderRadius, const BorderRadius.all(Radius.circular(12)));
      final BackdropFilter filter = tester.widget<BackdropFilter>(
        find.byType(BackdropFilter),
      );
      expect(filter.filter, isA<ImageFilter>());
    });
  });

  group('resolveSurface', () {
    testWidgets('falls back to the ambient theme', (tester) async {
      const ThemeData data = ThemeData(surfaceOpacity: 0.7, surfaceBlur: 8);
      late double? opacity;
      late double? blur;
      await tester.pumpWidget(
        _frame(
          data: data,
          child: Builder(
            builder: (BuildContext context) {
              opacity = resolveSurfaceOpacity(context);
              blur = resolveSurfaceBlur(context);
              return const SizedBox();
            },
          ),
        ),
      );
      expect(opacity, 0.7);
      expect(blur, 8);
    });

    testWidgets('component value wins over the ambient theme', (tester) async {
      const ThemeData data = ThemeData(surfaceOpacity: 0.5, surfaceBlur: 4);
      late double? opacity;
      late double? blur;
      await tester.pumpWidget(
        _frame(
          data: data,
          child: Builder(
            builder: (BuildContext context) {
              opacity = resolveSurfaceOpacity(context, component: 0.8);
              blur = resolveSurfaceBlur(context, component: 12);
              return const SizedBox();
            },
          ),
        ),
      );
      expect(opacity, 0.8);
      expect(blur, 12);
    });

    testWidgets('widget value wins over the component value', (tester) async {
      const ThemeData data = ThemeData(surfaceOpacity: 0.5, surfaceBlur: 4);
      late double? opacity;
      late double? blur;
      await tester.pumpWidget(
        _frame(
          data: data,
          child: Builder(
            builder: (BuildContext context) {
              opacity = resolveSurfaceOpacity(
                context,
                widget: 0.9,
                component: 0.8,
              );
              blur = resolveSurfaceBlur(context, widget: 16, component: 12);
              return const SizedBox();
            },
          ),
        ),
      );
      expect(opacity, 0.9);
      expect(blur, 16);
    });
  });
}

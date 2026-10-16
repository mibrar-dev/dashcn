// App preview theming (live-qa #3).
//
// Root cause: `AppPreview` built a bare `DashcnApp` (default light
// fallback theme, resolved via `MediaQuery`), so its banner painted white
// (`background: 0xFFFFFFFF`) on the dark docs canvas. Fix: the preview
// inherits the ambient site theme for both legs and renders the banner as
// a themed card (`card`/`cardForeground`/`border`, `radiusLg`), centred.

import 'package:dashcn/src/components/app/preview.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pumpPreview(WidgetTester tester, ThemeData outer) async {
  await tester.pumpWidget(
    Theme(
      data: outer,
      child: const Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: SizedBox(width: 600, height: 400, child: AppPreview()),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  const ThemeData light = ThemeData(colors: ThemeColors.lightFallback);
  const ThemeData dark = ThemeData(colors: ThemeColors.darkFallback);

  testWidgets('banner uses the ambient light theme (not white-on-dark)', (
    tester,
  ) async {
    await _pumpPreview(tester, light);
    expect(find.text('DashcnApp is wired and running.'), findsOneWidget);

    final DecoratedBox banner = tester.widget<DecoratedBox>(
      find.byWidgetPredicate(
        (Widget w) =>
            w is DecoratedBox &&
            w.decoration is BoxDecoration &&
            (w.decoration as BoxDecoration).border is Border,
      ),
    );
    final BoxDecoration decoration = banner.decoration as BoxDecoration;
    expect(decoration.color, light.colors.card);
    expect(decoration.border!.top.color, light.colors.border);
    expect(decoration.borderRadius, light.borderRadiusLg);
    // Centred in the stage.
    expect(
      find.ancestor(of: find.byWidget(banner), matching: find.byType(Center)),
      findsWidgets,
    );
    // Title reads on the card; the dismiss line is muted.
    final Text title = tester.widget<Text>(
      find.text('DashcnApp is wired and running.'),
    );
    expect(title.style!.color, light.colors.cardForeground);
  });

  testWidgets('banner follows the dark theme', (tester) async {
    await _pumpPreview(tester, dark);
    expect(find.text('DashcnApp is wired and running.'), findsOneWidget);

    final DecoratedBox banner = tester.widget<DecoratedBox>(
      find.byWidgetPredicate(
        (Widget w) =>
            w is DecoratedBox &&
            w.decoration is BoxDecoration &&
            (w.decoration as BoxDecoration).border is Border,
      ),
    );
    final BoxDecoration decoration = banner.decoration as BoxDecoration;
    expect(decoration.color, dark.colors.card);
    expect(decoration.color, isNot(const Color(0xFFFFFFFF)));
    expect(decoration.border!.top.color, dark.colors.border);
    expect(decoration.borderRadius, dark.borderRadiusLg);
    final Text title = tester.widget<Text>(
      find.text('DashcnApp is wired and running.'),
    );
    expect(title.style!.color, dark.colors.cardForeground);
  });
}

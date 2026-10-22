// P7-TH1 — the whole site follows the selected theme exactly.
//
// Widget tests that drive the Theme Studio model (radius 0 → 1rem, a preset
// switch, density compact → comfortable, a font switch) and assert the hero
// buttons/pill, header buttons, home cards, block cards and docs chrome all
// track the tokens (decoration radii equal the theme values, colours equal
// the tokens, spacing/font follow).

import 'package:docs/routing/docs_router.dart';
import 'package:docs/state/docs_state.dart';
import 'package:docs/ui/dashcn/components/badge/badge.dart';
import 'package:docs/ui/dashcn/components/button/button.dart';
import 'package:docs/ui/dashcn/components/card/card.dart';
import 'package:docs/ui/dashcn/primitives/clickable.dart';
import 'package:docs/ui/dashcn/theme/theme.dart';
import 'package:docs/widgets/announcement.dart';
import 'package:docs/widgets/block_card.dart';
import 'package:docs/widgets/collage_cards.dart';
import 'package:docs/widgets/docs_header.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/app_harness.dart';

/// Corner radius of a registry [Button]'s resting decoration.
BorderRadius? _buttonRadius(WidgetTester tester, Finder button) {
  final Clickable clickable = tester.widget<Clickable>(
    find.descendant(of: button, matching: find.byType(Clickable)),
  );
  final Decoration? decoration = clickable.decoration!.resolve(
    const <WidgetState>{},
  );
  return (decoration! as BoxDecoration).borderRadius as BorderRadius?;
}

/// Corner radius of a static registry [Badge].
BorderRadius? _badgeRadius(WidgetTester tester, Finder badge) {
  final DecoratedBox box = tester.widget<DecoratedBox>(
    find.descendant(of: badge, matching: find.byType(DecoratedBox)).first,
  );
  return (box.decoration as BoxDecoration).borderRadius as BorderRadius?;
}

/// Navigates the pumped app to [location] and settles, using the ROOT
/// navigator explicitly: deferred preview chunks cached from earlier tests
/// can add nested Navigators to the landing collage, which makes the
/// shared `goTo` helper (Navigator.last) misfire (P7-TH1 suite order).
Future<void> _goTo(
  WidgetTester tester,
  DocsRouterDelegate delegate,
  String location,
) async {
  delegate.go(tester.element(find.byType(Navigator).first), location);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('hero CTAs and header CTA follow the theme radius', (
    tester,
  ) async {
    await pumpDocsApp(tester, width: 1400);
    expect(find.text('Every platform at once'), findsOneWidget);

    docsState.themeModel.setRadiusPx(0);
    await tester.pumpAndSettle();
    ThemeData theme = docsState.theme;
    expect(theme.borderRadiusMd, BorderRadius.zero);
    final Finder ctas = find.widgetWithText(Button, 'Get Started');
    expect(ctas, findsWidgets);
    for (final Element element in ctas.evaluate()) {
      expect(
        _buttonRadius(tester, find.byWidget(element.widget)),
        BorderRadius.zero,
        reason: 'radius 0 makes every CTA square',
      );
    }

    docsState.themeModel.setRadiusPx(16);
    await tester.pumpAndSettle();
    theme = docsState.theme;
    expect(theme.radiusMd, 14);
    for (final Element element in ctas.evaluate()) {
      expect(
        _buttonRadius(tester, find.byWidget(element.widget)),
        theme.borderRadiusMd,
        reason: 'radius 1rem reshapes every CTA, hero and header alike',
      );
    }
  });

  testWidgets('announcement pill follows the theme radius', (tester) async {
    await pumpDocsApp(tester, width: 1400);
    final Finder pill = find.byType(Announcement);
    expect(pill, findsOneWidget);
    final Finder badge = find.descendant(
      of: pill,
      matching: find.byType(Badge),
    );
    expect(badge, findsOneWidget);

    docsState.themeModel.setRadiusPx(0);
    await tester.pumpAndSettle();
    expect(_badgeRadius(tester, badge), BorderRadius.zero);

    docsState.themeModel.setRadiusPx(16);
    await tester.pumpAndSettle();
    expect(
      _badgeRadius(tester, badge),
      docsState.theme.borderRadiusMd,
      reason: 'the pill is the registry Badge radius, never a fixed 999',
    );
  });

  testWidgets('preset switch re-themes chrome colours', (tester) async {
    await pumpDocsApp(tester, width: 1400);
    ThemeData before = docsState.theme;
    final Color beforePrimary = before.colors.primary;

    docsState.themeModel.selectPreset('claude');
    await tester.pumpAndSettle();
    final ThemeData after = docsState.theme;
    expect(
      after.colors.primary,
      isNot(equals(beforePrimary)),
      reason: 'neutral and claude primaries differ',
    );
    // Hero title tracks the foreground token.
    final Text title = tester.widget<Text>(find.text('Every platform at once'));
    expect(title.style!.color, after.colors.foreground);
    // Header bar tracks the background token (kit NavigationBar bar surface:
    // a ColoredBox painted with surfaceColor(background, surfaceOpacity)).
    final Iterable<ColoredBox> bars = tester.widgetList<ColoredBox>(
      find.descendant(
        of: find.byType(DocsHeader),
        matching: find.byType(ColoredBox),
      ),
    );
    expect(
      bars.any((ColoredBox bar) => bar.color == after.colors.background),
      isTrue,
      reason: 'header fill equals the background token',
    );
  });

  testWidgets('density switch re-spaces home cards', (tester) async {
    await pumpDocsApp(tester, width: 1400);
    docsState.themeModel.setSpacingRem(0.2);
    await tester.pumpAndSettle();
    final double compactGap = docsState.theme.spacing.sm;
    docsState.themeModel.setSpacingRem(0.3);
    await tester.pumpAndSettle();
    final ThemeData theme = docsState.theme;
    expect(theme.spacing.sm, greaterThan(compactGap));
    // Collage cards hug theme padding, radius and shadows.
    final Card card = tester.widget<Card>(
      find
          .descendant(of: find.byType(CollageCard), matching: find.byType(Card))
          .first,
    );
    expect(find.byType(CollageCard), findsWidgets);
    expect(card.borderRadius, theme.borderRadiusXl);
    expect(card.shadows, theme.tokens.shadows.shadowSm);
  });

  testWidgets('font switch re-types the hero', (tester) async {
    await pumpDocsApp(tester, width: 1400);
    expect(kDocsFontOptions.length, greaterThan(1));
    final String first = kDocsFontOptions.first;
    String second = kDocsFontOptions[1];
    if (second == first) {
      second = kDocsFontOptions.last;
    }
    docsState.themeModel.setFont('sans', first);
    await tester.pumpAndSettle();
    Text title = tester.widget<Text>(find.text('Every platform at once'));
    expect(title.style!.fontFamily, docsState.theme.typography.sans.fontFamily);

    docsState.themeModel.setFont('sans', second);
    await tester.pumpAndSettle();
    title = tester.widget<Text>(find.text('Every platform at once'));
    expect(title.style!.fontFamily, docsState.theme.typography.sans.fontFamily);
    expect(
      docsState.theme.typography.sans.fontFamily,
      isNotNull,
      reason: 'a concrete family list is wired into the type scale',
    );
  });

  testWidgets('block cards follow the theme radius', (tester) async {
    await pumpDocsApp(tester, width: 1400);
    final DocsRouterDelegate delegate = tester
        .widget<DocsRouterScope>(find.byType(DocsRouterScope).first)
        .delegate;
    await _goTo(tester, delegate, '/blocks');
    expect(find.byType(BlockCard), findsWidgets);

    docsState.themeModel.setRadiusPx(0);
    await tester.pumpAndSettle();
    DecoratedBox frame = tester.widget<DecoratedBox>(
      find
          .descendant(
            of: find.byType(BlockCard).first,
            matching: find.byType(DecoratedBox),
          )
          .first,
    );
    expect((frame.decoration as BoxDecoration).borderRadius, BorderRadius.zero);

    docsState.themeModel.setRadiusPx(16);
    await tester.pumpAndSettle();
    frame = tester.widget<DecoratedBox>(
      find
          .descendant(
            of: find.byType(BlockCard).first,
            matching: find.byType(DecoratedBox),
          )
          .first,
    );
    expect(
      (frame.decoration as BoxDecoration).borderRadius,
      docsState.theme.borderRadiusXl,
      reason: 'block cards use the xl radius token',
    );
  });
}

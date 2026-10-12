// P7-B2 full-page layout tests: every block renders as a real page.
//
// At the desktop page size (1280×800) split panels each take 50% width and
// 100% height, sidebars run (nearly) full height and every block fills the
// viewport instead of floating as a small card. At the mobile page width
// (390) the split brand panels hide and every block pumps without exception
// or overflow.

import 'package:flutter/widgets.dart';
import 'package:flutter_shadcn_kit/registry/blocks/account-01/account_01.dart';
import 'package:flutter_shadcn_kit/registry/blocks/account-02/account_02.dart';
import 'package:flutter_shadcn_kit/registry/blocks/calendar-01/calendar_01.dart';
import 'package:flutter_shadcn_kit/registry/blocks/calendar-02/calendar_02.dart';
import 'package:flutter_shadcn_kit/registry/blocks/dashboard-01/dashboard_01.dart';
import 'package:flutter_shadcn_kit/registry/blocks/dashboard-02/dashboard_02.dart';
import 'package:flutter_shadcn_kit/registry/blocks/login-01/login_01.dart';
import 'package:flutter_shadcn_kit/registry/blocks/login-02/login_02.dart';
import 'package:flutter_shadcn_kit/registry/blocks/login-02/login_02_panel.dart';
import 'package:flutter_shadcn_kit/registry/blocks/login-03/login_03.dart';
import 'package:flutter_shadcn_kit/registry/blocks/otp-01/otp_01.dart';
import 'package:flutter_shadcn_kit/registry/blocks/pricing-01/pricing_01.dart';
import 'package:flutter_shadcn_kit/registry/blocks/sidebar-01/sidebar_01.dart';
import 'package:flutter_shadcn_kit/registry/blocks/sidebar-02/sidebar_02.dart';
import 'package:flutter_shadcn_kit/registry/blocks/sidebar-02/sidebar_02_panel.dart';
import 'package:flutter_shadcn_kit/registry/blocks/sidebar-03/sidebar_03.dart';
import 'package:flutter_shadcn_kit/registry/blocks/signup-01/signup_01.dart';
import 'package:flutter_shadcn_kit/registry/blocks/signup-02/signup_02.dart';
import 'package:flutter_shadcn_kit/registry/blocks/signup-02/signup_02_aside.dart';
import 'package:flutter_shadcn_kit/registry/components/button/button.dart';
import 'package:flutter_shadcn_kit/registry/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

import '../themes/generated_theme.dart';
import 'blocks_support.dart';

/// Pumps [child] in a tight [width]×[height] page stage (the docs
/// page-size frame) and asserts nothing threw.
///
/// The tester viewport is set to the page size first: a bare `SizedBox`
/// larger than the default 800×600 test viewport would otherwise be clamped
/// to the viewport, so the block would never see the requested size.
Future<void> pumpPage(
  WidgetTester tester,
  Widget child,
  ShadcnThemeDataView theme,
  double width,
  double height,
) async {
  tester.view.physicalSize = Size(width, height);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ShadcnTheme(
      data: ShadcnThemeData(
        colors: theme.colors,
        tokens: theme.tokens,
        fonts: theme.fonts,
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Overlay.wrap(
          child: SizedBox(width: width, height: height, child: child),
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 16));
  final Object? exception = tester.takeException();
  expect(exception, isNull, reason: 'block at ${width}x$height threw');
}

void main() {
  group('P7-B2 split pages at 1280x800', () {
    testWidgets('login-02 halves are 50% width and 100% height', (
      WidgetTester tester,
    ) async {
      final ShadcnThemeDataView theme = blockTheme('neutral', Brightness.light);
      await pumpPage(tester, const Login02(), theme, 1280, 800);
      final Rect panel = tester.getRect(find.byType(Login02Panel));
      expect(panel.width, moreOrLessEquals(640, epsilon: 2));
      expect(panel.height, moreOrLessEquals(800, epsilon: 2));
      expect(panel.left, moreOrLessEquals(640, epsilon: 2));
      // The form lives in the left half: its submit button sits left of
      // the split.
      final Rect action = tester.getRect(
        find.widgetWithText(Button, 'Sign in'),
      );
      expect(action.right, lessThan(640));
      expect(tester.takeException(), isNull);
    });

    testWidgets('signup-02 halves are 50% width and 100% height', (
      WidgetTester tester,
    ) async {
      final ShadcnThemeDataView theme = blockTheme('neutral', Brightness.light);
      await pumpPage(tester, const Signup02(), theme, 1280, 800);
      final Rect panel = tester.getRect(find.byType(Signup02Aside));
      expect(panel.width, moreOrLessEquals(640, epsilon: 2));
      expect(panel.height, moreOrLessEquals(800, epsilon: 2));
      expect(panel.left, moreOrLessEquals(640, epsilon: 2));
      expect(tester.takeException(), isNull);
    });
  });

  group('P7-B2 sidebars run full height at 1280x800', () {
    testWidgets('sidebar-02 panel fills the page height', (
      WidgetTester tester,
    ) async {
      final ShadcnThemeDataView theme = blockTheme('neutral', Brightness.light);
      await pumpPage(tester, const Sidebar02(), theme, 1280, 800);
      final Rect panel = tester.getRect(find.byType(Sidebar02Panel).first);
      // Inset by the page gutter, otherwise full height (not a small card).
      expect(panel.height, greaterThan(700));
      expect(panel.height, lessThanOrEqualTo(800));
      expect(tester.takeException(), isNull);
    });

    testWidgets('sidebar-03 shell fills the viewport', (
      WidgetTester tester,
    ) async {
      final ShadcnThemeDataView theme = blockTheme('neutral', Brightness.light);
      await pumpPage(tester, const Sidebar03(), theme, 1280, 800);
      final Size root = tester.getSize(find.byType(Sidebar03));
      expect(root.width, moreOrLessEquals(1280, epsilon: 1));
      expect(root.height, moreOrLessEquals(800, epsilon: 1));
      expect(tester.takeException(), isNull);
    });

    testWidgets('sidebar-01 shell fills the viewport', (
      WidgetTester tester,
    ) async {
      final ShadcnThemeDataView theme = blockTheme('neutral', Brightness.light);
      await pumpPage(tester, const Sidebar01(), theme, 1280, 800);
      final Size root = tester.getSize(find.byType(Sidebar01));
      expect(root.width, moreOrLessEquals(1280, epsilon: 1));
      expect(root.height, moreOrLessEquals(800, epsilon: 1));
      expect(tester.takeException(), isNull);
    });
  });

  group('P7-B2 every block fills its page (not floating)', () {
    testWidgets('all 16 blocks fill 1280x800', (WidgetTester tester) async {
      final ShadcnThemeDataView theme = blockTheme('neutral', Brightness.light);
      final List<Widget> blocks = <Widget>[
        const Account01(),
        const Account02(),
        const Calendar01(),
        const Calendar02(),
        const Dashboard01(),
        const Dashboard02(),
        const Login01(),
        const Login02(),
        const Login03(),
        const Otp01(),
        const Pricing01(),
        const Sidebar01(),
        const Sidebar02(),
        const Sidebar03(),
        const Signup01(),
        const Signup02(),
      ];
      for (final Widget block in blocks) {
        await pumpPage(tester, block, theme, 1280, 800);
        final Size root = tester.getSize(find.byWidget(block));
        expect(
          root.width,
          moreOrLessEquals(1280, epsilon: 1),
          reason: '${block.runtimeType} fills the page width',
        );
        expect(
          root.height,
          moreOrLessEquals(800, epsilon: 1),
          reason: '${block.runtimeType} fills the page height',
        );
      }
    });
  });

  group('P7-B2 mobile layouts at 390 wide', () {
    testWidgets('split panels hide on phones', (WidgetTester tester) async {
      final ShadcnThemeDataView theme = blockTheme('neutral', Brightness.light);
      await pumpPage(tester, const Login02(), theme, 390, 844);
      expect(find.byType(Login02Panel), findsNothing);
      expect(find.widgetWithText(Button, 'Sign in'), findsOneWidget);

      await pumpPage(tester, const Signup02(), theme, 390, 844);
      expect(find.byType(Signup02Aside), findsNothing);
      expect(find.text('Create your account'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('all 16 blocks pump at 390x844', (WidgetTester tester) async {
      final ShadcnThemeDataView theme = blockTheme('neutral', Brightness.light);
      final List<Widget> blocks = <Widget>[
        const Account01(),
        const Account02(),
        const Calendar01(),
        const Calendar02(),
        const Dashboard01(),
        const Dashboard02(),
        const Login01(),
        const Login02(),
        const Login03(),
        const Otp01(),
        const Pricing01(),
        const Sidebar01(),
        const Sidebar02(),
        const Sidebar03(),
        const Signup01(),
        const Signup02(),
      ];
      for (final Widget block in blocks) {
        await pumpPage(tester, block, theme, 390, 844);
      }
    });
  });
}

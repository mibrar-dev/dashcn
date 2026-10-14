// P7-H1 fixes: calendar-01 renders two months side by side at >= 768 with a
// cross-month range, Clear/Apply wired and the footer showing the range;
// dashboard-01 status chips use the registry Badge at intrinsic size and
// rows sit at the upstream row height. Plus a sweep: no Badge in any block
// paints stretched.

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/blocks/account-01/account_01.dart';
import 'package:dashcn/src/blocks/account-02/account_02.dart';
import 'package:dashcn/src/blocks/calendar-01/calendar_01.dart';
import 'package:dashcn/src/blocks/calendar-02/calendar_02.dart';
import 'package:dashcn/src/blocks/dashboard-01/dashboard_01.dart';
import 'package:dashcn/src/blocks/dashboard-02/dashboard_02.dart';
import 'package:dashcn/src/blocks/login-01/login_01.dart';
import 'package:dashcn/src/blocks/login-02/login_02.dart';
import 'package:dashcn/src/blocks/login-03/login_03.dart';
import 'package:dashcn/src/blocks/otp-01/otp_01.dart';
import 'package:dashcn/src/blocks/pricing-01/pricing_01.dart';
import 'package:dashcn/src/blocks/sidebar-01/sidebar_01.dart';
import 'package:dashcn/src/blocks/sidebar-02/sidebar_02.dart';
import 'package:dashcn/src/blocks/sidebar-03/sidebar_03.dart';
import 'package:dashcn/src/blocks/signup-01/signup_01.dart';
import 'package:dashcn/src/blocks/signup-02/signup_02.dart';
import 'package:dashcn/src/components/badge/badge.dart';
import 'package:dashcn/src/components/button/button.dart';
import 'package:dashcn/src/components/calendar/calendar.dart';
import 'package:dashcn/src/primitives/date_math.dart';
import 'package:dashcn/src/primitives/table_layout/table_cell_view.dart';
import 'package:flutter_test/flutter_test.dart';

import 'blocks_support.dart';

void main() {
  group('P7-H1 calendar-01', () {
    testWidgets('one month at 390, two side by side at 768 and 1440', (
      tester,
    ) async {
      final theme = blockTheme('neutral', Brightness.light);
      await pumpBlock(tester, const Calendar01(), theme, 390);
      expect(find.byType(Calendar), findsOneWidget);

      await pumpBlock(tester, const Calendar01(), theme, 768);
      expect(find.byType(Calendar), findsNWidgets(2));

      await pumpBlock(tester, const Calendar01(), theme, 1440);
      expect(find.byType(Calendar), findsNWidgets(2));
      // Side by side: same top, second month starts right of the first.
      final Rect first = tester.getRect(find.byType(Calendar).first);
      final Rect second = tester.getRect(find.byType(Calendar).last);
      expect((first.top - second.top).abs(), lessThan(1));
      expect(second.left, greaterThan(first.right));
    });

    testWidgets('range across months, footer range, Clear/Apply wired', (
      tester,
    ) async {
      final theme = blockTheme('neutral', Brightness.light);
      CalendarValue? applied;
      await pumpBlock(
        tester,
        Calendar01(onApply: (CalendarValue? value) => applied = value),
        theme,
        1440,
      );
      expect(find.text('Pick a date range'), findsOneWidget);

      // October grid first, November grid second: '15'.first is Oct 15,
      // '20'.last is Nov 20.
      await tester.tap(find.text('15').first);
      await tester.pump();
      expect(find.textContaining('Oct 15', findRichText: true), findsOneWidget);
      await tester.tap(find.text('20').last);
      await tester.pump();
      expect(
        find.textContaining('Oct 15 – Nov 20', findRichText: true),
        findsOneWidget,
      );

      await tester.tap(find.widgetWithText(Button, 'Apply'));
      await tester.pump();
      final CalendarValue? picked = applied;
      expect(picked, isA<RangeCalendarValue>());
      expect((picked! as RangeCalendarValue).start, DateTime(2026, 10, 15));
      expect((picked as RangeCalendarValue).end, DateTime(2026, 11, 20));

      await tester.tap(find.widgetWithText(Button, 'Clear'));
      await tester.pump();
      expect(find.text('Pick a date range'), findsOneWidget);
    });
  });

  group('P7-H1 dashboard-01 table', () {
    testWidgets('status badges are intrinsic, rows at 40', (tester) async {
      final theme = blockTheme('neutral', Brightness.light);
      await pumpBlock(tester, const Dashboard01(), theme, 1440);

      final Finder badges = find.byType(Badge);
      expect(badges, findsNWidgets(5));
      for (final Element element in badges.evaluate()) {
        final Size size = (element.renderObject! as RenderBox).size;
        // upstream badge: h-5 (20) / px-2 (8) / text-xs — never the column.
        expect(size.width, lessThan(120));
        expect(size.height, lessThanOrEqualTo(24));
        // Left-aligned in the cell: the badge starts at the cell padding.
        final Finder cell = find.ancestor(
          of: find.byWidget(element.widget),
          matching: find.byType(TableCellView),
        );
        expect(cell, findsOneWidget);
        final Rect badgeRect = tester.getRect(find.byWidget(element.widget));
        final Rect cellRect = tester.getRect(cell);
        expect(badgeRect.left - cellRect.left, lessThan(16));
        expect(badgeRect.width, lessThan(cellRect.width - 8));
        expect(
          tester.getSize(cell).height,
          40,
          reason: 'upstream TableHead h-10 row height',
        );
      }
    });
  });

  group('P7-H1 badge sweep', () {
    testWidgets('no badge paints stretched in any block', (tester) async {
      final theme = blockTheme('neutral', Brightness.light);
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
        await pumpBlock(tester, block, theme, 1440);
        for (final Element element in find.byType(Badge).evaluate()) {
          final Size size = (element.renderObject! as RenderBox).size;
          expect(
            size.width,
            lessThan(200),
            reason: '${block.runtimeType} badge width $size',
          );
          expect(
            size.height,
            lessThanOrEqualTo(32),
            reason: '${block.runtimeType} badge height $size',
          );
        }
      }
    });
  });
}

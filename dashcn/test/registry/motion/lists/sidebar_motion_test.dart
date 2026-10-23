// Motion contract for sidebar: collapsing animates the rail width over the
// 200 ms base token, from the expanded width (kSidebarExpandedWidth) to the icon rail
// (kSidebarCollapsedWidth).
// Reduced motion snaps to the target width with no ticker.

import 'package:dashcn/src/components/sidebar/sidebar.dart';
import 'package:dashcn/src/foundation/icons/lucide_icons.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pump(
  WidgetTester tester, {
  required bool collapsed,
  bool disableAnimations = false,
}) {
  return tester.pumpWidget(
    MediaQuery(
      data: const MediaQueryData(
        size: Size(800, 700),
      ).copyWith(disableAnimations: disableAnimations),
      child: Theme(
        data: const ThemeData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: 600,
              child: DashboardSidebar(
                sections: const <SidebarSection>[
                  SidebarSection(
                    label: 'Main',
                    items: <SidebarItem>[
                      SidebarItem(
                        label: 'Dashboard',
                        icon: LucideIcons.layoutDashboard,
                      ),
                    ],
                  ),
                ],
                selectedId: 'Dashboard',
                onSelected: (_) {},
                collapsed: collapsed,
                onToggleCollapsed: () {},
                user: const SidebarUser(
                  name: 'Ibrar Ahmed',
                  email: 'm@example.com',
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

/// Width of the animated rail (the SizedBox that clips the content).
double _width(WidgetTester tester) {
  return tester
      .getSize(
        find.byWidgetPredicate(
          (Widget w) => w is SizedBox && w.child is ClipRect,
        ),
      )
      .width;
}

void main() {
  testWidgets('collapse animates the rail width to the icon rail', (
    WidgetTester tester,
  ) async {
    await _pump(tester, collapsed: false);
    await tester.pump();
    expect(_width(tester), closeTo(kSidebarExpandedWidth, 0.5));
    await _pump(tester, collapsed: true);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(_width(tester), greaterThan(kSidebarCollapsedWidth));
    expect(_width(tester), lessThan(kSidebarExpandedWidth));
    await tester.pump(const Duration(milliseconds: 200));
    expect(_width(tester), closeTo(kSidebarCollapsedWidth, 0.5));
    expect(tester.takeException(), isNull);
  });

  testWidgets('reduced motion snaps to the collapsed width with no ticker', (
    WidgetTester tester,
  ) async {
    await _pump(tester, collapsed: false, disableAnimations: true);
    await _pump(tester, collapsed: true, disableAnimations: true);
    await tester.pump();
    expect(_width(tester), closeTo(kSidebarCollapsedWidth, 0.5));
    expect(tester.binding.transientCallbackCount, 0);
  });
}

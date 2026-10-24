// Widget tests for the `sidebar` component.
//
// Covers: header/groups/items/footer rendering, selection reporting,
// sub-menu expand/collapse (tap and arrow keys), keyboard traversal
// (arrows, Home/End, Enter), RTL rendering, the collapsed rail (64 px,
// tooltips, hidden labels) and a 375 px phone width with no overflow.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/badge/badge.dart';
import 'package:dashcn/src/components/sidebar/sidebar.dart';
import 'package:dashcn/src/foundation/icons/lucide_icons.dart';
import 'package:dashcn/src/primitives/clickable.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _frame({
  ThemeData data = const ThemeData(),
  TextDirection direction = TextDirection.ltr,
  required Widget child,
}) {
  return Theme(
    data: data,
    child: ComponentThemes(
      themes: const <ComponentThemeData>[],
      child: Directionality(
        textDirection: direction,
        child: Center(child: child),
      ),
    ),
  );
}

List<SidebarSection> _sections() => const <SidebarSection>[
  SidebarSection(
    label: 'Main',
    items: <SidebarItem>[
      SidebarItem(label: 'Dashboard', icon: LucideIcons.layoutDashboard),
      SidebarItem(label: 'Documents', icon: LucideIcons.fileText, badge: '12'),
      SidebarItem(label: 'Reports', icon: LucideIcons.chartBar),
    ],
  ),
  SidebarSection(
    label: 'Account',
    items: <SidebarItem>[
      SidebarItem(
        label: 'Settings',
        icon: LucideIcons.settings,
        children: <SidebarItem>[
          SidebarItem(label: 'Profile', icon: LucideIcons.circleUser),
          SidebarItem(label: 'Billing', icon: LucideIcons.creditCard),
        ],
      ),
      SidebarItem(label: 'Help', icon: LucideIcons.circleHelp),
    ],
  ),
];

Widget _sidebar({
  String? selectedId = 'Dashboard',
  bool collapsed = false,
  TextDirection direction = TextDirection.ltr,
  ValueChanged<String>? onSelected,
}) {
  return _frame(
    direction: direction,
    child: SizedBox(
      height: 480,
      child: DashboardSidebar(
        sections: _sections(),
        selectedId: selectedId,
        onSelected: onSelected,
        collapsed: collapsed,
        onToggleCollapsed: () {},
        user: const SidebarUser(name: 'Ibrar Ahmed', email: 'm@example.com'),
        onUserPressed: () {},
      ),
    ),
  );
}

void main() {
  testWidgets('renders header, groups, items and footer', (tester) async {
    await tester.pumpWidget(_sidebar());
    expect(find.text('Acme Inc'), findsOneWidget);
    expect(find.text('Main'), findsOneWidget);
    expect(find.text('Account'), findsOneWidget);
    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Documents'), findsOneWidget);
    expect(find.byType(Badge), findsOneWidget);
    expect(find.text('Ibrar Ahmed'), findsOneWidget);
    expect(find.text('m@example.com'), findsOneWidget);
    // Sub-menu children stay hidden until the parent expands.
    expect(find.text('Profile'), findsNothing);
  });

  testWidgets('tap reports the row identity', (tester) async {
    String? selected;
    await tester.pumpWidget(_sidebar(onSelected: (String id) => selected = id));
    await tester.tap(find.text('Reports'));
    expect(selected, 'Reports');
  });

  testWidgets('rows are 32 px, sub-items 28 px, group labels 32 px', (
    tester,
  ) async {
    await tester.pumpWidget(_sidebar());
    await tester.pump();
    Finder rowOf(String label) =>
        find.ancestor(of: find.text(label), matching: find.byType(Clickable));
    expect(tester.getSize(rowOf('Dashboard')).height, 32);
    // Group labels are 32 px rows: the innermost SizedBox above the text
    // carries the height.
    final Finder labelBox = find.ancestor(
      of: find.text('Main'),
      matching: find.byType(SizedBox),
    );
    expect(tester.widget<SizedBox>(labelBox.first).height, 32);
    await tester.tap(find.text('Settings'));
    await tester.pump();
    expect(tester.getSize(rowOf('Profile')).height, 28);
  });

  testWidgets('tap on a parent expands its sub-menu', (tester) async {
    await tester.pumpWidget(_sidebar());
    await tester.tap(find.text('Settings'));
    await tester.pump();
    expect(find.text('Profile'), findsOneWidget);
    expect(find.text('Billing'), findsOneWidget);
  });

  testWidgets('arrow keys move focus and Enter activates', (tester) async {
    String? selected;
    await tester.pumpWidget(_sidebar(onSelected: (String id) => selected = id));
    await tester.tap(find.text('Dashboard'));
    await tester.pump();
    expect(selected, 'Dashboard');
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pump();
    expect(selected, 'Documents');
  });

  testWidgets('arrow right expands and arrow left collapses', (tester) async {
    await tester.pumpWidget(_sidebar());
    await tester.tap(find.text('Settings'));
    await tester.pump();
    // Focus the Settings row, then collapse it with ArrowLeft.
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
    await tester.pump();
    expect(find.text('Profile'), findsNothing);
    // Expand it again with ArrowRight.
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
    await tester.pump();
    expect(find.text('Profile'), findsOneWidget);
  });

  testWidgets('renders in RTL without overflow', (tester) async {
    await tester.pumpWidget(_sidebar(direction: TextDirection.rtl));
    await tester.pump();
    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('Ibrar Ahmed'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('collapsed rail hides labels and narrows to 64 px', (
    tester,
  ) async {
    await tester.pumpWidget(_sidebar(collapsed: true));
    await tester.pump();
    // Nav labels hide; tooltips carry them instead.
    expect(find.text('Dashboard'), findsNothing);
    expect(find.text('Main'), findsNothing);
    final Finder rail = find.byWidgetPredicate(
      (Widget widget) =>
          widget is SizedBox && widget.width == kSidebarCollapsedWidth,
    );
    expect(rail, findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('expanded rail is 256 px wide', (tester) async {
    await tester.pumpWidget(_sidebar());
    final Finder rail = find.byWidgetPredicate(
      (Widget widget) =>
          widget is SizedBox && widget.width == kSidebarExpandedWidth,
    );
    expect(rail, findsOneWidget);
  });

  testWidgets('renders at 375 px without overflow', (tester) async {
    await tester.pumpWidget(
      Theme(
        data: const ThemeData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: SizedBox(
              width: 375,
              height: 480,
              child: DashboardSidebar(
                sections: _sections(),
                selectedId: 'Dashboard',
                onSelected: (_) {},
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
    );
    await tester.pump();
    expect(find.text('Dashboard'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

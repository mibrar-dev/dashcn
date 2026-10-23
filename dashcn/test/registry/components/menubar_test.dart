// Widget tests for the `menubar` component: horizontal layout, the
// border/background surface, all four MenubarTheme legs, submenu placement,
// disabled rows, light/dark tokens and real sizes (triggers 28, bar 36).

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/menu/menu.dart';
import 'package:dashcn/src/components/menubar/menubar.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

const Color _green = Color(0xFF00FF00);
const Color _blue = Color(0xFF0000FF);

Widget _frame(
  Widget child, {
  ThemeData data = const ThemeData(),
  List<ComponentThemeData> app = const <ComponentThemeData>[],
  MenubarTheme? scoped,
}) {
  Widget body = child;
  if (scoped != null) {
    body = ComponentTheme<MenubarTheme>(data: scoped, child: body);
  }
  return Theme(
    data: data,
    child: ComponentThemes(
      themes: app,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Overlay(
          initialEntries: <OverlayEntry>[
            OverlayEntry(
              builder: (context) =>
                  Align(alignment: Alignment.topLeft, child: body),
            ),
          ],
        ),
      ),
    ),
  );
}

Menubar _bar({bool? border, Offset? popoverOffset, MenubarTheme? theme}) {
  return Menubar(
    border: border,
    popoverOffset: popoverOffset,
    theme: theme,
    children: <Widget>[
      MenuButton(
        subMenu: <Widget>[
          MenuButton(child: const Text('New'), onPressed: (_) {}),
          MenuButton(child: const Text('Open'), onPressed: (_) {}),
        ],
        child: const Text('File'),
      ),
      MenuButton(child: const Text('Edit'), onPressed: (_) {}),
      MenuButton(enabled: false, child: const Text('Help'), onPressed: (_) {}),
    ],
  );
}

BoxDecoration _surface(WidgetTester tester) {
  return tester
          .widget<DecoratedBox>(
            find
                .ancestor(
                  of: find.byType(MenuGroup),
                  matching: find.byType(DecoratedBox),
                )
                .first,
          )
          .decoration
      as BoxDecoration;
}

void main() {
  testWidgets('lays the triggers out in one horizontal row', (tester) async {
    await tester.pumpWidget(_frame(_bar()));
    await tester.pump();
    final Offset file = tester.getTopLeft(find.text('File'));
    final Offset edit = tester.getTopLeft(find.text('Edit'));
    expect(edit.dy, file.dy);
    expect(edit.dx, greaterThan(file.dx));
  });

  testWidgets('default bar is 36 high: 28px triggers + p-1', (tester) async {
    await tester.pumpWidget(_frame(_bar()));
    await tester.pump();
    expect(tester.getSize(find.byType(Menubar)).height, 36);
  });

  testWidgets('bar triggers are 28 px with 8/4 padding', (tester) async {
    await tester.pumpWidget(_frame(_bar()));
    await tester.pump();
    final Finder file = find.ancestor(
      of: find.text('File'),
      matching: find.byType(RovingRow),
    );
    expect(tester.getSize(file).height, 28);
    final RovingRow row = tester.widget<RovingRow>(file);
    final EdgeInsets padding = (row.padding! as EdgeInsets).resolve(
      TextDirection.ltr,
    );
    expect(padding.left, 8);
    expect(padding.top, 4);
  });

  testWidgets('bar triggers show no chevron for their submenu', (tester) async {
    await tester.pumpWidget(_frame(_bar()));
    await tester.pump();
    final Finder file = find.ancestor(
      of: find.text('File'),
      matching: find.byType(RovingRow),
    );
    expect(tester.widget<RovingRow>(file).showChevron, isFalse);
  });

  testWidgets('paints background, border and radius tokens by default', (
    tester,
  ) async {
    const ThemeData theme = ThemeData();
    await tester.pumpWidget(_frame(_bar(), data: theme));
    await tester.pump();
    final BoxDecoration surface = _surface(tester);
    expect(surface.color, theme.colors.background);
    expect(surface.border!.top.color, theme.colors.border);
    expect(surface.border!.top.width, 1);
    expect(surface.borderRadius, theme.borderRadiusMd);
  });

  testWidgets('dark tokens drive the bar surface', (tester) async {
    const ThemeData theme = ThemeData(colors: ThemeColors.darkFallback);
    await tester.pumpWidget(_frame(_bar(), data: theme));
    await tester.pump();
    expect(_surface(tester).color, theme.colors.background);
  });

  testWidgets('border: false drops the decorated surface', (tester) async {
    await tester.pumpWidget(_frame(_bar(border: false)));
    await tester.pump();
    expect(
      find.ancestor(
        of: find.byType(MenuGroup),
        matching: find.byType(DecoratedBox),
      ),
      findsNothing,
    );
  });

  group('theme legs', () {
    testWidgets('defaults resolve the tokens', (tester) async {
      await tester.pumpWidget(_frame(_bar()));
      await tester.pump();
      expect(_surface(tester).color, const ThemeData().colors.background);
    });

    testWidgets('app leg beats the defaults', (tester) async {
      await tester.pumpWidget(
        _frame(
          _bar(),
          app: const <ComponentThemeData>[
            MenubarTheme(background: ThemedColor.value(_green)),
          ],
        ),
      );
      await tester.pump();
      expect(_surface(tester).color, _green);
    });

    testWidgets('scoped leg beats the app leg', (tester) async {
      await tester.pumpWidget(
        _frame(
          _bar(),
          app: const <ComponentThemeData>[
            MenubarTheme(background: ThemedColor.value(_blue)),
          ],
          scoped: const MenubarTheme(background: ThemedColor.value(_green)),
        ),
      );
      await tester.pump();
      expect(_surface(tester).color, _green);
    });

    testWidgets('widget leg beats every other leg', (tester) async {
      await tester.pumpWidget(
        _frame(
          _bar(
            theme: const MenubarTheme(background: ThemedColor.value(_green)),
          ),
          app: const <ComponentThemeData>[
            MenubarTheme(background: ThemedColor.value(_blue)),
          ],
          scoped: const MenubarTheme(background: ThemedColor.value(_blue)),
        ),
      );
      await tester.pump();
      expect(_surface(tester).color, _green);
    });

    testWidgets('the widget border argument beats the theme border', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          _bar(
            border: false,
            theme: const MenubarTheme(background: ThemedColor.value(_blue)),
          ),
        ),
      );
      await tester.pump();
      expect(
        find.ancestor(
          of: find.byType(MenuGroup),
          matching: find.byType(DecoratedBox),
        ),
        findsNothing,
      );
    });
  });

  testWidgets('a trigger opens its submenu below the bar', (tester) async {
    await tester.pumpWidget(_frame(_bar()));
    await tester.pump();
    expect(find.text('New'), findsNothing);
    await tester.tap(find.text('File'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('New'), findsOneWidget);
    expect(find.text('Open'), findsOneWidget);
    final double menuTop = tester.getTopLeft(find.text('New')).dy;
    expect(menuTop, greaterThan(tester.getTopLeft(find.text('File')).dy));
  });

  testWidgets('disabled triggers dim to half opacity and stay shut', (
    tester,
  ) async {
    await tester.pumpWidget(_frame(_bar()));
    await tester.pump();
    final Opacity opacity = tester.widget<Opacity>(
      find.ancestor(of: find.text('Help'), matching: find.byType(Opacity)),
    );
    expect(opacity.opacity, 0.5);
    await tester.tap(find.text('Help'));
    await tester.pump();
    expect(find.text('New'), findsNothing);
  });

  testWidgets('arrow traversal activates the focused trigger', (tester) async {
    bool pressed = false;
    await tester.pumpWidget(
      _frame(
        Menubar(
          children: <Widget>[
            MenuButton(child: const Text('File'), onPressed: (_) {}),
            MenuButton(
              child: const Text('Edit'),
              onPressed: (_) => pressed = true,
            ),
          ],
        ),
      ),
    );
    await tester.pump();
    // Focus the bar's roving scope, walk to the second trigger and activate.
    final Focus scope = tester.widget<Focus>(
      find
          .descendant(of: find.byType(MenuGroup), matching: find.byType(Focus))
          .first,
    );
    scope.focusNode!.requestFocus();
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pump();
    expect(pressed, isTrue);
  });
}

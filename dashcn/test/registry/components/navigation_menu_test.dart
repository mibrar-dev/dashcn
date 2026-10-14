// Widget tests for the `navigation_menu` component.
//
// Covers bar rendering, hover/press popover presentation, content actions,
// Escape dismissal, the content list grid and the four theme-precedence
// legs. Geometry tests pin the upstream contract: the panel hugs its content
// (never the window width), sits below the bar and starts at the trigger.

import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/button/button.dart';
import 'package:dashcn/src/components/navigation_menu/navigation_menu.dart';
import 'package:dashcn/src/components/outlined_container/outlined_container.dart';
import 'package:dashcn/src/primitives/overlay.dart';
import 'package:dashcn/src/primitives/overlay_manager_layer.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

/// Fresh overlay per pump: `Overlay` keeps its initial entries across
/// widget updates, so a stable key would keep showing the first pump's body.
int _overlayGeneration = 0;

Widget _frame({
  required Widget child,
  ThemeData data = const ThemeData(),
  List<ComponentThemeData> app = const <ComponentThemeData>[],
  NavigationMenuTheme? scoped,
}) {
  Widget body = child;
  if (scoped != null) {
    body = ComponentTheme<NavigationMenuTheme>(data: scoped, child: body);
  }
  return Theme(
    data: data,
    child: ComponentThemes(
      themes: app,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: OverlayManagerLayer(
          popoverHandler: OverlayHandler.popover,
          tooltipHandler: OverlayHandler.popover,
          menuHandler: OverlayHandler.popover,
          child: Overlay(
            // The popover machinery needs a real `Overlay` to insert into.
            key: ValueKey<int>(_overlayGeneration++),
            initialEntries: <OverlayEntry>[
              OverlayEntry(builder: (context) => Center(child: body)),
            ],
          ),
        ),
      ),
    ),
  );
}

NavigationMenu _menu({void Function()? onHome, void Function()? onContent}) {
  return NavigationMenu(
    children: <Widget>[
      NavigationMenuItem(onPressed: onHome, child: const Text('Home')),
      NavigationMenuItem(
        content: NavigationMenuContent(
          title: const Text('Web Apps'),
          content: const Text('Ship in the browser'),
          onPressed: onContent,
        ),
        child: const Text('Products'),
      ),
    ],
  );
}

/// Dropdown-first bar: the open trigger starts at the bar's start edge, so
/// the panel's left edge must match the bar's.
NavigationMenu _startMenu() {
  const List<Widget> entries = <Widget>[
    NavigationMenuContent(
      title: Text('Alert Dialog'),
      content: Text('A modal dialog that interrupts the user'),
    ),
    NavigationMenuContent(
      title: Text('Hover Card'),
      content: Text('For sighted users to preview content'),
    ),
    NavigationMenuContent(
      title: Text('Progress'),
      content: Text('Displays an indicator showing progress'),
    ),
    NavigationMenuContent(
      title: Text('Scroll Area'),
      content: Text('Visually separates content into sections'),
    ),
    NavigationMenuContent(
      title: Text('Tabs'),
      content: Text('A set of layered sections of content'),
    ),
    NavigationMenuContent(
      title: Text('Tooltip'),
      content: Text('A popup that displays information'),
    ),
  ];
  return NavigationMenu(
    children: <Widget>[
      NavigationMenuItem(
        content: const NavigationMenuContentList(
          crossAxisCount: 2,
          children: entries,
        ),
        child: const Text('Components'),
      ),
      NavigationMenuItem(onPressed: () {}, child: const Text('Docs')),
    ],
  );
}

/// Parks a mouse pointer ready to move; one gesture per test (a second
/// simultaneous pointer confuses enter/exit tracking).
Future<TestGesture> _mouse(WidgetTester tester) async {
  final TestGesture gesture = await tester.createGesture(
    kind: PointerDeviceKind.mouse,
  );
  await gesture.addPointer(location: Offset.zero);
  addTearDown(gesture.removePointer);
  await tester.pump();
  return gesture;
}

/// Moves [gesture] onto [finder]'s centre and lets overlay frames land.
Future<void> _moveTo(
  WidgetTester tester,
  TestGesture gesture,
  Finder finder, {
  int frames = 4,
}) async {
  await gesture.moveTo(tester.getCenter(finder));
  for (var i = 0; i < frames; i++) {
    await tester.pump(const Duration(milliseconds: 50));
  }
}

/// Opens the first dropdown of [_startMenu] and returns the panel rect.
Future<Rect> _openStartPanel(WidgetTester tester) async {
  await tester.pumpWidget(_frame(child: _startMenu()));
  final TestGesture mouse = await _mouse(tester);
  await _moveTo(tester, mouse, find.text('Components'));
  return tester.getRect(find.byType(OutlinedContainer));
}

void main() {
  group('bar', () {
    testWidgets('renders every entry', (tester) async {
      await tester.pumpWidget(_frame(child: _menu()));
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Products'), findsOneWidget);
    });

    testWidgets('entries are ghost buttons', (tester) async {
      await tester.pumpWidget(_frame(child: _menu()));
      final Iterable<Button> buttons = tester.widgetList<Button>(
        find.byType(Button),
      );
      expect(buttons.length, 2);
      for (final Button button in buttons) {
        expect(button.variant, ButtonVariant.ghost);
      }
    });

    testWidgets('action entry fires without opening a popover', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        _frame(child: _menu(onHome: () => pressed = true)),
      );
      await tester.tap(find.text('Home'));
      await tester.pump(const Duration(milliseconds: 300));
      expect(pressed, isTrue);
    });
  });

  group('popover', () {
    testWidgets('hover opens the content surface', (tester) async {
      await tester.pumpWidget(_frame(child: _menu()));
      final TestGesture mouse = await _mouse(tester);
      await _moveTo(tester, mouse, find.text('Products'));
      expect(find.byType(OutlinedContainer), findsOneWidget);
      expect(find.text('Web Apps'), findsOneWidget);
    });

    testWidgets('hover waits for the open delay', (tester) async {
      await tester.pumpWidget(_frame(child: _menu()));
      final TestGesture mouse = await _mouse(tester);
      await mouse.moveTo(tester.getCenter(find.text('Products')));
      await tester.pump(const Duration(milliseconds: 10));
      expect(find.byType(OutlinedContainer), findsNothing);
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.byType(OutlinedContainer), findsOneWidget);
    });

    testWidgets('hovering the action entry closes the popover', (tester) async {
      await tester.pumpWidget(_frame(child: _menu()));
      final TestGesture mouse = await _mouse(tester);
      await _moveTo(tester, mouse, find.text('Products'));
      expect(find.byType(OutlinedContainer), findsOneWidget);
      await _moveTo(tester, mouse, find.text('Home'), frames: 10);
      expect(find.byType(OutlinedContainer), findsNothing);
    });

    testWidgets('press toggles the content surface', (tester) async {
      await tester.pumpWidget(_frame(child: _menu()));
      await tester.tap(find.text('Products'));
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.byType(OutlinedContainer), findsOneWidget);
      await tester.tap(find.text('Products'));
      // Two frames: the exit animation starts on the first, removes on the
      // second.
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.byType(OutlinedContainer), findsNothing);
    });

    testWidgets('content action fires and closes the menu', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        _frame(child: _menu(onContent: () => pressed = true)),
      );
      final TestGesture mouse = await _mouse(tester);
      await _moveTo(tester, mouse, find.text('Products'));
      expect(find.text('Web Apps'), findsOneWidget);
      await tester.tap(find.text('Web Apps'));
      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(milliseconds: 200));
      }
      expect(pressed, isTrue);
      expect(find.byType(OutlinedContainer), findsNothing);
    });

    testWidgets('chevron shows on entries with content only', (tester) async {
      await tester.pumpWidget(_frame(child: _menu()));
      expect(
        find.descendant(
          of: find.ancestor(
            of: find.text('Products'),
            matching: find.byType(Button),
          ),
          matching: find.byType(AnimatedRotation),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.ancestor(
            of: find.text('Home'),
            matching: find.byType(Button),
          ),
          matching: find.byType(AnimatedRotation),
        ),
        findsNothing,
      );
    });
  });

  group('panel geometry', () {
    testWidgets('hugs the content instead of the window', (tester) async {
      final Rect panel = await _openStartPanel(tester);
      expect(panel.width, greaterThan(400));
      expect(panel.width, lessThan(500));
      expect(panel.width, lessThan(800));
    });

    testWidgets('starts at the menu start, below the bar', (tester) async {
      await tester.pumpWidget(_frame(child: _startMenu()));
      final Rect bar = tester.getRect(find.byType(NavigationMenu));
      final Rect panel = await _openStartPanel(tester);
      expect((panel.left - bar.left).abs(), lessThanOrEqualTo(16));
      expect(panel.top, greaterThanOrEqualTo(bar.bottom - 1));
    });

    testWidgets('small content hugs instead of stretching', (tester) async {
      await tester.pumpWidget(_frame(child: _menu()));
      final TestGesture mouse = await _mouse(tester);
      await _moveTo(tester, mouse, find.text('Products'));
      final Rect panel = tester.getRect(find.byType(OutlinedContainer));
      expect(panel.width, lessThan(480));
      expect(panel.width, lessThan(800));
    });

    testWidgets('fits a narrow viewport', (tester) async {
      tester.view.physicalSize = const Size(375, 800);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final Rect panel = await _openStartPanel(tester);
      expect(tester.takeException(), isNull);
      expect(panel.width, lessThanOrEqualTo(375));
      expect(panel.left, greaterThanOrEqualTo(0));
      expect(panel.right, lessThanOrEqualTo(375));
    });
  });

  group('keyboard', () {
    testWidgets('arrows move across triggers and move the panel', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          child: NavigationMenu(
            children: <Widget>[
              NavigationMenuItem(onPressed: () {}, child: const Text('Home')),
              NavigationMenuItem(
                content: const Text('Panel body'),
                child: const Text('Products'),
              ),
            ],
          ),
        ),
      );
      final NavigationMenuItemState home = tester.state(
        find.byType(NavigationMenuItem).first,
      );
      final NavigationMenuItemState products = tester.state(
        find.byType(NavigationMenuItem).last,
      );
      home.focusNode.requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Panel body'), findsOneWidget);
      expect(products.focusNode.hasFocus, isTrue);
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.byType(OutlinedContainer), findsNothing);
    });

    testWidgets('Down opens the panel from the trigger', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: NavigationMenu(
            children: <Widget>[
              NavigationMenuItem(
                content: const Text('Panel body'),
                child: const Text('Products'),
              ),
            ],
          ),
        ),
      );
      final NavigationMenuItemState products = tester.state(
        find.byType(NavigationMenuItem),
      );
      products.focusNode.requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Panel body'), findsOneWidget);
    });

    testWidgets('Escape closes and returns focus to the trigger', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          child: NavigationMenu(
            children: <Widget>[
              NavigationMenuItem(
                content: const Text('Panel body'),
                child: const Text('Products'),
              ),
            ],
          ),
        ),
      );
      final NavigationMenuItemState products = tester.state(
        find.byType(NavigationMenuItem),
      );
      products.focusNode.requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.byType(OutlinedContainer), findsOneWidget);
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.byType(OutlinedContainer), findsNothing);
      expect(products.focusNode.hasFocus, isTrue);
    });

    testWidgets('Escape closes the open popover', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: NavigationMenu(
            children: <Widget>[
              NavigationMenuItem(
                content: const Focus(
                  autofocus: true,
                  child: NavigationMenuContent(title: Text('Panel')),
                ),
                child: const Text('Products'),
              ),
            ],
          ),
        ),
      );
      final TestGesture mouse = await _mouse(tester);
      await _moveTo(tester, mouse, find.text('Products'));
      expect(find.byType(OutlinedContainer), findsOneWidget);
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.byType(OutlinedContainer), findsNothing);
    });

    testWidgets('entry without action or content is disabled', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: const NavigationMenu(
            children: <Widget>[NavigationMenuItem(child: Text('Plain'))],
          ),
        ),
      );
      final Button button = tester.widget<Button>(find.byType(Button));
      expect(button.onPressed, isNull);
    });
  });

  group('content list', () {
    testWidgets('lays out entries in rows', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: const NavigationMenuContentList(
            crossAxisCount: 2,
            children: <Widget>[
              NavigationMenuContent(title: Text('A')),
              NavigationMenuContent(title: Text('B')),
              NavigationMenuContent(title: Text('C')),
            ],
          ),
        ),
      );
      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
      expect(find.text('C'), findsOneWidget);
      expect(find.byType(Row), findsWidgets);
    });

    testWidgets('clamps descriptions to two lines', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: NavigationMenuContent(
            title: const Text('Web Apps'),
            content: const Text('Ship in the browser'),
            onPressed: () {},
          ),
        ),
      );
      final Text description = tester.widget<Text>(
        find.text('Ship in the browser'),
      );
      expect(description.maxLines, 2);
      expect(description.overflow, TextOverflow.ellipsis);
    });
  });

  group('theme precedence', () {
    testWidgets('widget > scoped > app > defaults', (tester) async {
      NavigationMenuTheme resolve(
        BuildContext context,
        NavigationMenuTheme? widget,
      ) {
        return resolveComponentStyle<NavigationMenuTheme, NavigationMenuTheme>(
          context,
          widget: widget,
          select: (t) => t,
          defaults: navigationMenuDefaults,
        );
      }

      NavigationMenuTheme? seen;
      Future<void> pump({
        NavigationMenuTheme? widget,
        NavigationMenuTheme? scoped,
        List<ComponentThemeData> app = const <ComponentThemeData>[],
      }) async {
        await tester.pumpWidget(
          _frame(
            app: app,
            scoped: scoped,
            child: Builder(
              builder: (context) {
                seen = resolve(context, widget);
                return const SizedBox();
              },
            ),
          ),
        );
      }

      await pump();
      expect(seen!.offset, navigationMenuDefaults.offset);
      await pump(
        app: const <ComponentThemeData>[
          NavigationMenuTheme(offset: Offset(0, 1)),
        ],
      );
      expect(seen!.offset, const Offset(0, 1));
      await pump(
        scoped: const NavigationMenuTheme(offset: Offset(0, 2)),
        app: const <ComponentThemeData>[
          NavigationMenuTheme(offset: Offset(0, 1)),
        ],
      );
      expect(seen!.offset, const Offset(0, 2));
      await pump(
        widget: const NavigationMenuTheme(offset: Offset(0, 3)),
        scoped: const NavigationMenuTheme(offset: Offset(0, 2)),
        app: const <ComponentThemeData>[
          NavigationMenuTheme(offset: Offset(0, 1)),
        ],
      );
      expect(seen!.offset, const Offset(0, 3));
    });
  });

  group('regressions', () {
    testWidgets('no adaptive overlay conversion runs', (tester) async {
      await tester.pumpWidget(_frame(child: _menu()));
      final TestGesture mouse = await _mouse(tester);
      await _moveTo(tester, mouse, find.text('Products'));
      expect(find.byType(OutlinedContainer), findsOneWidget);
    });
  });
}

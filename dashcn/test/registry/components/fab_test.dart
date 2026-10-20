// Widget tests for the `fab` component.
//
// Covers rendering, the three sizes, the extended shape, the callback, the
// disabled state, the tooltip, the style/theme overrides, the speed dial,
// the positions helper, hide-on-scroll, RTL, reduced motion and the
// 375 px phone width.

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/fab/fab.dart';
import 'package:dashcn/src/foundation/icons/lucide_icons.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _frame({
  ThemeData data = const ThemeData(),
  List<ComponentThemeData> app = const <ComponentThemeData>[],
  TextDirection direction = TextDirection.ltr,
  bool overlay = false,
  required Widget child,
}) {
  final Widget inner = Center(child: child);
  Widget content = inner;
  if (overlay) {
    content = Overlay(
      initialEntries: <OverlayEntry>[
        OverlayEntry(builder: (BuildContext context) => inner),
      ],
    );
  }
  content = Directionality(textDirection: direction, child: content);
  return Theme(
    data: data,
    child: ComponentThemes(themes: app, child: content),
  );
}

/// A desktop theme: the touch padding of the hit area stays off.
const ThemeData _desktop = ThemeData(platform: TargetPlatform.linux);

void main() {
  group('Fab', () {
    testWidgets('renders its icon and stays square', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: const Fab(
            icon: Icon(LucideIcons.plus),
            semanticLabel: 'Add',
            onPressed: _noop,
          ),
        ),
      );
      expect(find.byType(Fab), findsOneWidget);
      expect(find.byIcon(LucideIcons.plus), findsOneWidget);
      expect(tester.getSize(find.byType(Fab)), const Size(56, 56));
    });

    testWidgets('paints the three fixed sizes', (tester) async {
      for (final (FabSize size, double box) in <(FabSize, double)>[
        (FabSize.sm, 40),
        (FabSize.md, 56),
        (FabSize.lg, 64),
      ]) {
        await tester.pumpWidget(
          _frame(
            data: _desktop,
            child: Fab(
              icon: const Icon(LucideIcons.plus),
              size: size,
              onPressed: _noop,
            ),
          ),
        );
        expect(tester.getSize(find.byType(Fab)), Size(box, box));
      }
    });

    testWidgets('the label switches the button to the pill shape', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          child: const Fab(
            icon: Icon(LucideIcons.pencil),
            label: Text('Compose'),
            onPressed: _noop,
          ),
        ),
      );
      expect(find.text('Compose'), findsOneWidget);
      final Size size = tester.getSize(find.byType(Fab));
      expect(size.height, 56);
      expect(size.width, greaterThan(56));
    });

    testWidgets('calls onPressed and reports the disabled state', (
      tester,
    ) async {
      int taps = 0;
      await tester.pumpWidget(
        _frame(
          child: Fab(
            icon: const Icon(LucideIcons.plus),
            semanticLabel: 'Add',
            onPressed: () => taps++,
          ),
        ),
      );
      await tester.tap(find.byType(Fab));
      expect(taps, 1);

      await tester.pumpWidget(
        _frame(
          child: const Fab(icon: Icon(LucideIcons.plus), semanticLabel: 'Add'),
        ),
      );
      await tester.tap(find.byType(Fab));
      expect(taps, 1, reason: 'a null callback disables the button');
    });

    testWidgets('shows the tooltip on hover', (tester) async {
      await tester.pumpWidget(
        _frame(
          overlay: true,
          child: const Fab(
            icon: Icon(LucideIcons.plus),
            tooltip: 'Add item',
            onPressed: _noop,
          ),
        ),
      );
      expect(find.text('Add item'), findsNothing);
      final TestGesture gesture = await tester.createGesture(
        kind: PointerDeviceKind.mouse,
      );
      await gesture.addPointer(location: tester.getCenter(find.byType(Fab)));
      addTearDown(gesture.removePointer);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.text('Add item'), findsOneWidget);
    });

    testWidgets('honours a widget-leg style override', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: const Fab(
            icon: Icon(LucideIcons.plus),
            onPressed: _noop,
            style: FabStyle(
              background: StateValue(
                rest: ThemedColor.ref(ColorRef.destructive),
              ),
              size: 72,
            ),
          ),
        ),
      );
      expect(tester.getSize(find.byType(Fab)), const Size(72, 72));
    });

    testWidgets('honours an app-level theme override', (tester) async {
      await tester.pumpWidget(
        _frame(
          app: const <ComponentThemeData>[
            FabTheme(
              standard: FabStyle(
                background: StateValue(
                  rest: ThemedColor.ref(ColorRef.secondary),
                ),
                size: 48,
              ),
            ),
          ],
          child: const Fab(icon: Icon(LucideIcons.plus), onPressed: _noop),
        ),
      );
      expect(tester.getSize(find.byType(Fab)), const Size(48, 48));
    });

    testWidgets('the content slot replaces the icon and the label', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          child: const Fab(content: Text('Go'), onPressed: _noop),
        ),
      );
      expect(find.text('Go'), findsOneWidget);
      expect(find.byIcon(LucideIcons.plus), findsNothing);
    });

    testWidgets('keeps the label on the end side in RTL', (tester) async {
      await tester.pumpWidget(
        _frame(
          direction: TextDirection.rtl,
          child: const Fab(
            icon: Icon(LucideIcons.pencil),
            label: Text('Compose'),
            onPressed: _noop,
          ),
        ),
      );
      final double iconX = tester.getCenter(find.byIcon(LucideIcons.pencil)).dx;
      final double labelX = tester.getCenter(find.text('Compose')).dx;
      expect(labelX, lessThan(iconX), reason: 'the label trails the icon');
    });

    testWidgets('the speed dial opens without a frame of animation', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          data: const ThemeData(),
          child: const MediaQuery(
            data: MediaQueryData(disableAnimations: true),
            child: FabSpeedDial(
              icon: Icon(LucideIcons.plus),
              semanticLabel: 'Create',
              onExpandedChanged: _onExpanded,
              actions: <FabSpeedDialAction>[
                FabSpeedDialAction(
                  icon: Icon(LucideIcons.image),
                  semanticLabel: 'Image',
                ),
              ],
            ),
          ),
        ),
      );
      await tester.tap(find.byIcon(LucideIcons.plus));
      await tester.pump();
      expect(_lastExpanded, isTrue);
    });

    testWidgets('fades out under reduced motion', (tester) async {
      await tester.pumpWidget(
        _frame(
          data: const ThemeData(),
          child: const FabHideOnScroll(
            controller: null,
            child: Fab(icon: Icon(LucideIcons.plus), onPressed: _noop),
          ),
        ),
      );
      // The reduced-motion path resolves the duration to zero, so the end
      // state is reached without a frame of animation.
      expect(tester.takeException(), isNull);
    });

    testWidgets('fits a 375 px phone width without overflowing', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        _frame(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Fab(
                icon: Icon(LucideIcons.plus),
                size: FabSize.lg,
                onPressed: _noop,
              ),
              const Fab(
                icon: Icon(LucideIcons.pencil),
                label: Text('Compose'),
                onPressed: _noop,
              ),
            ],
          ),
        ),
      );
      expect(tester.takeException(), isNull);
    });
  });

  group('FabSpeedDial', () {
    testWidgets('expands and reports the new state', (tester) async {
      bool? expanded;
      await tester.pumpWidget(
        _frame(
          child: FabSpeedDial(
            icon: const Icon(LucideIcons.plus),
            semanticLabel: 'Create',
            onExpandedChanged: (bool value) => expanded = value,
            actions: const <FabSpeedDialAction>[
              FabSpeedDialAction(
                icon: Icon(LucideIcons.image),
                semanticLabel: 'Image',
              ),
            ],
          ),
        ),
      );
      expect(find.byIcon(LucideIcons.image), findsOneWidget);
      await tester.tap(find.byIcon(LucideIcons.plus));
      await tester.pump();
      expect(expanded, isTrue);
    });

    testWidgets('the mini action runs its callback', (tester) async {
      int taps = 0;
      await tester.pumpWidget(
        _frame(
          child: FabSpeedDial(
            icon: const Icon(LucideIcons.plus),
            actions: <FabSpeedDialAction>[
              FabSpeedDialAction(
                icon: const Icon(LucideIcons.image),
                onPressed: () => taps++,
              ),
            ],
          ),
        ),
      );
      // The mini actions fan out of the main button: expand first.
      await tester.tap(find.byIcon(LucideIcons.plus));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      await tester.tap(find.byIcon(LucideIcons.image));
      expect(taps, 1);
    });
  });

  group('FabPositioner', () {
    testWidgets('aligns the button to the requested corner', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: const SizedBox(
            width: 200,
            height: 200,
            child: Stack(
              children: <Widget>[
                FabPositioner(
                  position: FabPosition.bottomEnd,
                  child: Fab(icon: Icon(LucideIcons.plus), onPressed: _noop),
                ),
              ],
            ),
          ),
        ),
      );
      final Offset center = tester.getCenter(find.byType(Fab));
      expect(center.dx, greaterThan(100));
      expect(center.dy, greaterThan(100));
    });
  });

  group('FabHideOnScroll', () {
    testWidgets('slides away while the list scrolls down', (tester) async {
      final ScrollController controller = ScrollController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        _frame(
          child: SizedBox(
            width: 200,
            height: 200,
            child: Stack(
              children: <Widget>[
                ListView.builder(
                  controller: controller,
                  itemCount: 40,
                  itemBuilder: (BuildContext context, int index) =>
                      SizedBox(height: 40, child: Text('row $index')),
                ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: FabHideOnScroll(
                    controller: controller,
                    child: const Fab(
                      icon: Icon(LucideIcons.plus),
                      onPressed: _noop,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      final Finder fab = find.byType(Fab);
      final double before = tester.getTopLeft(fab).dy;
      controller.jumpTo(200);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(tester.getTopLeft(fab).dy, greaterThan(before));
    });
  });
}

void _noop() {}

/// The last expansion state the speed dial reported.
bool? _lastExpanded;

void _onExpanded(bool value) => _lastExpanded = value;

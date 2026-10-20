// Behavioural audit: every floating/raised surface honours the ambient
// `ThemeData.surfaceOpacity` / `surfaceBlur` through the shared
// `primitives/surface.dart` primitive.
//
// Each group pumps its surface inside `ThemeData(surfaceOpacity: 0.5,
// surfaceBlur: 8)` on a saturated background and asserts the component's own
// background paint is translucent (fill alpha <= 0.6) and a `BackdropFilter`
// blur exists in the subtree. The component list below is reconciled with
// `dashcn/lib/src/manifests/registry.json` by the `registry coverage` test:
// every registry id is either exercised here or named in [_allowList] with
// the reason it has no frosted surface.
//
// Audit table (before -> after this change; cause):
//
// | component | before | after | cause |
// | card | pass | pass | already `surfaceColor` + `GlassSurface` (ambient legs) |
// | dialog | pass | pass | route shell already frosted |
// | alert_dialog | pass | pass | standalone shell already frosted |
// | drawer (route panel) | FAIL -> pass | null theme fill painted nothing, so
// |   glass had no fill to frost; now frosts with the `background` token |
// | drawer_container | FAIL -> pass | hardcoded `colors.background`,
// |   ignoring `DrawerTheme.background`; now resolves the theme leg |
// | pinned_sheet | pass | pass | shares the drawer-container chrome |
// | menubar | FAIL -> pass | bar `DecoratedBox` painted the raw token with
// |   no `surfaceColor`/`GlassSurface`; now frosted like every bar |
// | menu / dropdown_menu / context_menu / popup | pass | pass | share
// |   `MenuPopupSurface` (component legs win over ambient) |
// | select (popup) | pass | pass | popup is a `MenuPopup`; the trigger is a
// |   button, not a surface (see allow-list) |
// | autocomplete (popup) | pass | pass | popup is a `MenuPopupSurface`
// |   (ambient legs); the field is an `Input` (see `input`) |
// | command | pass | pass | already frosted (ambient legs) |
// | hover_card | pass | pass | already frosted (ambient legs) |
// | tooltip | pass | pass | already frosted (component legs win) |
// | toast | pass | pass | already frosted (ambient legs) |
// | gooey_toast | pass | pass | `GooeySurface` composites `fillAlpha`
// |   (opacity x blur factor) plus a clipped backdrop blur |
// | navigation_bar (bar/rail) | pass | pass | already frosted |
// | navigation_bar (sidebar) | FAIL -> pass | sidebars drew nothing, so
// |   glass never reached them; now frost under a glass theme and draw
// |   nothing at the opaque default (defaults identical) |
// | navigation_menu (panel) | pass | pass | panel is an `OutlinedContainer`
// |   (component legs win over ambient) |
// | scaffold app bar | pass | pass | already frosted (widget > component >
// |   ambient legs) |
// | scaffold bar section | pass | pass | already frosted (ambient legs);
// |   the full-screen body stays opaque by design (see allow-list) |
// | window | pass | pass | frame is a `Card` |
// | outlined_container | pass | pass | owns `GlassSurface` (component legs) |
// | input / phone_input / formatted_input | FAIL -> pass | field fills
// |   painted raw tokens; now `surfaceColor` + `GlassSurface` (ambient legs;
// |   `text_area` inherits the fill opacity through the shared resolver) |
// | file_picker (tile) | FAIL -> pass | tile painted the raw token; now
// |   frosted (ambient legs) |
// | dropzone | FAIL -> pass | drop area painted the raw token; now frosted
// |   (ambient legs) |
//
// At the opaque default (null/1.0 opacity, null/0 blur) every fixed component
// renders exactly as before: `surfaceColor` returns the base colour unchanged
// and `GlassSurface` returns its child unchanged (no extra layer), except for
// the sidebar/panel null-fill paths which keep drawing nothing.

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dashcn/src/components/alert_dialog/alert_dialog.dart';
import 'package:dashcn/src/components/autocomplete/autocomplete.dart';
import 'package:dashcn/src/components/card/card.dart';
import 'package:dashcn/src/components/command/command.dart';
import 'package:dashcn/src/components/context_menu/context_menu.dart';
import 'package:dashcn/src/components/dialog/dialog.dart';
import 'package:dashcn/src/components/drawer/drawer_style.dart';
import 'package:dashcn/src/components/drawer_container/drawer_container.dart';
import 'package:dashcn/src/components/dropdown_menu/dropdown_menu.dart';
import 'package:dashcn/src/components/dropzone/dropzone.dart';
import 'package:dashcn/src/components/file_picker/file_picker.dart';
import 'package:dashcn/src/components/formatted_input/formatted_input.dart';
import 'package:dashcn/src/components/hover_card/hover_card.dart';
import 'package:dashcn/src/components/image_lightbox/image_lightbox.dart';
import 'package:dashcn/src/components/input/input.dart';
import 'package:dashcn/src/components/menu/menu.dart';
import 'package:dashcn/src/components/menubar/menubar.dart';
import 'package:dashcn/src/components/navigation_bar/navigation_bar.dart';
import 'package:dashcn/src/components/navigation_menu/navigation_menu.dart';
import 'package:dashcn/src/components/outlined_container/outlined_container.dart';
import 'package:dashcn/src/components/phone_input/phone_input.dart';
import 'package:dashcn/src/components/pinned_sheet/pinned_sheet.dart';
import 'package:dashcn/src/components/scaffold/scaffold.dart';
import 'package:dashcn/src/components/select/select.dart';
import 'package:dashcn/src/components/toast/toast.dart';
import 'package:dashcn/src/components/video_player/video_player.dart';
import 'package:dashcn/src/components/audio_player/audio_player.dart';
import 'package:dashcn/src/components/gooey_toast/gooey_toast.dart';
import 'package:dashcn/src/components/tooltip/tooltip.dart';
import 'package:dashcn/src/components/window/window.dart';
import 'package:dashcn/src/primitives/drawer_route/drawer_panel_surface.dart';
import 'package:dashcn/src/primitives/drawer_route/drawer_route.dart';
import 'package:dashcn/src/primitives/gooey/gooey_surface.dart';
import 'package:dashcn/src/primitives/input_features/input_features.dart';
import 'package:dashcn/src/primitives/overlay.dart';
import 'package:dashcn/src/primitives/overlay_manager_layer.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:dashcn/src/theme/tokens.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// The glass theme every group pumps: half opacity, 8px blur.
const ThemeData _glass = ThemeData(surfaceOpacity: 0.5, surfaceBlur: 8);

/// Saturated non-white backdrop so translucency is observable, never white.
const Color _saturated = Color(0xFFD81B60);

/// Pumps [child] under the glass theme on the saturated backdrop.
Widget _frame(Widget child) {
  return Theme(
    data: _glass,
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: ColoredBox(
        color: _saturated,
        child: Center(child: child),
      ),
    ),
  );
}

/// Pumps [child] under the glass theme with a real `Overlay` to insert into.
int _overlayGeneration = 0;

Widget _overlayFrame(Widget child) {
  return Theme(
    data: _glass,
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: TapRegionSurface(
        child: Overlay(
          key: ValueKey<int>(_overlayGeneration++),
          initialEntries: <OverlayEntry>[
            OverlayEntry(
              builder: (BuildContext context) => ColoredBox(
                color: _saturated,
                child: Center(child: child),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// All background fills under [scope] (every paint in the subtree):
/// `DecoratedBox`/`Container` decoration colours plus `ColoredBox` colours,
/// in tree order.
List<Color> _allPaints(WidgetTester tester, Finder scope) {
  final List<Color> out = <Color>[];
  out.addAll(
    tester
        .widgetList<DecoratedBox>(
          find.descendant(of: scope, matching: find.byType(DecoratedBox)),
        )
        .where((DecoratedBox box) => box.decoration is BoxDecoration)
        .map((DecoratedBox box) => (box.decoration as BoxDecoration).color)
        .whereType<Color>(),
  );
  out.addAll(
    tester
        .widgetList<Container>(
          find.descendant(of: scope, matching: find.byType(Container)),
        )
        .expand((Container box) {
          final Decoration? decoration = box.decoration;
          if (decoration is BoxDecoration && decoration.color != null) {
            return <Color>[decoration.color!];
          }
          if (box.color != null) return <Color>[box.color!];
          return const <Color>[];
        }),
  );
  out.addAll(
    tester
        .widgetList<ColoredBox>(
          find.descendant(of: scope, matching: find.byType(ColoredBox)),
        )
        .map((ColoredBox box) => box.color),
  );
  return out;
}

/// Asserts [scope]'s first background paint is the frosted surface fill and
/// the subtree holds a backdrop blur.
void _expectGlass(WidgetTester tester, Finder scope) {
  final List<Color> paints = _allPaints(tester, scope);
  expect(paints, isNotEmpty, reason: 'no background paint under $scope');
  expect(
    paints.first.a,
    lessThanOrEqualTo(0.6),
    reason: 'surface fill is opaque: ${paints.first}',
  );
  expect(
    find.descendant(of: scope, matching: find.byType(BackdropFilter)),
    findsWidgets,
    reason: 'no BackdropFilter under $scope',
  );
}

/// Parks a mouse pointer ready to move; one gesture per test.
Future<TestGesture> _mouse(WidgetTester tester) async {
  final TestGesture gesture = await tester.createGesture(
    kind: PointerDeviceKind.mouse,
  );
  await gesture.addPointer(location: Offset.zero);
  addTearDown(gesture.removePointer);
  await tester.pump();
  return gesture;
}

void main() {
  group('card', () {
    testWidgets('fill is translucent with a blur', (tester) async {
      await tester.pumpWidget(_frame(const Card(child: Text('body'))));
      _expectGlass(tester, find.byType(Card));
    });
  });

  group('dialog', () {
    testWidgets('route shell is frosted', (tester) async {
      await tester.pumpWidget(
        Theme(
          data: _glass,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Navigator(
              onGenerateRoute: (_) => DialogRoute<void>(
                builder: (_) => const Text('content'),
                widgetTheme: null,
                duration: Duration.zero,
                barrierDismissible: true,
                useSafeArea: false,
                alignment: Alignment.center,
                fullScreen: false,
                openerFocus: null,
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      final DecoratedBox box = tester.widget<DecoratedBox>(
        find.byKey(kDialogSurfaceKey),
      );
      final Color fill = (box.decoration as BoxDecoration).color!;
      expect(fill.a, lessThanOrEqualTo(0.6));
      expect(find.byType(BackdropFilter), findsWidgets);
    });
  });

  group('alert_dialog', () {
    testWidgets('standalone shell is frosted', (tester) async {
      await tester.pumpWidget(_frame(const AlertDialog(title: Text('title'))));
      _expectGlass(tester, find.byType(AlertDialog));
    });
  });

  group('drawer panel', () {
    testWidgets('panel frosts with the theme fill', (tester) async {
      await tester.pumpWidget(
        _frame(
          const DrawerPanelSurface(
            position: OverlayPosition.left,
            theme: drawerDefaults,
            child: Text('panel'),
          ),
        ),
      );
      _expectGlass(tester, find.byType(DrawerPanelSurface));
    });

    testWidgets('null theme fill frosts with the background token', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          DrawerPanelSurface(
            position: OverlayPosition.left,
            theme: _NullFillDrawerTheme(),
            child: const Text('panel'),
          ),
        ),
      );
      _expectGlass(tester, find.byType(DrawerPanelSurface));
    });
  });

  group('drawer_container', () {
    testWidgets('container frosts with the drawer theme fill', (tester) async {
      await tester.pumpWidget(
        _frame(
          const DrawerRawContainer(
            position: OverlayPosition.left,
            child: Text('content'),
          ),
        ),
      );
      final Finder scope = find.byType(DrawerRawContainer);
      final List<Container> boxes = tester
          .widgetList<Container>(
            find.descendant(of: scope, matching: find.byType(Container)),
          )
          .where((Container box) {
            final Decoration? decoration = box.decoration;
            return decoration is BoxDecoration && decoration.border != null;
          })
          .toList();
      expect(boxes, isNotEmpty, reason: 'no surface container found');
      final Color fill = (boxes.first.decoration as BoxDecoration).color!;
      expect(fill.a, lessThanOrEqualTo(0.6));
      expect(
        find.descendant(of: scope, matching: find.byType(BackdropFilter)),
        findsWidgets,
      );
    });
  });

  group('pinned_sheet', () {
    testWidgets('sheet chrome is frosted', (tester) async {
      final SheetController controller = SheetController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        Theme(
          data: _glass,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: SizedBox(
              width: 300,
              height: 600,
              child: ColoredBox(
                color: _saturated,
                child: PinnedSheet(
                  controller: controller,
                  initialStage: const SheetStage.expanded(),
                  // The sheet publishes chrome data; the child owns the
                  // `DrawerContainer` that paints it (like the preview).
                  child: const DrawerContainer(child: Text('sheet')),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      _expectGlass(tester, find.byType(DrawerRawContainer));
    });
  });

  group('menubar', () {
    testWidgets('bar fill is translucent with a blur', (tester) async {
      await tester.pumpWidget(
        _frame(
          Menubar(
            children: <Widget>[
              MenuButton(child: const Text('File'), onPressed: (_) {}),
            ],
          ),
        ),
      );
      _expectGlass(tester, find.byType(Menubar));
    });
  });

  group('menu popup', () {
    testWidgets('popup fill is translucent with a blur', (tester) async {
      await tester.pumpWidget(
        _frame(
          const MenuPopup(children: <Widget>[MenuLabel(child: Text('row'))]),
        ),
      );
      final Finder scope = find.byType(MenuPopup);
      final Container surface = tester
          .widgetList<Container>(
            find.descendant(of: scope, matching: find.byType(Container)),
          )
          .firstWhere((Container box) => box.decoration is BoxDecoration);
      final Color fill = (surface.decoration as BoxDecoration).color!;
      expect(fill.a, lessThanOrEqualTo(0.6));
      expect(
        find.descendant(of: scope, matching: find.byType(BackdropFilter)),
        findsWidgets,
      );
    });
  });

  group('dropdown_menu', () {
    testWidgets('surface is frosted', (tester) async {
      await tester.pumpWidget(
        _frame(
          const DropdownMenu(children: <Widget>[MenuLabel(child: Text('row'))]),
        ),
      );
      _expectGlass(tester, find.byType(DropdownMenu));
    });
  });

  group('context_menu', () {
    testWidgets('opened popup is frosted', (tester) async {
      await tester.pumpWidget(
        _overlayFrame(
          ContextMenu(
            items: <Widget>[
              MenuButton(child: const Text('Copy link'), onPressed: (_) {}),
            ],
            child: const SizedBox(width: 600, height: 400),
          ),
        ),
      );
      await tester.pump();
      await tester.tapAt(
        const Offset(150, 120),
        buttons: kSecondaryMouseButton,
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Copy link'), findsOneWidget);
      _expectGlass(tester, find.byType(MenuPopup));
    });
  });

  group('popup', () {
    testWidgets('generic popup shares the frosted menu surface', (
      tester,
    ) async {
      // `popup` ships the `showPopup` helper over the menu surface: covering
      // the surface here covers the helper's paint.
      await tester.pumpWidget(
        _frame(
          const MenuPopup(children: <Widget>[MenuLabel(child: Text('row'))]),
        ),
      );
      _expectGlass(tester, find.byType(MenuPopup));
    });
  });

  group('select', () {
    testWidgets('opened popup is frosted', (tester) async {
      await tester.pumpWidget(
        _overlayFrame(
          SizedBox(
            width: 220,
            child: Select<String>(
              value: null,
              onChanged: (_) {},
              placeholder: const Text('Pick a fruit'),
              itemBuilder: (context, value) => Text(value),
              items: const <Widget>[
                SelectItem<String>(value: 'Apple', child: Text('Apple')),
              ],
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.tap(find.text('Pick a fruit'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.byType(MenuPopup), findsOneWidget);
      _expectGlass(tester, find.byType(MenuPopup));
    });
  });

  group('autocomplete', () {
    testWidgets('suggestion popup is frosted', (tester) async {
      await tester.pumpWidget(
        _overlayFrame(
          SizedBox(
            width: 220,
            child: Input(
              features: <InputFeature>[
                AutoCompleteFeature(
                  suggestions: (query) => query.isEmpty
                      ? const <String>[]
                      : <String>['Apple', 'Apricot'],
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pump();
      await tester.enterText(find.byType(EditableText), 'a');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.byType(MenuPopupSurface), findsOneWidget);
      _expectGlass(tester, find.byType(MenuPopupSurface));
    });
  });

  group('command', () {
    testWidgets('panel is frosted', (tester) async {
      await tester.pumpWidget(
        Theme(
          data: _glass,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Overlay(
              initialEntries: <OverlayEntry>[
                OverlayEntry(
                  builder: (_) => Center(
                    child: Command(
                      debounceDuration: Duration.zero,
                      builder: (_, _) => const Stream<List<Widget>>.empty(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 400));
      _expectGlass(tester, find.byType(Command));
    });
  });

  group('hover_card', () {
    testWidgets('hover surface is frosted', (tester) async {
      await tester.pumpWidget(
        _overlayFrame(
          HoverCard(
            wait: Duration.zero,
            hoverBuilder: (context) => const Text('preview-body'),
            // The anchor must hit-test so the mouse can enter it.
            child: Container(
              width: 20,
              height: 20,
              color: const Color(0xFF000001),
            ),
          ),
        ),
      );
      // The anchor paints nothing, so any frosted fill tree-wide must be the
      // hover surface (the private surface widget lives in the overlay,
      // outside the `HoverCard` subtree, and cannot be scoped to).
      List<Color> frosted() => _allPaints(
        tester,
        find.byType(Overlay),
      ).where((Color color) => color.a > 0.05 && color.a <= 0.6).toList();
      expect(frosted(), isEmpty);
      final TestGesture mouse = await _mouse(tester);
      await mouse.moveTo(tester.getCenter(find.byType(HoverCard)));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('preview-body'), findsOneWidget);
      expect(frosted(), isNotEmpty);
      expect(find.byType(BackdropFilter), findsWidgets);
    });
  });

  group('tooltip', () {
    testWidgets('bubble is frosted', (tester) async {
      await tester.pumpWidget(
        _frame(const TooltipContainer(child: Text('tip'))),
      );
      _expectGlass(tester, find.byType(TooltipContainer));
    });
  });

  group('toast', () {
    testWidgets('toast card is frosted', (tester) async {
      final ToastController controller = ToastController();
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        Theme(
          data: _glass,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: ToastLayer(controller: controller, child: const Text('app')),
          ),
        ),
      );
      controller.showToast(builder: (_) => const Text('hi'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('hi'), findsOneWidget);
      _expectGlass(tester, find.byType(ToastLayer));
      for (final entry in controller.entries.toList()) {
        controller.remove(entry.id);
      }
      await tester.pump();
    });
  });

  group('gooey_toast', () {
    testWidgets('gooey card composites a translucent fill plus blur', (
      tester,
    ) async {
      final GooeyToastController controller = GooeyToastController();
      await tester.pumpWidget(
        Theme(
          data: _glass,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Overlay(
              initialEntries: <OverlayEntry>[
                OverlayEntry(
                  builder: (BuildContext context) => GooeyToastLayer(
                    controller: controller,
                    child: const SizedBox.shrink(),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pump();
      controller.showGooeyToast(
        tester.element(find.byType(GooeyToastLayer)),
        GooeyToastOptions(title: 'Saved', state: GooeyToastState.success),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.byType(GooeySurface), findsOneWidget);
      final GooeySurface surface = tester.widget<GooeySurface>(
        find.byType(GooeySurface),
      );
      expect(surface.fillAlpha, lessThanOrEqualTo(0.6));
      expect(find.byType(BackdropFilter), findsWidgets);
      controller.dispose();
    });
  });

  group('navigation_bar', () {
    testWidgets('bar fill is translucent with a blur', (tester) async {
      await tester.pumpWidget(
        _frame(
          NavigationBar(
            children: <NavigationBarItem>[
              NavigationItem(label: const Text('home'), child: const Text('i')),
            ],
          ),
        ),
      );
      _expectGlass(tester, find.byType(NavigationBar));
    });

    testWidgets('sidebar frosts under a glass theme', (tester) async {
      await tester.pumpWidget(
        _frame(
          SizedBox(
            width: 260,
            height: 320,
            child: NavigationBar(
              container: NavigationContainerType.sidebar,
              children: <NavigationBarItem>[
                NavigationItem(
                  label: const Text('home'),
                  child: const Text('i'),
                ),
              ],
            ),
          ),
        ),
      );
      _expectGlass(tester, find.byType(NavigationBar));
    });
  });

  group('navigation_menu', () {
    testWidgets('opened panel is frosted', (tester) async {
      await tester.pumpWidget(
        Theme(
          data: _glass,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: OverlayManagerLayer(
              popoverHandler: OverlayHandler.popover,
              tooltipHandler: OverlayHandler.popover,
              menuHandler: OverlayHandler.popover,
              child: Overlay(
                key: ValueKey<int>(_overlayGeneration++),
                initialEntries: <OverlayEntry>[
                  OverlayEntry(
                    builder: (BuildContext context) => Center(
                      child: NavigationMenu(
                        children: <Widget>[
                          NavigationMenuItem(
                            content: const NavigationMenuContent(
                              title: Text('Web Apps'),
                              content: Text('Ship in the browser'),
                            ),
                            child: const Text('Products'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      final TestGesture mouse = await _mouse(tester);
      await mouse.moveTo(tester.getCenter(find.text('Products')));
      for (var i = 0; i < 4; i++) {
        await tester.pump(const Duration(milliseconds: 50));
      }
      expect(find.byType(OutlinedContainer), findsOneWidget);
      _expectGlass(tester, find.byType(OutlinedContainer));
    });
  });

  group('scaffold', () {
    testWidgets('app bar fill is translucent with a blur', (tester) async {
      await tester.pumpWidget(_frame(const AppBar(title: Text('title'))));
      final Finder scope = find.byType(AppBar);
      final ColoredBox box = tester.widget<ColoredBox>(
        find.descendant(of: scope, matching: find.byType(ColoredBox)).first,
      );
      expect(box.color.a, lessThanOrEqualTo(0.6));
      expect(
        find.descendant(of: scope, matching: find.byType(BackdropFilter)),
        findsOneWidget,
      );
    });

    testWidgets('header section frosts its background', (tester) async {
      await tester.pumpWidget(
        _frame(
          const Scaffold(
            headerBackgroundColor: ThemedColor.value(Color(0xFFFFFFFF)),
            headers: <Widget>[Text('header')],
            child: Text('body'),
          ),
        ),
      );
      await tester.pump();
      final Finder scope = find.byType(Scaffold);
      // The full-screen body background stays opaque by design (it is the
      // app background, not a floating surface); the floating header
      // section on top of it must frost.
      final List<Color> frosted = tester
          .widgetList<ColoredBox>(
            find.descendant(of: scope, matching: find.byType(ColoredBox)),
          )
          .map((ColoredBox box) => box.color)
          .where((Color color) => color.a <= 0.6)
          .toList();
      expect(frosted, isNotEmpty, reason: 'header section never frosts');
      expect(
        find.descendant(of: scope, matching: find.byType(BackdropFilter)),
        findsWidgets,
      );
    });
  });

  group('window', () {
    testWidgets('frame frosts through its card', (tester) async {
      final WindowController controller = WindowController(
        bounds: const Rect.fromLTWH(20, 30, 200, 150),
      );
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        _frame(
          SizedBox(
            width: 400,
            height: 300,
            child: WindowNavigator(
              initialWindows: <Window>[
                Window(
                  controller: controller,
                  title: const Text('Notes'),
                  content: const Text('body'),
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pump();
      _expectGlass(tester, find.byType(Window));
    });
  });

  group('outlined_container', () {
    testWidgets('fill is translucent with a blur', (tester) async {
      await tester.pumpWidget(
        _frame(const OutlinedContainer(child: Text('body'))),
      );
      _expectGlass(tester, find.byType(OutlinedContainer));
    });
  });

  group('input', () {
    testWidgets('filled field frosts', (tester) async {
      await tester.pumpWidget(_frame(const Input(filled: true)));
      await tester.pump();
      final Finder scope = find.byType(Input);
      final List<Color> paints = _allPaints(tester, scope).where((Color color) {
        return color.a > 0.05;
      }).toList();
      expect(paints, isNotEmpty, reason: 'no visible field fill');
      expect(
        paints,
        everyElement(
          predicate<Color>(
            (Color color) => color.a <= 0.6,
            'opaque field fill',
          ),
        ),
      );
      expect(
        find.descendant(of: scope, matching: find.byType(BackdropFilter)),
        findsWidgets,
      );
    });
  });

  group('phone_input', () {
    testWidgets('joined group frosts', (tester) async {
      await tester.pumpWidget(_frame(const PhoneInput()));
      await tester.pump();
      _expectGlass(tester, find.byType(PhoneInput));
    });
  });

  group('formatted_input', () {
    testWidgets('segmented field frosts', (tester) async {
      await tester.pumpWidget(
        _frame(
          const FormattedInput(
            initialValue: SegmentedValue(<SegmentPart>[
              SegmentPart.editable(length: 4),
            ]),
          ),
        ),
      );
      await tester.pump();
      _expectGlass(tester, find.byType(FormattedInput));
    });
  });

  group('file_picker', () {
    testWidgets('tile fill is translucent with a blur', (tester) async {
      await tester.pumpWidget(
        _frame(
          const FileUpload(
            variant: FileUploadVariant.tile,
            // The tile draws no fill by default (the ambient background
            // shows through); a themed fill must frost.
            theme: FileUploadTheme(
              background: ThemedColor.value(Color(0xFFFFFFFF)),
            ),
          ),
        ),
      );
      await tester.pump();
      final Container tile = tester.widget<Container>(
        find.byKey(fileUploadTileKey),
      );
      final Color fill = (tile.decoration as BoxDecoration).color!;
      expect(fill.a, lessThanOrEqualTo(0.6));
      expect(
        find.descendant(
          of: find.byType(FileUpload),
          matching: find.byType(BackdropFilter),
        ),
        findsWidgets,
      );
    });
  });

  group('dropzone', () {
    testWidgets('drop area frosts', (tester) async {
      await tester.pumpWidget(
        _frame(
          const Dropzone(
            theme: DropzoneTheme(
              background: ThemedColor.value(Color(0xFFFFFFFF)),
            ),
          ),
        ),
      );
      await tester.pump();
      final Container surface = tester.widget<Container>(
        find.byKey(dropzoneSurfaceKey),
      );
      final Color fill = (surface.decoration as BoxDecoration).color!;
      expect(fill.a, lessThanOrEqualTo(0.6));
      expect(find.byType(BackdropFilter), findsWidgets);
    });
  });

  group('video_player', () {
    testWidgets('control bar frosts', (tester) async {
      await tester.pumpWidget(_frame(const VideoPlayer()));
      await tester.pump();
      _expectGlass(tester, find.byType(VideoControlsBar));
    });
  });

  group('audio_player', () {
    testWidgets('card frosts', (tester) async {
      await tester.pumpWidget(_frame(const AudioPlayer(title: 'Frost')));
      await tester.pump();
      _expectGlass(tester, find.byType(AudioPlayer));
  group('image_lightbox', () {
    testWidgets('chrome frosts through the surface primitive', (tester) async {
      await tester.pumpWidget(
        _frame(
          ImageLightbox(
            images: <LightboxImage>[
              LightboxImage(
                image: MemoryImage(Uint8List(0)),
                semanticLabel: 'a',
              ),
              LightboxImage(
                image: MemoryImage(Uint8List(0)),
                semanticLabel: 'b',
              ),
            ],
          ),
        ),
      );
      await tester.pump();
      _expectGlass(
        tester,
        find.byKey(const ValueKey<String>('dashcn.image_lightbox.chrome')),
      );
    });
  });

  group('registry coverage', () {
    test('every registry id is tested or allow-listed', () {
      final Map<String, Object?> manifest = _readManifest();
      final Map<String, Object?> components = (manifest['components'] as Map)
          .cast<String, Object?>();
      final Set<String> ids = components.keys.toSet();
      final Set<String> missing = ids
          .difference(_tested)
          .difference(_allowList.keys.toSet());
      expect(
        missing,
        isEmpty,
        reason: 'registry ids with no surface test: $missing',
      );
    });
  });
}

/// Registry ids exercised by the groups above.
const Set<String> _tested = <String>{
  'card',
  'dialog',
  'alert_dialog',
  'drawer',
  'drawer_container',
  'pinned_sheet',
  'menubar',
  'menu',
  'dropdown_menu',
  'context_menu',
  'popup',
  'select',
  'autocomplete',
  'command',
  'hover_card',
  'tooltip',
  'toast',
  'gooey_toast',
  'navigation_bar',
  'navigation_menu',
  'scaffold',
  'window',
  'image_lightbox',
  'outlined_container',
  'input',
  'phone_input',
  'formatted_input',
  'file_picker',
  'dropzone',
  'video_player',
  'audio_player',
};

/// Registry ids with no frosted surface, and why.
///
/// There is no `popover` or `sheet` component in the registry: the popover
/// primitive paints through `MenuPopupSurface` (covered via `menu`) and sheet
/// chrome is the drawer container (covered via `drawer_container` /
/// `pinned_sheet`).
const Map<String, String> _allowList = <String, String>{
  'accordion': 'layout container; rows draw no surface fill',
  'action_sheet': 'overlay sheet; chrome covered via drawer/pinned_sheet',
  'alert': 'inline banner fill, not a floating surface',
  'alpha': 'color utility, no widget surface',
  'anchor': 'positioning utility, no paint',
  'app': 'app shell; the window background stays opaque by design',
  'async': 'async builder, no paint',
  'avatar': 'image/initials tile, not a surface',
  'backdrop_transform': 'transform utility, no paint',
  'badge': 'inline count label, not a surface',
  'border_loading': 'loading border effect, no surface fill',
  'breadcrumb': 'navigation trail text, no surface',
  'button': 'control, not a surface (triggers stay opaque)',
  'calendar':
      'day-cell accent fills, not a floating surface; per-cell blur '
      'would be a perf hazard and cells inherit no backdrop',
  'card_image': 'media slot, no surface of its own (lives in a card)',
  'carousel': 'no box paint; slides are caller content',
  'chat': 'composed of surfaces covered elsewhere (card/input)',
  'checkbox': 'control, not a surface',
  'chip': 'inline token, not a surface',
  'chip_input': 'input variant; fill covered via the shared input resolver',
  'code_snippet': 'code block; inline fill, not a floating surface',
  'collapsible': 'layout container, no surface of its own',
  'color': 'color utility, no widget surface',
  'color_field': 'input variant; fill covered via the shared input resolver',
  'color_input': 'input variant; fill covered via the shared input resolver',
  'color_picker': 'popover content; the popup surface is covered via menu',
  'country_flag': 'flag glyph, no surface',
  'date_picker': 'composes calendar cells and inputs; no own surface paint',
  'divider': 'hairline, not a surface',
  'dot_indicator': 'status dot accent, not a surface',
  'empty_state': 'placeholder layout; no surface of its own',
  'error_system': 'error mapping, no paint',
  'eye_dropper': 'color sampling tool; popup surface covered via menu',
  'feature_carousel': 'composed carousel; no own surface paint',
  'file_diff_viewer': 'diff text layout, no surface of its own',
  'filter_bar': 'composed of controls; no own surface',
  'form': 'form scope, no paint',
  'formatter': 'text formatting utility, no paint',
  'group': 'layout grouping, no paint',
  'history': 'history utility, no paint',
  'hsl': 'color utility, no widget surface',
  'hsv': 'color utility, no widget surface',
  'icon': 'glyph, no surface',
  'image': 'media, no surface of its own',
  'input_otp': 'input variant; fill covered via the shared input resolver',
  'item_picker': 'picker rows; popup surface covered via menu',
  'wheel_picker': 'inline scrolling control; no floating surface of its own',
  'keyboard_shortcut': 'hint label, no surface',
  'list_tile': 'row layout; no floating surface',
  'locale_utils': 'localization utility, no paint',
  'markdown': 'text rendering, no surface of its own',
  'media_query': 'media utility, no paint',
  'multi_select': 'select variant; popup surface covered via select',
  'multiple_choice': 'radio/choice rows; no floating surface',
  'number_ticker': 'animated number text, no surface',
  'object_input': 'composed inputs; fills covered via input',
  'overflow_marquee': 'edge-fade shader only; no box surface',
  'overlay_configuration': 'overlay config, no paint',
  'page_route': 'route, no paint of its own',
  'pagination': 'page buttons; controls, not a surface',
  'patch': 'patch utility, no paint',
  'progress': 'canvas track/fill accents, not a box surface',
  'qr_code':
      'fixed module bitmap; the quiet zone stays light by design, not a floating surface',
  'radio_group': 'controls, not a surface',
  'refresh_trigger': 'pull-to-refresh trigger, no surface of its own',
  'resizable': 'split layout; panels are caller content',
  'scrollable': 'scroll viewport, no surface of its own',
  'scrollable_client': 'scroll client, no paint',
  'scrollbar': 'scroll indicator, not a surface',
  'scrollview': 'scroll viewport, no surface of its own',
  'search_bar':
      'inline field + result card; the surface stays opaque by design',
  'selectable': 'selection wrapper, no surface of its own',
  'signature_pad':
      'drawing canvas; the ink surface stays opaque so strokes stay legible',
  'skeleton': 'loading shimmer placeholder, not a frosted surface',
  'slider': 'control, not a surface',
  'sortable': 'no box paint; rows are caller content',
  'spell_check_suggestions_toolbar': 'editor toolbar; no floating surface',
  'spinner': 'canvas stroke, not a box surface',
  'stage_container': 'drawer-container alias; covered via drawer_container',
  'star_rating': 'rating glyphs, not a surface',
  'stepper': 'step controls; no floating surface',
  'steps': 'step list layout, no surface of its own',
  'swipe_actions': 'swipe row actions; no floating surface',
  'swiper': 'dismiss scrim only; panel chrome is the drawer surface',
  'switch': 'control, not a surface',
  'switcher': 'segmented control; controls, not a surface',
  'table': 'data grid; cells are inline fills, not a floating surface',
  'tabs': 'tab controls; panels are caller content',
  'text_animate': 'animated text, no surface',
  'text_area': 'delegates to Input; fill covered via input',
  'time_picker': 'composes inputs; no own surface paint',
  'timeline': 'spine/dot accents, not a floating surface',
  'timeline_animation': 'timeline animation utility, no paint',
  'toggle': 'control, not a surface',
  'tracker': 'analytics utility, no paint',
  'chart': 'canvas paints, not a box surface',
  'tree': 'tree rows; inline fills, not a floating surface',
  'triple_dots': 'overflow glyph, no surface',
};

Map<String, Object?> _readManifest() {
  final File file = File('lib/src/manifests/registry.json');
  if (!file.existsSync()) {
    return const <String, Object?>{'components': <String, Object?>{}};
  }
  final Object? decoded = jsonDecode(file.readAsStringSync());
  if (decoded is Map<String, Object?>) return decoded;
  return const <String, Object?>{'components': <String, Object?>{}};
}

/// Drawer theme stand-in with no fill: exercises the null-base frost path.
class _NullFillDrawerTheme implements DrawerRouteTheme {
  @override
  ThemedColor? get background => null;
  @override
  ThemedColor? get foreground => null;
  @override
  ThemedColor? get borderColor => null;
  @override
  double? get borderWidth => null;
  @override
  BorderRadius? get borderRadius => null;
  @override
  EdgeInsetsGeometry? get padding => null;
  @override
  ThemedColor? get barrierColor => null;
  @override
  double? get maxSize => null;
  @override
  bool? get showDragHandle => null;
  @override
  Size? get dragHandleSize => null;
  @override
  ThemedColor? get dragHandleColor => null;
  @override
  Duration? get transitionDuration => null;
  @override
  List<BoxShadow>? get shadows => null;
  @override
  ShadowScale? get themeShadows => null;
}

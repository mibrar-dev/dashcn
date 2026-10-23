// Token-matrix captures: 8 representative components under radius 0 vs large
// radius (factor 0 vs 1.0) crossed with compact vs touch density.
//
// Renders under `flutter test` and writes one PNG per component/combination
// into `rearch/captures/fix-theme-tokens-everywhere/` (git-ignored,
// regenerated on demand — see CAPTURES.md there). The docs site cannot set
// these tokens: radius is only adjustable through the theme-rail picker UI
// (no URL param) and no rail control sets global density, so the matrix is
// captured by pumping the kit directly under modified tokens.
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/button/button.dart';
import 'package:dashcn/src/components/card/card.dart';
import 'package:dashcn/src/components/dialog/dialog.dart';
import 'package:dashcn/src/components/input/input.dart';
import 'package:dashcn/src/components/menu/menu.dart';
import 'package:dashcn/src/components/popup/popup.dart';
import 'package:dashcn/src/components/select/select.dart';
import 'package:dashcn/src/components/sidebar/sidebar.dart';
import 'package:dashcn/src/components/swipe_actions/swipe_actions.dart';
import 'package:dashcn/src/foundation/icons/lucide_icons.dart';
import 'package:dashcn/src/primitives/localizations/localizations.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/density_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:dashcn/src/theme/tokens.dart';
import 'package:flutter_test/flutter_test.dart';

/// Device pixel ratio of every capture.
const double _dpr = 1.0;

/// Stage size: wide enough for the sidebar rail, short enough for PNGs.
const Size _stage = Size(720, 520);

/// Output folder: `rearch/captures/fix-theme-tokens-everywhere/`.
/// `flutter test` runs in `dashcn/`, so `..` is the repo root.
Directory get _outDir => Directory(
  '${Directory.current.path}/../rearch/captures/fix-theme-tokens-everywhere',
);

/// Registers the repo's Geist + Lucide fonts on the test engine.
Future<void> _loadFonts() async {
  Future<void> load(String family, String asset) async {
    final loader = FontLoader(family);
    final bytes = File('${Directory.current.path}/$asset').readAsBytesSync();
    loader.addFont(Future<ByteData>.value(ByteData.sublistView(bytes)));
    await loader.load();
  }

  await load('GeistSans', 'assets/fonts/Geist-Regular.otf');
  await load('GeistMono', 'assets/fonts/GeistMono-Regular.otf');
  await load('LucideIcons', 'assets/fonts/lucide.ttf');
}

/// Theme for one matrix cell.
ThemeData _theme({required double radius, required DensityTokens density}) {
  return ThemeData(
    colors: ThemeColors.lightFallback,
    tokens: DesignTokens(radius: radius),
    densityTokens: density,
  );
}

Widget _frame(ThemeData data, Widget child) {
  return Theme(
    data: data,
    child: Localizations(
      locale: const Locale('en'),
      delegates: <LocalizationsDelegate<dynamic>>[
        ...ComponentLocalizations.localizationsDelegates,
        DefaultWidgetsLocalizations.delegate,
      ],
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: MediaQuery(
          data: const MediaQueryData(devicePixelRatio: _dpr),
          child: DefaultTextStyle(
            style: data.typography.sans.copyWith(
              color: data.colors.foreground,
              fontSize: 14,
            ),
            child: ColoredBox(
              color: data.colors.background,
              child: Overlay.wrap(
                child: Center(
                  child: SizedBox.fromSize(size: _stage, child: child),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

/// Taps [target] with a mouse.
Future<void> _tap(WidgetTester tester, Finder target) async {
  final gesture = await tester.createGesture();
  await gesture.addPointer(location: Offset.zero);
  addTearDown(gesture.removePointer);
  await gesture.moveTo(tester.getCenter(target));
  await gesture.down(tester.getCenter(target));
  await gesture.up();
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 320));
}

/// Writes the current pixels under [key] to `<tag>.png`. The real raster
/// path is required: these PNGs are the visual proof for the token matrix
/// (see rearch/captures/fix-theme-tokens-everywhere/CAPTURES.md).
Future<void> _snap(WidgetTester tester, GlobalKey key, String tag) async {
  await tester.pump();
  final RenderRepaintBoundary boundary =
      key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  final ui.Image? image = await tester.runAsync(() async {
    return boundary.toImage(pixelRatio: _dpr);
  });
  final ByteData? bytes = await image?.toByteData(
    format: ui.ImageByteFormat.png,
  );
  final Uint8List png = bytes!.buffer.asUint8List();
  File('${_outDir.path}/$tag.png').writeAsBytesSync(png);
}

Widget _padded(Widget child) {
  return Padding(padding: const EdgeInsets.all(48), child: child);
}

Widget _buttonScene() {
  return _padded(
    Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Button(
          variant: ButtonVariant.primary,
          onPressed: () {},
          child: const Text('Primary'),
        ),
        const SizedBox(height: 12),
        Button(
          variant: ButtonVariant.secondary,
          onPressed: () {},
          child: const Text('Secondary'),
        ),
        const SizedBox(height: 12),
        Button(
          variant: ButtonVariant.outline,
          onPressed: () {},
          child: const Text('Outline'),
        ),
      ],
    ),
  );
}

Widget _inputScene() {
  return _padded(
    const Input(initialValue: 'you@example.com', placeholder: Text('Email')),
  );
}

Widget _selectScene() {
  return _padded(
    Select<String>(
      items: const <Widget>[
        SelectItem<String>(value: 'Light', child: Text('Light')),
        SelectItem<String>(value: 'Dark', child: Text('Dark')),
        SelectItem<String>(value: 'System', child: Text('System')),
      ],
      itemBuilder: (BuildContext context, String item) => Text(item),
      placeholder: const Text('Theme'),
      onChanged: (_) {},
    ),
  );
}

Widget _cardScene() {
  return _padded(
    Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text('Quarterly revenue'),
          SizedBox(height: 8),
          Text('Up 12% versus last quarter across every region.'),
        ],
      ),
    ),
  );
}

Widget _dialogScene() {
  return Builder(
    builder: (BuildContext context) {
      return Center(
        child: Button(
          variant: ButtonVariant.primary,
          onPressed: () => showDialog<void>(
            context: context,
            builder: (BuildContext context) => const Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Delete project?'),
                  SizedBox(height: 8),
                  Text('This action cannot be undone.'),
                ],
              ),
            ),
          ),
          child: const Text('Open dialog'),
        ),
      );
    },
  );
}

Widget _popupScene() {
  return Builder(
    builder: (BuildContext context) {
      return Center(
        child: Button(
          variant: ButtonVariant.outline,
          onPressed: () => showPopup<void>(
            context: context,
            builder: (BuildContext context) => const Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Profile'),
                  Text('Settings'),
                  Text('Log out'),
                ],
              ),
            ),
          ),
          child: const Text('Open popup'),
        ),
      );
    },
  );
}

Widget _menuScene() {
  return Builder(
    builder: (BuildContext context) {
      return Center(
        child: Button(
          variant: ButtonVariant.outline,
          onPressed: () => showMenu<void>(
            context: context,
            children: const <Widget>[
              MenuButton(child: Text('Profile')),
              MenuButton(child: Text('Settings')),
              MenuButton(destructive: true, child: Text('Log out')),
            ],
          ),
          child: const Text('Open menu'),
        ),
      );
    },
  );
}

Widget _swipeScene(SwipeActionsController controller) {
  return _padded(
    SwipeActions(
      controller: controller,
      actions: <SwipeAction>[
        SwipeAction(label: 'Archive', onPressed: () {}),
        SwipeAction(label: 'Delete', destructive: true, onPressed: () {}),
      ],
      child: Container(
        height: 56,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Text('Swipe me'),
      ),
    ),
  );
}

Widget _sidebarScene() {
  return SizedBox(
    width: 280,
    height: 460,
    child: DashboardSidebar(
      title: 'Acme Inc',
      sections: const <SidebarSection>[
        SidebarSection(
          label: 'Main',
          items: <SidebarItem>[
            SidebarItem(label: 'Dashboard', icon: LucideIcons.layoutDashboard),
            SidebarItem(
              label: 'Documents',
              icon: LucideIcons.fileText,
              badge: '12',
            ),
            SidebarItem(label: 'Reports', icon: LucideIcons.chartBar),
          ],
        ),
        SidebarSection(
          label: 'Account',
          items: <SidebarItem>[
            SidebarItem(label: 'Settings', icon: LucideIcons.settings),
            SidebarItem(label: 'Help', icon: LucideIcons.circleHelp),
          ],
        ),
      ],
    ),
  );
}

/// Scene builders by component id. Overlay scenes expose a trigger button.
final Map<String, Widget Function(SwipeActionsController)> _scenes =
    <String, Widget Function(SwipeActionsController)>{
      'button': (_) => _buttonScene(),
      'input': (_) => _inputScene(),
      'select': (_) => _selectScene(),
      'card': (_) => _cardScene(),
      'dialog': (_) => _dialogScene(),
      'popup': (_) => _popupScene(),
      'menu': (_) => _menuScene(),
      'swipe_actions': (SwipeActionsController c) => _swipeScene(c),
      'sidebar': (_) => _sidebarScene(),
    };

/// Trigger labels for the overlay scenes (tapped before the snapshot).
const Map<String, String> _triggers = <String, String>{
  'dialog': 'Open dialog',
  'popup': 'Open popup',
  'menu': 'Open menu',
};

void main() {
  setUpAll(() async {
    await _loadFonts();
    _outDir.createSync(recursive: true);
  });

  const Map<String, double> radii = <String, double>{'r0': 0.0, 'r16': 1.0};
  const Map<String, DensityTokens> densities = <String, DensityTokens>{
    'compact': DensityTokens.compact,
    'touch': DensityTokens.touch,
  };

  for (final MapEntry<String, Widget Function(SwipeActionsController)> scene
      in _scenes.entries) {
    for (final MapEntry<String, double> radius in radii.entries) {
      for (final MapEntry<String, DensityTokens> density in densities.entries) {
        final String tag = '${scene.key}_${radius.key}_${density.key}';
        testWidgets(tag, (WidgetTester tester) async {
          tester.view.devicePixelRatio = _dpr;
          tester.view.physicalSize = _stage * _dpr;
          addTearDown(tester.view.reset);

          final GlobalKey key = GlobalKey();
          final SwipeActionsController controller = SwipeActionsController();
          addTearDown(controller.dispose);
          // The binding requires painting debug vars to be reset; restore
          // the default (shadows disabled) after each capture.
          debugDisableShadows = false;
          addTearDown(() => debugDisableShadows = true);
          await tester.pumpWidget(
            RepaintBoundary(
              key: key,
              child: _frame(
                _theme(radius: radius.value, density: density.value),
                scene.value(controller),
              ),
            ),
          );
          await tester.pump();
          final String? trigger = _triggers[scene.key];
          if (trigger != null) {
            await _tap(tester, find.text(trigger));
          }
          if (scene.key == 'swipe_actions') {
            controller.open();
            await tester.pump();
          }
          await tester.pump(const Duration(milliseconds: 320));
          await tester.pump(const Duration(milliseconds: 320));
          await _snap(tester, key, tag);
        });
      }
    }
  }
}

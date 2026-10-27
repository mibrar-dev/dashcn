// Capture harness for the `sidebar` component: renders every named example
// at 1280x800 and 375x812 in light and dark, opens the drawer for the
// open-drawer scenes, and writes real PNGs to `scratchpad/ui/sidebar/`.
//
// Run with: flutter test test/registry/visual/sidebar_captures_test.dart
// (from `dashcn/`). Read-only with respect to component code.

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/sidebar/preview.dart';
import 'package:dashcn/src/foundation/component_preview.dart';
import 'package:dashcn/src/foundation/icons/lucide_icons.dart';
import 'package:dashcn/src/primitives/overlay_manager.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

/// Device pixel ratio of every capture.
const double _dpr = 2.0;

/// Output folder `$KIT/scratchpad/ui/sidebar`, found by walking up to the
/// directory that contains INSTRUCTIONS.md.
Directory get _outDir {
  var dir = Directory.current;
  while (dir.path != dir.parent.path) {
    if (File('${dir.path}/INSTRUCTIONS.md').existsSync()) {
      break;
    }
    dir = dir.parent;
  }
  return Directory('${dir.path}/scratchpad/ui/sidebar');
}

void main() {
  setUpAll(() async {
    await _loadFonts();
    _outDir.createSync(recursive: true);
  });

  setUp(() {
    // Same desktop focus behaviour the captures document (see the pilot
    // harness): `flutter test` would otherwise never render focus rings.
    FocusManager.instance.highlightStrategy =
        FocusHighlightStrategy.alwaysTraditional;
  });

  for (final Size size in const <Size>[Size(1280, 800), Size(375, 812)]) {
    final String tag = '${size.width.toInt()}x${size.height.toInt()}';
    _scene(name: 'dashboard_$tag', size: size, index: 0);
    _scene(name: 'drawer_$tag', size: size, index: 1);
    _scene(
      name: 'drawer_open_$tag',
      size: size,
      index: 1,
      interact: _openDrawer,
    );
    _scene(name: 'collapsed_$tag', size: size, index: 2);
  }
}

/// Registers one scene for both brightnesses.
void _scene({
  required String name,
  required Size size,
  required int index,
  Future<void> Function(WidgetTester tester)? interact,
}) {
  for (final brightness in const <Brightness>[
    Brightness.light,
    Brightness.dark,
  ]) {
    testWidgets('$name ${brightness.name}', (WidgetTester tester) async {
      await _capture(
        tester,
        scene: name,
        brightness: brightness,
        size: size,
        preview: sidebarPreviews[index],
        interact: interact,
      );
    });
  }
}

/// Renders [preview] at [size] and writes the PNG.
Future<void> _capture(
  WidgetTester tester, {
  required String scene,
  required Brightness brightness,
  required Size size,
  required ComponentPreview preview,
  Future<void> Function(WidgetTester tester)? interact,
}) async {
  tester.view.devicePixelRatio = _dpr;
  tester.view.physicalSize = size * _dpr;
  addTearDown(tester.view.reset);

  final key = GlobalKey();
  final ThemeData data = _baseTheme(brightness);
  debugDisableShadows = false;
  await tester.pumpWidget(
    RepaintBoundary(key: key, child: _frame(data, size, preview)),
  );
  await tester.pump();

  if (interact != null) {
    await interact(tester);
    await tester.pump();
  }
  // Settle finite animations (drawer route) without `pumpAndSettle`, which
  // a blinking cursor would hang.
  await tester.pump(const Duration(milliseconds: 320));
  await tester.pump(const Duration(milliseconds: 320));

  final boundary =
      key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  final ui.Image? image = await tester.runAsync(
    () => boundary.toImage(pixelRatio: _dpr),
  );
  final ByteData? bytes = await tester.runAsync<ByteData?>(
    () => image!.toByteData(format: ui.ImageByteFormat.png),
  );
  final file = File(
    '${_outDir.path}/${scene}_'
    '${brightness == Brightness.dark ? 'dark' : 'light'}.png',
  );
  file.writeAsBytesSync(bytes!.buffer.asUint8List());
  debugDisableShadows = true;
}

/// Opens the drawer's menu so the open-drawer scenes capture the rail in a
/// drawer on top of the demo.
Future<void> _openDrawer(WidgetTester tester) async {
  await tester.tap(find.byIcon(LucideIcons.menu));
  await tester.pump();
}

/// Registers the repo's icon fonts on the test engine.
Future<void> _loadFonts() async {
  Future<void> load(String family, List<String> assets) async {
    final loader = FontLoader(family);
    for (final asset in assets) {
      final bytes = File('${Directory.current.path}/$asset').readAsBytesSync();
      loader.addFont(Future<ByteData>.value(ByteData.sublistView(bytes)));
    }
    await loader.load();
  }

  await load('LucideIcons', const <String>['assets/fonts/lucide.ttf']);
}

/// Upstream default fallback colours with default tokens.
ThemeData _baseTheme(Brightness brightness) => ThemeData(
  colors: brightness == Brightness.dark
      ? ThemeColors.darkFallback
      : ThemeColors.lightFallback,
);

/// One named docs example framed at [size] on the theme background.
Widget _frame(ThemeData data, Size size, ComponentPreview preview) {
  return Theme(
    data: data,
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: MediaQuery(
        data: MediaQueryData(size: size, devicePixelRatio: _dpr),
        child: Builder(
          builder: (BuildContext context) {
            final theme = Theme.of(context);
            return DefaultTextStyle(
              style: theme.typography.sans.copyWith(
                color: theme.colors.foreground,
                fontSize: 14,
              ),
              child: AppLayer(
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: ColoredBox(
                    color: data.colors.background,
                    // A real Navigator (with its own overlay): the drawer
                    // examples push a DrawerRoute onto it.
                    child: Navigator(
                      onGenerateRoute: (RouteSettings settings) =>
                          PageRouteBuilder<void>(
                            settings: settings,
                            pageBuilder:
                                (
                                  BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation,
                                ) => Center(child: preview.builder(context)),
                          ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}

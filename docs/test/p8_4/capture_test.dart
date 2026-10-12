// P8-4 screenshot captures (golden-free, do not open the PNGs).
//
// Renders the two new pages plus a component install block at desktop width
// in light and dark, and writes one PNG per scene to
// `rearch/screenshots/p8-4/` for the orchestrator's visual QA. No golden
// comparison runs here.
//
// Every scene is wrapped like the real docs surface (`DashcnApp` + the
// neutral site theme, so text has production colours). Every capture runs
// inside `tester.runAsync` (the golden path): engine and file futures only
// complete on the real async zone.

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:docs/generated/app_theme.dart';
import 'package:docs/pages/material_interop_page.dart';
import 'package:docs/pages/package_or_own_page.dart';
import 'package:docs/ui/dashcn/components/app/app.dart';
import 'package:docs/ui/dashcn/theme/theme.dart';
import 'package:docs/widgets/component_install_block.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Where the captures land (relative to the docs package root).
const String kCaptureDir = '../rearch/screenshots/p8-4';

/// One capturable scene: its file name, brightness and content.
class _Scene {
  const _Scene({
    required this.name,
    required this.brightness,
    required this.content,
  });

  final String name;
  final Brightness brightness;
  final Widget content;
}

List<_Scene> _scenes() {
  const Size viewport = Size(1280, 900);
  Widget frame(Widget child) =>
      SizedBox(width: viewport.width, height: viewport.height, child: child);
  return <_Scene>[
    for (final Brightness mode in const <Brightness>[
      Brightness.light,
      Brightness.dark,
    ]) ...<_Scene>[
      _Scene(
        name: 'package-or-own-${mode.name}',
        brightness: mode,
        content: frame(const PackageOrOwnPage()),
      ),
      _Scene(
        name: 'material-${mode.name}',
        brightness: mode,
        content: frame(const MaterialInteropPage()),
      ),
      _Scene(
        name: 'install-block-${mode.name}',
        brightness: mode,
        content: frame(
          const SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Center(
              child: SizedBox(
                width: 640,
                child: ComponentInstallBlock(componentId: 'button'),
              ),
            ),
          ),
        ),
      ),
    ],
  ];
}

Future<void> _pumpScene(WidgetTester tester, _Scene scene) async {
  tester.view.physicalSize = const Size(1280, 900);
  tester.view.devicePixelRatio = 1;
  final ThemeData light = buildDocsTheme('neutral', Brightness.light);
  final ThemeData dark = buildDocsTheme('neutral', Brightness.dark);
  final ThemeData theme = scene.brightness == Brightness.dark ? dark : light;
  await tester.pumpWidget(
    DashcnApp(
      theme: light,
      darkTheme: dark,
      themeMode: scene.brightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light,
      home: Directionality(
        textDirection: TextDirection.ltr,
        // The boundary wraps the background so captures are not transparent.
        child: RepaintBoundary(
          key: ValueKey<String>('shot-${scene.name}'),
          child: ColoredBox(
            color: theme.colors.background,
            child: scene.content,
          ),
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
}

void main() {
  testWidgets('captures the p8-4 pages and install block, light and dark', (
    WidgetTester tester,
  ) async {
    addTearDown(tester.view.reset);
    final List<_Scene> scenes = _scenes();
    for (final _Scene scene in scenes) {
      await _pumpScene(tester, scene);
      Object? error = tester.takeException();
      expect(error, isNull, reason: 'capture ${scene.name} has no errors');
      final RenderRepaintBoundary boundary =
          tester
                  .element(find.byKey(ValueKey<String>('shot-${scene.name}')))
                  .renderObject!
              as RenderRepaintBoundary;
      await tester.runAsync(() async {
        final ui.Image image = await boundary.toImage();
        final ByteData? bytes = await image.toByteData(
          format: ui.ImageByteFormat.png,
        );
        image.dispose();
        Directory(kCaptureDir).createSync(recursive: true);
        await File('$kCaptureDir/${scene.name}.png').writeAsBytes(
          bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes),
          flush: true,
        );
      });
    }
  }, timeout: const Timeout(Duration(minutes: 5)));
}

// P9-2b screenshot captures (golden-free, do not open the PNGs).
//
// Renders the playground panel for four components (button, select, slider,
// dialog) at desktop (1280) and phone (390) widths in light and dark, and
// writes one PNG per scene to `rearch/screenshots/p9-2b/` for the
// orchestrator's visual QA. No golden comparison runs here.
//
// The panel is wrapped like the real docs surface (`DashcnApp` + the neutral
// site theme, so text has production colours). Every capture runs inside
// `tester.runAsync` (the golden path): engine and file futures only complete
// on the real async zone.

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:docs/generated/app_theme.dart';
import 'package:docs/playground/ui/playground_panel.dart';
import 'package:docs/ui/dashcn/components/app/app.dart';
import 'package:docs/ui/dashcn/theme/theme.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Where the captures land (relative to the docs package root).
const String kCaptureDir = '../rearch/screenshots/p9-2b';

/// One capturable scene: its file name, viewport, theme and component.
class _Scene {
  const _Scene({
    required this.name,
    required this.viewport,
    required this.brightness,
    required this.componentId,
  });

  final String name;
  final Size viewport;
  final Brightness brightness;
  final String componentId;
}

List<_Scene> _scenes() {
  const List<String> ids = <String>['button', 'select', 'slider', 'dialog'];
  const List<Brightness> modes = <Brightness>[
    Brightness.light,
    Brightness.dark,
  ];
  final List<_Scene> out = <_Scene>[];
  for (final String id in ids) {
    for (final Brightness mode in modes) {
      final String suffix = mode == Brightness.dark ? 'dark' : 'light';
      out.add(
        _Scene(
          name: '$id-1280-$suffix',
          viewport: const Size(1280, 900),
          brightness: mode,
          componentId: id,
        ),
      );
      out.add(
        _Scene(
          name: '$id-390-$suffix',
          viewport: const Size(390, 844),
          brightness: mode,
          componentId: id,
        ),
      );
    }
  }
  return out;
}

Future<void> _pumpScene(WidgetTester tester, _Scene scene) async {
  tester.view.physicalSize = scene.viewport;
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
        child: ColoredBox(
          color: theme.colors.background,
          child: RepaintBoundary(
            key: ValueKey<String>('shot-${scene.name}'),
            child: SizedBox(
              width: scene.viewport.width,
              height: scene.viewport.height,
              child: SingleChildScrollView(
                child: PlaygroundPanel(componentId: scene.componentId),
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
}

void main() {
  testWidgets('captures four playgrounds at 1280 and 390, light and dark', (
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

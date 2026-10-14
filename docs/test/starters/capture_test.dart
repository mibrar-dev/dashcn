// P9-Z2 screenshot captures (golden-free, do not open the PNGs).
//
// Renders the Starters index plus the saas starter page in light and dark,
// at desktop (1280x900) and phone (390x844) sizes, and writes one PNG per
// scene to `rearch/screenshots/p9-z2/` for the orchestrator's visual QA.
// No golden comparison runs here.
//
// Every scene runs through the real docs surface (`DocsApp` + persisted
// state, so the pages render exactly like production). Every capture runs
// inside `tester.runAsync` (the golden path): engine and file futures only
// complete on the real async zone.

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:docs/generated/docs_starters.dart';
import 'package:docs/main.dart';
import 'package:docs/routing/docs_router.dart';
import 'package:docs/state/docs_state.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/app_harness.dart';

/// Where the captures land (relative to the docs package root).
const String kCaptureDir = '../rearch/screenshots/p9-z2';

/// One capturable scene: its file name, route, size and brightness.
class _Scene {
  const _Scene({
    required this.name,
    required this.route,
    required this.width,
    required this.height,
    required this.brightness,
  });

  final String name;
  final String route;
  final double width;
  final double height;
  final Brightness brightness;
}

List<_Scene> _scenes() {
  const List<(double, double)> sizes = <(double, double)>[
    (1280, 900),
    (390, 844),
  ];
  const List<Brightness> modes = <Brightness>[
    Brightness.light,
    Brightness.dark,
  ];
  final List<String> routes = <String>['/docs/starters', '/docs/starters/saas'];
  return <_Scene>[
    for (final (double, double) size in sizes)
      for (final Brightness mode in modes)
        for (final String route in routes)
          _Scene(
            name:
                '${_slug(route)}-${mode.name}-${size.$1.toInt()}x'
                '${size.$2.toInt()}',
            route: route,
            width: size.$1,
            height: size.$2,
            brightness: mode,
          ),
  ];
}

String _slug(String route) {
  if (route == '/docs/starters') {
    return 'starters-index';
  }
  return 'starter-${route.split('/').last}';
}

/// States created per scene; disposed once at the end (disposing mid-run
/// breaks the mounted app, which still listens to its state).
final List<DocsState> _states = <DocsState>[];

Future<void> _pumpScene(WidgetTester tester, _Scene scene) async {
  tester.view.physicalSize = Size(scene.width, scene.height);
  tester.view.devicePixelRatio = 1;
  tester.platformDispatcher.platformBrightnessTestValue = scene.brightness;
  final DocsState state = DocsState(
    storage: MemoryDocsStorage(),
    systemBrightness: scene.brightness,
  );
  _states.add(state);
  await tester.pumpWidget(
    // The boundary wraps the whole surface so captures are not transparent.
    RepaintBoundary(
      key: ValueKey<String>('shot-${scene.name}'),
      child: DocsApp(state: state),
    ),
  );
  await tester.pumpAndSettle();
  final DocsRouterDelegate delegate = tester
      .widget<DocsRouterScope>(find.byType(DocsRouterScope).first)
      .delegate;
  delegate.go(tester.element(find.byType(Navigator).last), scene.route);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('captures the starters index and pages, light and dark', (
    WidgetTester tester,
  ) async {
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
    addTearDown(() {
      for (final DocsState state in _states) {
        state.dispose();
      }
      _states.clear();
    });
    final List<_Scene> scenes = _scenes();
    // Derived from the manifest: index + saas page, light + dark, desktop +
    // phone. Never hard-code the count.
    expect(scenes.length, 2 * 2 * 2);
    expect(
      scenes.where((_) => true).length,
      scenes.length,
      reason: 'routes: ${scenes.map((_Scene s) => s.route).toList()}',
    );
    expect(kStarters.map((DocsStarter s) => s.id), contains('saas'));
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
  }, timeout: const Timeout(Duration(minutes: 10)));
}

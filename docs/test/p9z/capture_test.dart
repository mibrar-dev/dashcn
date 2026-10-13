// P9-Z screenshot captures (golden-free, do not open the PNGs).
//
// Component pages (button, select) at 1280x900 and 390x844 in light and
// dark, the landing hero at both widths in light and dark, and the command
// palette with `otp` results — one PNG per scene under
// `rearch/screenshots/p9-z/` for the orchestrator's visual QA.
//
// The full docs app is pumped inside a `RepaintBoundary` wrapping the
// background (so captures are not transparent); captures run inside
// `tester.runAsync` (the SDK golden path). Deferred chunks (component page,
// hero demo, button/select previews) are co-issued once up front: in widget
// tests only co-issued `loadLibrary()` calls resolve (see
// `test/device_frame/frame_harness.dart`). Fixed pump counts only, never
// `pumpAndSettle` (OTP cursors loop forever).

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:docs/landing/hero_demo.dart' deferred as hero_demo;
import 'package:docs/main.dart';
import 'package:docs/pages/component_page.dart' deferred as component_page;
import 'package:docs/previews/component_previews.dart';
import 'package:docs/routing/docs_router.dart';
import 'package:docs/state/docs_state.dart';
import 'package:docs/widgets/palette.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../device_frame/frame_harness.dart';
import '../support/app_harness.dart';

/// Where the captures land (relative to the docs package root).
const String kCaptureDir = '../rearch/screenshots/p9-z';

/// One capturable scene.
class _Scene {
  const _Scene({
    required this.name,
    required this.width,
    required this.height,
    required this.brightness,
    required this.route,
    this.paletteQuery,
  });

  final String name;
  final double width;
  final double height;
  final Brightness brightness;
  final String route;

  /// When non-null, opens the palette and types the query before capture.
  final String? paletteQuery;
}

List<_Scene> _scenes() {
  const List<String> ids = <String>['button', 'select'];
  const List<double> widths = <double>[1280, 390];
  const List<Brightness> modes = <Brightness>[
    Brightness.light,
    Brightness.dark,
  ];
  return <_Scene>[
    for (final String id in ids)
      for (final double width in widths)
        for (final Brightness mode in modes)
          _Scene(
            name: 'component-$id-${width.toInt()}-${mode.name}',
            width: width,
            height: width == 390 ? 844 : 900,
            brightness: mode,
            route: '/docs/components/$id',
          ),
    for (final double width in widths)
      for (final Brightness mode in modes)
        _Scene(
          name: 'landing-hero-${width.toInt()}-${mode.name}',
          width: width,
          height: width == 390 ? 844 : 900,
          brightness: mode,
          route: '/',
        ),
    const _Scene(
      name: 'search-otp',
      width: 1280,
      height: 900,
      brightness: Brightness.light,
      route: '/',
      paletteQuery: 'otp',
    ),
  ];
}

/// Pumps the real docs app for [scene] inside a capture boundary.
Future<DocsRouterDelegate> _pumpCaptureApp(
  WidgetTester tester,
  _Scene scene,
) async {
  tester.view.physicalSize = Size(scene.width, scene.height);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  tester.platformDispatcher.platformBrightnessTestValue = scene.brightness;
  addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);
  docsState = DocsState(
    storage: MemoryDocsStorage(),
    systemBrightness: scene.brightness,
  );
  addTearDown(docsState.dispose);
  await tester.pumpWidget(
    RepaintBoundary(
      key: ValueKey<String>('shot-${scene.name}'),
      child: ColoredBox(
        color: const Color(0xFF000000),
        child: DocsApp(state: docsState),
      ),
    ),
  );
  await pumpFrames(tester, 3);
  return tester
      .widget<DocsRouterScope>(find.byType(DocsRouterScope).first)
      .delegate;
}

void main() {
  testWidgets('captures the p9-z surfaces', (WidgetTester tester) async {
    // Co-issue every deferred chunk once (see file docs above).
    await _pumpCaptureApp(
      tester,
      const _Scene(
        name: 'warm',
        width: 1280,
        height: 900,
        brightness: Brightness.light,
        route: '/',
      ),
    );
    await resolveAcrossPumps(
      tester,
      Future.wait<dynamic>(<Future<dynamic>>[
        component_page.loadLibrary(),
        hero_demo.loadLibrary(),
        loadComponentPreview('button'),
        loadComponentPreview('select'),
      ]),
    );
    // Name the deferred widgets after loading: instantiating them is what
    // counts as "using" a deferred import for the analyzer (a bare
    // `loadLibrary()` call does not), mirroring `main.dart`.
    expect(component_page.ComponentPage, isNotNull);
    expect(hero_demo.LandingHeroDemo, isNotNull);

    for (final _Scene scene in _scenes()) {
      final DocsRouterDelegate delegate = await _pumpCaptureApp(tester, scene);
      await goTo(tester, delegate, scene.route);
      await pumpFrames(tester, 8);
      if (scene.paletteQuery != null) {
        delegate.openPalette();
        await pumpFrames(tester, 3);
        await tester.enterText(
          find.descendant(
            of: find.byType(DocsPalette),
            matching: find.byType(EditableText),
          ),
          'otp',
        );
        await pumpFrames(tester, 4);
      }
      expectNoTestErrors(tester, 'capture ${scene.name} has no errors');
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

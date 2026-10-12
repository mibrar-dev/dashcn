// P9-5b screenshot captures (golden-free, do not open the PNGs).
//
// Renders the trust scorecard card (light/dark) and the "How we measure"
// page (light/dark) and writes one PNG per scene to
// `rearch/screenshots/p9-5b/` for the orchestrator's visual QA.
// No golden comparison runs here.
//
// Captures run inside `tester.runAsync` (the golden path): engine and file
// futures only complete on the real async zone.

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:docs/main.dart';
import 'package:docs/routing/docs_router.dart';
import 'package:docs/state/docs_state.dart';
import 'package:docs/ui/dashcn/theme/color_tokens.dart';
import 'package:docs/ui/dashcn/theme/theme.dart' as dashcn;
import 'package:docs/widgets/scorecard/scorecard_card.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/app_harness.dart';

/// Where the captures land (relative to the docs package root).
const String kCaptureDir = '../rearch/screenshots/p9-5b';

Future<void> _capture(WidgetTester tester, GlobalKey key, String name) async {
  await tester.pump();
  final RenderRepaintBoundary boundary =
      key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  await tester.runAsync(() async {
    final ui.Image image = await boundary.toImage();
    final ByteData? bytes = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    image.dispose();
    Directory(kCaptureDir).createSync(recursive: true);
    await File('$kCaptureDir/$name.png').writeAsBytes(
      bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes),
      flush: true,
    );
  });
}

/// Pumps an isolated card wrapped in a capturable boundary.
Future<void> _pumpCard(
  WidgetTester tester,
  GlobalKey key, {
  required Brightness brightness,
  required String componentId,
}) async {
  tester.view.physicalSize = const Size(800, 1200);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  final ThemeColors colors = brightness == Brightness.dark
      ? ThemeColors.darkFallback
      : ThemeColors.lightFallback;
  await tester.pumpWidget(
    RepaintBoundary(
      key: key,
      child: WidgetsApp(
        color: const Color(0xFFFFFFFF),
        builder: (BuildContext context, Widget? child) => Directionality(
          textDirection: TextDirection.ltr,
          child: dashcn.Theme(
            data: dashcn.ThemeData(colors: colors),
            child: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                width: 600,
                child: SingleChildScrollView(
                  child: ScorecardCard(componentId: componentId),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

/// Pumps the full app on the scorecards page wrapped in a boundary.
Future<DocsRouterDelegate> _pumpPage(
  WidgetTester tester,
  GlobalKey key, {
  required Brightness brightness,
}) async {
  tester.view.physicalSize = const Size(1400, 900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  tester.platformDispatcher.platformBrightnessTestValue = brightness;
  addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);

  docsState = DocsState(
    storage: MemoryDocsStorage(),
    systemBrightness: brightness,
  );
  addTearDown(docsState.dispose);
  await tester.pumpWidget(
    RepaintBoundary(
      key: key,
      child: DocsApp(state: docsState),
    ),
  );
  await tester.pumpAndSettle();
  final DocsRouterDelegate delegate = tester
      .widget<DocsRouterScope>(find.byType(DocsRouterScope).first)
      .delegate;
  delegate.go(tester.element(find.byType(Navigator).last), '/docs/scorecards');
  await tester.pumpAndSettle();
  await tester.pumpAndSettle();
  return delegate;
}

void main() {
  testWidgets('captures the scorecard card (light and dark)', (
    WidgetTester tester,
  ) async {
    final GlobalKey lightKey = GlobalKey(debugLabel: 'p9-5b-card-light');
    await _pumpCard(
      tester,
      lightKey,
      brightness: Brightness.light,
      componentId: 'button',
    );
    expect(find.text('Trust scorecard'), findsOneWidget);
    await _capture(tester, lightKey, 'scorecard-card-light');

    final GlobalKey darkKey = GlobalKey(debugLabel: 'p9-5b-card-dark');
    await _pumpCard(
      tester,
      darkKey,
      brightness: Brightness.dark,
      componentId: 'button',
    );
    expect(find.text('Trust scorecard'), findsOneWidget);
    await _capture(tester, darkKey, 'scorecard-card-dark');
  }, timeout: const Timeout(Duration(minutes: 5)));

  testWidgets('captures the how-we-measure page (light and dark)', (
    WidgetTester tester,
  ) async {
    final GlobalKey lightKey = GlobalKey(debugLabel: 'p9-5b-page-light');
    await _pumpPage(tester, lightKey, brightness: Brightness.light);
    expect(find.text('How we measure'), findsWidgets);
    await _capture(tester, lightKey, 'scorecards-page-light');

    final GlobalKey darkKey = GlobalKey(debugLabel: 'p9-5b-page-dark');
    await _pumpPage(tester, darkKey, brightness: Brightness.dark);
    expect(find.text('How we measure'), findsWidgets);
    await _capture(tester, darkKey, 'scorecards-page-dark');
  }, timeout: const Timeout(Duration(minutes: 5)));
}

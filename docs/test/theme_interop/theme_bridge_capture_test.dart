// P9-4b screenshot captures (golden-free, do not open the PNGs).
//
// Renders the real Theme Studio import dialog (with a pasted web theme,
// live preview and report) and the Get Code export tabs, and writes one PNG
// per scene to `rearch/screenshots/p9-4b/` for the orchestrator's visual QA.
// No golden comparison runs here.
//
// One pumped app per brightness serves every scene; captures run inside
// `tester.runAsync` (the golden path): engine and file futures only complete
// on the real async zone.

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:docs/main.dart';
import 'package:docs/routing/docs_router.dart';
import 'package:docs/state/docs_state.dart';
import 'package:docs/ui/dashcn/components/text_area/text_area.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support/app_harness.dart';

/// Where the captures land (absolute: the test CWD is the docs package).
const String kCaptureDir = '/home/user/dashcn-kit/rearch/screenshots/p9-4b';

/// A tweakcn-shaped source for the import dialog's paste area.
const String kCaptureCss =
    ':root { '
    '--background: oklch(1 0 0); --foreground: oklch(0.141 0.005 285.823); '
    '--primary: oklch(0.21 0.006 285.885); '
    '--primary-foreground: oklch(0.985 0 0); --radius: 0.625rem; } '
    '.dark { --background: oklch(0.141 0.005 285.823); '
    '--foreground: oklch(0.985 0 0); --primary: oklch(0.92 0.004 286.32); '
    '--primary-foreground: oklch(0.21 0.006 285.885); }';

/// Pumps the app wrapped in a capturable boundary at 1400x900.
Future<DocsRouterDelegate> _pumpCapturable(
  WidgetTester tester,
  GlobalKey key, {
  required Brightness platformBrightness,
}) async {
  tester.view.physicalSize = const Size(1400, 900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  tester.platformDispatcher.platformBrightnessTestValue = platformBrightness;
  addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);

  docsState = DocsState(
    storage: MemoryDocsStorage(),
    systemBrightness: platformBrightness,
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
  delegate.go(tester.element(find.byType(Navigator).last), '/themes');
  await tester.pumpAndSettle();
  return delegate;
}

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

void _pasteImport(WidgetTester tester, String source) {
  final TextArea area = tester.widget<TextArea>(
    find.byKey(const ValueKey<String>('theme-import-input')),
  );
  area.controller!.text = source;
}

Future<void> _openImport(WidgetTester tester) async {
  await tester.tap(find.text('Import'));
  await tester.pumpAndSettle();
  expect(find.text('Import Web Theme'), findsOneWidget);
}

Future<void> _closeDialog(WidgetTester tester, String cancelLabel) async {
  await tester.tap(find.text(cancelLabel).last);
  await tester.pumpAndSettle();
}

Future<void> _openExportTab(WidgetTester tester, String label) async {
  await tester.tap(find.byKey(const ValueKey<String>('theme-rail-get-code')));
  await tester.pumpAndSettle();
  await _selectExportTab(tester, label);
}

Future<void> _selectExportTab(WidgetTester tester, String label) async {
  await tester.ensureVisible(find.text(label));
  await tester.pumpAndSettle();
  await tester.tap(find.text(label));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('captures the import dialog and export tabs (light)', (
    WidgetTester tester,
  ) async {
    final GlobalKey key = GlobalKey(debugLabel: 'p9-4b-light');
    await _pumpCapturable(tester, key, platformBrightness: Brightness.light);

    await _openImport(tester);
    _pasteImport(tester, kCaptureCss);
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey<String>('theme-import-preview')),
      findsOneWidget,
    );
    await _capture(tester, key, 'import-dialog-light');
    await _closeDialog(tester, 'Cancel');

    await _openExportTab(tester, 'Web CSS (v4)');
    await _capture(tester, key, 'export-webcss-light');

    await _selectExportTab(tester, 'Tokens (DTCG)');
    await _capture(tester, key, 'export-dtcg-light');
  }, timeout: const Timeout(Duration(minutes: 5)));

  testWidgets('captures the import dialog and export tabs (dark)', (
    WidgetTester tester,
  ) async {
    final GlobalKey key = GlobalKey(debugLabel: 'p9-4b-dark');
    await _pumpCapturable(tester, key, platformBrightness: Brightness.dark);

    await _openImport(tester);
    _pasteImport(tester, kCaptureCss);
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey<String>('theme-import-preview')),
      findsOneWidget,
    );
    await _capture(tester, key, 'import-dialog-dark');
    await _closeDialog(tester, 'Cancel');

    await _openExportTab(tester, 'Tokens (DTCG)');
    await _capture(tester, key, 'export-dtcg-dark');
  }, timeout: const Timeout(Duration(minutes: 5)));
}

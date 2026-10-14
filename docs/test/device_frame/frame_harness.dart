// Shared harness for the device-frame tests (P9-1).
//
// Pumps a scene under the neutral preset, a directionality and a media
// query inside a vertical scroller (mirroring the docs article, which
// scrolls). Fixed pump counts only — never `pumpAndSettle`, so a preview
// with a looping animation cannot hang the suite.

import 'package:docs/previews/block_previews.dart';
import 'package:docs/previews/component_previews.dart';
import 'package:docs/theme/theme_document.dart';
import 'package:docs/ui/dashcn/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// The six representative previews of the P9-1 matrix.
const List<String> kMatrixPreviewIds = <String>[
  'button',
  'card',
  'dialog',
  'select',
  'calendar',
  'sidebar-01',
];

/// Isolate-level cache of the loaded previews (see [loadWarmPreview]).
Map<String, Widget>? _previewCache;

/// Loads [id] through the isolate's warm cache.
///
/// Deferred chunks have an engine quirk in widget tests: co-issued
/// `loadLibrary()` calls resolve together, but a second *distinct* chunk
/// issued after the first completed hangs forever. Warming all six at once
/// on the first call (whichever test runs first, so `--name` filtering
/// stays safe) keeps every later load a cache hit. Call after a scene is
/// pumped.
Future<Widget> loadWarmPreview(WidgetTester tester, String id) async {
  _previewCache ??= await resolveAcrossPumps(
    tester,
    Future.wait(<Future<Widget>>[
      for (final String previewId in kMatrixPreviewIds)
        previewId == 'sidebar-01'
            ? loadBlockPreview(previewId)
            : loadComponentPreview(previewId),
    ]).then(
      (List<Widget> previews) =>
          Map<String, Widget>.fromIterables(kMatrixPreviewIds, previews),
    ),
  );
  return _previewCache![id]!;
}

/// Pumps [child] at [viewport] under the neutral [brightness] theme.
///
/// The test view is resized to [viewport] so the scene width matches the
/// `RenderView` (a wide scene in the default 800x600 view would overflow).
Future<void> pumpFramedScene(
  WidgetTester tester,
  Widget child, {
  Brightness brightness = Brightness.light,
  Size viewport = const Size(1400, 1000),
}) {
  tester.view.physicalSize = viewport;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  final ThemeData theme = ThemeDocument.fromPreset('neutral').theme(brightness);
  return tester.pumpWidget(
    Theme(
      data: theme,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: MediaQuery(
          data: MediaQueryData(size: viewport),
          child: SingleChildScrollView(
            child: SizedBox(width: viewport.width, child: child),
          ),
        ),
      ),
    ),
  );
}

/// Advances [frames] frames of 100 ms (lets futures and first animations
/// land without hanging on looping ones).
Future<void> pumpFrames(WidgetTester tester, [int frames = 4]) async {
  for (int i = 0; i < frames; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

/// Resolves a deferred preview load ([loadComponentPreview] /
/// [loadBlockPreview]) by pumping until it lands, bounded by a wall-clock
/// [budget].
///
/// `loadLibrary()` completions are delivered through engine callbacks that
/// only dispatch while the test binding pumps frames — and widget tests run
/// on a fake clock, so a bare `await` on the load future hangs forever.
/// This loop pumps until the future completes (or [budget] of real time
/// passes, which fails the test instead of hanging the suite). Call it
/// after a scene is pumped.
Future<T> resolveAcrossPumps<T>(
  WidgetTester tester,
  Future<T> future, {
  Duration budget = const Duration(seconds: 45),
}) async {
  T? result;
  Object? error;
  bool done = false;
  future.then(
    (T value) {
      done = true;
      result = value;
    },
    onError: (Object e) {
      done = true;
      error = e;
    },
  );
  final DateTime deadline = DateTime.now().add(budget);
  while (!done && DateTime.now().isBefore(deadline)) {
    await tester.pump(const Duration(milliseconds: 100));
    // Real time for the engine: back-to-back fake pumps alone never let the
    // loader thread deliver the next chunk.
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 25)),
    );
  }
  if (error != null) {
    throw error!;
  }
  expect(done, isTrue, reason: 'deferred preview resolved within $budget');
  return result as T;
}

/// Fails when the last pump left any error behind (layout overflows and
/// missing-ancestor errors surface here), draining the queue first.
void expectNoTestErrors(WidgetTester tester, String label) {
  final List<String> errors = <String>[];
  Object? error = tester.takeException();
  while (error != null) {
    errors.add('$error');
    error = tester.takeException();
  }
  expect(errors, isEmpty, reason: label);
}

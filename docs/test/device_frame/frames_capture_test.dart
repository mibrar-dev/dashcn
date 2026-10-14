// P9-1 screenshot captures (golden-free, do not open the PNGs).
//
// Renders the six representative previews in real frames and writes one PNG
// per scene to `rearch/screenshots/p9-1/` for the orchestrator's visual QA.
// No golden comparison runs here: pixel proofs belong to the invitation-only
// canvas tests, not to the feature matrix.
//
// One pumped tree serves every scene through a scene switcher, and every
// capture runs inside `tester.runAsync` (the golden path): engine and file
// futures only complete on the real async zone. Calling `toImage` — or an
// async file write — in the fake zone wedges every later binding op in the
// isolate, including teardown. Deferred chunks warm all at once through the
// isolate cache ([loadWarmPreview]): a second distinct chunk issued after
// the first completed hangs the engine.

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:docs/theme/theme_document.dart';
import 'package:docs/ui/dashcn/theme/theme.dart';
import 'package:docs/widgets/device_frame/all_frames.dart';
import 'package:docs/widgets/device_frame/device_frame.dart';
import 'package:docs/widgets/device_frame/device_spec.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'frame_harness.dart';

/// Where the captures land (absolute: the test CWD is the docs package).
// Relative to the docs package root (`flutter test` runs there).
const String kCaptureDir = '../rearch/screenshots/p9-1';

/// One viewport for every capture (fits the widest collage and the tallest
/// landscape window).
const Size kCaptureViewport = Size(3600, 1500);

/// One capturable scene: its file name, theme and content.
class _Scene {
  const _Scene({
    required this.name,
    required this.theme,
    required this.content,
  });

  final String name;
  final ThemeData theme;
  final Widget content;
}

void main() {
  testWidgets('captures six previews in phone and desktop frames', (
    WidgetTester tester,
  ) async {
    // Placeholder first: deferred loads only resolve while frames pump.
    await pumpFramedScene(tester, const SizedBox.shrink());
    final Map<String, Widget> previews = <String, Widget>{};
    for (final String id in kMatrixPreviewIds) {
      previews[id] = await loadWarmPreview(tester, id);
    }
    final ThemeData light = ThemeDocument.fromPreset(
      'neutral',
    ).theme(Brightness.light);
    final ThemeData dark = ThemeDocument.fromPreset(
      'neutral',
    ).theme(Brightness.dark);
    final List<_Scene> scenes = <_Scene>[
      for (final MapEntry<String, Widget> entry in previews.entries)
        _Scene(
          name: '${entry.key}-iphone-light',
          theme: light,
          content: Center(
            child: DeviceFrame(spec: kIphoneSpec, child: entry.value),
          ),
        ),
      for (final MapEntry<String, Widget> entry in previews.entries)
        _Scene(
          name: '${entry.key}-desktop-dark',
          theme: dark,
          content: Center(
            child: DeviceFrame(spec: kDesktopSpec, child: entry.value),
          ),
        ),
      _Scene(
        name: 'all-button-light',
        theme: light,
        content: Align(
          alignment: Alignment.topCenter,
          child: AllFrames(child: previews['button']!),
        ),
      ),
    ];

    int index = 0;
    late StateSetter setScene;
    await pumpFramedScene(
      tester,
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          setScene = setState;
          final _Scene scene = scenes[index];
          return Theme(
            data: scene.theme,
            child: RepaintBoundary(
              key: ValueKey<String>('shot-${scene.name}'),
              child: Builder(
                builder: (BuildContext context) => ColoredBox(
                  color: Theme.of(context).colors.background,
                  child: scene.content,
                ),
              ),
            ),
          );
        },
      ),
      viewport: kCaptureViewport,
    );
    for (int i = 0; i < scenes.length; i++) {
      setScene(() => index = i);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expectNoTestErrors(tester, 'capture ${scenes[i].name}');
      final RenderRepaintBoundary boundary =
          tester
                  .element(
                    find.byKey(ValueKey<String>('shot-${scenes[i].name}')),
                  )
                  .renderObject!
              as RenderRepaintBoundary;
      await tester.runAsync(() async {
        final ui.Image image = await boundary.toImage();
        final ByteData? bytes = await image.toByteData(
          format: ui.ImageByteFormat.png,
        );
        image.dispose();
        Directory(kCaptureDir).createSync(recursive: true);
        await File('$kCaptureDir/${scenes[i].name}.png').writeAsBytes(
          bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes),
          flush: true,
        );
      });
    }
  }, timeout: const Timeout(Duration(minutes: 5)));
}

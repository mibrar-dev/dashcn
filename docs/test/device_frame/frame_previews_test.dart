// P9-1 overflow matrix: the six representative previews render in every
// frame mode, portrait and landscape, light and dark, with no errors.
//
// One test per (preview, brightness) so progress streams and a slow leg
// cannot hide behind the others; each leg has a 90 s budget. The previews
// are the real registry examples (first named example of
// button/card/dialog/select/calendar, plus the sidebar-01 block), loaded
// through the same deferred registries the docs pages use. Dialog, select
// and the sidebar render in their closed/resting state (no overlay open),
// so the matrix covers layout, not gestures.
//
// Fixed pump counts only — never `pumpAndSettle`, so a preview with a
// looping animation cannot hang the suite.

import 'package:docs/widgets/device_frame/device_spec.dart';
import 'package:docs/widgets/device_frame/framed_preview.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'frame_harness.dart';

/// Loads one representative preview through the isolate warm cache (see
/// `loadWarmPreview`): the first caller warms all six at once, the rest
/// are cache hits.
Future<Widget> _loadPreview(WidgetTester tester, String id) {
  return loadWarmPreview(tester, id);
}

const List<String> _previewIds = kMatrixPreviewIds;

const List<DeviceFrameId> _modes = <DeviceFrameId>[
  DeviceFrameId.none,
  DeviceFrameId.iphone,
  DeviceFrameId.android,
  DeviceFrameId.ipad,
  DeviceFrameId.desktop,
  DeviceFrameId.web,
  DeviceFrameId.all,
];

/// Drives one preview through every mode in both orientations.
Future<void> _runMatrix(
  WidgetTester tester,
  String previewId,
  Widget preview,
  Brightness brightness,
) async {
  DeviceFrameId frame = DeviceFrameId.none;
  DeviceOrientation current = DeviceOrientation.portrait;
  await pumpFramedScene(
    tester,
    StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return FramedPreview(
          id: previewId,
          frame: frame,
          onFrameChanged: (DeviceFrameId next) => setState(() => frame = next),
          orientation: current,
          onOrientationChanged: (DeviceOrientation next) =>
              setState(() => current = next),
          child: preview,
        );
      },
    ),
    brightness: brightness,
  );
  // Leg 0 runs portrait, the rotate tap flips to landscape, leg 1 runs
  // landscape, the second rotate returns to portrait.
  for (int leg = 0; leg < 2; leg++) {
    for (final DeviceFrameId mode in _modes) {
      if (mode != frame) {
        await tester.tap(
          find.byKey(ValueKey<String>('frame-bar-${mode.queryValue}')),
        );
      }
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expectNoTestErrors(
        tester,
        '$previewId ${brightness.name} ${current.name} ${mode.queryValue}',
      );
    }
    await tester.tap(find.byKey(const ValueKey<String>('frame-bar-rotate')));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
  }
  expect(
    current,
    DeviceOrientation.portrait,
    reason: 'both orientation legs ran for $previewId',
  );
}

void main() {
  group('framed previews have no overflow', () {
    for (final String previewId in _previewIds) {
      for (final Brightness brightness in Brightness.values) {
        testWidgets('$previewId ${brightness.name}', (
          WidgetTester tester,
        ) async {
          // Placeholder first: the deferred load only resolves while pumping.
          await pumpFramedScene(
            tester,
            const SizedBox.shrink(),
            brightness: brightness,
          );
          final Widget preview = await _loadPreview(tester, previewId);
          await _runMatrix(tester, previewId, preview, brightness);
        }, timeout: const Timeout(Duration(seconds: 90)));
      }
    }
  });
}

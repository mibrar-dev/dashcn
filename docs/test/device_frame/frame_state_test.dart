// P9-1 state tests: the frame/orientation choice persists, round-trips
// through `?frame=` / `?orientation=`, and `FramedPreview` writes back to
// the ambient `DocsState`.
//
// The router hookup itself (parse on load, report on change) lands in P9-Z;
// these tests pin the mechanism it uses (`applyFrameUri` / `frameUri`).

import 'package:docs/routing/docs_router.dart';
import 'package:docs/state/docs_state.dart';
import 'package:docs/widgets/device_frame/device_spec.dart';
import 'package:docs/widgets/device_frame/framed_preview.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'frame_harness.dart';

/// In-memory [DocsStorage] so tests never touch localStorage.
class MemoryDocsStorage extends DocsStorage {
  /// Creates a memory store, optionally pre-seeded.
  MemoryDocsStorage([Map<String, String>? seed])
    : values = <String, String>{...?seed};

  /// Stored key/value pairs.
  final Map<String, String> values;

  @override
  String? read(String key) => values[key];

  @override
  void write(String key, String value) => values[key] = value;
}

DocsState _state({Map<String, String>? seed}) {
  final DocsState state = DocsState(storage: MemoryDocsStorage(seed));
  addTearDown(state.dispose);
  return state;
}

void main() {
  group('DocsState frame fields', () {
    test('defaults are none + portrait with no query values', () {
      final DocsState state = _state();
      expect(state.frame, DeviceFrameId.none);
      expect(state.orientation, DeviceOrientation.portrait);
      expect(state.frameQueryValue, isNull);
      expect(state.orientationQueryValue, isNull);
    });

    test('setFrame persists and notifies once', () {
      final MemoryDocsStorage storage = MemoryDocsStorage();
      final DocsState state = DocsState(storage: storage);
      addTearDown(state.dispose);
      int notifications = 0;
      state.addListener(() => notifications++);

      state.setFrame(DeviceFrameId.iphone);
      expect(state.frame, DeviceFrameId.iphone);
      expect(state.frameQueryValue, 'iphone');
      expect(storage.values[kDocsFrameKey], 'iphone');
      expect(notifications, 1);

      state.setFrame(DeviceFrameId.iphone);
      expect(notifications, 1, reason: 'same value does not notify');

      state.setOrientation(DeviceOrientation.landscape);
      expect(state.orientationQueryValue, 'landscape');
      expect(storage.values[kDocsOrientationKey], 'landscape');
      expect(notifications, 2);
    });

    test('restore loads persisted values and drops invalid ones', () {
      final DocsState kept = DocsState(
        storage: MemoryDocsStorage(<String, String>{
          kDocsFrameKey: 'desktop',
          kDocsOrientationKey: 'landscape',
        }),
      );
      addTearDown(kept.dispose);
      kept.restore();
      expect(kept.frame, DeviceFrameId.desktop);
      expect(kept.orientation, DeviceOrientation.landscape);

      final DocsState dropped = DocsState(
        storage: MemoryDocsStorage(<String, String>{
          kDocsFrameKey: 'blackberry',
          kDocsOrientationKey: 'upside-down',
        }),
      );
      addTearDown(dropped.dispose);
      dropped.restore();
      expect(dropped.frame, DeviceFrameId.none);
      expect(dropped.orientation, DeviceOrientation.portrait);
    });

    test('frame choice round-trips through the URL', () {
      final DocsState state = _state();
      state
        ..setFrame(DeviceFrameId.android)
        ..setOrientation(DeviceOrientation.landscape);

      final Uri withFrame = state.frameUri(
        Uri.parse('/docs/components/button?tab=usage'),
      );
      expect(withFrame.queryParameters['frame'], 'android');
      expect(withFrame.queryParameters['orientation'], 'landscape');
      // Unrelated params survive.
      expect(withFrame.queryParameters['tab'], 'usage');

      final DocsState fresh = _state();
      fresh.applyFrameUri(withFrame);
      expect(fresh.frame, DeviceFrameId.android);
      expect(fresh.orientation, DeviceOrientation.landscape);

      // Defaults strip the params again.
      final DocsState plain = _state();
      final Uri stripped = plain.frameUri(withFrame);
      expect(stripped.queryParameters.containsKey('frame'), isFalse);
      expect(stripped.queryParameters.containsKey('orientation'), isFalse);
      expect(stripped.queryParameters['tab'], 'usage');
    });

    test('unknown query values reset to the defaults', () {
      final DocsState state = _state();
      state
        ..setFrame(DeviceFrameId.web)
        ..setOrientation(DeviceOrientation.landscape);
      state.applyFrameQuery('palm', 'diagonal');
      expect(state.frame, DeviceFrameId.none);
      expect(state.orientation, DeviceOrientation.portrait);
    });
  });

  group('FramedPreview state wiring', () {
    testWidgets('uncontrolled preview reads and writes DocsState', (
      WidgetTester tester,
    ) async {
      final MemoryDocsStorage storage = MemoryDocsStorage();
      final DocsState state = DocsState(storage: storage);
      addTearDown(state.dispose);
      final DocsRouterDelegate delegate = DocsRouterDelegate(
        state: state,
        pageBuilder: (BuildContext context, DocsRouteConfiguration config) =>
            const SizedBox(),
        paletteBuilder: (BuildContext context, VoidCallback close) =>
            const SizedBox(),
        shellBuilder: (BuildContext context, Widget navigator) => navigator,
      );
      addTearDown(delegate.dispose);

      await pumpFramedScene(
        tester,
        DocsRouterScope(
          delegate: delegate,
          child: const FramedPreview(id: 'button', child: Text('preview')),
        ),
      );
      await pumpFrames(tester);

      // Rotate while unframed (the control hides for desktop/web frames).
      await tester.tap(find.byKey(const ValueKey<String>('frame-bar-rotate')));
      await pumpFrames(tester);
      expect(state.orientation, DeviceOrientation.landscape);
      expect(storage.values[kDocsOrientationKey], 'landscape');

      await tester.tap(find.byKey(const ValueKey<String>('frame-bar-web')));
      await pumpFrames(tester);
      expect(state.frame, DeviceFrameId.web);
      expect(storage.values[kDocsFrameKey], 'web');
      expectNoTestErrors(tester, 'scoped framed preview');
    });

    testWidgets('controlled preview reports through callbacks', (
      WidgetTester tester,
    ) async {
      DeviceFrameId frame = DeviceFrameId.none;
      DeviceOrientation orientation = DeviceOrientation.portrait;
      await pumpFramedScene(
        tester,
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return FramedPreview(
              frame: frame,
              onFrameChanged: (DeviceFrameId next) =>
                  setState(() => frame = next),
              orientation: orientation,
              onOrientationChanged: (DeviceOrientation next) =>
                  setState(() => orientation = next),
              child: const Text('preview'),
            );
          },
        ),
      );
      await pumpFrames(tester);

      await tester.tap(find.byKey(const ValueKey<String>('frame-bar-iphone')));
      await pumpFrames(tester);
      expect(frame, DeviceFrameId.iphone);

      await tester.tap(find.byKey(const ValueKey<String>('frame-bar-rotate')));
      await pumpFrames(tester);
      expect(orientation, DeviceOrientation.landscape);
      expectNoTestErrors(tester, 'controlled framed preview');
    });
  });
}

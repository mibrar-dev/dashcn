// Widget tests for the P9-1 frames: the `MediaQuery` + platform override
// each spec exposes, the toolbar callbacks and the "All" layouts.

import 'package:docs/theme/theme_document.dart';
import 'package:docs/ui/dashcn/theme/theme.dart';
import 'package:docs/widgets/device_frame/all_frames.dart';
import 'package:docs/widgets/device_frame/device_frame.dart';
import 'package:docs/widgets/device_frame/device_spec.dart';
import 'package:docs/widgets/device_frame/frame_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Records what one framed subtree sees.
class _Seen {
  Size? size;
  EdgeInsets? padding;
  double? devicePixelRatio;
  TargetPlatform? platform;
}

/// A probe child: records the ambient frame values on every build.
class _Probe extends StatelessWidget {
  const _Probe(this.seen);

  final _Seen seen;

  @override
  Widget build(BuildContext context) {
    seen
      ..size = MediaQuery.sizeOf(context)
      ..padding = MediaQuery.paddingOf(context)
      ..devicePixelRatio = MediaQuery.devicePixelRatioOf(context)
      ..platform = Theme.of(context).platform;
    return const SizedBox(width: 10, height: 10);
  }
}

/// Pumps [child] under a real theme, directionality and media query.
///
/// The test view is resized to [viewport] so the scene matches the
/// `RenderView`.
Future<void> _pumpFramed(
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

void main() {
  group('DeviceFrame', () {
    testWidgets('iphone exposes size, insets, dpr and platform', (
      WidgetTester tester,
    ) async {
      final _Seen seen = _Seen();
      await _pumpFramed(
        tester,
        DeviceFrame(spec: kIphoneSpec, child: _Probe(seen)),
      );
      await tester.pump();
      expect(seen.size, const Size(393, 852));
      expect(seen.padding, const EdgeInsets.only(top: 59, bottom: 34));
      expect(seen.devicePixelRatio, 3);
      // The test host runs on android; the frame must still read iOS.
      expect(defaultTargetPlatform, TargetPlatform.android);
      expect(seen.platform, TargetPlatform.iOS);
      expect(tester.takeException(), isNull);
    });

    testWidgets('landscape swaps the screen and the safe areas', (
      WidgetTester tester,
    ) async {
      final _Seen seen = _Seen();
      await _pumpFramed(
        tester,
        DeviceFrame(
          spec: kIphoneSpec,
          orientation: DeviceOrientation.landscape,
          child: _Probe(seen),
        ),
      );
      await tester.pump();
      expect(seen.size, const Size(852, 393));
      expect(seen.padding!.left, 59);
      expect(tester.takeException(), isNull);
    });

    testWidgets('every spec exposes its own platform', (
      WidgetTester tester,
    ) async {
      for (final DeviceSpec spec in kFramedSpecs) {
        final _Seen seen = _Seen();
        await _pumpFramed(tester, DeviceFrame(spec: spec, child: _Probe(seen)));
        await tester.pump();
        expect(seen.size, spec.size);
        expect(seen.platform, spec.platform);
        expect(seen.devicePixelRatio, spec.devicePixelRatio);
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('chrome paints without images and clips the screen', (
      WidgetTester tester,
    ) async {
      await _pumpFramed(
        tester,
        DeviceFrame(spec: kDesktopSpec, child: const SizedBox.shrink()),
      );
      await tester.pump();
      expect(
        find.descendant(
          of: find.byType(DeviceFrame),
          matching: find.byType(CustomPaint),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(DeviceFrame),
          matching: find.byType(ClipRRect),
        ),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    });
  });

  group('FrameBar', () {
    testWidgets('tapping a segment selects that frame', (
      WidgetTester tester,
    ) async {
      DeviceFrameId selected = DeviceFrameId.none;
      await _pumpFramed(
        tester,
        FrameBar(
          frame: selected,
          onFrameChanged: (DeviceFrameId id) => selected = id,
          orientation: DeviceOrientation.portrait,
          onOrientationChanged: (_) {},
        ),
      );
      await tester.tap(find.byKey(const ValueKey<String>('frame-bar-web')));
      expect(selected, DeviceFrameId.web);
      await tester.tap(find.byKey(const ValueKey<String>('frame-bar-android')));
      expect(selected, DeviceFrameId.android);
      expect(tester.takeException(), isNull);
    });

    testWidgets('rotate flips the orientation', (WidgetTester tester) async {
      DeviceOrientation orientation = DeviceOrientation.portrait;
      await _pumpFramed(
        tester,
        FrameBar(
          frame: DeviceFrameId.iphone,
          onFrameChanged: (_) {},
          orientation: orientation,
          onOrientationChanged: (DeviceOrientation next) => orientation = next,
        ),
      );
      await tester.tap(find.byKey(const ValueKey<String>('frame-bar-rotate')));
      expect(orientation, DeviceOrientation.landscape);
      expect(tester.takeException(), isNull);
    });

    testWidgets('rotate hides for desktop/browser, shows for all', (
      WidgetTester tester,
    ) async {
      for (final DeviceFrameId frame in <DeviceFrameId>[
        DeviceFrameId.desktop,
        DeviceFrameId.web,
      ]) {
        await _pumpFramed(
          tester,
          FrameBar(
            frame: frame,
            onFrameChanged: (_) {},
            orientation: DeviceOrientation.portrait,
            onOrientationChanged: (_) {},
          ),
        );
        expect(
          find.byKey(const ValueKey<String>('frame-bar-rotate')),
          findsNothing,
          reason: '${frame.queryValue} is not rotatable',
        );
        expect(tester.takeException(), isNull);
      }
      await _pumpFramed(
        tester,
        FrameBar(
          frame: DeviceFrameId.all,
          onFrameChanged: (_) {},
          orientation: DeviceOrientation.portrait,
          onOrientationChanged: (_) {},
        ),
      );
      expect(
        find.byKey(const ValueKey<String>('frame-bar-rotate')),
        findsOneWidget,
        reason: 'all keeps rotate for its phones',
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('brightness toggle hides without a mode', (
      WidgetTester tester,
    ) async {
      await _pumpFramed(
        tester,
        FrameBar(
          frame: DeviceFrameId.none,
          onFrameChanged: (_) {},
          orientation: DeviceOrientation.portrait,
          onOrientationChanged: (_) {},
        ),
      );
      expect(
        find.byKey(const ValueKey<String>('frame-bar-brightness')),
        findsNothing,
      );

      Brightness mode = Brightness.light;
      await _pumpFramed(
        tester,
        FrameBar(
          frame: DeviceFrameId.none,
          onFrameChanged: (_) {},
          orientation: DeviceOrientation.portrait,
          onOrientationChanged: (_) {},
          brightness: mode,
          onBrightnessChanged: (Brightness next) => mode = next,
        ),
      );
      await tester.tap(
        find.byKey(const ValueKey<String>('frame-bar-brightness')),
      );
      expect(mode, Brightness.dark);
      expect(tester.takeException(), isNull);
    });
  });

  group('AllFrames', () {
    testWidgets('wide shows four frames with distinct platforms', (
      WidgetTester tester,
    ) async {
      final List<_Seen> seen = <_Seen>[_Seen(), _Seen(), _Seen(), _Seen()];
      int next = 0;
      await _pumpFramed(
        tester,
        AllFrames(
          child: Builder(
            builder: (BuildContext context) {
              final _Seen slot = seen[next++];
              return _Probe(slot);
            },
          ),
        ),
      );
      await tester.pump();
      expect(find.byType(DeviceFrame), findsNWidgets(4));
      expect(find.byType(FittedBox), findsWidgets);
      expect(seen.map((_Seen s) => s.platform), <TargetPlatform?>[
        TargetPlatform.iOS,
        TargetPlatform.android,
        TargetPlatform.macOS,
        TargetPlatform.windows,
      ]);
      expect(tester.takeException(), isNull);
    });

    testWidgets('narrow becomes a snap scroller', (WidgetTester tester) async {
      final List<TargetPlatform?> platforms = <TargetPlatform?>[];
      await _pumpFramed(
        tester,
        AllFrames(
          child: Builder(
            builder: (BuildContext context) {
              platforms.add(Theme.of(context).platform);
              return const SizedBox(width: 10, height: 10);
            },
          ),
        ),
        viewport: const Size(600, 1000),
      );
      await tester.pump();
      expect(find.byType(PageView), findsOneWidget);
      // PageView builds lazily: fling through all four pages.
      for (int i = 0; i < 3; i++) {
        await tester.fling(find.byType(PageView), const Offset(-400, 0), 1000);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 300));
      }
      expect(platforms, <TargetPlatform?>[
        TargetPlatform.iOS,
        TargetPlatform.android,
        TargetPlatform.macOS,
        TargetPlatform.windows,
      ]);
      expect(tester.takeException(), isNull);
    });
  });
}

// F1 placement sweep: every component's main example on real device screens.
//
// For every component id (from the generated data) and four framed scenes
// (iPhone / Android / Desktop portrait, iPhone landscape), pumps the
// component's main example (index 0, the same widget the docs page shows)
// inside `DeviceFrame > FramedScreen` and asserts:
//   (a) no FlutterError/overflow (the exception queue is empty),
//   (b) the content rect is constrained to the safe-area box (strictly
//       inside horizontally; vertically inside when it fits, otherwise
//       carried by a vertical scroll view — never horizontal overflow),
//   (c) the placement holds (bottom/top edge within 2 px, centre within
//       2 px, fill width within 2 px; centre-dy and the bottom edge only
//       when the content fits vertically — taller content scrolls).
//
// One test per component id (the four scenes run inside it); failures name
// the id and the scene. Cases that fail because of the component's OWN
// widget (not the frame infrastructure) are listed in [kKnownF2] with the
// failure reason — those go to phase F2 and are not asserted.
//
// Deferred-loading note: every chunk is warmed in one co-issued batch (see
// `loadWarmPreview` in the harness): a second *distinct* `loadLibrary()`
// issued after the first completed hangs the engine, so the sweep never
// loads ids one test at a time.

import 'package:docs/generated/docs_data.dart';
import 'package:docs/previews/component_previews.dart';
import 'package:docs/widgets/device_frame/device_frame.dart';
import 'package:docs/widgets/device_frame/device_spec.dart';
import 'package:docs/widgets/device_frame/framed_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'frame_harness.dart';

/// One sweep scene: the spec plus the orientation to pump it in.
class _Scene {
  const _Scene(this.spec, this.orientation);

  final DeviceSpec spec;
  final DeviceOrientation orientation;

  String get label => '${spec.id.queryValue}-${orientation.queryValue}';
}

/// The four framed scenes every component runs in.
final List<_Scene> _sweepScenes = <_Scene>[
  _Scene(kIphoneSpec, DeviceOrientation.portrait),
  _Scene(kAndroidSpec, DeviceOrientation.portrait),
  _Scene(kDesktopSpec, DeviceOrientation.portrait),
  _Scene(kIphoneSpec, DeviceOrientation.landscape),
];

/// Cases that fail because of the component's OWN widget (phase F2), keyed
/// `id@frame:orientation` with the failure reason. These scenes are not
/// asserted; everything else in the id's test still runs.
const Map<String, String> kKnownF2 = <String, String>{
  'patch@iphone:portrait':
      'F2: PatchPreview reset Row (Button + unwrapped hint text) overflows '
      'narrow phones; the hint text measures 406px under flutter_test Ahem '
      'metrics (Row content ~520px vs 313px box). Widget-own fragile row.',
  'patch@android:portrait':
      'F2: same PatchPreview reset Row overflow as iphone-portrait '
      '(persistent OVERFLOWING state; overflow reports fire once per '
      'render object so this scene is caught by the state walk).',
};

/// Whole-test skips for ids whose OWN widget breaks the test harness
/// itself (phase F2), with the reason. `async` re-arms 600ms futures on
/// every build, so a Timer is always pending at teardown and the binding's
/// `!timersPending` invariant fails outside any scene assertion.
const Map<String, String> kF2TestSkips = <String, String>{
  'async':
      'F2: AsyncPreview re-arms 600ms futures on every build; a Timer '
      'is always pending at teardown '
      '(flutter_test `!timersPending` invariant).',
};

/// Isolate-level warm cache: id -> main-example widget.
Map<String, Widget>? _warm;

final List<String> _sweepIds = <String>[
  for (final DocsComponent component in kComponents) component.id,
];

/// Warms every preview chunk in one co-issued batch (no-op when warm).
Future<void> _ensureWarm(WidgetTester tester) async {
  if (_warm != null) {
    return;
  }
  await pumpFramedScene(tester, const SizedBox.shrink());
  final Map<String, Widget> loaded = await resolveAcrossPumps(
    tester,
    Future.wait(<Future<Widget>>[
      for (final String id in _sweepIds) loadComponentPreview(id),
    ]).then(
      (List<Widget> previews) =>
          Map<String, Widget>.fromIterables(_sweepIds, previews),
    ),
    budget: const Duration(minutes: 8),
  );
  _warm = loaded;
}

/// Runs one id through the four scenes, returning failure lines.
Future<List<String>> _runSweep(
  WidgetTester tester,
  String id,
  Widget preview,
) async {
  final List<String> failures = <String>[];
  DeviceSpec spec = _sweepScenes.first.spec;
  DeviceOrientation orientation = _sweepScenes.first.orientation;
  late StateSetter setScene;
  await pumpFramedScene(
    tester,
    StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        setScene = setState;
        // Real docs pages always have an `Overlay` above the page (the app
        // shell owns one): `EditableText` and `SelectableRegion` inside
        // previews require it, so the sweep provides one too (`Overlay.wrap`,
        // the same pattern the registry preview audits use).
        return Overlay.wrap(
          child: Center(
            child: DeviceFrame(
              spec: spec,
              orientation: orientation,
              child: FramedScreen(componentId: id, child: preview),
            ),
          ),
        );
      },
    ),
    viewport: const Size(1600, 1100),
  );
  await pumpFrames(tester);
  // No separate setup drain: the initial pumps build scene 1, so scene 1's
  // check drains whatever they left behind (overflow reports fire on first
  // paint, which is scene 1's configuration).
  for (final _Scene scene in _sweepScenes) {
    final String caseKey =
        '$id@${scene.spec.id.queryValue}:${scene.orientation.queryValue}';
    setScene(() {
      spec = scene.spec;
      orientation = scene.orientation;
    });
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    if (kKnownF2.containsKey(caseKey)) {
      // Still drain: a skipped scene's paints must not pollute the next
      // scene's queue (overflow reports are paint-time events).
      while (tester.takeException() != null) {}
      continue;
    }
    failures.addAll(_checkScene(tester, id, scene));
  }
  return failures;
}

/// Checks one pumped scene, returning failure lines (empty when green).
List<String> _checkScene(WidgetTester tester, String id, _Scene scene) {
  final List<String> failures = <String>[];
  String label(String what) => '$id ${scene.label} $what';

  final Finder safeFinder = find.byKey(ValueKey<String>('framed-safe-$id'));
  final Finder contentFinder = find.byKey(
    ValueKey<String>('framed-content-$id'),
  );
  if (safeFinder.evaluate().isEmpty || contentFinder.evaluate().isEmpty) {
    failures.add('${label('(setup)')}: safe/content box missing');
    return failures;
  }

  // Overflow *reports* fire once per render object (framework
  // `DebugOverflowIndicatorMixin._overflowReportNeeded`), so a scene that
  // keeps overflowing after the first report stays silent in the queue.
  // The overflow *state* persists, so also read it directly: any render
  // object under the safe box that marks itself OVERFLOWING fails the scene
  // it is observed in.
  final List<String> overflowing = _overflowingBoxes(tester, safeFinder);
  if (overflowing.isNotEmpty) {
    failures.add('${label('(a) overflow-state')}: ${overflowing.join(' | ')}');
    return failures;
  }

  final Rect safe = tester.getRect(safeFinder);
  final Rect content = tester.getRect(contentFinder);
  if (safe.width <= 0 || safe.height <= 0) {
    failures.add('${label('(setup)')}: safe box is empty ($safe)');
    return failures;
  }
  // Scene fidelity FIRST: the frame must actually switch scenes (a stale
  // frame would make every later assertion vacuous, and a queued error
  // must not pre-empt this check).
  final Size expectedSafe = _safeSize(scene.spec, scene.orientation);
  if ((safe.width - expectedSafe.width).abs() > 0.5 ||
      (safe.height - expectedSafe.height).abs() > 0.5) {
    failures.add(
      '${label('(setup) stale frame')}: safe $safe != expected $expectedSafe',
    );
    return failures;
  }

  final List<String> errors = <String>[];
  Object? error = tester.takeException();
  while (error != null) {
    errors.add('$error');
    error = tester.takeException();
  }
  if (errors.isNotEmpty) {
    failures.add('${label('(a) errors')}: ${errors.join(' | ')}');
    return failures;
  }

  // (b) containment: strict horizontally, always.
  if (content.left < safe.left - 0.5 || content.right > safe.right + 0.5) {
    failures.add(
      '${label('(b) horizontal')}: content $content not inside safe $safe',
    );
  }
  final bool fitsVertically = content.height <= safe.height + 0.5;
  if (fitsVertically) {
    if (content.top < safe.top - 0.5 || content.bottom > safe.bottom + 0.5) {
      failures.add(
        '${label('(b) vertical')}: content $content not inside safe $safe',
      );
    }
  } else {
    final Finder scroll = find.ancestor(
      of: contentFinder,
      matching: find.byType(SingleChildScrollView),
    );
    if (scroll.evaluate().isEmpty) {
      failures.add(
        '${label('(b) scroll')}: taller content $content has no vertical '
        'scroll (safe $safe)',
      );
    }
  }

  // (c) placement.
  final PreviewPlacement placement = previewPlacementOf(id);
  switch (placement) {
    case PreviewPlacement.bottom:
      if (fitsVertically && (content.bottom - safe.bottom).abs() > 2) {
        failures.add(
          '${label('(c) bottom')}: bottom ${content.bottom} not within 2px '
          'of safe bottom ${safe.bottom}',
        );
      }
    case PreviewPlacement.top:
      if ((content.top - safe.top).abs() > 2) {
        failures.add(
          '${label('(c) top')}: top ${content.top} not within 2px of safe '
          'top ${safe.top}',
        );
      }
    case PreviewPlacement.center:
      if ((content.center.dx - safe.center.dx).abs() > 2) {
        failures.add(
          '${label('(c) center-x')}: centre ${content.center} not within '
          '2px of safe centre ${safe.center}',
        );
      }
      if (fitsVertically && (content.center.dy - safe.center.dy).abs() > 2) {
        failures.add(
          '${label('(c) center-y')}: centre ${content.center} not within '
          '2px of safe centre ${safe.center}',
        );
      }
    case PreviewPlacement.fill:
      if ((content.width - safe.width).abs() > 2) {
        failures.add(
          '${label('(c) fill')}: width ${content.width} does not fill safe '
          'width ${safe.width}',
        );
      }
    case PreviewPlacement.leading:
      break;
  }
  return failures;
}

/// Render objects under [scope] that currently mark themselves OVERFLOWING
/// (debug `toStringShort` flag), deepest first. Complements the exception
/// queue: overflow *reports* fire once per render object, but the *state*
/// persists across scenes.
List<String> _overflowingBoxes(WidgetTester tester, Finder scope) {
  final List<String> found = <String>[];
  void visit(RenderObject object) {
    if (object.toStringShort().contains('OVERFLOWING')) {
      found.add(object.toStringShort());
    }
    object.visitChildren(visit);
  }

  visit(tester.renderObject(scope));
  return found;
}

/// Expected safe-area size for [spec] in [orientation] (screen minus the
/// spec's safe insets).
Size _safeSize(DeviceSpec spec, DeviceOrientation orientation) {
  final Size screen = spec.sizeFor(orientation);
  final EdgeInsets padding = spec.paddingFor(orientation);
  return Size(
    screen.width - padding.left - padding.right,
    screen.height - padding.top - padding.bottom,
  );
}

void main() {
  testWidgets('warms all preview chunks', (WidgetTester tester) async {
    await _ensureWarm(tester);
    expect(_warm, isNotNull);
    expect(_warm!.length, _sweepIds.length);
  }, timeout: const Timeout(Duration(minutes: 10)));

  group('F1 placement sweep', () {
    for (final String id in _sweepIds) {
      testWidgets(
        'placement $id',
        (WidgetTester tester) async {
          await _ensureWarm(tester);
          final List<String> failures = await _runSweep(
            tester,
            id,
            _warm![id]!,
          );
          expect(failures, isEmpty, reason: failures.join('\n'));
        },
        timeout: const Timeout(Duration(minutes: 3)),
        // Reason for each skip lives in kF2TestSkips (this flutter_test
        // pins `skip:` to bool?).
        skip: kF2TestSkips.containsKey(id),
      );
    }
  });
}

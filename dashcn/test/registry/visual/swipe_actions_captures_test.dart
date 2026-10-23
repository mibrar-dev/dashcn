// Capture harness for `swipe_actions`: swiped rows (half open mid-drag, and
// fully open) for the Default, Compact and Comfortable examples on the neutral
// preset in light and dark, with the real Geist fonts loaded. Writes PNGs to
// SWIPE_CAPTURE_DIR (or the scratchpad default) and asserts that the revealed
// action tiles fill the full row height and stay at least 64 px wide.
//
// Run from dashcn/:
//   flutter test test/registry/visual/swipe_actions_captures_test.dart
// Read-only with respect to component code.

import 'dart:io';
import 'dart:ui' as ui;

import 'package:dashcn/src/components/swipe_actions/preview.dart';
import 'package:dashcn/src/components/swipe_actions/swipe_actions.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:dashcn/src/theme/typography.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../themes/generated_theme.dart';

/// Device pixel ratio of every capture.
const double _dpr = 2;

/// Logical size of the capture frame.
const Size _frame = Size(440, 260);

/// Width of the row column inside the frame.
const double _rowWidth = 400;

/// Touch slop the drag recognizer swallows before it starts moving the row.
const double _slop = 18;

String get _outDir =>
    Platform.environment['SWIPE_CAPTURE_DIR'] ??
    '/Users/ibrar/Desktop/infinora.noworkspace/shadcn_copy_paste/scratchpad/ui/round2/controls/swipe-captures';

Future<void> _loadFonts() async {
  Future<void> load(String family, List<String> files) async {
    final FontLoader loader = FontLoader(family);
    for (final String file in files) {
      final Uint8List bytes = File(
        '${Directory.current.path}/assets/fonts/$file',
      ).readAsBytesSync();
      loader.addFont(Future<ByteData>.value(ByteData.sublistView(bytes)));
    }
    await loader.load();
  }

  // The neutral preset names its families 'Geist' and 'Geist Mono'.
  await load('Geist', const <String>['Geist-Regular.otf']);
  await load('Geist Mono', const <String>['GeistMono-Regular.otf']);
  await load('NotoSansSymbols2', const <String>[
    'NotoSansSymbols2-Regular.ttf',
  ]);
  await load('LucideIcons', const <String>['lucide.ttf']);
}

/// The two poses captured per example.
enum _Pose { halfOpen, fullyOpen }

/// Finder for the revealed run of action tiles inside the first row.
Finder _runOf(Finder row) => find.descendant(
  of: find.descendant(of: row, matching: find.byType(SwipeActionButtons)),
  matching: find.byWidgetPredicate(
    (Widget w) => w is SizedBox && w.child is Row,
  ),
);

/// Captures one scene; returns the still-held drag for a half-open pose so
/// the caller can release it after the test body.
Future<TestGesture?> _capture(
  WidgetTester tester, {
  required String file,
  required int exampleIndex,
  required Brightness brightness,
  required _Pose pose,
}) async {
  tester.view.devicePixelRatio = _dpr;
  tester.view.physicalSize = Size(_frame.width * _dpr, _frame.height * _dpr);
  addTearDown(tester.view.reset);

  final ThemeDataView view = loadGeneratedTheme(
    '${Directory.current.path}/lib/src/themes/neutral.json',
  ).view(brightness);
  // The preset's families ('Geist', 'Geist Mono') drive the typography, so
  // the text resolves to the fonts registered in _loadFonts.
  final ThemeData appTheme = ThemeData(
    colors: view.colors,
    tokens: view.tokens,
    fonts: view.fonts,
    typography: const Typography.geist().applyFonts(view.fonts),
  );
  final GlobalKey boundaryKey = GlobalKey();

  await tester.pumpWidget(
    RepaintBoundary(
      key: boundaryKey,
      child: Theme(
        data: appTheme,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: const MediaQueryData(devicePixelRatio: _dpr),
            child: DefaultTextStyle(
              // The app's ambient text style: preset sans family and the
              // foreground colour, as the docs page provides.
              style: appTheme.typography.sans.copyWith(
                color: appTheme.colors.foreground,
                fontSize: 14,
              ),
              child: ColoredBox(
                color: appTheme.colors.background,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: _rowWidth,
                    child: Builder(
                      builder: swipeActionsPreviews[exampleIndex].builder,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();

  final Finder row = find.byType(SwipeActions).first;
  final Finder run = _runOf(row).first;
  final double runWidth = tester.getSize(run).width;
  TestGesture? held;

  if (pose == _Pose.halfOpen) {
    // Hold the drag without releasing: the row stays mid-swipe at about half
    // of the actions run, so the capture shows the partial reveal.
    held = await tester.startGesture(tester.getCenter(row));
    // Ten small moves with a frame each, like a finger, so the drag is
    // recognized and the row follows it.
    for (int step = 0; step < 10; step++) {
      await held.moveBy(Offset(-(0.5 * runWidth + _slop) / 10, 0));
      await tester.pump(const Duration(milliseconds: 16));
    }
  } else {
    // Steady 500 ms drag to ~90% of the run, released slowly: the row settles
    // fully open (reveal 1.0), below the 1.05 full-swipe dismiss line.
    await tester.timedDrag(
      row,
      Offset(-(0.9 * runWidth + _slop), 0),
      const Duration(milliseconds: 500),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
  }

  final Size rowSize = tester.getSize(row);
  final Size runSize = tester.getSize(run);
  // ignore: avoid_print
  print(
    'SWIPE[$file] row=${rowSize.width.toStringAsFixed(1)}x'
    '${rowSize.height.toStringAsFixed(1)} run=${runSize.width.toStringAsFixed(1)}'
    'x${runSize.height.toStringAsFixed(1)} tile='
    '${(runSize.width / 2).toStringAsFixed(1)}x${runSize.height.toStringAsFixed(1)}',
  );
  // The revealed tiles fill the full row height and are at least 64 px wide.
  expect(
    (runSize.height - rowSize.height).abs(),
    lessThan(0.5),
    reason: '$file: action run must match the row height',
  );
  expect(runSize.width / 2, greaterThanOrEqualTo(64), reason: '$file: tile');

  final RenderRepaintBoundary boundary =
      boundaryKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  // Engine image capture leaves the test zone via runAsync.
  final ui.Image? image = await tester.runAsync(
    () => boundary.toImage(pixelRatio: _dpr),
  );
  final ByteData? bytes = await tester.runAsync<ByteData?>(
    () => image!.toByteData(format: ui.ImageByteFormat.png),
  );
  File('$_outDir/$file.png')
    ..createSync(recursive: true)
    ..writeAsBytesSync(bytes!.buffer.asUint8List());

  return held;
}

void main() {
  setUpAll(() {
    Directory(_outDir).createSync(recursive: true);
  });

  const List<(int, String)> examples = <(int, String)>[
    (0, 'default'),
    (1, 'compact'),
    (2, 'comfortable'),
  ];
  const List<(Brightness, String)> themes = <(Brightness, String)>[
    (Brightness.light, 'light'),
    (Brightness.dark, 'dark'),
  ];
  const List<(_Pose, String)> poses = <(_Pose, String)>[
    (_Pose.halfOpen, 'half-open'),
    (_Pose.fullyOpen, 'fully-open'),
  ];

  for (final (int index, String example) in examples) {
    for (final (Brightness brightness, String mode) in themes) {
      for (final (_Pose pose, String poseName) in poses) {
        final String file = 'swipe-$example-$poseName-$mode';
        testWidgets(file, (WidgetTester tester) async {
          // Real font bytes are read and registered on the real async zone.
          await tester.runAsync(_loadFonts);
          final TestGesture? held = await _capture(
            tester,
            file: file,
            exampleIndex: index,
            brightness: brightness,
            pose: pose,
          );
          // Release the held pointer so the test ends with no pending gesture.
          await held?.up();
        });
      }
    }
  }
}

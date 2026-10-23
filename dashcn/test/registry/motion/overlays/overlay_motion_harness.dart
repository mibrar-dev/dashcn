// Shared harness for the overlay motion tests: a themed page with a real
// Navigator (so dialogs, drawers and overlays insert the way they do in an
// app), a frame sampler, and a reduced-motion switch.

import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Pumps [page] inside a themed [Navigator]. [disabled] sets
/// `MediaQuery.disableAnimations` (the reduced-motion switch).
/// Boundary around the whole test page; frame captures read its pixels.
final GlobalKey overlayCaptureKey = GlobalKey(debugLabel: 'overlayCapture');

Future<void> pumpOverlayPage(
  WidgetTester tester, {
  required Widget Function(BuildContext context) page,
  bool disabled = false,
  Size size = const Size(800, 600),
}) {
  return tester.pumpWidget(
    RepaintBoundary(
      key: overlayCaptureKey,
      child: MediaQuery(
        data: MediaQueryData(size: size, disableAnimations: disabled),
        child: Theme(
          data: const ThemeData(),
          child: Directionality(
            textDirection: TextDirection.ltr,
            // TapRegionSurface: the outside-tap region every popover relies on.
            child: TapRegionSurface(
              child: Navigator(
                key: UniqueKey(),
                onGenerateRoute: (RouteSettings settings) =>
                    PageRouteBuilder<void>(
                      settings: settings,
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          Builder(
                            builder: (context) => Center(child: page(context)),
                          ),
                    ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

/// Reads [read] once now, then after each of [frames] frames of [stepMs].
/// The first element is the value right after the triggering frame.
Future<List<double>> sampleFrames(
  WidgetTester tester,
  double Function() read, {
  required int frames,
  int stepMs = 25,
}) async {
  final List<double> values = <double>[read()];
  for (int i = 0; i < frames; i++) {
    await tester.pump(Duration(milliseconds: stepMs));
    values.add(read());
  }
  return values;
}

/// True when every consecutive pair of [values] is non-decreasing.
bool isNonDecreasing(List<double> values) {
  for (int i = 1; i < values.length; i++) {
    if (values[i] + 1e-9 < values[i - 1]) return false;
  }
  return true;
}

/// True when every consecutive pair of [values] is non-increasing.
bool isNonIncreasing(List<double> values) {
  for (int i = 1; i < values.length; i++) {
    if (values[i] - 1e-9 > values[i - 1]) return false;
  }
  return true;
}

/// Number of distinct values in [values], rounded to 4 decimals.
int distinctCount(List<double> values) =>
    values.map((double v) => (v * 10000).round()).toSet().length;

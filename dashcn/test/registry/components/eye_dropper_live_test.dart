// Live whole-app eye-dropper sampling (P7-CP1).
//
// A known painted scene is sampled through an [EyeDropperLayer]: hover moves
// must update the picker's value live (hue/sat/val/alpha + hex), tap commits,
// Escape / right-click cancels and restores the previous colour, arrows nudge
// 1px and Enter commits. DPR 2 maps logical positions to image pixels, the
// root-layer overlay covers the full window, and disposing mid-session throws
// nothing.

import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/color/color.dart';
import 'package:dashcn/src/components/color_picker/color_picker.dart';
import 'package:dashcn/src/components/eye_dropper/eye_dropper.dart';
import 'package:dashcn/src/components/history/history.dart';
import 'package:dashcn/src/components/hsv/hsv.dart';
import 'package:dashcn/src/components/select/select.dart';
import 'package:dashcn/src/components/app/app.dart';
import 'package:dashcn/src/foundation/icons/lucide_icons.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

const Color _red = Color(0xFFFF0000);
const Color _blue = Color(0xFF0000FF);
const Color _halfRed = Color(0x80FF0000);
const Color _initial = Color(0xFF2563EB);

/// Controlled harness: a known scene (red / blue / half-red swatches) above a
/// picker that owns its value. [onScope] exposes the layer scope.
class _LiveHarness extends StatefulWidget {
  const _LiveHarness({required this.onScope});

  final void Function(EyeDropperLayerScope scope) onScope;

  @override
  State<_LiveHarness> createState() => _LiveHarnessState();
}

class _LiveHarnessState extends State<_LiveHarness> {
  ColorDerivative value = ColorDerivative.fromColor(_initial);

  /// Streams a live eye-dropper sample into the picker value.
  void applySample(Color sample) {
    if (!mounted) return;
    setState(() => value = value.changeToColor(sample));
  }

  /// Restores a previous value (cancel path).
  void restore(ColorDerivative previous) {
    if (!mounted) return;
    setState(() => value = previous);
  }

  @override
  Widget build(BuildContext context) {
    return EyeDropperLayer(
      child: Builder(
        builder: (BuildContext context) {
          widget.onScope(EyeDropperLayerScope.find(context));
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    key: ValueKey<String>('swatch-red'),
                    width: 40,
                    height: 40,
                    child: ColoredBox(color: _red),
                  ),
                  SizedBox(
                    key: ValueKey<String>('swatch-blue'),
                    width: 40,
                    height: 40,
                    child: ColoredBox(color: _blue),
                  ),
                  SizedBox(
                    key: ValueKey<String>('swatch-half'),
                    width: 40,
                    height: 40,
                    child: ColoredBox(color: _halfRed),
                  ),
                ],
              ),
              ColorPicker(
                value: value,
                showAlpha: true,
                onChanging: (ColorDerivative next) =>
                    setState(() => value = next),
                onChanged: (ColorDerivative next) =>
                    setState(() => value = next),
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget _frame(Widget child) {
  return Theme(
    data: const ThemeData(),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: TapRegionSurface(
        child: Overlay(
          initialEntries: <OverlayEntry>[
            OverlayEntry(
              builder: (BuildContext context) =>
                  Align(alignment: Alignment.topLeft, child: child),
            ),
          ],
        ),
      ),
    ),
  );
}

Future<void> _pumpHarness(
  WidgetTester tester,
  void Function(EyeDropperLayerScope scope) onScope,
) async {
  // Bare shrink first: the frame's Overlay keeps its initial entries across
  // pumpWidgets in one test, so a bare pump is the only full reset.
  await tester.pumpWidget(const SizedBox.shrink());
  await tester.pumpWidget(_frame(_LiveHarness(onScope: onScope)));
  await tester.pump();
}

_LiveHarnessState _harnessState(WidgetTester tester) {
  return tester.state<_LiveHarnessState>(find.byType(_LiveHarness));
}

/// Starts a live session like the picker's pipette does: samples stream into
/// the harness value, the returned future completes on commit/cancel.
Future<Future<Color?>> _startLive(
  WidgetTester tester,
  EyeDropperLayerScope scope,
  _LiveHarnessState state,
) async {
  late Future<Color?> pick;
  await tester.runAsync(() async {
    pick = scope.promptPickColor(null, state.applySample);
    await Future<void>.delayed(const Duration(milliseconds: 100));
  });
  await tester.pump();
  return pick;
}

Future<TestGesture> _hover(WidgetTester tester) async {
  final TestGesture gesture = await tester.createGesture(
    kind: PointerDeviceKind.mouse,
  );
  await gesture.addPointer(location: Offset.zero);
  addTearDown(gesture.removePointer);
  return gesture;
}

Offset _center(WidgetTester tester, String key) {
  return tester.getCenter(find.byKey(ValueKey<String>(key)));
}

HSVColorSlider _slider(WidgetTester tester, HSVColorSliderType type) {
  return tester
      .widgetList<HSVColorSlider>(find.byType(HSVColorSlider))
      .firstWhere((HSVColorSlider s) => s.sliderType == type);
}

Future<void> _openHex(WidgetTester tester) async {
  await tester.tap(find.byType(Select<ColorPickerMode>));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
  await tester.tap(find.text('HEX'));
  await tester.pumpAndSettle();
}

void main() {
  group('live sampling', () {
    testWidgets('hover streams hue/sat/val/alpha + hex into the picker', (
      tester,
    ) async {
      late EyeDropperLayerScope scope;
      await _pumpHarness(tester, (s) => scope = s);
      // The session freezes pointer input below it, so pick HEX first.
      await _openHex(tester);
      final _LiveHarnessState state = _harnessState(tester);
      final Future<Color?> pick = await _startLive(tester, scope, state);
      final TestGesture mouse = await _hover(tester);

      await mouse.moveTo(_center(tester, 'swatch-red'));
      await tester.pump();
      expect(state.value.toColor().toARGB32(), _red.toARGB32());
      expect(_slider(tester, HSVColorSliderType.hue).color.hue, closeTo(0, 2));
      final HSVColor sv = _slider(tester, HSVColorSliderType.satVal).color;
      expect(sv.saturation, closeTo(1, 0.05));
      expect(sv.value, closeTo(1, 0.05));

      await mouse.moveTo(_center(tester, 'swatch-half'));
      await tester.pump();
      expect((state.value.opacity * 100).round(), 50);
      expect(
        _slider(tester, HSVColorSliderType.alpha).color.alpha,
        closeTo(0.5, 0.05),
      );

      await mouse.moveTo(_center(tester, 'swatch-blue'));
      await tester.pump();
      // Both the hex field and the loupe label track the live sample.
      expect(find.text('#0000ff'), findsWidgets);

      await tester.tapAt(_center(tester, 'swatch-blue'));
      await tester.pump();
      expect(await tester.runAsync<Color?>(() => pick), _blue);
      expect(state.value.toColor().toARGB32(), _blue.toARGB32());
    });

    testWidgets('tap commits the hovered colour', (tester) async {
      late EyeDropperLayerScope scope;
      await _pumpHarness(tester, (s) => scope = s);
      final _LiveHarnessState state = _harnessState(tester);
      final Future<Color?> pick = await _startLive(tester, scope, state);
      final TestGesture mouse = await _hover(tester);
      await mouse.moveTo(_center(tester, 'swatch-blue'));
      await tester.pump();
      await tester.tapAt(_center(tester, 'swatch-blue'));
      await tester.pump();
      expect(await tester.runAsync<Color?>(() => pick), _blue);
      expect(state.value.toColor().toARGB32(), _blue.toARGB32());
    });

    testWidgets('Escape cancels and restores the previous colour', (
      tester,
    ) async {
      late EyeDropperLayerScope scope;
      await _pumpHarness(tester, (s) => scope = s);
      final _LiveHarnessState state = _harnessState(tester);
      final ColorDerivative before = state.value;
      final Future<Color?> pick = await _startLive(tester, scope, state);
      final TestGesture mouse = await _hover(tester);
      await mouse.moveTo(_center(tester, 'swatch-red'));
      await tester.pump();
      expect(state.value.toColor().toARGB32(), _red.toARGB32());
      // The controls restore `before` on a null commit; mimic that path here.
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pump();
      expect(await tester.runAsync<Color?>(() => pick), isNull);
      state.restore(before);
      await tester.pump();
      expect(state.value.toColor().toARGB32(), _initial.toARGB32());
    });

    testWidgets('right-click cancels the session', (tester) async {
      late EyeDropperLayerScope scope;
      await _pumpHarness(tester, (s) => scope = s);
      final _LiveHarnessState state = _harnessState(tester);
      final Future<Color?> pick = await _startLive(tester, scope, state);
      final TestGesture mouse = await _hover(tester);
      await mouse.moveTo(_center(tester, 'swatch-red'));
      await tester.pump();
      final GestureDetector detector = tester.widget<GestureDetector>(
        find
            .descendant(
              of: find.byType(EyeDropperLayer),
              matching: find.byType(GestureDetector),
            )
            .first,
      );
      detector.onSecondaryTapDown!(
        TapDownDetails(globalPosition: const Offset(10, 10)),
      );
      await tester.pump();
      expect(await tester.runAsync<Color?>(() => pick), isNull);
      expect(state.mounted, isTrue);
    });

    testWidgets('arrows nudge 1px and Enter commits', (tester) async {
      late EyeDropperLayerScope scope;
      await _pumpHarness(tester, (s) => scope = s);
      final _LiveHarnessState state = _harnessState(tester);
      final Future<Color?> pick = await _startLive(tester, scope, state);
      final TestGesture mouse = await _hover(tester);
      // Left edge of the red swatch: one nudge left leaves the swatch.
      await mouse.moveTo(_center(tester, 'swatch-red'));
      await tester.pump();
      expect(state.value.toColor().toARGB32(), _red.toARGB32());
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pump();
      final Color? committed = await tester.runAsync<Color?>(() => pick);
      expect(committed, isNotNull);
    });
  });

  group('mapping and overlay', () {
    testWidgets('DPR 2 maps logical positions to image pixels', (tester) async {
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);
      late EyeDropperLayerScope scope;
      await _pumpHarness(tester, (s) => scope = s);
      final _LiveHarnessState state = _harnessState(tester);
      final Future<Color?> pick = await _startLive(tester, scope, state);
      final TestGesture mouse = await _hover(tester);
      // Logical (60, 20) is image pixel (120, 40): blue. Without the ratio
      // mapping the layer would read image pixel (60, 20): red.
      await mouse.moveTo(_center(tester, 'swatch-blue'));
      await tester.pump();
      expect(state.value.toColor().toARGB32(), _blue.toARGB32());
      await tester.tapAt(_center(tester, 'swatch-blue'));
      await tester.pump();
      expect(await tester.runAsync<Color?>(() => pick), _blue);
    });

    testWidgets('the root overlay covers the full window', (tester) async {
      late EyeDropperLayerScope inner;
      await tester.pumpWidget(
        DashcnApp(home: _LiveHarness(onScope: (s) => inner = s)),
      );
      await tester.pumpAndSettle();
      final _LiveHarnessState state = _harnessState(tester);
      await tester.runAsync(() async {
        inner.promptPickColor(null, state.applySample);
        await Future<void>.delayed(const Duration(milliseconds: 100));
      });
      await tester.pump();
      // The frozen capture sits above the app content, full-window sized.
      final Size window =
          tester.view.physicalSize / tester.view.devicePixelRatio;
      final Size rawSize = tester.getSize(find.byType(RawImage));
      expect(rawSize.width, window.width);
      expect(rawSize.height, window.height);
      // A hover far outside the nested layer still samples (whole window).
      final TestGesture mouse = await _hover(tester);
      await mouse.moveTo(Offset(window.width - 20, window.height - 20));
      await tester.pump();
      expect(tester.takeException(), isNull);
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pump();
    });
  });

  group('robustness', () {
    testWidgets('disposing mid-session completes null with no exception', (
      tester,
    ) async {
      late EyeDropperLayerScope scope;
      await _pumpHarness(tester, (s) => scope = s);
      final _LiveHarnessState state = _harnessState(tester);
      final Future<Color?> pick = await _startLive(tester, scope, state);
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(milliseconds: 600));
      expect(tester.takeException(), isNull);
      expect(await tester.runAsync<Color?>(() => pick), isNull);
    });

    testWidgets('the pipette hides without a scope in the tree', (
      tester,
    ) async {
      Future<void> pumpScope({required bool withLayer}) async {
        // Bare shrink between trees: the frame's Overlay keeps its initial
        // entries, so only a bare pump fully swaps the displayed tree.
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pumpWidget(
          _frame(
            RecentColorsScope(
              child: withLayer
                  ? EyeDropperLayer(
                      child: ColorPicker(
                        value: ColorDerivative.fromColor(_red),
                        onChanged: (_) {},
                      ),
                    )
                  : ColorPicker(
                      value: ColorDerivative.fromColor(_red),
                      onChanged: (_) {},
                    ),
            ),
          ),
        );
        await tester.pump();
      }

      await pumpScope(withLayer: false);
      expect(find.byIcon(LucideIcons.pipette), findsNothing);
      await pumpScope(withLayer: true);
      expect(find.byIcon(LucideIcons.pipette), findsOneWidget);
    });
  });
}

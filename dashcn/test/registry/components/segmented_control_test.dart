// Widget tests for the `segmented_control` component.
//
// Covers rendering, single and multiple selection, the controlled and
// uncontrolled modes, the disabled segments, the sliding thumb, the
// full-width and intrinsic sizes, the callbacks, the arrow keys, RTL, the
// style/theme overrides, the custom builder and the 375 px phone width.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/segmented_control/segmented_control.dart';
import 'package:dashcn/src/foundation/icons/lucide_icons.dart';
import 'package:dashcn/src/primitives/clickable.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _frame({
  ThemeData data = const ThemeData(),
  List<ComponentThemeData> app = const <ComponentThemeData>[],
  TextDirection direction = TextDirection.ltr,
  required Widget child,
}) {
  return Theme(
    data: data,
    child: ComponentThemes(
      themes: app,
      child: Directionality(
        textDirection: direction,
        child: Center(child: child),
      ),
    ),
  );
}

List<SegmentedControlSegment<String>> _segments({bool secondDisabled = false}) {
  return <SegmentedControlSegment<String>>[
    const SegmentedControlSegment<String>(value: 'a', label: Text('A')),
    SegmentedControlSegment<String>(
      value: 'b',
      label: const Text('B'),
      enabled: !secondDisabled,
    ),
    const SegmentedControlSegment<String>(value: 'c', label: Text('C')),
  ];
}

void main() {
  group('SegmentedControl', () {
    testWidgets('renders every segment', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: SegmentedControl<String>(
            value: 'a',
            onChanged: _noop,
            segments: _segments(),
          ),
        ),
      );
      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
      expect(find.text('C'), findsOneWidget);
    });

    testWidgets('reports the next value in single mode', (tester) async {
      String? next;
      await tester.pumpWidget(
        _frame(
          child: SegmentedControl<String>(
            value: 'a',
            onChanged: (String value) => next = value,
            segments: _segments(),
          ),
        ),
      );
      await tester.tap(find.text('C'));
      await tester.pump();
      expect(next, 'c');
    });

    testWidgets('adds and removes values in multiple mode', (tester) async {
      Set<String>? next;
      await tester.pumpWidget(
        _frame(
          child: _MultipleExample(
            onChanged: (Set<String> values) {
              next = values;
            },
          ),
        ),
      );
      await tester.tap(find.text('C'));
      await tester.pump();
      expect(next, <String>{'a', 'c'});
      await tester.tap(find.text('A'));
      await tester.pump();
      expect(next, <String>{'c'});
    });

    testWidgets('a controller owns the selection', (tester) async {
      final SegmentedControlController<String> controller =
          SegmentedControlController<String>(<String>{'a'});
      addTearDown(controller.dispose);
      await tester.pumpWidget(
        _frame(
          child: SegmentedControl<String>(
            controller: controller,
            segments: _segments(),
          ),
        ),
      );
      await tester.tap(find.text('C'));
      await tester.pump();
      expect(controller.value, <String>{'c'});
    });

    testWidgets('an uncontrolled control starts on its first segment', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(child: SegmentedControl<String>(segments: _segments())),
      );
      await tester.pump();
      expect(_selectedIndex(tester), 0);
    });

    testWidgets('a disabled segment cannot be picked', (tester) async {
      String? next;
      await tester.pumpWidget(
        _frame(
          child: SegmentedControl<String>(
            value: 'a',
            onChanged: (String value) => next = value,
            segments: _segments(secondDisabled: true),
          ),
        ),
      );
      await tester.tap(find.text('B'));
      await tester.pump();
      expect(next, isNull);
    });

    testWidgets('the thumb slides to the selected segment', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: SegmentedControl<String>(
            value: 'a',
            onChanged: _noop,
            segments: _segments(),
          ),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      final double first = _thumbLeft(tester);
      await tester.pumpWidget(
        _frame(
          child: SegmentedControl<String>(
            value: 'c',
            onChanged: _noop,
            segments: _segments(),
          ),
        ),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(_thumbLeft(tester), greaterThan(first));
    });

    testWidgets('the thumb sits on the selected segment in LTR', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          child: SegmentedControl<String>(
            value: 'c',
            onChanged: _noop,
            segments: _segments(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(_thumbOverlaps(tester, 'C'), isTrue);
    });

    testWidgets('the thumb sits on the selected segment in RTL', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          direction: TextDirection.rtl,
          child: SegmentedControl<String>(
            value: 'a',
            onChanged: _noop,
            segments: _segments(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(_thumbOverlaps(tester, 'A'), isTrue);
    });

    testWidgets('fills the width it is given', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: SizedBox(
            width: 300,
            child: SegmentedControl<String>(
              expand: true,
              value: 'a',
              onChanged: _noop,
              segments: _segments(),
            ),
          ),
        ),
      );
      expect(tester.getSize(find.byType(SegmentedControl<String>)).width, 300);
    });

    testWidgets('hugs its content in the intrinsic mode', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: SegmentedControl<String>(
            value: 'a',
            onChanged: _noop,
            segments: _segments(),
          ),
        ),
      );
      expect(
        tester.getSize(find.byType(SegmentedControl<String>)).width,
        lessThan(300),
      );
    });

    testWidgets('the arrow keys walk the segments and pick them', (
      tester,
    ) async {
      String? next;
      await tester.pumpWidget(
        _frame(
          child: SegmentedControl<String>(
            value: 'a',
            onChanged: (String value) => next = value,
            segments: _segments(),
          ),
        ),
      );
      final List<Clickable> clickables = tester
          .widgetList<Clickable>(
            find.descendant(
              of: find.byType(SegmentedControl<String>),
              matching: find.byType(Clickable),
            ),
          )
          .toList();
      clickables.first.focusNode?.requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
      await tester.pump();
      expect(next, 'b');
    });

    testWidgets('the arrow map is mirrored in RTL', (tester) async {
      String? next;
      await tester.pumpWidget(
        _frame(
          direction: TextDirection.rtl,
          child: SegmentedControl<String>(
            value: 'a',
            onChanged: (String value) => next = value,
            segments: _segments(),
          ),
        ),
      );
      final List<Clickable> clickables = tester
          .widgetList<Clickable>(
            find.descendant(
              of: find.byType(SegmentedControl<String>),
              matching: find.byType(Clickable),
            ),
          )
          .toList();
      clickables.first.focusNode?.requestFocus();
      await tester.pump();
      await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
      await tester.pump();
      expect(next, 'b');
    });

    testWidgets('paints a 36 px track with 28 px segments', (tester) async {
      await tester.pumpWidget(
        _frame(
          data: const ThemeData(platform: TargetPlatform.macOS),
          child: SegmentedControl<String>(
            value: 'a',
            onChanged: _noop,
            segments: _segments(),
          ),
        ),
      );
      // SIZING.md bars: 36 px track, 28 px items — the tabs-strip look.
      expect(tester.getSize(find.byType(SegmentedControl<String>)).height, 36);
      final Finder segment = find
          .descendant(
            of: find.byType(SegmentedControl<String>),
            matching: find.byType(Clickable),
          )
          .first;
      expect(tester.getSize(segment).height, 28);
    });

    testWidgets('honours a widget-leg style override', (tester) async {
      await tester.pumpWidget(
        _frame(
          data: const ThemeData(platform: TargetPlatform.macOS),
          child: SegmentedControl<String>(
            value: 'a',
            onChanged: _noop,
            style: SegmentedControlStyle(
              background: ThemedColor.ref(ColorRef.secondary),
              height: 48,
            ),
            segments: _segments(),
          ),
        ),
      );
      expect(tester.getSize(find.byType(SegmentedControl<String>)).height, 48);
    });

    testWidgets('honours an app-level theme override', (tester) async {
      await tester.pumpWidget(
        _frame(
          data: const ThemeData(platform: TargetPlatform.macOS),
          app: const <ComponentThemeData>[
            SegmentedControlTheme(control: SegmentedControlStyle(height: 44)),
          ],
          child: SegmentedControl<String>(
            value: 'a',
            onChanged: _noop,
            segments: _segments(),
          ),
        ),
      );
      expect(tester.getSize(find.byType(SegmentedControl<String>)).height, 44);
    });

    testWidgets('grows to the touch tap minimum on a phone', (tester) async {
      await tester.pumpWidget(
        _frame(
          data: const ThemeData(platform: TargetPlatform.android),
          child: SegmentedControl<String>(
            value: 'a',
            onChanged: _noop,
            segments: _segments(),
          ),
        ),
      );
      // SIZING.md: the painted track keeps 36 px and the segment visuals
      // 28 px on every platform; the control's box grows to the 48 px touch
      // minimum and the segments stretch to it, so every segment keeps a
      // 48 px invisible hit area with unchanged visuals.
      expect(tester.getSize(find.byType(SegmentedControl<String>)).height, 48);
      final Finder segment = find
          .descendant(
            of: find.byType(SegmentedControl<String>),
            matching: find.byType(Clickable),
          )
          .first;
      expect(tester.getSize(segment).height, 48);
    });

    testWidgets('the segment builder replaces the content', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: SegmentedControl<String>(
            value: 'a',
            onChanged: _noop,
            segments: _segments(),
            segmentBuilder:
                (
                  BuildContext context,
                  SegmentedControlSegment<String> segment, {
                  required bool selected,
                  required bool enabled,
                }) => Text('custom ${segment.value}'),
          ),
        ),
      );
      expect(find.text('custom a'), findsOneWidget);
      expect(find.text('A'), findsNothing);
    });

    testWidgets('renders icons next to the labels', (tester) async {
      await tester.pumpWidget(
        _frame(
          child: SegmentedControl<String>(
            value: 'a',
            onChanged: _noop,
            segments: const <SegmentedControlSegment<String>>[
              SegmentedControlSegment<String>(
                value: 'a',
                icon: Icon(LucideIcons.bold),
                label: Text('Bold'),
              ),
            ],
          ),
        ),
      );
      expect(find.byIcon(LucideIcons.bold), findsOneWidget);
      expect(find.text('Bold'), findsOneWidget);
    });

    testWidgets('the thumb jumps to the end state under reduced motion', (
      tester,
    ) async {
      await tester.pumpWidget(
        _frame(
          data: const ThemeData(),
          child: const MediaQuery(
            data: MediaQueryData(disableAnimations: true),
            child: SegmentedControl<String>(
              value: 'a',
              onChanged: _noop,
              segments: <SegmentedControlSegment<String>>[
                SegmentedControlSegment<String>(value: 'a', label: Text('A')),
                SegmentedControlSegment<String>(value: 'b', label: Text('B')),
              ],
            ),
          ),
        ),
      );
      await tester.pump();
      final double before = _thumbLeft(tester);
      await tester.pumpWidget(
        _frame(
          data: const ThemeData(),
          child: const MediaQuery(
            data: MediaQueryData(disableAnimations: true),
            child: SegmentedControl<String>(
              value: 'b',
              onChanged: _noop,
              segments: <SegmentedControlSegment<String>>[
                SegmentedControlSegment<String>(value: 'a', label: Text('A')),
                SegmentedControlSegment<String>(value: 'b', label: Text('B')),
              ],
            ),
          ),
        ),
      );
      // No frame of animation: the thumb is already at its end position.
      await tester.pump();
      expect(_thumbLeft(tester), greaterThan(before));
    });

    testWidgets('fits a 375 px phone width without overflowing', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        _frame(
          child: SegmentedControl<String>(
            value: 'a',
            onChanged: _noop,
            segments: const <SegmentedControlSegment<String>>[
              SegmentedControlSegment<String>(
                value: 'a',
                icon: Icon(LucideIcons.bold),
                label: Text('Bold'),
              ),
              SegmentedControlSegment<String>(
                value: 'b',
                icon: Icon(LucideIcons.italic),
                label: Text('Italic'),
              ),
              SegmentedControlSegment<String>(
                value: 'c',
                icon: Icon(LucideIcons.underline),
                label: Text('Underline'),
              ),
            ],
          ),
        ),
      );
      expect(tester.takeException(), isNull);
    });
  });
}

void _noop(String value) {}

/// A controlled multiple-select control that owns its selection.
class _MultipleExample extends StatefulWidget {
  const _MultipleExample({required this.onChanged});

  final ValueChanged<Set<String>> onChanged;

  @override
  State<_MultipleExample> createState() => _MultipleExampleState();
}

class _MultipleExampleState extends State<_MultipleExample> {
  Set<String> _values = <String>{'a'};

  @override
  Widget build(BuildContext context) {
    return SegmentedControl<String>(
      selection: SegmentedControlSelection.multiple,
      values: _values,
      onValuesChanged: (Set<String> values) {
        setState(() => _values = values);
        widget.onChanged(values);
      },
      segments: <SegmentedControlSegment<String>>[
        const SegmentedControlSegment<String>(value: 'a', label: Text('A')),
        const SegmentedControlSegment<String>(value: 'b', label: Text('B')),
        const SegmentedControlSegment<String>(value: 'c', label: Text('C')),
      ],
    );
  }
}

/// The index of the selected segment.
int _selectedIndex(WidgetTester tester) {
  final List<Clickable> clickables = tester
      .widgetList<Clickable>(
        find.descendant(
          of: find.byType(SegmentedControl<String>),
          matching: find.byType(Clickable),
        ),
      )
      .toList();
  for (int i = 0; i < clickables.length; i++) {
    final Semantics node = tester.widget<Semantics>(
      find
          .descendant(
            of: find.byType(SegmentedControl<String>),
            matching: find.byType(Semantics),
          )
          .at(i),
    );
    if (node.properties.selected ?? false) {
      return i;
    }
  }
  return -1;
}

/// The left edge of the sliding thumb.
double _thumbLeft(WidgetTester tester) {
  final Finder thumb = find.descendant(
    of: find.byType(SegmentedControl<String>),
    matching: find.byType(AnimatedPositioned),
  );
  expect(thumb, findsOneWidget);
  return tester.getTopLeft(thumb).dx;
}

/// Whether the sliding thumb covers the given segment's label.
///
/// The thumb is painted under the row, so the label is on top of it; an
/// overlap proves the thumb sits on the right segment (and on the right
/// side in RTL).
bool _thumbOverlaps(WidgetTester tester, String label) {
  final Finder thumb = find.descendant(
    of: find.byType(SegmentedControl<String>),
    matching: find.byType(AnimatedPositioned),
  );
  expect(thumb, findsOneWidget);
  final Rect thumbRect = tester.getRect(thumb);
  final Rect labelRect = tester.getRect(find.text(label));
  return thumbRect.overlaps(labelRect);
}

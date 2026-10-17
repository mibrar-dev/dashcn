// P7-F3 input polish (2026-10-11): segment wrap, separator gaps, heights.
//
// 1. Object/formatted segments never wrap: every segment box fits its
//    placeholder and its `length` glyphs, and every label paints one line.
// 2. Formatted segments butt against static separators (gap <= 1px), like a
//    single text field.
// 3. Date/time triggers and object fields share the input height (h-9) at
//    compact, default and spacious densities.

import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/date_picker/date_picker.dart';
import 'package:dashcn/src/components/formatted_input/formatted_input.dart';
import 'package:dashcn/src/components/gooey_toast/gooey_toast.dart';
import 'package:dashcn/src/components/input/input.dart';
import 'package:dashcn/src/components/object_input/object_input.dart';
import 'package:dashcn/src/components/time_picker/time_picker.dart';
import 'package:dashcn/src/primitives/color_math.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/density.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pump(
  WidgetTester tester,
  Widget child, {
  double width = 1000,
  Density? density,
}) async {
  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = Size(width, 600);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final ThemeData data = density == null
      ? const ThemeData()
      : const ThemeData().copyWith(density: () => density);
  await tester.pumpWidget(
    Theme(
      data: data,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: MediaQuery(
          data: const MediaQueryData(),
          child: Overlay(
            // Remount every pump: `initialEntries` only applies on insert,
            // so an updated Overlay would keep showing the previous test's
            // entries.
            key: UniqueKey(),
            initialEntries: <OverlayEntry>[
              OverlayEntry(
                builder: (_) =>
                    Align(alignment: Alignment.topLeft, child: child),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

/// Single-line height of [text] in the ambient default style of [element].
double _lineHeight(Element element, String text) {
  final TextStyle style = DefaultTextStyle.of(element).style;
  final TextPainter painter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: TextDirection.ltr,
  )..layout();
  return painter.preferredLineHeight;
}

/// Width of [text] in the ambient default style of [element].
double _textWidth(Element element, String text) {
  final TextStyle style = DefaultTextStyle.of(element).style;
  final TextPainter painter = TextPainter(
    text: TextSpan(text: text, style: style),
    textDirection: TextDirection.ltr,
  )..layout();
  return painter.width;
}

/// The nearest segment box above a placeholder label.
Finder _segmentBox(String label) =>
    find.ancestor(of: find.text(label), matching: find.byType(SizedBox));

void main() {
  group('segments never wrap', () {
    for (final (String name, Widget field, List<String> labels)
        in <(String, Widget, List<String>)>[
          (
            'date',
            DateInput(onChanged: (_) {}),
            const <String>['MM', 'DD', 'YYYY'],
          ),
          ('time', TimeInput(onChanged: (_) {}), const <String>['HH', 'MM']),
          (
            'duration',
            DurationInput(onChanged: (_) {}),
            const <String>['HH', 'MM'],
          ),
        ]) {
      testWidgets('$name placeholders paint on one line', (tester) async {
        await _pump(tester, field);
        expect(tester.takeException(), isNull);
        for (final String label in labels) {
          expect(find.text(label), findsOneWidget, reason: label);
          final double height = tester.getSize(find.text(label)).height;
          final double line = _lineHeight(
            tester.element(find.text(label)),
            label,
          );
          expect(height, lessThanOrEqualTo(line + 1.0), reason: label);
        }
      });

      testWidgets('$name boxes fit their placeholders', (tester) async {
        await _pump(tester, field);
        expect(tester.takeException(), isNull);
        for (final String label in labels) {
          final double box = tester.getSize(_segmentBox(label).first).width;
          final double text = _textWidth(
            tester.element(find.text(label)),
            label,
          );
          expect(box, greaterThanOrEqualTo(text), reason: label);
        }
      });
    }
  });

  group('formatted segments butt against separators', () {
    const SegmentedValue phone = SegmentedValue(<SegmentPart>[
      SegmentPart.separator('('),
      SegmentPart.editable(length: 3, value: '555'),
      SegmentPart.separator(') '),
      SegmentPart.editable(length: 3, value: '123'),
      SegmentPart.separator('-'),
      SegmentPart.editable(length: 4, value: '4567'),
    ]);

    Future<double> gap(
      WidgetTester tester,
      Finder edge,
      Finder box,
      double inset, {
      required bool edgeFirst,
    }) async {
      final Rect edgeRect = tester.getRect(edge);
      final Rect boxRect = tester.getRect(box);
      return edgeFirst
          ? boxRect.left - edgeRect.right + inset
          : edgeRect.left - boxRect.right + inset;
    }

    testWidgets('gaps around separators are at most 1px', (tester) async {
      await _pump(tester, FormattedInput(value: phone, onChanged: (_) {}));
      expect(tester.takeException(), isNull);
      final Finder boxes = find.byType(EditableText);
      expect(boxes, findsNWidgets(3));
      for (int i = 0; i < 3; i++) {
        final EditableText editable = tester.widget<EditableText>(boxes.at(i));
        final Rect box = tester.getRect(boxes.at(i));
        final String text = editable.controller.text;
        final double textWidth = (TextPainter(
          text: TextSpan(text: text, style: editable.style),
          textDirection: TextDirection.ltr,
        )..layout()).width;
        // Centered text splits the caret-only reserve evenly: ~1px a side.
        final double inset = (box.width - textWidth) / 2;
        expect(inset, lessThanOrEqualTo(1.05), reason: 'segment $i inset');
        expect(inset, greaterThanOrEqualTo(0), reason: 'segment $i fits');
      }
      // '555' against '(' (left) and ') ' (right).
      final Rect first = tester.getRect(boxes.at(0));
      final double firstWidth = (TextPainter(
        text: TextSpan(
          text: '555',
          style: tester.widget<EditableText>(boxes.at(0)).style,
        ),
        textDirection: TextDirection.ltr,
      )..layout()).width;
      final double firstInset = (first.width - firstWidth) / 2;
      expect(
        await gap(
          tester,
          find.text('('),
          boxes.at(0),
          firstInset,
          edgeFirst: true,
        ),
        lessThanOrEqualTo(1.05),
      );
      expect(
        await gap(
          tester,
          find.text(') '),
          boxes.at(0),
          firstInset,
          edgeFirst: false,
        ),
        lessThanOrEqualTo(1.05),
      );
    });
  });

  group('triggers share the input height', () {
    const List<(String, Density)> densities = <(String, Density)>[
      ('compact', Density.compactDensity),
      ('default', Density.defaultDensity),
      ('spacious', Density.spaciousDensity),
    ];
    for (final (String name, Density density) in densities) {
      testWidgets('$name density: pickers match inputs', (tester) async {
        await _pump(tester, const Input(), density: density);
        final double input = tester.getSize(find.byType(Input)).height;
        expect(input, greaterThanOrEqualTo(36));
        // DateInput carries the 16px date prompt, which centres in the 48px
        // touch minimum: it stands taller than a plain input (54/58/60 at
        // compact/default/spacious density).
        const Map<String, double> promptHeights = <String, double>{
          'compact': 54,
          'default': 58,
          'spacious': 60,
        };
        for (final Widget field in <Widget>[
          DatePicker(value: null, onChanged: (_) {}),
          DateRangePicker(value: null, onChanged: (_) {}),
          TimePicker(value: null, onChanged: (_) {}),
          const DurationPicker(value: null, onChanged: null),
          TimeInput(onChanged: (_) {}),
        ]) {
          await _pump(tester, field, density: density);
          expect(tester.takeException(), isNull);
          expect(
            tester.getSize(find.byWidget(field)).height,
            moreOrLessEquals(input, epsilon: 0.5),
            reason: '${field.runtimeType} at $name density',
          );
        }
        await _pump(tester, DateInput(onChanged: (_) {}), density: density);
        expect(tester.takeException(), isNull);
        expect(
          tester.getSize(find.byType(DateInput)).height,
          moreOrLessEquals(promptHeights[name]!, epsilon: 0.5),
          reason: 'DateInput at $name density',
        );
      });
    }
  });

  group('gooey tone contrast', () {
    const Color white = Color(0xFFFFFFFF);
    const Color black = Color(0xFF000000);

    test('passing tones return untouched (stable across modes)', () {
      for (final ThemeColors colors in <ThemeColors>[
        ThemeColors.lightFallback,
        ThemeColors.darkFallback,
      ]) {
        final Color surface = colors.popover;
        expect(
          GooeyToastState.success.tone(gooeyToastDefaults, colors),
          gooeySuccessTone,
        );
        expect(
          GooeyToastState.warning.tone(gooeyToastDefaults, colors),
          gooeyWarningTone,
        );
        expect(
          GooeyToastState.info.tone(gooeyToastDefaults, colors),
          gooeyInfoTone,
        );
        expect(
          GooeyToastState.error.tone(gooeyToastDefaults, colors),
          gooeyErrorTone,
        );
        for (final GooeyToastState state in GooeyToastState.values) {
          expect(
            contrastRatio(state.tone(gooeyToastDefaults, colors), surface),
            greaterThanOrEqualTo(3),
            reason: '${state.name} on ${colors.brightness.name}',
          );
        }
      }
      // Same green in both modes (the P7-F3 bug: blue vs orange).
      expect(
        GooeyToastState.success.tone(
          gooeyToastDefaults,
          ThemeColors.lightFallback,
        ),
        GooeyToastState.success.tone(
          gooeyToastDefaults,
          ThemeColors.darkFallback,
        ),
      );
    });

    test('failing tones blend toward the foreground', () {
      final Color blended = ensureToneContrast(
        white,
        surface: white,
        foreground: black,
      );
      expect(contrastRatio(blended, white), greaterThanOrEqualTo(3));
      expect(blended, isNot(white));
      expect(
        ensureToneContrast(white, surface: white, foreground: white),
        white,
      );
    });
  });
}

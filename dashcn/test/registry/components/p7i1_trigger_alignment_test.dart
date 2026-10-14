// P7-I1: picker trigger icon alignment + content-sized width (P7-Z2 wrap
// contract).
//
// The icon sits in a fixed 16px box beside the label in one centred row, so
// their vertical centres match in every font (Geist, the docs web font,
// included). Width hugs `icon + gap + full label + padding` with no minimum
// and never an ellipsis; a parent narrower than the content shrinks the
// label to a second line instead of overflowing.

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/date_picker/date_picker.dart';
import 'package:dashcn/src/components/time_picker/time_picker.dart';
import 'package:dashcn/src/foundation/icons/lucide_icons.dart';
import 'package:dashcn/src/foundation/time_of_day.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/density.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _loadFonts() async {
  Future<void> load(String family, String asset) async {
    final bytes = File('${Directory.current.path}/$asset').readAsBytesSync();
    final loader = FontLoader(family)
      ..addFont(Future<ByteData>.value(ByteData.sublistView(bytes)));
    await loader.load();
  }

  await load('GeistSans', 'assets/fonts/Geist-Regular.otf');
  await load('LucideIcons', 'assets/fonts/lucide.ttf');
}

ThemeData _theme(Brightness brightness, Density density) {
  return ThemeData(
    colors: brightness == Brightness.dark
        ? ThemeColors.darkFallback
        : ThemeColors.lightFallback,
  ).copyWith(density: () => density);
}

Future<void> _pump(WidgetTester tester, Widget child, ThemeData data) async {
  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = const Size(1000, 600);
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(
    Theme(
      data: data,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: MediaQuery(
          data: const MediaQueryData(),
          child: Overlay(
            // Remount every pump: `initialEntries` only applies on insert.
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

double _dy(WidgetTester tester, Finder finder) => tester.getCenter(finder).dy;

void _expectCentred(WidgetTester tester, Finder icon, Finder label) {
  expect(icon, findsOneWidget);
  expect(label, findsOneWidget);
  expect(
    (_dy(tester, icon) - _dy(tester, label)).abs(),
    lessThanOrEqualTo(1.0),
  );
  final Size box = tester.getSize(
    find.ancestor(of: icon, matching: find.byType(SizedBox)).first,
  );
  expect(box.width, moreOrLessEquals(16, epsilon: 0.01));
  expect(box.height, moreOrLessEquals(16, epsilon: 0.01));
}

void _expectNoEllipsis(WidgetTester tester, Finder scope) {
  final Iterable<Text> texts = tester.widgetList<Text>(
    find.descendant(of: scope, matching: find.byType(Text)),
  );
  expect(texts, isNotEmpty);
  for (final Text text in texts) {
    expect(text.overflow, isNot(TextOverflow.ellipsis));
  }
}

void main() {
  setUpAll(_loadFonts);

  const List<(String, Density)> densities = <(String, Density)>[
    ('compact', Density.compactDensity),
    ('default', Density.defaultDensity),
    ('spacious', Density.spaciousDensity),
  ];
  const List<Brightness> skins = <Brightness>[
    Brightness.light,
    Brightness.dark,
  ];

  for (final (String name, Density density) in densities) {
    for (final Brightness brightness in skins) {
      final String tag = '$name/${brightness.name}';
      testWidgets('$tag: date icon centred on placeholder', (tester) async {
        await _pump(
          tester,
          DatePicker(value: null, onChanged: (_) {}),
          _theme(brightness, density),
        );
        _expectCentred(
          tester,
          find.byIcon(LucideIcons.calendarDays),
          find.text('Pick a date'),
        );
        _expectNoEllipsis(tester, find.byType(DatePicker));
      });

      testWidgets('$tag: date icon centred on value', (tester) async {
        await _pump(
          tester,
          DatePicker(value: DateTime(2024, 3, 14), onChanged: (_) {}),
          _theme(brightness, density),
        );
        _expectCentred(
          tester,
          find.byIcon(LucideIcons.calendarDays),
          find.text('March 14, 2024'),
        );
      });

      testWidgets('$tag: range icon centred on long label', (tester) async {
        await _pump(
          tester,
          DateRangePicker(
            value: DateTimeRange(DateTime(2026, 1, 1), DateTime(2026, 1, 14)),
            onChanged: (_) {},
          ),
          _theme(brightness, density),
        );
        _expectCentred(
          tester,
          find.byIcon(LucideIcons.calendarRange),
          find.text('January 1, 2026 - January 14, 2026'),
        );
        _expectNoEllipsis(tester, find.byType(DateRangePicker));
      });

      testWidgets('$tag: time icon centred', (tester) async {
        await _pump(
          tester,
          TimePicker(
            value: const TimeOfDay(hour: 14, minute: 30),
            onChanged: (_) {},
            use24HourFormat: true,
          ),
          _theme(brightness, density),
        );
        _expectCentred(
          tester,
          find.byIcon(LucideIcons.clock),
          find.text('14:30'),
        );
        _expectNoEllipsis(tester, find.byType(TimePicker));
      });
    }
  }

  testWidgets('width hugs short and long labels, no minimum', (tester) async {
    final ThemeData data = _theme(Brightness.light, Density.defaultDensity);
    await _pump(tester, DateRangePicker(value: null, onChanged: (_) {}), data);
    final double empty = tester.getSize(find.byType(DateRangePicker)).width;
    expect(empty, greaterThan(100));
    expect(empty, lessThan(1000));

    await _pump(
      tester,
      DateRangePicker(
        value: DateTimeRange(DateTime(2026, 1, 1), DateTime(2026, 1, 14)),
        onChanged: (_) {},
      ),
      data,
    );
    expect(tester.takeException(), isNull);
    final double long = tester.getSize(find.byType(DateRangePicker)).width;
    expect(find.text('January 1, 2026 - January 14, 2026'), findsOneWidget);
    expect(long, greaterThan(empty));
    expect(long, lessThan(1000));
    _expectNoEllipsis(tester, find.byType(DateRangePicker));
  });

  testWidgets('tight parent fills; narrow wraps, never overflows', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = const Size(800, 600);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final ThemeData data = _theme(Brightness.light, Density.defaultDensity);
    Widget frame(double width, Widget child) => Theme(
      data: data,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: MediaQuery(
          data: const MediaQueryData(),
          child: Overlay(
            key: UniqueKey(),
            initialEntries: <OverlayEntry>[
              OverlayEntry(
                builder: (_) => Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(width: width, child: child),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    await tester.pumpWidget(
      frame(
        800,
        DateRangePicker(
          value: DateTimeRange(DateTime(2026, 1, 1), DateTime(2026, 1, 14)),
          onChanged: (_) {},
        ),
      ),
    );
    expect(tester.getSize(find.byType(DateRangePicker)).width, 800);
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(
      frame(
        200,
        DateRangePicker(
          value: DateTimeRange(DateTime(2026, 1, 1), DateTime(2026, 1, 14)),
          onChanged: (_) {},
        ),
      ),
    );
    // Shrinks to the parent instead of overflowing: the trigger is exactly
    // the parent width, nothing throws, the label wraps to a second line
    // (taller than one line) and still never ellipsizes.
    expect(tester.getSize(find.byType(DateRangePicker)).width, 200);
    expect(tester.takeException(), isNull);
    final Size label = tester.getSize(
      find.text('January 1, 2026 - January 14, 2026'),
    );
    expect(label.height, greaterThan(14));
    expect(label.width, lessThanOrEqualTo(200));
    _expectNoEllipsis(tester, find.byType(DateRangePicker));
  });
}

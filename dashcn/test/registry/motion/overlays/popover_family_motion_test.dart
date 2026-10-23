// Motion tests for the popover family: menu, dropdown menu, context menu,
// menubar menus, popup and select. They share the popover overlay, so each
// test samples the PopoverLayout scale and the fade of the presented surface.
//
// Contract (MOTION.md): enter = fade plus scale 0.95 to 1 from the anchor
// side over 150 ms (decelerate); exit = fade only over 100 ms; reduced
// motion = opacity fade of at most 150 ms, no scale.

import 'package:dashcn/src/components/context_menu/context_menu.dart';
import 'package:dashcn/src/components/dropdown_menu/dropdown_menu.dart';
import 'package:dashcn/src/components/menu/menu.dart';
import 'package:dashcn/src/components/menubar/menubar.dart';
import 'package:dashcn/src/components/popup/popup.dart';
import 'package:dashcn/src/components/select/select.dart';
import 'package:dashcn/src/primitives/popover_layout.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'overlay_motion_harness.dart';

/// Scale of the presented popover (the first PopoverLayout on screen).
double _scale(WidgetTester tester) =>
    tester.widget<PopoverLayout>(find.byType(PopoverLayout).first).scale;

/// Opacity of the presented popover content.
double _opacity(WidgetTester tester) {
  final Finder fade = find.descendant(
    of: find.byType(PopoverLayout).first,
    matching: find.byType(FadeTransition),
  );
  return tester.widget<FadeTransition>(fade.first).opacity.value;
}

/// Trigger that opens an overlay on tap.
Widget _trigger(String label, void Function(BuildContext) onOpen) {
  return Builder(
    builder: (BuildContext context) =>
        GestureDetector(onTap: () => onOpen(context), child: Text(label)),
  );
}

/// Items for the menu family.
List<Widget> _items() => <Widget>[
  MenuButton(child: const Text('Item one'), onPressed: (_) {}),
  MenuButton(child: const Text('Item two'), onPressed: (_) {}),
];

/// Opens via [trigger], asserts the enter, then closes by an outside tap and
/// asserts the exit fades without scaling.
Future<void> _runPopover(
  WidgetTester tester, {
  required Widget Function(BuildContext) page,
  required String trigger,
  required bool reduced,
}) async {
  await pumpOverlayPage(tester, page: page, disabled: reduced);
  await tester.tap(find.text(trigger));
  // The popover entry is inserted on the frame after the tap.
  await tester.pump();
  // Enter: sample the scale over the open (25 ms frames, 200 ms total).
  final List<double> scales = await sampleFrames(
    tester,
    () => _scale(tester),
    frames: 8,
  );
  expect(scales.last, closeTo(1.0, 1e-6), reason: 'settles at scale 1');
  if (reduced) {
    expect(
      scales.every((double s) => (s - 1.0).abs() < 1e-6),
      isTrue,
      reason: 'reduced motion never scales',
    );
  } else {
    expect(scales.first, closeTo(0.95, 0.01), reason: 'starts at 0.95');
    expect(
      distinctCount(scales),
      greaterThan(2),
      reason: 'scale animates over time',
    );
    expect(isNonDecreasing(scales), isTrue);
  }
  await tester.pump(const Duration(milliseconds: 200));
  expect(_opacity(tester), closeTo(1.0, 1e-6), reason: 'opacity settles at 1');

  // Exit: Escape closes; the fade runs and the scale holds at 1.
  // Outside tap hits the modal barrier, which closes every popover kind.
  await tester.tapAt(const Offset(5, 5));
  final List<double> exitOpacity = await sampleFrames(
    tester,
    () => _opacity(tester),
    frames: 4,
  );
  expect(isNonIncreasing(exitOpacity), isTrue, reason: 'fades out');
  expect(exitOpacity.last, lessThan(exitOpacity.first));
  final List<double> exitScale = <double>[_scale(tester)];
  expect(
    exitScale.every((double s) => (s - 1.0).abs() < 1e-6),
    isTrue,
    reason: 'exit does not scale',
  );
  await tester.pump(const Duration(milliseconds: 300));
  expect(find.byType(PopoverLayout), findsNothing, reason: 'removed at end');
}

void main() {
  group('menu', () {
    testWidgets('open scales 0.95 to 1 and fades in, exit only fades', (
      WidgetTester tester,
    ) async {
      await _runPopover(
        tester,
        trigger: 'Open menu',
        reduced: false,
        page: (BuildContext context) => _trigger(
          'Open menu',
          (BuildContext c) => showMenu<void>(context: c, children: _items()),
        ),
      );
    });

    testWidgets('reduced motion: no scale, fade only', (
      WidgetTester tester,
    ) async {
      await _runPopover(
        tester,
        trigger: 'Open menu',
        reduced: true,
        page: (BuildContext context) => _trigger(
          'Open menu',
          (BuildContext c) => showMenu<void>(context: c, children: _items()),
        ),
      );
    });
  });

  group('dropdown menu', () {
    testWidgets('open scales 0.95 to 1 and fades in, exit only fades', (
      WidgetTester tester,
    ) async {
      await _runPopover(
        tester,
        trigger: 'Open dropdown',
        reduced: false,
        page: (BuildContext context) => _trigger(
          'Open dropdown',
          (BuildContext c) =>
              showDropdown<void>(context: c, children: _items()),
        ),
      );
    });

    testWidgets('reduced motion: no scale, fade only', (
      WidgetTester tester,
    ) async {
      await _runPopover(
        tester,
        trigger: 'Open dropdown',
        reduced: true,
        page: (BuildContext context) => _trigger(
          'Open dropdown',
          (BuildContext c) =>
              showDropdown<void>(context: c, children: _items()),
        ),
      );
    });
  });

  group('context menu', () {
    testWidgets('open scales 0.95 to 1 and fades in, exit only fades', (
      WidgetTester tester,
    ) async {
      await _runPopover(
        tester,
        trigger: 'Right click me',
        reduced: false,
        page: (BuildContext context) => _trigger(
          'Right click me',
          (BuildContext c) => showContextMenu<void>(
            context: c,
            position: const Offset(300, 200),
            children: _items(),
          ),
        ),
      );
    });

    testWidgets('reduced motion: no scale, fade only', (
      WidgetTester tester,
    ) async {
      await _runPopover(
        tester,
        trigger: 'Right click me',
        reduced: true,
        page: (BuildContext context) => _trigger(
          'Right click me',
          (BuildContext c) => showContextMenu<void>(
            context: c,
            position: const Offset(300, 200),
            children: _items(),
          ),
        ),
      );
    });
  });

  group('menubar menu', () {
    testWidgets('open scales 0.95 to 1 and fades in, exit only fades', (
      WidgetTester tester,
    ) async {
      await _runPopover(
        tester,
        trigger: 'File',
        reduced: false,
        page: (BuildContext context) => Menubar(
          children: <Widget>[
            MenuButton(
              subMenu: <Widget>[
                MenuButton(child: const Text('New'), onPressed: (_) {}),
                MenuButton(child: const Text('Open'), onPressed: (_) {}),
              ],
              child: const Text('File'),
            ),
          ],
        ),
      );
    });

    testWidgets('reduced motion: no scale, fade only', (
      WidgetTester tester,
    ) async {
      await _runPopover(
        tester,
        trigger: 'File',
        reduced: true,
        page: (BuildContext context) => Menubar(
          children: <Widget>[
            MenuButton(
              subMenu: <Widget>[
                MenuButton(child: const Text('New'), onPressed: (_) {}),
              ],
              child: const Text('File'),
            ),
          ],
        ),
      );
    });
  });

  group('popup', () {
    testWidgets('open scales 0.95 to 1 and fades in, exit only fades', (
      WidgetTester tester,
    ) async {
      await _runPopover(
        tester,
        trigger: 'Open popup',
        reduced: false,
        page: (BuildContext context) => _trigger(
          'Open popup',
          (BuildContext c) => showPopup<void>(
            context: c,
            builder: (_) => const SizedBox(width: 120, height: 40),
          ),
        ),
      );
    });

    testWidgets('reduced motion: no scale, fade only', (
      WidgetTester tester,
    ) async {
      await _runPopover(
        tester,
        trigger: 'Open popup',
        reduced: true,
        page: (BuildContext context) => _trigger(
          'Open popup',
          (BuildContext c) => showPopup<void>(
            context: c,
            builder: (_) => const SizedBox(width: 120, height: 40),
          ),
        ),
      );
    });
  });

  group('select', () {
    Widget select() => Select<String>(
      // A null onChanged disables the trigger, so the select needs one.
      onChanged: (String? _) {},
      placeholder: const Text('Pick a fruit'),
      itemBuilder: (BuildContext context, String value) => Text(value),
      items: <Widget>[
        SelectItem<String>(value: 'Apple', child: const Text('Apple')),
        SelectItem<String>(value: 'Banana', child: const Text('Banana')),
      ],
    );

    testWidgets('open scales 0.95 to 1 and fades in, exit only fades', (
      WidgetTester tester,
    ) async {
      await _runPopover(
        tester,
        trigger: 'Pick a fruit',
        reduced: false,
        page: (BuildContext context) => SizedBox(width: 220, child: select()),
      );
    });

    testWidgets('reduced motion: no scale, fade only', (
      WidgetTester tester,
    ) async {
      await _runPopover(
        tester,
        trigger: 'Pick a fruit',
        reduced: true,
        page: (BuildContext context) => SizedBox(width: 220, child: select()),
      );
    });
  });
}

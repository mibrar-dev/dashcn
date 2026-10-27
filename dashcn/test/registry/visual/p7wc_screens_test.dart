// P7-WC screenshots: the data table (with a selected row), the invoices
// grid, the kbd chord row and the in-menu-item hint.
//
// Renders under `flutter test` like `p7wa_screens_test.dart` and writes one
// PNG per brightness into `rearch/design/ours/screens/p7wc-*_<light|dark>.png`.

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/checkbox/checkbox.dart';
import 'package:dashcn/src/components/keyboard_shortcut/keyboard_shortcut.dart';
import 'package:dashcn/src/components/keyboard_shortcut/preview.dart'
    as kbd_preview;
import 'package:dashcn/src/components/table/preview.dart';
import 'package:dashcn/src/foundation/component_preview.dart';
import 'package:dashcn/src/foundation/gap.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

/// Device pixel ratio of every capture.
const double _dpr = 2.0;

/// Output folder `$KIT/rearch/design/ours/screens`.
Directory get _outDir {
  Directory dir = Directory.current;
  while (dir.path != dir.parent.path) {
    if (File('${dir.path}/INSTRUCTIONS.md').existsSync()) {
      return Directory('${dir.path}/rearch/design/ours/screens');
    }
    dir = dir.parent;
  }
  return Directory('${Directory.current.path}/rearch/design/ours/screens');
}

void main() {
  setUpAll(() async {
    await _loadFonts();
    _outDir.createSync(recursive: true);
  });

  setUp(() {
    FocusManager.instance.highlightStrategy =
        FocusHighlightStrategy.alwaysTraditional;
  });

  group('table', () {
    _scene(
      name: 'p7wc-table-data',
      size: const Size(760, 560),
      build: _dataTable,
      interact: (WidgetTester tester) async {
        // Select Avery so the capture shows the selected fill + count.
        await _tap(tester, find.byType(Checkbox).at(1));
      },
    );
    _scene(
      name: 'p7wc-table-invoices',
      size: const Size(760, 560),
      build: _invoices,
    );
  });

  group('keyboard_shortcut', () {
    _scene(
      name: 'p7wc-kbd-chords',
      size: const Size(640, 360),
      build: (BuildContext context) => const _ChordsScene(),
    );
    _scene(
      name: 'p7wc-kbd-menuitem',
      size: const Size(640, 360),
      build: _menuItem,
    );
  });
}

/// The default table example by name (keeps the capture on the docs demo).
WidgetBuilder get _dataTable {
  return tablePreviews
      .firstWhere((ComponentPreview preview) => preview.name == 'Data table')
      .builder;
}

/// The invoices example by name.
WidgetBuilder get _invoices {
  return tablePreviews
      .firstWhere((ComponentPreview preview) => preview.name == 'Invoices')
      .builder;
}

/// The menu-item example by name.
WidgetBuilder get _menuItem {
  return kbd_preview.keyboardShortcutPreviews
      .firstWhere((ComponentPreview preview) => preview.name == 'In menu item')
      .builder;
}

/// ⌘K, Ctrl+Shift+P and the G-then-H sequence, stacked and centred.
class _ChordsScene extends StatelessWidget {
  const _ChordsScene();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const KeyboardShortcut.fromActivator(
            activator: SingleActivator(LogicalKeyboardKey.keyK, meta: true),
          ),
          Gap(theme.spacing.lg),
          const KeyboardShortcut(
            keys: <LogicalKeyboardKey>[
              LogicalKeyboardKey.control,
              LogicalKeyboardKey.shift,
              LogicalKeyboardKey.keyP,
            ],
          ),
          Gap(theme.spacing.lg),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const KeyboardShortcut(
                keys: <LogicalKeyboardKey>[LogicalKeyboardKey.keyG],
              ),
              Gap(theme.spacing.sm),
              Text(
                'then',
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colors.mutedForeground,
                ),
              ),
              Gap(theme.spacing.sm),
              const KeyboardShortcut(
                keys: <LogicalKeyboardKey>[LogicalKeyboardKey.keyH],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Registers the repo's icon fonts on the test engine.
Future<void> _loadFonts() async {
  Future<void> load(String family, List<String> assets) async {
    final loader = FontLoader(family);
    for (final asset in assets) {
      final bytes = File('${Directory.current.path}/$asset').readAsBytesSync();
      loader.addFont(Future<ByteData>.value(ByteData.sublistView(bytes)));
    }
    await loader.load();
  }

  await load('LucideIcons', const <String>['assets/fonts/lucide.ttf']);
}

/// Upstream default fallback colours with default tokens.
ThemeData _theme(Brightness brightness) => ThemeData(
  colors: brightness == Brightness.dark
      ? ThemeColors.darkFallback
      : ThemeColors.lightFallback,
);

/// Wraps [child] in theme legs, directionality and a [Navigator].
Widget _frame(ThemeData data, Size size, Widget child) {
  return Theme(
    data: data,
    child: ComponentThemes(
      themes: const <ComponentThemeData>[],
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: MediaQuery(
          data: const MediaQueryData(devicePixelRatio: _dpr),
          child: Builder(
            builder: (BuildContext context) {
              final theme = Theme.of(context);
              return DefaultTextStyle(
                style: theme.typography.sans.copyWith(
                  color: theme.colors.foreground,
                  fontSize: 14,
                ),
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: ColoredBox(
                    color: data.colors.background,
                    child: Navigator(
                      onGenerateRoute: (RouteSettings settings) =>
                          PageRouteBuilder<void>(
                            settings: settings,
                            pageBuilder: (_, _, _) => child,
                          ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    ),
  );
}

/// Registers one scene for both brightnesses.
void _scene({
  required String name,
  required Size size,
  required WidgetBuilder build,
  Future<void> Function(WidgetTester tester)? interact,
}) {
  for (final brightness in const <Brightness>[
    Brightness.light,
    Brightness.dark,
  ]) {
    testWidgets('$name ${brightness.name}', (WidgetTester tester) async {
      await _capture(
        tester,
        scene: name,
        brightness: brightness,
        size: size,
        child: Builder(builder: build),
        interact: interact,
      );
    });
  }
}

/// Taps [target] with a mouse.
Future<void> _tap(WidgetTester tester, Finder target) async {
  final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
  await gesture.addPointer(location: Offset.zero);
  addTearDown(gesture.removePointer);
  await gesture.moveTo(tester.getCenter(target));
  await gesture.down(tester.getCenter(target));
  await gesture.up();
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 250));
}

/// Renders [child] at [size] and writes the PNG.
Future<void> _capture(
  WidgetTester tester, {
  required String scene,
  required Brightness brightness,
  required Size size,
  required Widget child,
  Future<void> Function(WidgetTester tester)? interact,
}) async {
  tester.view.devicePixelRatio = _dpr;
  tester.view.physicalSize = size * _dpr;
  addTearDown(tester.view.reset);

  final key = GlobalKey();
  debugDisableShadows = false;
  await tester.pumpWidget(
    RepaintBoundary(key: key, child: _frame(_theme(brightness), size, child)),
  );
  await tester.pump();
  if (interact != null) {
    await interact(tester);
    await tester.pump();
  }
  await tester.pump(const Duration(milliseconds: 320));

  final boundary =
      key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  final ui.Image? image = await tester.runAsync(
    () => boundary.toImage(pixelRatio: _dpr),
  );
  final ByteData? bytes = await tester.runAsync<ByteData?>(
    () => image!.toByteData(format: ui.ImageByteFormat.png),
  );
  final file = File(
    '${_outDir.path}/${scene}_'
    '${brightness == Brightness.dark ? 'dark' : 'light'}.png',
  );
  file.writeAsBytesSync(bytes!.buffer.asUint8List());
  debugDisableShadows = true;
}

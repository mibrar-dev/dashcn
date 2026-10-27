// P7I-alert-dialog captures: the open delete-account dialog over the app.
//
// Renders under `flutter test` like `p7wa_screens_test.dart` and writes one
// PNG per brightness and viewport into
// `rearch/screenshots/p7i-alert-dialog/`. The trigger taps open a real
// `showAlertDialog` route (root navigator), so every capture shows the dialog
// over the whole app, not staged inline.

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/alert_dialog/alert_dialog.dart';
import 'package:dashcn/src/components/button/button.dart';
import 'package:dashcn/src/foundation/icons/lucide_icons.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

/// Device pixel ratio of every capture.
const double _dpr = 2.0;

/// Output folder `$KIT/rearch/screenshots/p7i-alert-dialog`, resolved
/// relative to the package root (`flutter test` runs there).
Directory get _outDir => Directory(
  '${Directory.current.path}/../rearch/screenshots/p7i-alert-dialog',
);

void main() {
  setUpAll(() async {
    await _loadFonts();
    _outDir.createSync(recursive: true);
  });

  setUp(() {
    FocusManager.instance.highlightStrategy =
        FocusHighlightStrategy.alwaysTraditional;
  });

  for (final brightness in const <Brightness>[
    Brightness.light,
    Brightness.dark,
  ]) {
    for (final size in const <Size>[Size(1280, 900), Size(390, 844)]) {
      final String tag =
          '${brightness == Brightness.dark ? 'dark' : 'light'}_${size.width.toInt()}x${size.height.toInt()}';
      testWidgets('p7i-alert-dialog $tag', (WidgetTester tester) async {
        await _capture(tester, tag: tag, brightness: brightness, size: size);
      });
    }
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

/// Wraps the trigger in theme legs, directionality and a [Navigator].
Widget _frame(ThemeData data, Size size) {
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
                            pageBuilder: (_, _, _) => const _TriggerScene(),
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

/// Renders the trigger at [size], opens the dialog and writes the PNG.
Future<void> _capture(
  WidgetTester tester, {
  required String tag,
  required Brightness brightness,
  required Size size,
}) async {
  tester.view.devicePixelRatio = _dpr;
  tester.view.physicalSize = size * _dpr;
  addTearDown(tester.view.reset);

  final key = GlobalKey();
  debugDisableShadows = false;
  await tester.pumpWidget(
    RepaintBoundary(key: key, child: _frame(_theme(brightness), size)),
  );
  await tester.pump();
  await _tap(tester, find.text('Delete account'));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 320));

  final boundary =
      key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  final ui.Image? image = await tester.runAsync(
    () => boundary.toImage(pixelRatio: _dpr),
  );
  final ByteData? bytes = await tester.runAsync<ByteData?>(
    () => image!.toByteData(format: ui.ImageByteFormat.png),
  );
  final file = File('${_outDir.path}/p7i-alert-dialog_$tag.png');
  file.writeAsBytesSync(bytes!.buffer.asUint8List());
  debugDisableShadows = true;
}

/// Scene: a trigger opening the delete-account alert over the whole app.
class _TriggerScene extends StatelessWidget {
  const _TriggerScene();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Button(
        variant: ButtonVariant.outline,
        size: ButtonSize.sm,
        onPressed: () => showAlertDialog<void>(
          context: context,
          icon: const Icon(LucideIcons.circleAlert),
          title: const Text('Delete your account?'),
          description: const Text(
            'This permanently deletes your account and all of its data. '
            'This action cannot be undone.',
          ),
          actionsBuilder: (BuildContext dialogContext) => <Widget>[
            Button(
              size: ButtonSize.sm,
              variant: ButtonVariant.outline,
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            Button(
              size: ButtonSize.sm,
              variant: ButtonVariant.destructive,
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Delete account'),
            ),
          ],
        ),
        child: const Text('Delete account'),
      ),
    );
  }
}

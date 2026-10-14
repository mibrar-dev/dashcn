// P7-WA screenshots: alert layout, whole-app dialog, toast and drawer scale.
//
// Renders under `flutter test` like `p7u2_screens_test.dart` and writes one
// PNG per brightness into `rearch/design/ours/screens/p7wa-*_<light|dark>.png`.

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/alert_dialog/alert_dialog.dart';
import 'package:dashcn/src/components/button/button.dart';
import 'package:dashcn/src/components/dialog/dialog.dart';
import 'package:dashcn/src/components/drawer/drawer.dart';
import 'package:dashcn/src/components/toast/toast.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

/// Device pixel ratio of every capture.
const double _dpr = 2.0;

/// Output folder `$KIT/rearch/design/ours/screens`.
Directory get _outDir {
  Directory dir = Directory.current;
  while (dir.path != dir.parent.path) {
    if (File('${dir.path}/REARCHITECTURE_PLAN.md').existsSync()) {
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

  group('alert', () {
    _scene(
      name: 'p7wa-alert-delete',
      size: const Size(760, 560),
      build: () => const _AlertScene(),
      interact: (tester) => _tap(tester, find.text('Delete account')),
    );
  });

  group('dialog', () {
    _scene(
      name: 'p7wa-dialog-edit',
      size: const Size(1440, 900),
      build: () => const _DialogScene(),
      interact: (tester) => _tap(tester, find.text('Edit profile')),
    );
  });

  group('toast', () {
    _scene(
      name: 'p7wa-toast',
      size: const Size(1440, 900),
      build: () => const _ToastScene(),
      interact: (tester) => _tap(tester, find.text('Show toast')),
    );
  });

  group('drawer', () {
    _scene(
      name: 'p7wa-drawer-scale',
      size: const Size(1440, 900),
      build: () => const _DrawerScene(),
      interact: (tester) => _tap(tester, find.text('Open drawer')),
    );
  });
}

/// Registers the repo's Geist + Lucide fonts on the test engine.
Future<void> _loadFonts() async {
  Future<void> load(String family, List<String> assets) async {
    final loader = FontLoader(family);
    for (final asset in assets) {
      final bytes = File('${Directory.current.path}/$asset').readAsBytesSync();
      loader.addFont(Future<ByteData>.value(ByteData.sublistView(bytes)));
    }
    await loader.load();
  }

  await load('GeistSans', const <String>['assets/fonts/Geist-Regular.otf']);
  await load('GeistMono', const <String>['assets/fonts/GeistMono-Regular.otf']);
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
  required Widget Function() build,
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
        child: build(),
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

/// Scene: a trigger opening the delete-account alert over the whole app.
class _AlertScene extends StatelessWidget {
  const _AlertScene();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Button(
        variant: ButtonVariant.outline,
        size: ButtonSize.sm,
        onPressed: () => showAlertDialog<void>(
          context: context,
          title: const Text('Delete your account?'),
          description: const Text(
            'This permanently deletes your account and all of its data.',
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

/// Scene: a trigger opening the edit-profile dialog over the whole app.
class _DialogScene extends StatelessWidget {
  const _DialogScene();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Button(
        variant: ButtonVariant.outline,
        size: ButtonSize.sm,
        onPressed: () => showDialog<void>(
          context: context,
          builder: (BuildContext dialogContext) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text('Edit profile'),
              const SizedBox(height: 12),
              const Text('Update your display name below.'),
              const SizedBox(height: 24),
              Button(
                size: ButtonSize.sm,
                onPressed: () => Navigator.of(dialogContext).pop(),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
        child: const Text('Edit profile'),
      ),
    );
  }
}

/// Scene: a trigger showing a toast over the app-level host.
class _ToastScene extends StatelessWidget {
  const _ToastScene();

  @override
  Widget build(BuildContext context) {
    final ToastController controller = ToastController();
    return ToastLayer(
      controller: controller,
      child: Center(
        child: Builder(
          builder: (BuildContext context) => Button(
            variant: ButtonVariant.outline,
            size: ButtonSize.sm,
            onPressed: () => showToast(
              context,
              autoDismiss: false,
              builder: (_) => const Text('Saved to your workspace.'),
            ),
            child: const Text('Show toast'),
          ),
        ),
      ),
    );
  }
}

/// Scene: a drawer opening over a scaled background.
class _DrawerScene extends StatelessWidget {
  const _DrawerScene();

  @override
  Widget build(BuildContext context) {
    final DrawerScaleObserver observer = DrawerScaleObserver();
    return Navigator(
      observers: <NavigatorObserver>[observer],
      onGenerateRoute: (RouteSettings settings) => PageRouteBuilder<void>(
        settings: settings,
        pageBuilder: (BuildContext context, _, _) => DrawerBackgroundScale(
          observer: observer,
          child: Center(
            child: Builder(
              builder: (BuildContext context) => Button(
                variant: ButtonVariant.outline,
                size: ButtonSize.sm,
                onPressed: () => openDrawer<void>(
                  context: context,
                  useRootNavigator: false,
                  builder: (_) => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const Text('Drawer content'),
                      const SizedBox(height: 12),
                      Button(
                        size: ButtonSize.sm,
                        onPressed: () => closeDrawer(context),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                ),
                child: const Text('Open drawer'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

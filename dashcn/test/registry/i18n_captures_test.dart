// i18n captures: the kit in en, ar and de — light and dark — at desktop and
// phone widths, with a date picker and a localized dialog open.
//
// Renders under `flutter test` like `p7i-alert-dialog_captures_test.dart` and
// writes one PNG per locale/brightness/size into
// `scratchpad/ui/i18n/captures/` (regenerated on demand, not committed).
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/alert_dialog/alert_dialog.dart';
import 'package:dashcn/src/components/button/button.dart';
import 'package:dashcn/src/foundation/icons/lucide_icons.dart';
import 'package:dashcn/src/primitives/localizations/localizations.dart';
import 'package:dashcn/src/components/date_picker/date_picker.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

/// Device pixel ratio of every capture.
const double _dpr = 2.0;

/// Output folder, resolved relative to the package root (`flutter test`
/// runs there): the committed `scratchpad/ui/i18n/captures` directory.
Directory get _outDir =>
    Directory('${Directory.current.path}/../scratchpad/ui/i18n/captures');

/// The captures need the macOS system Arabic font; other hosts skip them.
final String? _skipReason = Platform.isMacOS
    ? null
    : 'i18n captures need macOS system fonts (run on macOS)';

void main() {
  setUpAll(() async {
    if (_skipReason != null) return;
    await _loadFonts();
    _outDir.createSync(recursive: true);
  });

  setUp(() {
    FocusManager.instance.highlightStrategy =
        FocusHighlightStrategy.alwaysTraditional;
  });

  const List<Locale> locales = <Locale>[
    Locale('en'),
    Locale('ar'),
    Locale('de'),
  ];
  for (final Locale locale in locales) {
    final String code = locale.languageCode;
    for (final Brightness brightness in const <Brightness>[
      Brightness.light,
      Brightness.dark,
    ]) {
      for (final Size size in const <Size>[Size(1280, 800), Size(375, 812)]) {
        final String tag =
            'i18n_${code}_${brightness == Brightness.dark ? 'dark' : 'light'}_${size.width.toInt()}x${size.height.toInt()}';
        testWidgets(tag, (WidgetTester tester) async {
          await _capture(
            tester,
            tag: tag,
            locale: locale,
            brightness: brightness,
            size: size,
          );
        }, skip: _skipReason != null);
      }
    }
  }
}

/// Registers the repo's Geist + Lucide fonts on the test engine.
Future<void> _loadFonts() async {
  Future<void> load(String family, List<String> assets) async {
    final loader = FontLoader(family);
    for (final asset in assets) {
      final String path = asset.startsWith('/')
          ? asset
          : '${Directory.current.path}/$asset';
      final bytes = File(path).readAsBytesSync();
      loader.addFont(Future<ByteData>.value(ByteData.sublistView(bytes)));
    }
    await loader.load();
  }

  await load('GeistSans', const <String>['assets/fonts/Geist-Regular.otf']);
  await load('GeistMono', const <String>['assets/fonts/GeistMono-Regular.otf']);
  await load('LucideIcons', const <String>['assets/fonts/lucide.ttf']);
  // Arabic coverage for the ar captures (Geist has no Arabic glyphs).
  // Flutter falls back across every loaded family, so Arabic text renders
  // with Geeza Pro while Latin text keeps Geist.
  await load('GeezaPro', const <String>['/System/Library/Fonts/SFArabic.ttf']);
}

/// Upstream default fallback colours with default tokens.
ThemeData _theme(Brightness brightness) => ThemeData(
  colors: brightness == Brightness.dark
      ? ThemeColors.darkFallback
      : ThemeColors.lightFallback,
);

/// Frame: theme, locale strings, implied direction and a [Navigator].
Widget _frame(ThemeData data, Locale locale, Size size) {
  return Theme(
    data: data,
    child: Localizations(
      locale: locale,
      delegates: <LocalizationsDelegate<dynamic>>[
        ...ComponentLocalizations.localizationsDelegates,
        DefaultWidgetsLocalizations.delegate,
      ],
      child: Builder(
        builder: (BuildContext context) => Directionality(
          textDirection: textDirectionForLocale(locale),
          child: MediaQuery(
            data: const MediaQueryData(devicePixelRatio: _dpr),
            child: Builder(
              builder: (BuildContext context) {
                final ThemeData theme = Theme.of(context);
                return DefaultTextStyle(
                  style: theme.typography.sans.copyWith(
                    color: theme.colors.foreground,
                    fontSize: 14,
                    // Test-only fallback so Arabic glyphs render in captures
                    // (Geist ships no Arabic; loaded as `GeezaPro` above).
                    fontFamilyFallback: const <String>['GeezaPro'],
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
                              pageBuilder: (_, _, _) => _PickerScene(size),
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

/// Renders the date picker at [size], opens the localized dialog over it and
/// writes the PNG.
Future<void> _capture(
  WidgetTester tester, {
  required String tag,
  required Locale locale,
  required Brightness brightness,
  required Size size,
}) async {
  tester.view.devicePixelRatio = _dpr;
  tester.view.physicalSize = size * _dpr;
  addTearDown(tester.view.reset);

  final GlobalKey key = GlobalKey();
  debugDisableShadows = false;
  await tester.pumpWidget(
    RepaintBoundary(key: key, child: _frame(_theme(brightness), locale, size)),
  );
  await tester.pump();
  await _tap(tester, find.text('open-dialog'));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 320));

  final RenderRepaintBoundary boundary =
      key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  final ui.Image? image = await tester.runAsync(
    () => boundary.toImage(pixelRatio: _dpr),
  );
  final ByteData? bytes = await tester.runAsync<ByteData?>(
    () => image!.toByteData(format: ui.ImageByteFormat.png),
  );
  final File file = File('${_outDir.path}/$tag.png');
  file.writeAsBytesSync(bytes!.buffer.asUint8List());
  debugDisableShadows = true;
}

/// Scene: an inline date picker plus a trigger opening the localized dialog.
class _PickerScene extends StatelessWidget {
  const _PickerScene(this.size);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size.width == 375 ? 343 : 560,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const DatePickerDialog(),
            const SizedBox(height: 12),
            Button(
              variant: ButtonVariant.outline,
              size: ButtonSize.sm,
              onPressed: () => showAlertDialog<void>(
                context: context,
                icon: const Icon(LucideIcons.circleAlert),
                title: Builder(
                  builder: (BuildContext c) => Text(
                    ComponentLocalizations.of(c).errorSomethingWentWrong,
                  ),
                ),
                description: Builder(
                  builder: (BuildContext c) =>
                      Text(ComponentLocalizations.of(c).errorUnexpectedMessage),
                ),
                actionsBuilder: (BuildContext dialogContext) => <Widget>[
                  Button(
                    size: ButtonSize.sm,
                    variant: ButtonVariant.outline,
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    child: Builder(
                      builder: (BuildContext c) =>
                          Text(ComponentLocalizations.of(c).buttonCancel),
                    ),
                  ),
                  Button(
                    size: ButtonSize.sm,
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    child: Builder(
                      builder: (BuildContext c) =>
                          Text(ComponentLocalizations.of(c).errorActionRetry),
                    ),
                  ),
                ],
              ),
              // Hidden trigger label (excluded from the capture's story).
              child: const Text('open-dialog'),
            ),
          ],
        ),
      ),
    );
  }
}

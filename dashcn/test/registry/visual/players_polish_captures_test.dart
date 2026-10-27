// Players-polish captures (branch feat/players-polish).
//
// Renders under `flutter test` like `pilot_screenshots_test.dart`: each scene
// is rendered at device pixel ratio 2 inside `Theme` + `ComponentThemes`,
// captured through a `RepaintBoundary` and written as a real PNG to
// `scratchpad/ui/players-polish/captures/<scene>_<size>_<light|dark>.png`.
//
// Scenes: audio compact pill, expanded card (full disc), details panel open,
// video desktop paused/playing (glass bar), video phone paused/playing
// (minimal thin bar). Playing scenes pin `controlsVisible` so no hide timer
// is pending at capture time and the bar stays in frame.

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/audio_player/audio_player.dart';
import 'package:dashcn/src/components/video_player/video_player.dart';
import 'package:dashcn/src/primitives/overlay_manager.dart';
import 'package:dashcn/src/theme/color_tokens.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

/// Device pixel ratio of every capture.
const double _dpr = 2.0;

/// Capture viewports.
const Size _desktop = Size(1280, 800);
const Size _phone = Size(375, 812);

/// Output folder `$ROOT/scratchpad/ui/players-polish/captures`, found by
/// walking up to the directory that contains INSTRUCTIONS.md.
Directory get _outDir {
  var dir = Directory.current;
  while (dir.path != dir.parent.path) {
    if (File('${dir.path}/INSTRUCTIONS.md').existsSync()) {
      break;
    }
    dir = dir.parent;
  }
  return Directory('${dir.path}/scratchpad/ui/players-polish/captures');
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

  group('audio', () {
    _scene(
      name: 'audio_compact',
      sizes: const <Size>[_desktop, _phone],
      build: (_) => _AudioCompactScene(),
    );
    _scene(
      name: 'audio_expanded',
      sizes: const <Size>[_desktop, _phone],
      build: (_) => _AudioExpandedScene(),
    );
    _scene(
      name: 'audio_details',
      sizes: const <Size>[_desktop, _phone],
      build: (_) => _AudioExpandedScene(),
      interact: _openDetails,
    );
  });

  group('video desktop', () {
    _scene(
      name: 'video_desktop_paused',
      sizes: const <Size>[_desktop],
      build: (size) => _VideoScene(size: size, isPlaying: false),
    );
    _scene(
      name: 'video_desktop_playing',
      sizes: const <Size>[_desktop],
      build: (size) => _VideoScene(size: size, isPlaying: true),
    );
  });

  group('video phone', () {
    _scene(
      name: 'video_phone_paused',
      sizes: const <Size>[_phone],
      build: (size) => _VideoScene(size: size, isPlaying: false),
    );
    _scene(
      name: 'video_phone_playing',
      sizes: const <Size>[_phone],
      build: (size) => _VideoScene(size: size, isPlaying: true),
    );
  });
}

/// Registers one scene for every size x brightness.
void _scene({
  required String name,
  required List<Size> sizes,
  required Widget Function(Size size) build,
  Future<void> Function(WidgetTester tester)? interact,
}) {
  for (final Size size in sizes) {
    final String tag = '${size.width.toInt()}x${size.height.toInt()}';
    for (final brightness in const <Brightness>[
      Brightness.light,
      Brightness.dark,
    ]) {
      testWidgets('$name $tag ${brightness.name}', (WidgetTester tester) async {
        await _capture(
          tester,
          scene: '${name}_$tag',
          brightness: brightness,
          size: size,
          child: build(size),
          interact: interact,
        );
      });
    }
  }
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
  final data = ThemeData(
    colors: brightness == Brightness.dark
        ? ThemeColors.darkFallback
        : ThemeColors.lightFallback,
  );
  debugDisableShadows = false;
  await tester.pumpWidget(
    RepaintBoundary(key: key, child: _frame(data, size, child)),
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

/// Wraps [child] in the theme legs, directionality and background.
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
                child: AppLayer(
                  child: SizedBox(
                    width: size.width,
                    height: size.height,
                    child: ColoredBox(
                      color: data.colors.background,
                      child: Overlay(
                        initialEntries: <OverlayEntry>[
                          OverlayEntry(builder: (_) => child),
                        ],
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

/// Compact pill, paused, centred.
class _AudioCompactScene extends StatefulWidget {
  @override
  State<_AudioCompactScene> createState() => _AudioCompactSceneState();
}

class _AudioCompactSceneState extends State<_AudioCompactScene> {
  final FakeAudioPlaybackController _controller = FakeAudioPlaybackController(
    position: const Duration(minutes: 1, seconds: 1),
    duration: const Duration(minutes: 5, seconds: 40),
    tracks: demoAudioTracks,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 360,
        child: AudioPlayer(
          controller: _controller,
          variant: AudioPlayerVariant.compact,
          onDownload: () {},
        ),
      ),
    );
  }
}

/// Expanded card, paused, centred (full 144 px disc).
class _AudioExpandedScene extends StatefulWidget {
  @override
  State<_AudioExpandedScene> createState() => _AudioExpandedSceneState();
}

class _AudioExpandedSceneState extends State<_AudioExpandedScene> {
  final FakeAudioPlaybackController _controller = FakeAudioPlaybackController(
    tracks: demoAudioTracks,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 360,
        child: AudioPlayer(
          controller: _controller,
          variant: AudioPlayerVariant.full,
        ),
      ),
    );
  }
}

/// Taps the disc to open the details panel.
Future<void> _openDetails(WidgetTester tester) async {
  await tester.tap(find.bySemanticsLabel('Southern Roots Boogie'));
  await tester.pump();
}

/// Video player: desktop layout at 1280 px, minimal phone bar under 600 px.
///
/// Playing scenes pin the controls visible so the bar stays in frame and no
/// auto-hide timer is pending at capture time.
class _VideoScene extends StatefulWidget {
  const _VideoScene({required this.size, required this.isPlaying});

  final Size size;
  final bool isPlaying;

  @override
  State<_VideoScene> createState() => _VideoSceneState();
}

class _VideoSceneState extends State<_VideoScene> {
  late final FakeVideoPlaybackController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FakeVideoPlaybackController(isPlaying: widget.isPlaying);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isPhone = widget.size.width < 600;
    final double width = isPhone
        ? widget.size.width
        : (widget.size.width - 32).clamp(320.0, 960.0);
    final Widget player = VideoPlayer(
      controller: _controller,
      // Pin the bar visible for the capture (paused has no timer; playing
      // would otherwise auto-hide after 3 s).
      controlsVisible: true,
      title: 'For Bigger Blazes',
      subtitle: 'Season 3 episode 6',
      content: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[Color(0xFF312E81), Color(0xFF0EA5E9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        alignment: Alignment.center,
        child: const Text(
          'Online MP4',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
    if (isPhone) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[SizedBox(width: width, child: player)],
      );
    }
    return Center(
      child: SizedBox(width: width, child: player),
    );
  }
}

// Widget and unit tests for the `video_player` component.
//
// Covers: rendering, controlled/uncontrolled, callbacks, keyboard, RTL,
// reduced motion, theme + style overrides, custom builders and a 375px
// phone-width overflow guard.

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dashcn/src/components/video_player/video_player.dart';
import 'package:dashcn/src/foundation/icons/lucide_icons.dart';
import 'package:dashcn/src/theme/theme.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _frame({
  ThemeData data = const ThemeData(),
  List<ComponentThemeData> app = const <ComponentThemeData>[],
  TextDirection direction = TextDirection.ltr,
  bool reducedMotion = false,
  required Widget child,
}) {
  Widget body = Directionality(
    textDirection: direction,
    child: Center(child: SizedBox(width: 360, child: child)),
  );
  if (reducedMotion) {
    body = MediaQuery(
      data: const MediaQueryData(disableAnimations: true),
      child: body,
    );
  }
  return Theme(
    data: data,
    child: ComponentThemes(themes: app, child: body),
  );
}

void main() {
  group('formatMediaTime', () {
    test('formats m:ss and h:mm:ss', () {
      expect(formatMediaTime(const Duration(seconds: 37)), '0:37');
      expect(formatMediaTime(const Duration(minutes: 3, seconds: 42)), '3:42');
      expect(
        formatMediaTime(const Duration(hours: 1, minutes: 2, seconds: 3)),
        '1:02:03',
      );
    });
  });

  group('fake controller', () {
    test('play/pause/seek/volume/mute/speed/loop notify', () async {
      final FakeVideoPlaybackController c = FakeVideoPlaybackController();
      var calls = 0;
      c.addListener(() => calls++);
      await c.play();
      expect(c.isPlaying, isTrue);
      await c.pause();
      expect(c.isPlaying, isFalse);
      await c.seekTo(const Duration(seconds: 60));
      expect(c.position, const Duration(seconds: 60));
      await c.seekTo(const Duration(hours: 5));
      expect(c.position, c.duration);
      await c.setVolume(0.2);
      expect(c.volume, 0.2);
      await c.setMuted(true);
      expect(c.isMuted, isTrue);
      await c.setPlaybackSpeed(2);
      expect(c.playbackSpeed, 2);
      await c.setLooping(true);
      expect(c.isLooping, isTrue);
      expect(calls, greaterThan(0));
      c.dispose();
    });

    test('toggle flips playback', () async {
      final FakeVideoPlaybackController c = FakeVideoPlaybackController();
      await c.toggle();
      expect(c.isPlaying, isTrue);
      await c.toggle();
      expect(c.isPlaying, isFalse);
      c.dispose();
    });
  });

  testWidgets('renders time labels and controls', (tester) async {
    final FakeVideoPlaybackController c = FakeVideoPlaybackController();
    addTearDown(c.dispose);
    await tester.pumpWidget(_frame(child: VideoPlayer(controller: c)));
    expect(find.text('0:37 / 3:42'), findsOneWidget);
    expect(find.bySemanticsLabel('Play'), findsWidgets);
    expect(find.bySemanticsLabel('Mute'), findsOneWidget);
    expect(find.bySemanticsLabel('Fullscreen'), findsOneWidget);
    expect(find.bySemanticsLabel('Playback speed 1.0x'), findsOneWidget);
  });

  testWidgets('play overlay toggles playback', (tester) async {
    final FakeVideoPlaybackController c = FakeVideoPlaybackController();
    addTearDown(c.dispose);
    await tester.pumpWidget(_frame(child: VideoPlayer(controller: c)));
    expect(c.isPlaying, isFalse);
    await tester.tap(find.byIcon(LucideIcons.play).first);
    await tester.pump();
    expect(c.isPlaying, isTrue);
    expect(find.bySemanticsLabel('Pause'), findsWidgets);
  });

  testWidgets('mute, speed and fullscreen callbacks fire', (tester) async {
    final FakeVideoPlaybackController c = FakeVideoPlaybackController();
    addTearDown(c.dispose);
    var fullscreen = 0;
    await tester.pumpWidget(
      _frame(
        child: VideoPlayer(
          controller: c,
          onFullscreenRequested: () => fullscreen++,
        ),
      ),
    );
    await tester.tap(find.bySemanticsLabel('Mute'));
    await tester.pump();
    expect(c.isMuted, isTrue);

    await tester.tap(find.bySemanticsLabel('Playback speed 1.0x'));
    await tester.pump();
    expect(find.bySemanticsLabel('Speed 2.0x'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('Speed 2.0x'));
    await tester.pump();
    expect(c.playbackSpeed, 2.0);

    await tester.tap(find.bySemanticsLabel('Fullscreen'));
    expect(fullscreen, 1);
  });

  testWidgets('uncontrolled mode owns a fake controller', (tester) async {
    await tester.pumpWidget(_frame(child: const VideoPlayer()));
    expect(find.text('0:37 / 3:42'), findsOneWidget);
    await tester.tap(find.byIcon(LucideIcons.play).first);
    await tester.pump();
    expect(find.bySemanticsLabel('Pause'), findsWidgets);
  });

  testWidgets('loading and error states render', (tester) async {
    final FakeVideoPlaybackController loading = FakeVideoPlaybackController(
      isBuffering: true,
    );
    addTearDown(loading.dispose);
    await tester.pumpWidget(_frame(child: VideoPlayer(controller: loading)));
    expect(find.byIcon(LucideIcons.loaderCircle), findsWidgets);

    final FakeVideoPlaybackController failing = FakeVideoPlaybackController();
    addTearDown(failing.dispose);
    failing.setError(Exception('boom'));
    await tester.pumpWidget(_frame(child: VideoPlayer(controller: failing)));
    await tester.pump();
    expect(find.text('Playback failed'), findsOneWidget);
  });

  testWidgets('keyboard: space/k/arrows/m/f', (tester) async {
    final FakeVideoPlaybackController c = FakeVideoPlaybackController();
    addTearDown(c.dispose);
    var fullscreen = 0;
    await tester.pumpWidget(
      _frame(
        child: VideoPlayer(
          controller: c,
          autofocus: true,
          onFullscreenRequested: () => fullscreen++,
        ),
      ),
    );
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.space);
    await tester.pump();
    expect(c.isPlaying, isTrue);
    await tester.sendKeyEvent(LogicalKeyboardKey.keyK);
    await tester.pump();
    expect(c.isPlaying, isFalse);
    final Duration before = c.position;
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
    await tester.pump();
    expect(c.position, before + const Duration(seconds: 5));
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
    await tester.pump();
    expect(c.position, before);
    await tester.sendKeyEvent(LogicalKeyboardKey.keyM);
    await tester.pump();
    expect(c.isMuted, isTrue);
    await tester.sendKeyEvent(LogicalKeyboardKey.keyF);
    await tester.pump();
    expect(fullscreen, 1);
  });

  testWidgets('renders in RTL without overflow', (tester) async {
    final FakeVideoPlaybackController c = FakeVideoPlaybackController();
    addTearDown(c.dispose);
    await tester.pumpWidget(
      _frame(
        direction: TextDirection.rtl,
        child: VideoPlayer(controller: c),
      ),
    );
    expect(tester.takeException(), isNull);
    expect(find.text('0:37 / 3:42'), findsOneWidget);
  });

  testWidgets('renders under reduced motion', (tester) async {
    final FakeVideoPlaybackController c = FakeVideoPlaybackController();
    addTearDown(c.dispose);
    await tester.pumpWidget(
      _frame(reducedMotion: true, child: VideoPlayer(controller: c)),
    );
    expect(tester.takeException(), isNull);
    expect(find.byType(VideoPlayer), findsOneWidget);
  });

  testWidgets('widget theme leg overrides time style', (tester) async {
    final FakeVideoPlaybackController c = FakeVideoPlaybackController();
    addTearDown(c.dispose);
    const Color custom = Color(0xFFE11D48);
    await tester.pumpWidget(
      _frame(
        child: VideoPlayer(
          controller: c,
          theme: const VideoPlayerTheme(
            timeTextStyle: TextStyle(color: custom),
          ),
        ),
      ),
    );
    final Text label = tester.widget<Text>(find.text('0:37 / 3:42'));
    expect(label.style?.color, custom);
  });

  testWidgets('custom builders replace parts', (tester) async {
    final FakeVideoPlaybackController c = FakeVideoPlaybackController();
    addTearDown(c.dispose);
    await tester.pumpWidget(
      _frame(
        child: VideoPlayer(
          controller: c,
          progressBuilder: (context, controller, defaults) =>
              const Text('custom scrub'),
          timeLabelBuilder: (context, controller) => const Text('custom time'),
          playButtonBuilder: (context, controller) => const Text('custom play'),
          captions: const Text('caption track'),
        ),
      ),
    );
    expect(find.text('custom scrub'), findsOneWidget);
    expect(find.text('custom time'), findsOneWidget);
    expect(find.text('custom play'), findsWidgets);
    expect(find.text('caption track'), findsOneWidget);
  });

  testWidgets('375px phone width has no overflow', (tester) async {
    tester.view.physicalSize = const Size(375, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final FakeVideoPlaybackController c = FakeVideoPlaybackController();
    addTearDown(c.dispose);
    await tester.pumpWidget(
      Theme(
        data: const ThemeData(),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Center(
            child: SizedBox(
              width: 375,
              child: VideoPlayer(
                controller: c,
                captions: const Text('A caption line'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    expect(tester.takeException(), isNull);
    expect(find.byType(VideoPlayer), findsOneWidget);
    expect(find.byType(VideoControlsBar), findsOneWidget);
  });
}

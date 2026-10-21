// Widget and unit tests for the `video_player` component.
//
// Covers: SPEC glass bar with title header, 10s skips, more menu (speeds,
// captions), live badge, bar hidden state, controlled/uncontrolled,
// callbacks, keyboard (10s, 5s with Shift), RTL, reduced motion, theme and
// style overrides, custom builders and a 375px phone-width overflow guard.

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
    child: Center(child: SizedBox(width: 640, child: child)),
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

    test('demo sources cover mp4, live and camera', () {
      expect(demoVideoSources, hasLength(3));
      expect(demoVideoSources[0].uri, isNotNull);
      expect(demoVideoSources[0].isLive, isFalse);
      expect(demoVideoSources[1].isLive, isTrue);
      expect(demoVideoSources[1].uri, isNotNull);
      expect(demoVideoSources[2].isCamera, isTrue);
    });
  });

  testWidgets('renders title header, times and seek buttons', (tester) async {
    final FakeVideoPlaybackController c = FakeVideoPlaybackController();
    addTearDown(c.dispose);
    await tester.pumpWidget(
      _frame(
        child: VideoPlayer(
          controller: c,
          title: 'For Bigger Blazes',
          subtitle: 'Season 3 episode 6',
        ),
      ),
    );
    expect(find.text('For Bigger Blazes'), findsOneWidget);
    expect(find.text('Season 3 episode 6'), findsOneWidget);
    expect(find.text('0:37 / 3:42'), findsOneWidget);
    expect(find.bySemanticsLabel('Play'), findsWidgets);
    expect(find.bySemanticsLabel('Back 10 seconds'), findsOneWidget);
    expect(find.bySemanticsLabel('Forward 10 seconds'), findsOneWidget);
    expect(find.bySemanticsLabel('Mute'), findsOneWidget);
    expect(find.bySemanticsLabel('Fullscreen'), findsOneWidget);
    expect(
      find.bySemanticsLabel('More options, playback speed 1.0x'),
      findsOneWidget,
    );
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

  testWidgets('mute, more menu speed and fullscreen fire', (tester) async {
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

    await tester.tap(
      find.bySemanticsLabel('More options, playback speed 1.0x'),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.bySemanticsLabel('Speed 2.0x'), findsOneWidget);
    expect(find.bySemanticsLabel('Captions off'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('Speed 2.0x'));
    await tester.pump();
    expect(c.playbackSpeed, 2.0);

    await tester.tap(find.bySemanticsLabel('Fullscreen'));
    expect(fullscreen, 1);
  });

  testWidgets('skip buttons seek 10 seconds', (tester) async {
    final FakeVideoPlaybackController c = FakeVideoPlaybackController();
    addTearDown(c.dispose);
    await tester.pumpWidget(_frame(child: VideoPlayer(controller: c)));
    final Duration before = c.position;
    await tester.tap(find.bySemanticsLabel('Forward 10 seconds'));
    await tester.pump();
    expect(c.position, before + const Duration(seconds: 10));
    await tester.tap(find.bySemanticsLabel('Back 10 seconds'));
    await tester.pump();
    expect(c.position, before);
  });

  testWidgets('captions toggle from the bar and the menu', (tester) async {
    final FakeVideoPlaybackController c = FakeVideoPlaybackController(
      cues: const <VideoCaptionCue>[
        VideoCaptionCue(
          start: Duration(seconds: 10),
          end: Duration(seconds: 15),
          text: 'Hello, world',
        ),
      ],
    );
    addTearDown(c.dispose);
    await tester.pumpWidget(_frame(child: VideoPlayer(controller: c)));
    await tester.tap(find.bySemanticsLabel('Show captions'));
    await tester.pump();
    expect(c.areCaptionsEnabled, isTrue);
    await tester.tap(
      find.bySemanticsLabel('More options, playback speed 1.0x'),
    );
    await tester.pump();
    expect(find.bySemanticsLabel('Captions on'), findsOneWidget);
  });

  testWidgets('live source shows a LIVE badge without total', (tester) async {
    final FakeVideoPlaybackController c = FakeVideoPlaybackController(
      isPlaying: true,
      isLive: true,
      sourceLabel: 'HLS test stream',
    );
    addTearDown(c.dispose);
    await tester.pumpWidget(
      _frame(
        child: VideoPlayer(controller: c, title: 'Live stream'),
      ),
    );
    expect(find.textContaining('LIVE'), findsOneWidget);
    expect(find.text('0:37 / 3:42'), findsNothing);
  });

  testWidgets('pinned hidden bar keeps the centre play button', (tester) async {
    final FakeVideoPlaybackController c = FakeVideoPlaybackController();
    addTearDown(c.dispose);
    await tester.pumpWidget(
      _frame(child: VideoPlayer(controller: c, controlsVisible: false)),
    );
    await tester.pump();
    expect(find.byType(VideoControlsBar), findsOneWidget);
    expect(find.bySemanticsLabel('Play'), findsWidgets);
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

  testWidgets('keyboard: space/k/arrows/shift/m/f/c', (tester) async {
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
    expect(c.position, before + const Duration(seconds: 10));
    await tester.sendKeyDownEvent(LogicalKeyboardKey.shiftLeft);
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.shiftLeft);
    await tester.pump();
    expect(c.position, before + const Duration(seconds: 5));
    await tester.sendKeyEvent(LogicalKeyboardKey.keyM);
    await tester.pump();
    expect(c.isMuted, isTrue);
    await tester.sendKeyEvent(LogicalKeyboardKey.keyF);
    await tester.pump();
    expect(fullscreen, 1);
    await tester.sendKeyEvent(LogicalKeyboardKey.keyC);
    await tester.pump();
    expect(c.areCaptionsEnabled, isTrue);
  });

  testWidgets('renders in RTL without overflow', (tester) async {
    final FakeVideoPlaybackController c = FakeVideoPlaybackController();
    addTearDown(c.dispose);
    await tester.pumpWidget(
      _frame(
        direction: TextDirection.rtl,
        child: VideoPlayer(controller: c, title: 'RTL'),
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
          headerBuilder: (context, controller) => const Text('custom header'),
          playButtonBuilder: (context, controller) => const Text('custom play'),
          captions: const Text('caption track'),
        ),
      ),
    );
    expect(find.text('custom scrub'), findsOneWidget);
    expect(find.text('custom header'), findsOneWidget);
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
                title: 'A long title that must ellipsize gracefully',
                subtitle: 'Season 3 episode 6',
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
